unit Un_Pizzaria;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, ControllerPedidoVda, ControllerRestaurante, Vcl.Menus, FavoritoButtons, Vcl.ComCtrls, QEdit_Setes, ControllerDskRestMenu, ControllerBase, ControllerItensNFL;

type

  TFr_Pizzaria = class(TForm)
    Pnl_fundos: TPanel;
    PopupMenu1: TPopupMenu;
    CORTESIA1: TMenuItem;
    IMPRIMIRCOMANDA1: TMenuItem;
    Qr_Lista_SubGrupo: TSTQuery;
    Qr_Lista_SubGrupoMED_CODIGO: TIntegerField;
    Qr_Lista_SubGrupoMED_DESCRICAO: TStringField;
    Pnl_botao: TPanel;
    SB_Alterar: TSpeedButton;
    SB_Inserir: TSpeedButton;
    SB_Faturar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    SB_Sair_1: TSpeedButton;
    Sb_Pesquisar: TSpeedButton;
    Sb_Imprimir: TSpeedButton;
    SB_Entregar: TSpeedButton;
    SB_Gravar: TSpeedButton;
    Qr_Produtos: TSTQuery;
    Qr_ProdutosPRO_CODIGO: TIntegerField;
    Qr_ProdutosPRO_DESCRICAO: TStringField;
    Qr_ProdutosPRO_VALOR: TFloatField;
    Qr_ProdutosPRO_CAMPANHA: TStringField;
    Ds_Produtos: TDataSource;
    SB_Excluir: TSpeedButton;
    Qr_Itens_RTR: TSTQuery;
    Qr_Itens_RTRITF_CODIGO: TIntegerField;
    Qr_Itens_RTRITF_CODPED: TIntegerField;
    Qr_Itens_RTRITF_CODPRO: TIntegerField;
    Qr_Itens_RTRITR_NR_ITEM: TIntegerField;
    Qr_Itens_RTRITR_DESCRICAO: TStringField;
    Qr_Itens_RTRITF_QTDE: TBCDField;
    Qr_Itens_RTRITF_VL_UNIT: TFloatField;
    Qr_Itens_RTRITF_VL_DESC: TBCDField;
    Qr_Itens_RTRITF_ESTOQUE: TStringField;
    Qr_Itens_RTRITR_OBS: TStringField;
    Qr_Itens_RTRITR_CODGRC: TIntegerField;
    Qr_Itens_RTRITR_CODSBG: TIntegerField;
    Qr_Itens_RTRITR_CORTESIA: TStringField;
    Qr_Prox_Item: TSTQuery;
    Mnu_Principal: TMainMenu;
    arefas1: TMenuItem;
    Sair1: TMenuItem;
    Relatrios1: TMenuItem;
    LanamentosCaixa1: TMenuItem;
    Comisso1: TMenuItem;
    NotasFiscais1: TMenuItem;
    Pg_Cardapio: TPageControl;
    Pnl_Left: TPanel;
    Label10: TLabel;
    E_Qt_Total: TLabel;
    GbObsPedido: TGroupBox;
    E_OBS: TMemo;
    StrGrd_ItensVenda: TStringGrid;
    Pnl_Total: TPanel;
    SubTotal: TLabel;
    Label15: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label4: TLabel;
    E_VL_SubTotal: TEdit_Setes;
    E_VL_Entrega: TEdit_Setes;
    E_Vl_Desconto: TEdit_Setes;
    E_VL_Adicional: TEdit_Setes;
    E_Vl_Pedido: TEdit_Setes;
    Sb_Exc_Item: TBitBtn;
    Sb_Imp_Item: TBitBtn;
    Pnl_Top: TPanel;
    Pg_modalidade: TPageControl;
    tbs_Entrega: TTabSheet;
    GbDadosClientes: TGroupBox;
    Lb_bairro: TLabel;
    Lb_Telefone: TLabel;
    Lb_Cliente: TLabel;
    Lb_Cep: TLabel;
    Lb_endereco: TLabel;
    Lb_compl: TLabel;
    Lb_numero: TLabel;
    Lb_ObsCliente: TLabel;
    Sb_Cep: TSpeedButton;
    Sb_Cliente: TSpeedButton;
    Sb_Endereco: TSpeedButton;
    GroupBox2: TGroupBox;
    Lb_Nr_Pedidos: TLabel;
    Label1: TLabel;
    E_Nr_Pedidos: TEdit_Setes;
    Sb_UltimoPedido: TBitBtn;
    E_DataUltimoPedido: TEdit_Setes;
    Sb_AtualizaHistorico: TBitBtn;
    E_Nome: TEdit;
    E_Endereco: TEdit;
    E_Compl: TEdit;
    E_Bairro: TEdit;
    E_CEP: TMaskEdit;
    E_Numero: TEdit;
    E_ObsCliente: TEdit;
    E_Telefone: TEdit_Setes;
    tbs_Balcao: TTabSheet;
    GroupBox5: TGroupBox;
    Label5: TLabel;
    E_Cliente_Balcao: TEdit;
    tbs_Mesa: TTabSheet;
    grp_mesa: TGroupBox;
    Label3: TLabel;
    E_NR_Mesa: TEdit;
    Rg_Modalidade: TRadioGroup;
    pnl_Mesa: TPanel;
    PrgoramaPAYBACK1: TMenuItem;
    Fechamento1: TMenuItem;
    Sb_Identifica_balcao: TSpeedButton;
    Sb_Identifica_Mesa: TSpeedButton;
    pop_Pausa_By_Name: TPopupMenu;
    MnuPausarByName: TMenuItem;
    MnuHabilitarByName: TMenuItem;
    MnuDesativarByName: TMenuItem;
    pop_Pausa_By_Codigo: TPopupMenu;
    MnuDesativarByCodigo: TMenuItem;
    MnuPausaByCodigo: TMenuItem;
    MnuHabilitarByCodigo: TMenuItem;
    AtualizaoCtrlF51: TMenuItem;
    PedidosIfood1: TMenuItem;
    procedure Rg_ModalidadeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_EntregarClick(Sender: TObject);
    procedure SB_FaturarClick(Sender: TObject);
    procedure Sb_ImprimirClick(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure E_Cliente_BalcaoExit(Sender: TObject);
    procedure Pg_modalidadeExit(Sender: TObject);
    procedure Sb_CepClick(Sender: TObject);
    procedure E_CEPExit(Sender: TObject);
    procedure SB_Sair_1Click(Sender: TObject);
    procedure Sb_ClienteClick(Sender: TObject);
    procedure StrGrd_ItensVendaDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure E_VL_AdicionalExit(Sender: TObject);
    procedure E_Vl_DescontoExit(Sender: TObject);
    procedure E_VL_EntregaExit(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    //Controle do Identificador de Chamada

    procedure Pc_MostraMensagem(Pc_Fone: String);

    procedure Sb_Exc_ItemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Sb_EnderecoClick(Sender: TObject);
    procedure Sb_AtualizaHistoricoClick(Sender: TObject);
    procedure Sb_UltimoPedidoClick(Sender: TObject);
    procedure tbs_BalcaoShow(Sender: TObject);
    procedure tbs_MesaShow(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure LanamentosCaixa1Click(Sender: TObject);
    procedure Relatrios1Click(Sender: TObject);
    procedure E_EnderecoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Comisso1Click(Sender: TObject);
    procedure E_TelefoneEnter(Sender: TObject);
    procedure E_TelefoneExit(Sender: TObject);
    procedure E_TelefoneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NotasFiscais1Click(Sender: TObject);
    procedure Sb_Imp_ItemClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PrgoramaPAYBACK1Click(Sender: TObject);
    procedure Fechamento1Click(Sender: TObject);
    procedure Sb_Identifica_balcaoClick(Sender: TObject);
    procedure Sb_Identifica_MesaClick(Sender: TObject);
    procedure MnuPausarByNameClick(Sender: TObject);
    procedure MnuHabilitarByNameClick(Sender: TObject);
    procedure MnuDesativarByNameClick(Sender: TObject);
    procedure MnuDesativarByCodigoClick(Sender: TObject);
    procedure MnuPausaByCodigoClick(Sender: TObject);
    procedure MnuHabilitarByCodigoClick(Sender: TObject);
    procedure AtualizaoCtrlF51Click(Sender: TObject);
    procedure PedidosIfood1Click(Sender: TObject);
  private
    { Private declarations }
    FoneEntrou : String;
    It_Inserir : Boolean;
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    It_Visualizar : Boolean;
    //Mover componente
    it_captura : Boolean;
    It_Act_Page :Integer;
    //Trata String Identificador
    It_Tra_Str_Ini_Piz,It_Tra_Str_Tam_Piz:Integer;
    //Verifica se o faturamente deu certo

    It_Modal_ant : Integer;

    It_Tx_Garcon : Real;

    It_NFCe : Boolean;

    It_SaborPizza : String;

    CodigoConsumidor : Integer;
    //Permite redução do valor de entrega
    PermiteReducaoValorEntrega : Boolean;

    Obs_RecheioListaSimples : String;
    Vlr_RecheioListaSimples : Real;
    function ValidaDesativaProdutoByName:Boolean;
    procedure DesativaProdutoByName(Produto:String;GRupo:Integer);

    function ValidaDesativaProdutoByCodigo:Boolean;
    procedure DesativaProdutoByCodigo(Produto:Integer);
    procedure PausarHabilitarItemByCodigo(Pausa:Boolean;Produto:Integer);
    function VerificaProdutoPausadoByCodigo(Produto:Integer):Boolean;

    procedure PausarHabilitarItemByName(Pausa:Boolean;Produto:String;GRupo:Integer);
    function VerificaProdutoPausadoByName(Produto:String;GRupo:Integer):Boolean;
    function validaidentificacao:Boolean;
    procedure Pc_NovoRegistro;
    procedure FocoCampoReferencia;

    procedure Pc_AlteraRegistro;
    procedure Pc_CancelaRegistro;
    procedure Pc_LimpaBalcao;
    procedure Pc_LimpaItens;
    procedure Pc_LimpaMesa;
    procedure Pc_LimpaPedido;
    procedure Pc_LimpaTudo;
    function Fc_ValidaCancelaRegistro: Boolean;
    function Fc_ValidaGravaPedido: Boolean;
    function Fc_validaGravaBalcao: Boolean;
    function Fc_validaGravaEntrega: Boolean;
    function MesaOcupada : Boolean;
    function Fc_validaGravaMesa: Boolean;
    procedure Pc_GravaPedido;
    procedure Pc_AtualizaRestaurante;
    procedure Pc_GravaEntrega;
    procedure Pc_CadastroCliente;
    function Fc_ValidaEntregaRegistro: Boolean;
    procedure Pc_EntregaRegistro;
    function Fc_ValidaFaturamento: Boolean;
    function Fc_FaturarRegistro:boolean;

    function Fc_ValidaImpressaoRegistro: Boolean;
    function Fc_ImprimeRegistro:boolean;

    procedure Pc_GeraNumeroPedido;

    procedure Pc_LimpaClienteEntrega;

    procedure Pc_MostraEntrega;
    procedure Pc_PreencherClienteBalcao;
    procedure Pc_PreencherClienteBalcaoCadastro;
    procedure Pc_PreencherClienteEntrega;

    procedure Pc_PreencherClienteMesa;
    procedure Pc_EstadoEdicaoOrdem;
    procedure Pc_PreencherOrdem;

    procedure Pc_PreencherItensVenda(Pc_Cd_Pedido:Integer);
    function Fc_ValidaAlteracao():Boolean;
    function Fc_ValidaExclusao():Boolean;
    Function Fc_validaExcluiItem():Boolean;

    Function Fc_validaImprimeItem():Boolean;
    procedure ImprimeItem;
    procedure SelecinaItensParaExcluir;
  public
    { Public declarations }
    It_Calculo_Pizza : String;
    It_Edicao_Ordem : String;
    //Controle Identificador de Chamadas
    Conectado : Boolean;
    Modo_Programacao: Boolean;
    Pedido : TControllerPedidoVda;

    //================================================================

    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    //Objetos da Interface
    procedure Pc_CriaBotao(Pc_Botao:TSpeedButton);
    procedure Pc_CriaPanel(Pc_Panel:TPanel);
    procedure Pc_CriasScrollbox(Pc_Panel:TScrollbox);

    function Fc_ValidaAbertura():Boolean;
    procedure Pc_FormataTela;
    procedure Pc_ImagemBotao;
    procedure Pc_IniciaVariveis;
    procedure Pc_CriaAbasAtendimento;

    procedure Pc_CriaAbaListaComposicao(Pc_Cd_grupo:Integer;Pc_Agrupa:String;Pc_Panel:TPanel);
    procedure Pc_CriaAreaListaComposicao(Pc_Cd_Codigo:Integer;Pc_Agrupa:String;Pc_Panel:TPanel);
    function  Fc_GrupoAgrupado(CodigoGrupo:Integer):Boolean;
    procedure Pc_MontaComposicao(Sender: TObject);
    procedure Pc_MontaComposicaoByEnter(Sender: TObject; var Key: Char);
    procedure Pc_MostraValorComposicao(Sender: TObject);
    procedure StGradeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Pc_CriaAreaComposicao(Pc_Cd_Grupo:Integer;Pc_Panel:TPanel);

    procedure Pc_ConfirmaItemComposicao(Sender: TObject);
    procedure Pc_LimpaItemComposicao(Sender: TObject);
    procedure Pc_MostraRecheioComposicao(Sender: TObject);

    procedure Pc_MostraRecheioSimples(Sender: TObject);

    procedure Pc_CriaAbaListaBotao(Pc_Cd_grupo:Integer;Pc_Panel:TPanel);
    procedure Pc_CriaAreaBotao(Pc_Cd_SubGrupo:Integer;Pc_Scroll:TScrollBox);
    procedure Pc_AdicionaItemBotao(Sender: TObject);
    procedure Pc_DesenhaCelula(Sender: TObject; ACol,ARow: Integer; Rect: TRect; State: TGridDrawState);

    procedure Pc_CriaAbaListaSimples(Pc_Cd_grupo:Integer;Pc_Panel:TPanel);
    procedure AbaListaSimplesDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);

    procedure Pc_CriaAreaListaSimples(Pc_Cd_SubGrupo:Integer;Pc_StGrade:TStringGrid);
    procedure Pc_ConfirmaItemListaSimples(Sender: TObject);

    procedure Pc_ChamaCadastroCliente;
    procedure Pc_BuscaCep(Pc_Cep: string);
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_totalizaItensPedido;
    procedure Pc_totalizaPedido;
    procedure AtualizaHistoricoClientes;
    procedure UtilizaClienteconsumidor;


  end;

var
  Fr_Pizzaria: TFr_Pizzaria;


implementation

uses     Un_DM, UN_MSG, UN_Sistema, DateUtils, Un_Regra_Negocio, Un_PizzariaItensMedida, UN_Principal, env, Un_PesqEndereco, Un_PesqPedPizza, RN_Pizzaria, RN_Pedido, PrintPizzaria, sea_pay_back, un_imp_fechamento, Un_CliResumo, RN_FormaPagto, Un_Fc_Sored_Procedures, RN_Estoque, Un_Cupom_Fiscal, RN_Itens_Vda_Avulso, RN_Crud, Un_PizzariaRecheios, Un_PizzariaEntrega, UN_TabelasEmListas, RI_MovimentoFinanceiro, Un_PizzariaImpressao, Un_PizzariaHistorico, Un_Caixa, UN_Imp_Pizzaria, Un_MostraRegraTributacao, Un_Imp_Comissao, RN_Permissao, Un_Funcoes, RN_NotaFiscalConsumidor, Un_Liberacao, api_route_cep;
{$R *.dfm}



procedure TFr_Pizzaria.Pc_PermissaoBotao(Pc_Menu: string);
begin
  It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
  It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
  It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
  It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
end;

procedure TFr_Pizzaria.Pc_totalizaItensPedido;
Var
  Lc_I : Integer;
  Lc_Qtde,Lc_Vl_Unit,Lc_Vl_SubTotal : Real;
  Lc_Qt_Total : real;
Begin
  Lc_Vl_SubTotal := 0;
  Lc_Qt_Total := 0;
  For Lc_I:= 1 to StrGrd_ItensVenda.RowCount - 1 do
  Begin
    Lc_Qtde := StrToFloatDef(StrGrd_ItensVenda.Cells[5,Lc_I],0);
    Lc_Qt_Total := Lc_Qt_Total + Lc_Qtde;
    Lc_Vl_Unit := StrToFloatDef(StrGrd_ItensVenda.Cells[6,Lc_I],0);
    Lc_Vl_SubTotal := Lc_Vl_SubTotal + (Lc_Qtde * Lc_Vl_Unit);
  end;
  E_Qt_Total.Caption := FloatToStrF(Lc_Qt_Total,ffFixed,10,2);
  E_VL_SubTotal.Text := FloatToStrF(Lc_Vl_SubTotal,ffFixed,10,2);
end;

procedure TFr_Pizzaria.Pc_totalizaPedido;
Var
  Lc_Vl_Subtotal,Lc_Vl_Adicional,
  Lc_Vl_Desconto, Lc_Vl_Entrega,
  Lc_VL_Total:Real;
Begin
  Lc_Vl_Subtotal := StrToFloatDef(E_VL_SubTotal.Text,0);
  E_VL_SubTotal.Text := FloatToStrF(Lc_Vl_Subtotal,ffFixed,10,2);

  Lc_Vl_Adicional := StrToFloatDef(E_VL_Adicional.Text,0);
  E_VL_Adicional.Text := FloatToStrF(Lc_Vl_Adicional,ffFixed,10,2);

  Lc_Vl_Desconto := StrToFloatDef(E_Vl_Desconto.Text,0);
  E_Vl_Desconto.Text := FloatToStrF(Lc_Vl_Desconto,ffFixed,10,2);

  Lc_Vl_Entrega := StrToFloatDef(E_VL_Entrega.Text,0);
  E_VL_Entrega.Text := FloatToStrF(Lc_Vl_Entrega,ffFixed,10,2);

  Lc_VL_Total := Lc_Vl_Subtotal + Lc_Vl_Adicional - Lc_Vl_Desconto + Lc_Vl_Entrega;
  E_Vl_Pedido.Text := FloatToStrF(Lc_VL_Total,ffFixed,10,2);
end;


procedure TFr_Pizzaria.PedidosIfood1Click(Sender: TObject);
Var
  Lc_Data : TDate;
begin
  MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                 'Sistema Ifood desativo temporariamente.' + EOLN +
                 'Está sob avaliação mercadológica.' + EOLN ,
                 ['OK'], [bEscape], mpInformacao);
  exit;
  if  true then
  Begin
    if Fr_Principal.ValidaAberturaFrenteCaixa then
    Begin
      Lc_Data := Date;
     if (Fc_Aq_Geral('L','IFOOD','TESTE','') = 'S') then
     Begin
        Gb_DataCaixa := strToDate(Fc_Aq_Geral('L','IFOOD','DATATESTE',''));
        Lc_Data := Gb_DataCaixa;
      end;
      if (Gb_DataCaixa < Lc_Data) then
      Begin
        MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                       'Para utilizar o Ifood o caixa aberto deve ser o de Hoje.' + EOLN +
                       'Verifique e tente novamente.' + EOLN ,
                       ['OK'], [bEscape], mpInformacao);
        if Fc_VerificaPermissao('Fr_Caixa','Lançamento Caixa','Visualizar',GB_Cd_Usuario,'S') then
          Fr_Principal.AbrirTelaCaixa;
        exit;
      end;

      //No futuro chamar o programa Ifood aqui
    end;
  End
  else
  Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Para utilizar o Ifood precisa de acesso a internet.' + EOLN +
                   'Verifique e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
  End;
end;

procedure TFr_Pizzaria.Pc_BuscaCep(Pc_Cep: string);
Var
  Lc_Cep : TCependereco;
begin
  Lc_Cep := Fc_BuscaPorCep(Pc_Cep);
  if (trim(Lc_Cep.FLogradouro) <> '') then
  Begin
    E_Endereco.Text := Lc_Cep.FLogradouro;
    E_Bairro.Text := Lc_Cep.FBairro;
    if E_Numero.CanFocus then E_Numero.SetFocus;
  end;
end;

procedure TFr_Pizzaria.Pc_CriaBotao(Pc_Botao:TSpeedButton);
Begin
  with Pc_Botao do
    Begin
    Top := 3;
    Height := 38;
    Width := 100;
    Font.Size := 10;
    Font.Name := 'Arial';
    Font.Color := clNavy;
    end;
end;
procedure TFr_Pizzaria.Pc_CriaPanel(Pc_Panel:TPanel);
Begin
  with Pc_Panel do
  Begin
    Align := alClient;
    BevelInner := bvRaised;
    BevelOuter := bvLowered;
    Caption := '';
  end;
end;

procedure TFr_Pizzaria.Pc_CriasScrollbox(Pc_Panel:TScrollbox);
Begin
  with Pc_Panel do
  Begin
    Align := alClient;
    BevelInner := bvRaised;
    BevelOuter := bvLowered;
    Caption := '';
  end;
end;

function TFr_Pizzaria.Fc_ValidaAbertura():Boolean;
Begin
  Result := true;

end;

procedure TFr_Pizzaria.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    CarregaImagemBotao(SB_Inserir,'INSERIR');
    CarregaImagemBotao(SB_Alterar,'ALTERAR');
    CarregaImagemBotao(SB_Excluir,'EXCLUIR');
    CarregaImagemBotao(SB_Gravar,'GRAVAR');
    CarregaImagemBotao(SB_Cancelar,'CANCELAR');
    CarregaImagemBotao(SB_Pesquisar,'PESQUISAR');
    CarregaImagemBotao(SB_Faturar,'FATURAR');
    CarregaImagemBotao(SB_Imprimir,'IMPRIMIR');
    CarregaImagemBotao(SB_Sair_1,'SAIR');
  END;

end;

procedure TFr_Pizzaria.Pc_FormataTela;
Var
  Lc_I : Integer;
Begin
  for Lc_I := 1 to Pg_modalidade.PageCount do
    Pg_modalidade.Pages[Lc_I - 1].TabVisible := False;
  Pg_modalidade.ActivePage := tbs_Entrega;
  top := 0;
  Pc_CriaAbasAtendimento;
  //Colunas Fixas
  with StrGrd_ItensVenda,Qr_Itens_RTR do
  Begin
    For Lc_I:= 0 to FieldCount -1 do
    Begin                                   
      ColWidths[Lc_I]:= Fields[Lc_I].Tag;
      Cols[Lc_I].Add(Fields[Lc_I].DisplayLabel);
    end;
  end;
  Pc_ImagemBotao;
end;

procedure TFr_Pizzaria.Pc_IniciaVariveis;
Begin
  Pc_LimpaTudo;
  PermiteReducaoValorEntrega := (Fc_Tb_Geral('L','PIZ_REDUZ_VL_ENTREGA','') = 'S');
  It_Calculo_Pizza := Fc_Tb_Geral('L','PIZ_CALC_PIZZA','1');

  CodigoConsumidor := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);


  It_Tra_Str_Ini_Piz := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_IDENT_STR_INI','3'),3);
  It_Tra_Str_Tam_Piz := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_IDENT_STR_TAM','8'),8);
  It_NFCe := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_VDA_NFCE', 'N') = 'S');

  Caption := 'Atendimento Pizzaria';
end;

procedure TFr_Pizzaria.Pc_CriaAbasAtendimento;
var
  Lc_Panel : TPanel;
  Lc_TabTipo: TTabSheet;
  Lc_PageControl : TPageControl;
  Lc_Qry : TSTQuery;
  Lc_I:Integer;
  LcBase : TControllerBase;
begin
  Try
    //Cria a consulta local para Montar o Cardapio
    LcBase := TControllerBase.create(nil);
    Lc_Qry :=  LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'SELECT DISTINCT GRP_CODIGO, GRP_DESCRICAO, GRP_AGRUPAR,',
              'GRP_COMPOSICAO,GRP_INTERFACE,GRP_TAMANHOS,GRP_PROG_TAM ',
              'FROM TB_GRUPOS ',
              '  INNER JOIN TB_SUBGRUPOS ',
              '  ON (GRP_CODIGO = SBG_CODGRP) ',
              'WHERE (GRP_SHOW_MENU = ''S'') ',
              ' and (SBG_ABAS IS NOT NULL) ',
              ' AND GRP_ATIVO = ''S'' ',
              ' ORDER BY GRP_SEQUENCIA,GRP_DESCRICAO,SBG_SEQUENCIA,SBG_DESCRICAO '
              ));
      Active:=true;
      FetchAll;
      First;
      Lc_I := 0;
      while not eof do
      Begin
        //Cria a Pagina do Page Control Tipos do Cardapio
        Lc_TabTipo := TTabSheet.Create(Pg_Cardapio);
        Lc_TabTipo.PageControl := Pg_Cardapio;
        Lc_TabTipo.Name := 'tbs_ref_grp_' + InttoStr(Lc_I);
        Lc_TabTipo.Caption := UpperCase(FieldByName('GRP_DESCRICAO').AsString);
        Lc_TabTipo.Tag := FieldByName('GRP_CODIGO').AsInteger;
        Lc_TabTipo.Font.Color := clNavy;
        //Cria o Panel para dar uma moldura ao tipo de Cardapio
        Lc_Panel := TPanel.Create(Lc_TabTipo);
        Lc_Panel.Name := 'Pnl_grp_' +  InttoStr(Lc_I);
        Pc_CriaPanel(Lc_Panel);
        Lc_Panel.Parent := Lc_TabTipo;
        //Monta as Abas em que teremos multiplos tamanhos
        if FieldByName('GRP_TAMANHOS').AsString = 'S' then
        Begin
          if FieldByName('GRP_INTERFACE').AsString = '1' then
          Begin
            //Monta a Aba onde a interface é uma lista de composição
            Pc_CriaAbaListaComposicao(FieldByName('GRP_CODIGO').AsInteger,FieldByName('GRP_AGRUPAR').AsString , Lc_Panel);
          end
          else
          Begin
            //Monta Uma lista onde a interface ~são botões
            Pc_CriaAbaListaBotao(FieldByName('GRP_CODIGO').AsInteger,Lc_Panel);
          end;
        end
        else
        Begin
          //Monta a Aba simples semm composição
          Pc_CriaAbaListaSimples(FieldByName('GRP_CODIGO').AsInteger,Lc_Panel);
        end;
        Next;
        Inc(Lc_I);
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Pizzaria.Pc_CriaAbaListaComposicao(Pc_Cd_grupo:Integer;Pc_Agrupa:String;Pc_Panel:TPanel);
Var
  Lc_PageControl : TPageControl;
  Lc_TabTipo : TTabSheet;
  Lc_Panel : TPanel;
  Lc_Qry : TSTQuery;
  Lc_I : Integer;
  LcBase : TControllerBase;
Begin
  if Pc_Agrupa = 'N' then
  Begin
    Try
      //Cria a pagecontrol do Tipo da da Cardapio
      Lc_PageControl := TPageControl.Create(Pc_Panel);
      Lc_PageControl.Name := 'Pg_ListaComposicaO';
      Lc_PageControl.Parent := Pc_Panel;
      Lc_PageControl.Align := alClient;
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add('SELECT SBG_CODIGO, SBG_DESCRICAO,SBG_ABAS '+
                'FROM TB_SUBGRUPOS '+
                'WHERE (SBG_CODGRP =:GRP_CODIGO) '+
                'ORDER BY SBG_SEQUENCIA,SBG_DESCRICAO');
        ParamByName('GRP_CODIGO').AsInteger := Pc_Cd_grupo;
        Active:=true;
        FetchAll;
        First;
        Lc_I := 0;
        while not eof do
        Begin
          //Cria a Pagina do Page Control Tipos do Cardapio
          Lc_TabTipo := TTabSheet.Create(Lc_PageControl);
          Lc_TabTipo.PageControl := Lc_PageControl;
          Lc_TabTipo.Name := 'tbs_ref_sbg_' + FieldByName('SBG_CODIGO').AsString;
          Lc_TabTipo.Caption := FieldByName('SBG_ABAS').AsString;
          Lc_TabTipo.Tag := FieldByName('SBG_CODIGO').AsInteger;
          //Cria o Panel para dar uma moldura ao tipo de Cardapio
          Lc_Panel := TPanel.Create(Lc_TabTipo);
          Lc_Panel.Name := 'Pnl_sbg_'+ FieldByName('SBG_CODIGO').AsString;
          Pc_CriaPanel(Lc_Panel);
          Lc_Panel.Parent := Lc_TabTipo;
          Pc_CriaAreaListaComposicao(FieldByName('SBG_CODIGO').AsInteger,Pc_Agrupa,Lc_Panel);
          Next;
          Inc(Lc_I);
        End;
      End;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      FreeAndNil(LcBase);
    End;
  end
  else
  Begin
    Pc_CriaAreaListaComposicao(Pc_Cd_grupo,Pc_Agrupa,Pc_Panel);
  end;
  Pc_CriaAreaComposicao( Pc_Cd_grupo, Pc_Panel);
end;

procedure TFr_Pizzaria.Pc_CriaAreaListaComposicao(Pc_Cd_Codigo:Integer;Pc_Agrupa:String;Pc_Panel:TPanel);
Var
  Lc_Qry : TSTQuery;
  Lc_Lista : TListBox;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if Pc_Agrupa = 'N' then
      Begin
        SQL.Add('SELECT DISTINCT PRO_DESCRICAO,PRO_FORA_LINHA '+
                'FROM TB_PRODUTO tb_produto '+
                'WHERE PRO_CODSBG=:SBG_CODIGO AND PRO_ATIVO=''S'' '+
                'ORDER BY PRO_DESCRICAO ');
        ParamByName('SBG_CODIGO').AsInteger := Pc_Cd_Codigo;
      end
      else
      Begin
        SQL.Add('SELECT DISTINCT PRO_DESCRICAO, PRO_FORA_LINHA '+
                'FROM TB_PRODUTO tb_produto '+
                'WHERE PRO_CODGRP=:GRP_CODIGO AND PRO_ATIVO=''S'' '+
                'ORDER BY PRO_DESCRICAO ');
        ParamByName('GRP_CODIGO').AsInteger := Pc_Cd_Codigo;
      end;
      Active := true;
      FetchAll;
      first;
      if recordCount > 0 then
      Begin
        //Cria o List Box
        Lc_Lista := TListBox.Create(Pc_Panel);
        Lc_Lista.Parent := Pc_Panel;//SELF; //
        Lc_Lista.Name := 'Lista_' + InttoStr(Pc_Cd_Codigo);
        Lc_Lista.tag := Pc_Cd_Codigo;
        Lc_Lista.OnDrawItem := ListBoxDrawItem;
        Lc_Lista.Align := alClient;
        Lc_Lista.Items.Clear;
        Lc_Lista.Columns := 2;
        Lc_Lista.Sorted := True;
        Lc_Lista.MultiSelect := False;
        Lc_Lista.AutoComplete := true;
        Lc_Lista.AutoCompleteDelay := 500;
        Lc_Lista.ExtendedSelect := True;
        Lc_Lista.ParentColor := False;
        Lc_Lista.ParentFont := false;
        Lc_Lista.Style := lbOwnerDrawFixed;
        try
          Lc_Lista.Items.BeginUpdate;
          while not Eof do
          begin
            IF (FieldByName('PRO_FORA_LINHA').AsString = 'N') then
              Lc_Lista.Items.AddObject(FieldByName('PRO_DESCRICAO').AsString, TObject(clBlack))
            else
              Lc_Lista.Items.AddObject(FieldByName('PRO_DESCRICAO').AsString, TObject(clRed));
            next;
          end;
        finally
          Lc_Lista.Items.EndUpdate;
        end;
        Lc_Lista.ItemIndex := 0;
        Lc_Lista.Selected[0]:= True;
        Lc_Lista.OnDblClick := Pc_MontaComposicao;
        Lc_Lista.OnKeyPress := Pc_MontaComposicaoByEnter;
        Lc_Lista.PopupMenu := pop_Pausa_By_Name;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function TFr_Pizzaria.Fc_GrupoAgrupado(CodigoGrupo:Integer):Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Sql.Add('SELECT GRP_AGRUPAR FROM TB_GRUPOS WHERE GRP_CODIGO =:GRP_CODIGO');
      parambyname('GRP_CODIGO').AsInteger := CodigoGrupo;
      active := True;
      Fetchall;
      Result := FieldByName('GRP_AGRUPAR').asString = 'S';
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
End;


function TFr_Pizzaria.Fc_ImprimeRegistro: boolean;
Var
  Form : TFr_PizzariaImpressao;
begin
  Try
    Result := False;
    Form := TFr_PizzariaImpressao.create(nil);
    Form.It_Pizzaria := True;
    Form.It_Cd_Cliente := Pedido.Cliente.Empresa.Registro.Codigo;
    Form.It_Cd_Pedido := Pedido.Registro.Codigo;
    Form.It_Nr_Pedido := Pedido.Registro.Numero;
    Form.E_VL_Total.Text := E_Vl_Pedido.Text;
    Form.It_NFCe := It_NFCe;
    Form.ShowModal;
    Result := Form.it_fatura_ok;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TFr_Pizzaria.Pc_MontaComposicao(Sender: TObject);
Var
  Lc_List : TListBox;
  Lc_Panel_1,Lc_Panel_2 : TPanel;
  Lc_Composicao : TPanel;
  Lc_Tabs : TTabSheet;
  Lc_Page : TPageControl;
  Lc_StrGrd : TStringGrid;
  Lc_Radio : TRadioButton;
  Lc_I,Lc_J : Integer;
  Lc_Produto : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Nr_Sabores : Integer;
  Lc_Agrupado : Boolean;
Begin
  //Sequencia de Comando para encontrar a StringString

  Lc_List  := TListBox.Create(Fr_Pizzaria);
  Lc_List  := TListBox(Sender);

  Lc_Panel_1 := TPanel.Create(Fr_Pizzaria);
  Lc_Panel_1 := TPanel(Lc_List.Parent);
  //Com esta tab pega no campo tag o grupo para saber se os subbrupos estão agrupados em uma aba ou não
  Lc_Tabs  := TTabSheet.Create(Fr_Pizzaria);
  Lc_Tabs  := TTabSheet(Lc_Panel_1.Parent);
  Lc_Agrupado := Fc_GrupoAgrupado(Lc_Tabs.Tag);
  if Lc_Agrupado then
  Begin
    Lc_Composicao := TPanel.Create(Fr_Pizzaria);
    Lc_Composicao := TPanel(Fc_LocalizaComponente(Lc_Panel_1,TPanel));
  End
  else
  Begin
    //PEgar o pg control do subgrupo
    Lc_Page  := TPageControl.Create(Fr_Pizzaria);
    Lc_Page  := TPageControl(Lc_Tabs.Parent);
    //PEga o Panel que agrupo os pg control
    Lc_Panel_2 := TPanel.Create(Fr_Pizzaria);
    Lc_Panel_2 := TPanel(Lc_Page.Parent);
    //Com o panel anterior eu pego o panel da composição
    Lc_Composicao := TPanel.Create(Fr_Pizzaria);
    Lc_Composicao := TPanel(Fc_LocalizaComponente(Lc_Panel_2,TPanel));

  End;

  Lc_Radio := TRadioButton.Create(Fr_Pizzaria);
  Lc_Radio := TRadioButton(Fc_LocalizaComponente(Lc_Composicao,TRadioButton));

  Lc_StrGrd := TStringGrid.Create(Fr_Pizzaria);
  Lc_StrGrd := TStringGrid(Fc_LocalizaComponente(Lc_Composicao,TStringGrid));

  //Verifica numero de Sabores
  Lc_Nr_Sabores := 0;
  For Lc_I := 0 to Lc_StrGrd.RowCount do
  Begin
    if trim(Lc_StrGrd.Cells[0,Lc_I])<> '' then
      inc(Lc_Nr_Sabores);
  end;

  if Lc_Nr_Sabores = 4 then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Número de Sabores para a composição foi atingido.' + EOLN +
                   'Não é possível carregar mais este sabor.'+ EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  end;

  Lc_Produto := Trim( Lc_List.Items.Strings[Lc_List.itemIndex]);

  if VerificaProdutoPausadoByName(Lc_Produto,Lc_List.Tag) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Este Produto está pausado para vendas.' + EOLN +
                   'Não é possível carregar mais este sabor.'+ EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  End;


  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    For Lc_I := 0 to Lc_StrGrd.RowCount do
    Begin
      if trim(Lc_StrGrd.Cells[0,Lc_I])= '' then
      Begin
        Lc_StrGrd.Cells[0,Lc_I] := Lc_Produto;
        //Preencher os Valores
        with Lc_Qry do
        Begin
          SQL.Clear;
          SQL.Add('SELECT distinct PRO_CODIGO,MED_ABREVIATURA, tb_normal.PRC_VL_VDA PRO_VL_NORMAL, tb_promocao.PRC_VL_VDA PRO_VL_PROMOCAO,PRO_CAMPANHA '+
                  'FROM tb_medida '+
                  '   INNER JOIN tb_produto '+
                  '   ON (tb_medida.med_codigo =tb_produto.PRO_CODMED) '+
                  '   INNER JOIN tb_preco tb_normal '+
                  '   ON ((tb_normal.prc_codpro = tb_produto.pro_codigo) and (tb_normal.PRC_CODTPR = 1)) '+
                  '   INNER JOIN tb_preco tb_promocao '+
                  '   ON ((tb_promocao.prc_codpro = tb_produto.pro_codigo) and (tb_promocao.prc_codtpr = 2)) ');
          if Lc_Agrupado then
            SQL.Add('WHERE (PRO_CODGRP=:GRP_CODIGO) ')
          else
            SQL.Add('WHERE (PRO_CODSBG=:SBG_CODIGO) ');

          SQL.Add(' AND (PRO_ATIVO=''S'') AND (PRO_DESCRICAO=:PRO_DESCRICAO)  and med_sequencia is not null '+
                  ' AND MED_ATIVO = ''S'' '+
                    'ORDER BY MED_SEQUENCIA,MED_DESCRICAO ');
          ParamByName('PRO_DESCRICAO').AsString := Lc_Produto;
          if Lc_Agrupado then
            ParamByName('GRP_CODIGO').AsInteger := Lc_List.Tag
          else
            ParamByName('SBG_CODIGO').AsInteger := Lc_List.Tag;
          Active := True;
          First;

          Lc_J := 0;
          while not eof do
          Begin
            Lc_StrGrd.Cells[Lc_J + 1 ,Lc_I] := FieldByname('PRO_CODIGO').AsString;
            Lc_StrGrd.Cells[Lc_J + 2 ,Lc_I] := FieldByname('MED_ABREVIATURA').AsString;
            //if (FieldByname('PRO_CAMPANHA').AsString = 'N') then
            if (FieldByname('PRO_VL_PROMOCAO').AsCurrency = 0) then
              Lc_StrGrd.Cells[Lc_J + 3,Lc_I] := FloatToStrF(FieldByname('PRO_VL_NORMAL').AsCurrency,ffFixed,10,2)
            else
              Lc_StrGrd.Cells[Lc_J + 3,Lc_I] := FloatToStrF(FieldByname('PRO_VL_PROMOCAO').AsCurrency,ffFixed,10,2);
            Lc_J := Lc_J + 3;
            next;
          end;
        End;
        Break;
      end;
    end;
    Lc_Radio.Checked := False;
    Lc_Radio.Checked := True;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Pizzaria.Pc_MontaComposicaoByEnter(Sender: TObject; var Key: Char);
Begin
  if (Key = #13) then Pc_MontaComposicao(Sender);
End;

procedure TFr_Pizzaria.Pc_MostraValorComposicao(Sender: TObject);
Var
  Lc_Radio : TRadioButton;
  Lc_Panel : TPanel;
  Lc_StrGrd : TStringGrid;
  Lc_Edit : TEdit_Setes;
  Lc_Valor : Real;
  Lc_SomaValor : Real;
  Lc_I,Lc_J : Integer;
Begin
  //Sequencia de Comando para encontrar a StringString
  Lc_Radio := TRadioButton.Create(Fr_Pizzaria);
  Lc_Radio := TRadioButton(Sender);

  Lc_Panel := TPanel.Create(Fr_Pizzaria);
  Lc_Panel := TPanel(Lc_Radio.Parent);

  Lc_Edit  := TEdit_Setes.Create(Fr_Pizzaria);
  Lc_Edit  := TEdit_Setes(Fc_LocalizaComponentePorNome(Lc_Panel,TEdit_Setes,'E_VL_Unit',9));

  Lc_StrGrd := TStringGrid.Create(Fr_Pizzaria);
  Lc_StrGrd := TStringGrid(Fc_LocalizaComponente(Lc_Panel,TStringGrid));
  //Registra na Grid qual tamanho foi clicado

  Lc_Valor := 0;
  Lc_J := 0;

  if It_Calculo_Pizza = '1' then
  Begin
    //Calcula pela Media dos Valores
    For Lc_I := 0 to Lc_StrGrd.RowCount do
    Begin
      Lc_StrGrd.Cells[Lc_StrGrd.ColCount,Lc_I] := FloatToStrF((Lc_Radio.tag-3)+1,ffFixed,10,0);
      if (StrToFloatDef(Lc_StrGrd.Cells[Lc_Radio.tag,Lc_I],0) > 0) then
      Begin
        Lc_Valor := Lc_Valor + StrToFloatDef(Lc_StrGrd.Cells[Lc_Radio.tag,Lc_I],0);
        inc(Lc_J);
      end;
    end;
    if (Lc_J > 0) and (Lc_Valor > 0)then
      Lc_Edit.Text := FloatToStrF(Lc_Valor/Lc_J,ffFixed,10,2)
    else
      Lc_Edit.Text := '0,00';
  end
  else
  Begin
    //Calculo pelo Maior Valor
    For Lc_I := 0 to Lc_StrGrd.RowCount do
    Begin
      Lc_StrGrd.Cells[Lc_StrGrd.ColCount,Lc_I] := FloatToStrF((Lc_Radio.tag-3)+1,ffFixed,10,0);
      if (StrToFloatDef(Lc_StrGrd.Cells[Lc_Radio.tag,Lc_I],0) > Lc_Valor) then
        Lc_Valor := StrToFloatDef(Lc_StrGrd.Cells[Lc_Radio.tag,Lc_I],0);
    end;
    Lc_Edit.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
  end;
end;

procedure TFr_Pizzaria.StGradeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = []) and ( Key = VK_delete ) then
  Begin
    Del_Linha_StringGrid(TStringGrid(Sender),TStringGrid(Sender).Row,4);
  end;
end;

procedure TFr_Pizzaria.Pc_CriaAreaComposicao(Pc_Cd_Grupo:Integer;Pc_Panel:TPanel);
Var
  Lc_Composicao : TPanel;
  Lc_StGrade : TStringGrid;
  Lc_Label : Tlabel;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Medida : TRadioButton;
  Lc_I,Lc_J :Integer;
  Lc_Edit:TEdit_Setes;
  Lc_Down: TUpDown;
  Lc_Botao : TSpeedButton;

Begin
  //Cria o Panel para dar uma moldura a composição do cardarpio
  Lc_Composicao := TPanel.Create(Pc_Panel);
  Lc_Composicao.Name := 'Pnl_CPS_'+ IntToStr(Pc_Cd_grupo);
  Pc_CriaPanel(Lc_Composicao);
  Lc_Composicao.Parent := Pc_Panel;
  Lc_Composicao.Align := alBottom;
  Lc_Composicao.Height := 139;
  //Cria a lista de tamanhos
  Lc_Label := Tlabel.Create(Fr_Pizzaria);
  With Lc_Label do
  Begin
    Parent := Lc_Composicao;
    Name := 'Lb_Tamanhos_' + IntToStr(Pc_Cd_grupo);
    Top := 2;
    Left := 7;
    Caption := 'Tamanhos Disponíveis';
    Font.Size := 10;
    Font.Name := 'MS Sans Serif';
    Font.Color := clNavy;
  end;

  //Cria os Radios das medidas
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT DISTINCT MED_ABREVIATURA '+
              'FROM TB_PRODUTO '+
              '  INNER JOIN TB_MEDIDA '+
              '  ON (MED_CODIGO = PRO_CODMED) '+
              '  INNER JOIN TB_GRUPOS '+
              '  on (GRP_CODIGO = PRO_CODGRP) '+
              'WHERE (PRO_TIPO = ''A'') AND (GRP_CODIGO=:GRP_CODIGO) and med_sequencia is not null '+
              ' AND (PRO_ATIVO = ''S'') '+
              ' AND (MED_ATIVO = ''S'') '+
              ' AND (GRP_ATIVO = ''S'') '+
              'ORDER BY MED_SEQUENCIA, MED_ABREVIATURA ');
      ParamByName('GRP_CODIGO').AsInteger := Pc_Cd_Grupo;
      Active := true;
      FetchAll;
      first;
      Lc_I := 0;
      while not eof do
        Begin
        Lc_Medida := TRadioButton.Create(Lc_Composicao);
        with Lc_Medida do
        Begin
          Parent := Lc_Composicao;
          Name := 'Rd_' +FieldByName('MED_ABREVIATURA').AsString;
          Tag := (Lc_I + 1) * 3; // Este é o indice da Coluna para pegar o valor da Pizza
          Top := 22;
          Width := 77;
          Left := 7 + (84 * Lc_I);
          Width := 77;
          Caption := FieldByName('MED_ABREVIATURA').AsString;
          Font.Size := 10;
          Font.Name :=  'MS Sans Serif';
          Font.Color := clNavy;
          OnClick := Pc_MostraValorComposicao;
        end;
        next;
        Inc(Lc_I);
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;


  //Cria a GRId com os Tamanhos do tipo de Cardapio
  Lc_StGrade := TStringGrid.Create(Lc_Composicao);
  with Lc_StGrade do
  Begin
    Parent := Lc_Composicao;
    Name := 'Stg_Composicao_'+ InttoStr(Pc_Cd_Grupo);
    Align := alNone;
    Top := 49;
    left := 1;
    Width := 397;
    Height := 89;
    Font.Size := 10;
    Font.Name :=  'MS Sans Serif';
    Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goTabs];
    Font.Color := clBlack;
    ColCount := (Lc_I * 3) + 3;
    RowCount := 4;
    FixedCols := 0;
    FixedRows := 0;
    DefaultRowHeight := 20;
    ColWidths[0] := 390;
    //0 - Nome do Produto
    //1 - Pro_codigo
    //2 - Tamanho Abreviatura
    //3 - Valor
    //Lc_I * Numero de Tamanhos
    For Lc_J := 1 to Lc_I do
      ColWidths[Lc_J] := 50;
    ScrollBars := ssNone;
    OnKeyDown := StGradeKeyDown;
  end;

  //Cria a Label quantidade
  Lc_Label := Tlabel.Create(Fr_Pizzaria);
  with Lc_Label do
  Begin
    Parent := Lc_Composicao;
    Name := 'Lb_Qtde_' + IntToStr(Pc_Cd_grupo);
    Top := 50;
    Left := 406;
    Caption := 'Quantidade';
    Font.Size := 10;
    Font.Name := 'MS Sans Serif';
    Font.Color := clNavy;
  end;
  //Campo Edit com a Quantidad
  Lc_Edit := TEdit_Setes.Create(Lc_Composicao);
  with Lc_Edit do
  Begin
    Parent := Lc_Composicao;
    Name := 'E_Qtde' + IntToStr(Pc_Cd_grupo);
    Alignment := taCenter;
    ReadOnly := True;
    Top := 66;
    Left := 406;
    Width := 72;
    Height := 28;
    Text := '1';
    Font.Size := 10;
    Font.Name := 'MS Sans Serif';
    Font.Color := clNavy;
  end;
    //Cria o componente upDowq
  Lc_Down := TUpDown.Create(Lc_Composicao);
  with Lc_Down do
  Begin
    Parent := Lc_Composicao;
    Name := 'Ud_Qtde' + IntToStr(Pc_Cd_grupo);
    Top := 66;
    Left := 479;
    Width := 24;
    Height := 32;
    Min := 1;
    Max := 100;
    Position := 1;
    Associate :=  Lc_Edit;
  end;
  //Cria a Label Valor Unitario
  Lc_Label := Tlabel.Create(Fr_Pizzaria);
  with Lc_Label do
    Begin
    Parent := Lc_Composicao;
    Name := 'Lb_Vl_Unit_' + IntToStr(Pc_Cd_grupo);
    Top := 50;
    Left := 506;
    Caption := 'Valor Unitário';
    Font.Size := 10;
    Font.Name := 'MS Sans Serif';
    Font.Color := clNavy;
    end;
  //Campo Edit com a Quantidad
  Lc_Edit := TEdit_Setes.Create(Lc_Composicao);
  with Lc_Edit do
    Begin
    Parent := Lc_Composicao;
    Name := 'E_VL_Unit' + IntToStr(Pc_Cd_grupo);
    Alignment := taRightJustify;
    Top := 66;
    Left := 506;
    Width := 120;
    Height := 28;
    //ReadOnly := True;
    Text := '0,00';
    Font.Size := 10;
    Font.Name := 'MS Sans Serif';
    Font.Color := clNavy;
    end;

  //Botão Recheio
  Lc_Botao := TSpeedButton.Create(Fr_Pizzaria);
  with Lc_Botao do
  Begin
    Parent := Lc_Composicao;
    Name := 'Sb_Recheio_' + IntToStr(Pc_Cd_grupo);
    Top := 96;
    Left := 405;
    Width := 74;
    Height := 41;
    Caption := 'Recheios';
    Font.Size := 10;
    Font.Name := 'MS Sans Serif';
    Font.Color := clNavy;
    OnClick := Pc_MostraRecheioComposicao;
  end;



  //Botão Limpa Item
  Lc_Botao := TSpeedButton.Create(Fr_Pizzaria);
  with Lc_Botao do
  Begin
    Parent := Lc_Composicao;
    Name := 'Sb_Limpa_' + IntToStr(Pc_Cd_grupo);
    Top := 96;
    Left := 480;
    Width := 74;
    Height := 41;
    Caption := 'Limpa';
    Font.Size := 10;
    Font.Name := 'MS Sans Serif';
    Font.Color := clNavy;
    OnClick := Pc_LimpaItemComposicao;
  end;
  //Botão Confirma Item
  Lc_Botao := TSpeedButton.Create(Fr_Pizzaria);
  with Lc_Botao do
  Begin
    Parent := Lc_Composicao;
    Name := 'Sb_Confirma_' + IntToStr(Pc_Cd_grupo);
    Top := 96;
    Left := 555;
    Width := 74;
    Height := 41;
    Caption := 'Confirma';
    Font.Size := 10;
    Font.Name := 'MS Sans Serif';
    Font.Color := clNavy;
    Onclick := Pc_ConfirmaItemComposicao;
  end;

end;


procedure TFr_Pizzaria.Pc_ConfirmaItemComposicao(Sender: TObject);
Var
  Lc_List : TListBox;
  Lc_Panel : TPanel;
  Lc_Composicao : TPanel;
  Lc_Tabs : TTabSheet;
  Lc_Page : TPageControl;
  Lc_StrGrd : TStringGrid;
  Lc_Radio : TRadioButton;
  Lc_I,Lc_J,Lc_Nr_Sabores : Integer;
  Lc_Edit : TEdit_Setes;
  Lc_Botao : TSpeedButton;
  Lc_Qtde,Lc_Vl_Unit : Real;
  Lc_Ind_Tamanho : Integer;
  Lc_Mostra_Valor : Boolean;
  Lc_Nr_Item : Integer;
  Lc_Valor : Real;
  Lc_Str_Valor : String;
  Lc_Vl_SubTotal : Real;
  Lc_descricao_produto : String;
Begin

   //Sequencia de Comando para encontrar a StringString
  Lc_Botao := TSpeedButton.Create(Fr_Pizzaria);
  Lc_Botao := TSpeedButton(Sender);

  Lc_Panel := TPanel.Create(Fr_Pizzaria);
  Lc_Panel := TPanel(Lc_Botao.Parent);

  Lc_Radio := TRadioButton.Create(Fr_Pizzaria);
  Lc_Radio := TRadioButton(Fc_LocalizaComponente(Lc_Panel,TRadioButton));

  Lc_StrGrd := TStringGrid.Create(Fr_Pizzaria);
  Lc_StrGrd := TStringGrid(Fc_LocalizaComponente(Lc_Panel,TStringGrid));

  //Verifica numero de Sabores
  Lc_Nr_Sabores := 0;
  For Lc_I := 0 to Lc_StrGrd.RowCount do
  Begin
    if trim(Lc_StrGrd.Cells[0,Lc_I])<> '' then
      inc(Lc_Nr_Sabores);
  end;

  if Lc_Nr_Sabores = 0 then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Por favor monte a composição antes de Continuar.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  end;

  Lc_Edit  := TEdit_Setes.Create(Fr_Pizzaria);
  Lc_Edit  := TEdit_Setes(Fc_LocalizaComponentePorNome(Lc_Panel,TEdit_Setes,'E_VL_Unit',9));
  Lc_Vl_Unit := StrToFloatDef(Lc_Edit.Text,0);
  if (Lc_Vl_Unit = 0 ) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'O valor Unitário deve ser maior do que 0(Zero).' + EOLN + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  end;

  Lc_Edit  := TEdit_Setes.Create(Fr_Pizzaria);
  Lc_Edit  := TEdit_Setes(Fc_LocalizaComponentePorNome(Lc_Panel,TEdit_Setes,'E_Qtde',6));
  Lc_Qtde := StrToFloatDef(Lc_Edit.Text,0);
  if (Lc_Qtde = 0) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'A quantidade deve ser maior do que 0(Zero).' + EOLN + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  end;
  //Grava o pedido caso não tenha sido gravado ainda
  IF (Pedido.Registro.codigo = 0) then
  Begin
    if Fc_ValidaGravaPedido then
    Begin
      Pc_GravaPedido;
    end
    else
    Begin
      Exit;
    end;
  end;
  //Pega os Valores dos adicionais da pizza
  Lc_Valor := 0;
  For Lc_I := 0 to Lc_StrGrd.RowCount do
    Lc_Valor := Lc_Valor + StrToFloatDef(Lc_StrGrd.Cells[(Lc_StrGrd.Colcount-1),Lc_I],0);
  //Adiciona ao valor unitario
  Lc_Vl_Unit := Lc_Vl_Unit + Lc_Valor;
  //FAz a inclusão dos itens
  Lc_Nr_Item := Fc_GeraProximoNrItem(Pedido.Registro.codigo);
  Lc_Valor := Lc_Vl_Unit / Lc_Nr_Sabores;
  Lc_Str_Valor := FloatToStrf(Lc_Valor,ffFixed,10,2);
  Lc_Valor := StrToFloatDef(Lc_Str_Valor,0);

  For Lc_I := 0 to Lc_StrGrd.RowCount do
  Begin
    if trim(Lc_StrGrd.Cells[0,Lc_I])<> '' then
    Begin
      Lc_Ind_Tamanho := StrToIntdef(Lc_StrGrd.Cells[Lc_StrGrd.ColCount,Lc_I],0);
      //SÓ mostra o Valor no ultimo sabor
      Lc_Mostra_Valor := False;
      Lc_Vl_SubTotal := 0;
      if ( Lc_Nr_Sabores = (Lc_I + 1)) then
      Begin
        Lc_Mostra_Valor := True;
        Lc_Valor := Lc_Valor * (Lc_Nr_Sabores - 1 );
        Lc_Valor := Lc_VL_Unit - Lc_Valor;
        Lc_Vl_SubTotal := Lc_VL_Unit;
      End;

      Lc_descricao_produto := Lc_StrGrd.Cells[Lc_Ind_Tamanho+1,Lc_I] + ' - ' + Lc_StrGrd.Cells[0,Lc_I] + '/' + IntToStr(Lc_Nr_Sabores);

      with Pedido.Itens.Registro do
      Begin
        Codigo            := 0;
        Sequencia         := Lc_Nr_Item;
        CodigoPedido      := Pedido.Registro.codigo;
        CodigoNota        := 0;
        CodigoProduto     := StrToIntdef(Lc_StrGrd.Cells[(Lc_Ind_Tamanho),Lc_I],0);
        Quantidade        := Lc_Qtde;
        ValorCusto        := 0;
        ValorUnitario     := Lc_valor;
        Despachar         := 'N';
        Estoque           := 'S';
        AliqComissao      := 0;
        ValorDesconto     := 0;
        AliqDesconto      := 0;
        AliqIPI           := 0;
        Operacao          := 'V';
        AliqICMS          := 0;
        CodigoEstoque     := gb_Estoque;
        CodigoTabela      := 1;
        Altura            := 0;
        Largura           := 0;
        Sentido           := 'S';
        PedidoCompra      := '';
        ItemCompra        := '';
        ImpostoAproximado := 0;
        NumeroPecas       := 0;
      End;
      Pedido.Itens.insere;
      //AVL
      with Pedido.Itens.ItensAvulso.Registro do
      Begin
        Codigo        := Pedido.Itens.Registro.Codigo;
        Unidade       := 'UND';
        Descricao     := Lc_descricao_produto;
      End;
      Pedido.Itens.ItensAvulso.insere;
      //RTR
      with Pedido.Itens.ItensRTR.Registro do
      Begin
        Item          := Pedido.Itens.Registro.Codigo;
        NrITem        := Lc_Nr_Item;
        Descricao     := Lc_descricao_produto;
        Qtde          := 0; //será colocado no ultimo;
        ValorUnitario := 0;//será colocadp no ultimo
        Observacao    := Copy(Lc_StrGrd.Cells[(Lc_StrGrd.Colcount-2),Lc_I],1,100);
        Garcon        := 0;
        SubGrupo      := 0;
        Cortesia      := 'N';
      End;
      Pedido.Itens.ItensRTR.insere;
      //Estoque
      with Pedido.CtrlEstoque.Registro do
      Begin
        Codigo      := 0;
        Terminal    := Gb_Terminal;
        Vinculo     := 'P';
        Ordem       := Pedido.Registro.codigo;
        Item        := Pedido.Itens.Registro.Codigo;
        Estoque     := Gb_Estoque;
        operacao    := 'S';
        Produto     := Pedido.Itens.Registro.CodigoProduto;
        Quantidade  := Pedido.Itens.Registro.Quantidade;
        Data        := Pedido.registro.Data;
        Tipo        := 'Venda';
        UpdateAt    := Now;
      End;
      Pedido.CtrlEstoque.Registra;

      Pc_PreencherItensVenda(Pedido.Registro.codigo);
      Pc_totalizaItensPedido;
      Pc_totalizaPedido;
      Pc_GravaPedido;
    end;
  end;
  //Atualiza o ultimo item do RTR
  Pedido.Itens.ItensRTR.updateQtdeLasItem(Pedido.Registro.codigo, Pedido.Itens.ItensRTR.Registro.NrITem, Lc_Vl_SubTotal,Lc_Qtde);
  //Prenche os itens da venda;
  Pc_PreencherItensVenda(Pedido.Registro.codigo);
  Pc_totalizaItensPedido;
  Pc_totalizaPedido;
  Pc_GravaPedido;
  //Limpa oscampos
  For Lc_I := 0 to Lc_StrGrd.RowCount do
    For Lc_J := 0 to Lc_StrGrd.ColCount do
      Lc_StrGrd.Cells[Lc_J,Lc_I] := '';
  Lc_StrGrd.RowCount := 4;
  //Quantidade
  Lc_Edit  := TEdit_Setes.Create(Fr_Pizzaria);
  Lc_Edit  := TEdit_Setes(Fc_LocalizaComponentePorNome(Lc_Panel,TEdit_Setes,'E_Qtde',6));
  Lc_Edit.Text := '1,00';
  //Valores
  Lc_Edit  := TEdit_Setes.Create(Fr_Pizzaria);
  Lc_Edit  := TEdit_Setes(Fc_LocalizaComponentePorNome(Lc_Panel,TEdit_Setes,'E_VL_Unit',9));
  Lc_Edit.Text := '0,00';
end;

procedure TFr_Pizzaria.Pc_LimpaItemComposicao(Sender: TObject);
Var
  Lc_Botao : TSpeedButton;
  Lc_Panel : TPanel;
  Lc_StrGrd : TStringGrid;
  Lc_I,Lc_J : Integer;
  Lc_Edit : TEdit_Setes;
Begin
  //Sequencia de Comando para encontrar a StringString
  Lc_Botao := TSpeedButton.Create(Fr_Pizzaria);
  Lc_Botao := TSpeedButton(Sender);

  Lc_Panel := TPanel.Create(Fr_Pizzaria);
  Lc_Panel := TPanel(Lc_Botao.Parent);

  Lc_StrGrd := TStringGrid.Create(Fr_Pizzaria);
  Lc_StrGrd := TStringGrid(Fc_LocalizaComponente(Lc_Panel,TStringGrid));

  Lc_Edit  := TEdit_Setes.Create(Fr_Pizzaria);
  Lc_Edit  := TEdit_Setes(Fc_LocalizaComponentePorNome(Lc_Panel,TEdit_Setes,'E_VL_Unit',9));
  Lc_Edit.Text := '0,00';

  For Lc_I := 0 to Lc_StrGrd.RowCount do
    For Lc_J := 0 to Lc_StrGrd.ColCount do
      Lc_StrGrd.Cells[Lc_J,Lc_I] := '';
  Lc_StrGrd.RowCount := 4;
end;

procedure TFr_Pizzaria.Pc_MostraRecheioComposicao(Sender: TObject);
Var
  Lc_Fr_Recheio : TFr_PizzariaRecheios;
  Lc_Panel : TPanel;
  Lc_StrGrd : TStringGrid;
  Lc_I : Integer;
  Lc_Coluna : Integer;
  Lc_Obs : TStringList;
  Lc_Aux : String;
  Lc_Valor : Real;
Begin
  Lc_Panel := TPanel.Create(Self);
  Lc_Panel := TPanel(TSpeedButton(Sender).Parent);

  Lc_StrGrd := TStringGrid.Create(Self);
  Lc_StrGrd := TStringGrid(Fc_LocalizaComponente(Lc_Panel,TStringGrid));
  if (Lc_StrGrd.Cells[0,Lc_StrGrd.Row]<> '') then
  Begin
    Lc_Fr_Recheio := TFr_PizzariaRecheios.Create(Self);
    with Lc_Fr_Recheio do
    Begin
      It_Ds_Sabor := Lc_StrGrd.Cells[0,Lc_StrGrd.Row];
      ShowModal;
      if (It_Confirma) then
      Begin
        Try
          Lc_Obs := TStringList.Create;
          if Trim(E_OpcaoLivre.Text)<> '' then
            Lc_Obs.Append(E_OpcaoLivre.Text);
          Lc_Coluna := (Lc_StrGrd.ColCount - 1);
          Lc_Valor := 0;
          For Lc_I:= 1 to (StrGrd_Recheio.RowCount - 1) do
          Begin
            if (StrGrd_Recheio.Cells[2,Lc_I] = '') and (StrGrd_Recheio.Cells[5,Lc_I] = 'Padrão') then
              Lc_Obs.Append('S/' + StrGrd_Recheio.Cells[4,Lc_I])
            else
            if (StrGrd_Recheio.Cells[2,Lc_I] = 'X') and (StrGrd_Recheio.Cells[5,Lc_I] = 'Opcional') then
            Begin
              Lc_Obs.Append('C/' + StrGrd_Recheio.Cells[4,Lc_I]);
              Lc_Valor := Lc_Valor  + StrToFloatDef(StrGrd_Recheio.Cells[7,Lc_I],0);
            End;
          end;
          //Preenche a Grid da composição
          if (Lc_Obs.Count > 0) then
          Begin
            For Lc_I:= 0 to (Lc_Obs.Count-1) do
            Begin
              if (Lc_I = 0) then
                Lc_Aux := Trim( Lc_Obs.Strings[lc_I] )
              else
                Lc_Aux := Trim( Lc_Aux + '|' + Lc_Obs.Strings[lc_I] );
            end;
            Lc_StrGrd.Cells[(Lc_StrGrd.ColCount-2),Lc_StrGrd.Row] := Lc_Aux;
            Lc_StrGrd.Cells[(Lc_StrGrd.ColCount-1),Lc_StrGrd.Row] := FloatToStr(Lc_Valor);
          end;
        Finally
          FreeAndNil(Lc_Obs);
        End;
      end;
    end;
    FreeAndNil(Lc_Fr_Recheio);
  end
  else
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor escolha um sabor primeiro.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  end;

end;

procedure TFr_Pizzaria.Pc_MostraRecheioSimples(Sender: TObject);
Var
  Lc_Fr_Recheio : TFr_PizzariaRecheios;
  Lc_Panel : TPanel;
  Lc_StrGrd : TStringGrid;
  Lc_I : Integer;
  Lc_Coluna : Integer;
  Lc_Obs : TStringList;
  Lc_Aux : String;
  Lc_Valor : Real;
Begin
  Lc_Panel := TPanel.Create(Self);
  Lc_Panel := TPanel(TSpeedButton(Sender).Parent);

  Lc_StrGrd := TStringGrid.Create(Self);
  Lc_StrGrd := TStringGrid(Fc_LocalizaComponente(Lc_Panel.Parent,TStringGrid));
  if (Lc_StrGrd.Cells[0,Lc_StrGrd.Row]<> '') then
  Begin
    Lc_Fr_Recheio := TFr_PizzariaRecheios.Create(nil);
    with Lc_Fr_Recheio do
    Begin
      It_Ds_Sabor := Lc_StrGrd.Cells[0,Lc_StrGrd.Row];
      ShowModal;
      if (It_Confirma) then
      Begin
        Try
          Lc_Obs := TStringList.Create;
          if Trim(E_OpcaoLivre.Text)<> '' then
            Lc_Obs.Append(E_OpcaoLivre.Text);
          Lc_Coluna := (Lc_StrGrd.ColCount - 1);
          Lc_Valor := 0;
          For Lc_I:= 1 to (StrGrd_Recheio.RowCount - 1) do
          Begin
            if (StrGrd_Recheio.Cells[2,Lc_I] = '') and (StrGrd_Recheio.Cells[5,Lc_I] = 'Padrão') then
              Lc_Obs.Append('S/' + StrGrd_Recheio.Cells[4,Lc_I])
            else
            if (StrGrd_Recheio.Cells[2,Lc_I] = 'X') and (StrGrd_Recheio.Cells[5,Lc_I] = 'Opcional') then
            Begin
              Lc_Obs.Append('C/' + StrGrd_Recheio.Cells[4,Lc_I]);
              Lc_Valor := Lc_Valor  + StrToFloatDef(StrGrd_Recheio.Cells[7,Lc_I],0);
            End;
          end;
          //Preenche a Grid da composição
          if (Lc_Obs.Count > 0) then
          Begin
            For Lc_I:= 0 to (Lc_Obs.Count-1) do
            Begin
              if (Lc_I = 0) then
                Lc_Aux := Trim( Lc_Obs.Strings[lc_I] )
              else
                Lc_Aux := Trim( Lc_Aux + '|' + Lc_Obs.Strings[lc_I] );
            end;
            Obs_RecheioListaSimples := Lc_Aux;
            Vlr_RecheioListaSimples := Lc_Valor;
          end;
        Finally
          FreeAndNil(Lc_Obs);
        End;
      end;
    end;
    FreeAndNil(Lc_Fr_Recheio);
  end
  else
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor escolha um item primeiro.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  end;
end;

procedure TFr_Pizzaria.Pc_CriaAbaListaBotao(Pc_Cd_grupo:Integer;Pc_Panel:TPanel);
Var
  Lc_PageControl : TPageControl;
  Lc_TabTipo : TTabSheet;
  Lc_Scroll : TScrollBox;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_I : Integer;
Begin
  //Cria a pagecontrol do Tipo da da Cardapio
  Lc_PageControl := TPageControl.Create(Pc_Panel);
  Lc_PageControl.Name := 'Pg_ListaComposica';
  Lc_PageControl.Parent := Pc_Panel;
  Lc_PageControl.Align := alClient;
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT SBG_CODIGO, SBG_DESCRICAO,sbg_Abas '+
              'FROM TB_SUBGRUPOS '+
              'WHERE (SBG_CODGRP =:GRP_CODIGO) '+
              'ORDER BY SBG_SEQUENCIA, SBG_DESCRICAO');
      ParamByName('GRP_CODIGO').AsInteger := Pc_Cd_grupo;
      Active:=true;
      FetchAll;
      First;
      Lc_I := 0;
      while not eof do
      Begin
        //Cria a Pagina do Page Control Tipos do Cardapio
        Lc_TabTipo := TTabSheet.Create(Lc_PageControl);
        Lc_TabTipo.PageControl := Lc_PageControl;
        Lc_TabTipo.Name := 'tbs_ref_sbg_' + FieldByName('SBG_CODIGO').AsString;
        Lc_TabTipo.Caption := FieldByName('SBG_ABAS').AsString;
        Lc_TabTipo.Tag := FieldByName('SBG_CODIGO').AsInteger;
        //Cria o Panel para dar uma moldura ao tipo de Cardapio
        Lc_Scroll := TScrollBox.Create(Lc_TabTipo);
        Lc_Scroll.Name := 'Pnl_sbg_'+ FieldByName('SBG_CODIGO').AsString;
        Pc_CriasScrollbox(Lc_Scroll);
        Lc_Scroll.Parent := Lc_TabTipo;
        Pc_CriaAreaBotao(FieldByName('SBG_CODIGO').AsInteger,Lc_Scroll);
        Next;
        Inc(Lc_I);
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
END;

procedure TFr_Pizzaria.Pc_CriaAreaBotao(Pc_Cd_SubGrupo:Integer;Pc_Scroll:TScrollBox);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Botao : TSpeedButton;
  Lc_Linha : integer;
  Lc_Nr_botao : integer;
  Lc_Pos_Top : integer;
  Lc_Pos_Left : integer;
  Lc_Coluna : Integer;
  Lc_Nr_Colunas : Integer;
  St_Image:TStream;
  Jp_IMage: TBitmap; // sem a unit 'jpeg' essa classe não existiria
Begin
  //Cria os Botoes
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT DISTINCT BTN_CODIGO, IBT_SEQUENCIA, BTN_ALTURA, BTN_LARGURA, '+
               'BTN_LABEL, BTN_MRG_SUP, BTN_IMAGEM '+
               'FROM TB_PRODUTO tb_produto '+
               '   INNER JOIN TB_ITENS_BTN tb_itens_btn '+
               '   ON (tb_itens_btn.IBT_CODPRO = tb_produto.PRO_CODIGO) '+
               '   INNER JOIN TB_BOTAO tb_botao '+
               '   ON (tb_botao.BTN_CODIGO = tb_itens_btn.IBT_CODBTN) '+
               '   INNER JOIN TB_SUBGRUPOS tb_subgrupos '+
               '   ON (tb_subgrupos.SBG_CODIGO = tb_produto.PRO_CODSBG) '+
               'WHERE SBG_CODIGO=:SBG_CODIGO '+
               ' AND (PRO_ATIVO = ''S'') '+
               'ORDER BY IBT_SEQUENCIA, BTN_IMAGEM DESC ');
      ParamByName('SBG_CODIGO').AsInteger := Pc_Cd_sUBGrupo;
      Active := true;
      FetchAll;
      first;
      if recordCount > 0 then
      Begin
        Lc_Linha := 1;
        Lc_Nr_botao := 1;
        Lc_Pos_Top := 2;
        Lc_Pos_Left := 2;
        Lc_Nr_Colunas := trunc(Pg_Cardapio.Width / fieldByName('BTN_LARGURA').AsInteger) -1;
        while not Eof do
        begin
          for Lc_Coluna := 1 to Lc_Nr_Colunas  do
          Begin
            //Cria Componentes
            if not Eof then
            Begin
              Lc_Botao := TSpeedButton.Create(Fr_Pizzaria);
              with Lc_Botao do
              Begin
                Parent := Pc_Scroll;
                Name := 'Sb_' + IntToStr(Pc_Cd_SubGrupo) + '_' + IntToStr(Lc_Nr_botao);
                Font.Size := 9;
                Font.Color := clNavy;
                Font.Style := [fsBold];
                Top := Lc_Pos_Top;
                Left := Lc_Pos_Left;
                Lc_Pos_Left := Lc_Pos_Left + fieldByName('BTN_LARGURA').AsInteger + 1;
                Width := fieldByName('BTN_LARGURA').AsInteger;
                Height := fieldByName('BTN_ALTURA').AsInteger;
                Caption := fieldByName('BTN_LABEL').AsString;
                tag := fieldByName('BTN_CODIGO').AsInteger;
                Layout := blGlyphTop;
                try
                  Jp_IMage := nil;
                  St_Image := CreateBlobStream(FieldByName('BTN_IMAGEM'),bmRead);
                  if St_Image.Size > 0 then
                  begin
                    Jp_IMage := TBitmap.Create;
                    Jp_IMage.LoadFromStream(St_Image);
                    Margin := fieldByName('BTN_MRG_SUP').AsInteger;
                    Glyph.Assign(Jp_IMage);
                  end;
                finally
                  FreeAndNil(St_Image);
                  DM.Qr_ImagenBotao.Close;
                  FreeAndNil(Jp_IMage);
                end;
                OnClick := Pc_AdicionaItemBotao;
              end;
              Inc(Lc_Nr_botao);
              Next;
            end;
          end;
          Lc_Pos_Top := Lc_Pos_Top + fieldByName('BTN_ALTURA').AsInteger  ;
          Lc_Pos_Left := 2;
          Inc(Lc_Linha);
        end;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Pizzaria.MnuPausaByCodigoClick(Sender: TObject);
Var
  Caller: TObject;
  Lc_Grid : TStringGrid;
  Lc_Produto: Integer;
begin
  Caller := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  Lc_Grid := (Caller as TStringGrid);
  Lc_Produto := StrToIntDef( Lc_Grid.Cells[0,Lc_Grid.Row],0);
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja relamente Pausar a Venda deste Item?.' + EOLN +
                     'Confirmar a Operação ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  Begin
    PausarHabilitarItemByCodigo(True,Lc_Produto);
    Lc_Grid.Cells[4,Lc_Grid.Row] := 'S';
  End;

end;

procedure TFr_Pizzaria.MnuPausarByNameClick(Sender: TObject);
Var
 Caller: TObject;
 Lc_Produto : String;
 Lc_Index : Integer;
begin
  Caller := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  Lc_Index := (Caller as TListBox).itemIndex;
  if (Lc_Index < 0 ) then
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'Por favor revise o item marcado.' + EOLN +
                   'Verifique se está devidamente selecionado.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Exit;
  End;

  Lc_Produto := Trim( (Caller as TListBox).Items.Strings[(Caller as TListBox).itemIndex]);
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja relamente Pausar a Venda deste Item?.' + EOLN +
                     'Confirmar a Operação ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  Begin
    PausarHabilitarItemByName(True,Lc_Produto,(Caller as TListBox).Tag);
    Lc_Index := (Caller as TListBox).itemIndex;
    (Caller as TListBox).DeleteSelected;
    (Caller as TListBox).Items.InsertObject(Lc_Index,Lc_Produto, TObject(clRed));
  End;
end;

procedure TFr_Pizzaria.PausarHabilitarItemByCodigo(Pausa: Boolean;
  Produto: Integer);
Var
  Lc_DskRestMenu : TControllerDskRestMenu;
begin
  try
    Lc_DskRestMenu := TControllerDskRestMenu.Create(nil);
    if Pausa then
      Lc_DskRestMenu.PausarHabilitarItemByCodigo('S',Produto)
    else
      Lc_DskRestMenu.PausarHabilitarItemByCodigo('N',Produto);
  finally
    FreeAndNil(Lc_DskRestMenu);
  end;


end;

procedure TFr_Pizzaria.PausarHabilitarItemByName(Pausa:Boolean;Produto: String; GRupo: Integer);
Var
  Lc_DskRestMenu : TControllerDskRestMenu;
begin
  try
    Lc_DskRestMenu := TControllerDskRestMenu.Create(nil);
    if Pausa then
      Lc_DskRestMenu.PausarHabilitarItemByName('S',Produto,Grupo)
    else
      Lc_DskRestMenu.PausarHabilitarItemByName('N',Produto,Grupo);
  finally
    FreeAndNil(Lc_DskRestMenu);
  end;
end;

procedure TFr_Pizzaria.Pc_AdicionaItemBotao(Sender: TObject);
Var
  Lc_Botao : TSpeedButton;
  Lc_Form : TFr_PizzariaItensMedida;
Begin
  Try
    Lc_Botao := TSpeedButton.Create(Self);
    Lc_Botao := TSpeedButton(sender);

    //Chama o formulario dos tamanhos
    Lc_Form := TFr_PizzariaItensMedida.Create(nil);
    Lc_Form.It_Cd_Botao := Lc_Botao.Tag;
    Lc_Form.ShowModal;
    if Lc_Form.It_Confirma then
    Begin
      //Grava o pedido caso não tenha sido gravado ainda
      IF (Pedido.Registro.codigo = 0) then
      Begin
        if Fc_ValidaGravaPedido then
        Begin
          Pc_GravaPedido;
        end
        else
        Begin
          Exit;
        end;
      end;
      Pc_GravaItemVenda( Pedido.Registro.codigo,
                        Fc_GeraProximoNrItem(Pedido.Registro.codigo),
                        Lc_Form.It_Cd_Produto,
                        0,
                        Lc_Form.It_Cd_SubGrupo,
                        Lc_Form.It_Ds_Produto + ' ' + Lc_Form.It_Ds_Medida,
                        '',
                        'N',
                        Lc_Form.It_qtde,
                        Lc_Form.It_VL_Unit,
                        0,
                        Gb_Datacaixa,
                        1,
                        Lc_Form.It_VL_Unit,
                        True);
      Pc_PreencherItensVenda(Pedido.Registro.codigo);
      Pc_totalizaItensPedido;
      Pc_totalizaPedido;
      Pc_GravaPedido;
      Pc_PreencherItensVenda(Pedido.Registro.codigo);
      Pc_totalizaItensPedido;
      Pc_totalizaPedido;
      Pc_GravaPedido;
    end;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_Pizzaria.Pc_DesenhaCelula(Sender: TObject; ACol,ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   LarguraTexto, AlturaTexto, X, Y: integer;
   Texto: string;
   Lc_Lista : TStringGrid;
   Lc_Valor : Real;
begin
  Lc_Lista := TStringGrid.Create(Fr_Pizzaria);
  Lc_Lista := TStringGrid(sender);
  if (arow > 0) and (acol > 0) then // testa se não é a primeira linha (fixa)
    Begin
    if (Rect.Top = TStringGrid(Lc_Lista).CellRect( aCol ,TStringGrid(Lc_Lista).Row).Top)
        or( gdSelected in State)  then
      begin
      Canvas.FillRect(Rect);
      Lc_Lista.Canvas.Font.Color := clBlack;
      Canvas.Brush.Color := clNavy;
      end
    else
      Begin
      Lc_Lista.Canvas.Font.Color := clBlack;
      Lc_Lista.Canvas.Brush.Color := clCream;
      end;
    end;
  Lc_Lista.Canvas.FillRect(Rect); // redesenha a celula
  Lc_Lista.Canvas.TextOut(Rect.Left + 2, Rect.Top, Lc_Lista.Cells[acol, arow]); // reimprime o texto.


  // Pega o texto da célula
    if (arow > 0) and (acol > 1) then
      Begin
      Lc_Valor := StrToFloatDef(Lc_Lista.Cells[acol, ARow],0);
      Texto :=  FloatToStrF(Lc_Valor,ffFixed,10,2) +  ' ';
      end
    else
      Begin
      Texto := Lc_Lista.Cells[acol, ARow] +  ' ';
      end;

  // Calcura largura e altura (em pontos) do texto
   LarguraTexto := Lc_Lista.Canvas.TextWidth(Texto);
   AlturaTexto := Lc_Lista.Canvas.TextHeight(Texto);

  { Calcula a posição horizontal do início do texto }
  if  (ACol = 0) OR (ACol = 1) then { esquerda }
    X := Rect.Left + 2
  else if  (ACol = 13) then { Centro }
    X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
  else { Direita }
    X := Rect.Right - LarguraTexto - 2;

  // Calcula a posição vertical do início do texto para
  //  que seja impresso no centro (verticalmente) da célula
   Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
      AlturaTexto div 2;

  // Pinta o texto
   Lc_Lista.Canvas.TextRect(Rect, X, Y, Texto);

end;

procedure TFr_Pizzaria.Pc_CriaAbaListaSimples(Pc_Cd_grupo:Integer;Pc_Panel:TPanel);
Var
  Lc_PageControl : TPageControl;
  Lc_TabTipo : TTabSheet;
//  Lc_Panel : TPanel;
  Lc_Pnl_botao : TPanel;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_I : Integer;
  Lc_StGrade : TStringGrid;
  Lc_Botao : TSpeedButton;
Begin
  Try
    //Cria a pagecontrol do Tipo da da Cardapio
    Lc_PageControl := TPageControl.Create(Pc_Panel);
    Lc_PageControl.Name := 'Pg_ListaComposica';
    Lc_PageControl.Parent := Pc_Panel;
    Lc_PageControl.Align := alClient;

    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT SBG_CODIGO, SBG_DESCRICAO, SBG_ABAS '+
              'FROM TB_SUBGRUPOS '+
              'WHERE (SBG_CODGRP =:GRP_CODIGO) '+
              'ORDER BY SBG_SEQUENCIA,SBG_DESCRICAO');
      ParamByName('GRP_CODIGO').AsInteger := Pc_Cd_grupo;
      Active:=true;
      FetchAll;
      First;
      Lc_I := 0;
      while not eof do
      Begin
        //Cria a Pagina do Page Control Tipos do Cardapio
        Lc_TabTipo := TTabSheet.Create(Lc_PageControl);
        Lc_TabTipo.PageControl := Lc_PageControl;
        Lc_TabTipo.Name := 'tbs_ref_sbg_' + FieldByName('SBG_CODIGO').AsString;
        Lc_TabTipo.Caption := FieldByName('SBG_ABAS').AsString;
        Lc_TabTipo.Tag := FieldByName('SBG_CODIGO').AsInteger;

        //Cria a DBGRId com os Tamanhos do tipo de Cardapio
        Lc_StGrade := TStringGrid.Create(Lc_TabTipo);
        with Lc_StGrade do
        Begin
          Parent := Lc_TabTipo;
          Name := 'Stg_Unitario_'+ FieldByName('SBG_CODIGO').AsString;
          Align := alClient;
          OnDrawCell := Pc_DesenhaCelula;
          Font.Size := 10;
          Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRowSelect];
          Font.Name := 'Arial';
          Font.Color := clBlack;
          ColCount := 5;
          RowCount := 2;
          FixedCols := 0;
          DefaultRowHeight := 20;
          ColWidths[0] := -1;
          ColWidths[1] := 420;
          ColWidths[2] := 150;
          ColWidths[3] := -1;
          ColWidths[4] := -1;
          Cols[0].Add('CODIGO');
          Cols[1].Add('DESCRIÇÃO');
          Cols[2].Add('PREÇO');
          Cols[4].Add('FORA_LINHA');
        end;
        Lc_StGrade.OnDrawCell := AbaListaSimplesDrawCell;
        Pc_CriaAreaListaSimples(FieldByName('SBG_CODIGO').AsInteger,Lc_StGrade);

        Lc_StGrade.PopupMenu := pop_Pausa_By_Codigo;
        //Cria o Panel para dar uma moldura aos botoes

        Lc_Pnl_botao := TPanel.Create(Lc_TabTipo);
        Pc_CriaPanel(Lc_Pnl_botao);
        Lc_Pnl_botao.Name := 'Pnl_Confirm_' + FieldByName('SBG_CODIGO').AsString;
        Lc_Pnl_botao.Parent := Lc_TabTipo;
        Lc_Pnl_botao.Align := alBottom;
        Lc_Pnl_botao.Height := 55;
        Lc_Pnl_botao.Caption := '';

        //Cria o botão de Inserir Tamanho
        Lc_Botao := TSpeedButton.Create(Lc_Pnl_botao);
        with Lc_Botao do
        Begin
          Parent := Lc_Pnl_botao;
          AlignWithMargins := true;
          Name := 'Sb_Confirma_' + FieldByName('SBG_CODIGO').AsString;
          Top := 5;
          Left := 542;
          Width := 74;
          Height := 41;
          Caption := 'Confirma';
          Font.Size := 10;
          Font.Name := 'MS Sans Serif';
          Font.Color := clNavy;
          Align := alLeft;
          OnClick := Pc_ConfirmaItemListaSimples;
        end;
        //Cria o botão de Inserir Tamanho
        Lc_Botao := TSpeedButton.Create(Lc_Pnl_botao);
        with Lc_Botao do
        Begin
          Parent := Lc_Pnl_botao;
          AlignWithMargins := true;
          Name := 'Sb_recheio_' + FieldByName('SBG_CODIGO').AsString;
          Top := 5;
          Left := 542;
          Width := 74;
          Height := 41;
          Caption := 'Recheios';
          Font.Size := 10;
          Font.Name := 'MS Sans Serif';
          Font.Color := clNavy;
          Align := alLeft;
          OnClick := Pc_MostraRecheioSimples;
        end;
        Next;
        Inc(Lc_I);
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Pizzaria.Pc_CriaAreaListaSimples(Pc_Cd_SubGrupo:Integer;Pc_StGrade:TStringGrid);
Var
  Lc_Qry : TSTQuery;
  Lc_I : Integer;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT distinct PRO_CODIGO, PRO_DESCRICAO,PRO_CAMPANHA, '+
              'tb_normal.PRC_VL_VDA PRO_VL_NORMAL, '+
              'tb_promocao.PRC_VL_VDA PRO_VL_PROMOCAO, '+
              ' PRO_FORA_LINHA  '+
              'FROM tb_produto '+
              '   INNER JOIN tb_preco tb_normal '+
              '   ON ((tb_normal.prc_codpro = tb_produto.pro_codigo) and (tb_normal.PRC_CODTPR = 1)) '+
              '   INNER JOIN tb_preco tb_promocao '+
              '   ON ((tb_promocao.prc_codpro = tb_produto.pro_codigo) and (tb_promocao.prc_codtpr = 2)) '+
              'WHERE PRO_CODSBG=:SBG_CODIGO AND PRO_ATIVO=''S'' '+
              'ORDER BY PRO_DESCRICAO ');
      ParamByName('SBG_CODIGO').AsInteger := Pc_Cd_sUBGrupo;
      Active := true;
      FetchAll;
      first;
      if recordCount > 0 then
      Begin
        Lc_I := 1;
        while not Eof do
        begin
          Pc_StGrade.RowCount := Lc_I + 1;
          Pc_StGrade.Cells[0,Lc_I] := FieldByName('PRO_CODIGO').AsString;
          Pc_StGrade.Cells[1,Lc_I] := FieldByName('PRO_DESCRICAO').AsString;
          //if (FieldByName('PRO_CAMPANHA').AsString = 'N') then
          if FieldByName('PRO_VL_PROMOCAO').AsCurrency = 0 then
            Pc_StGrade.Cells[2,Lc_I] := FloatToStrF(FieldByName('PRO_VL_NORMAL').AsCurrency,ffFixed,10,2)
          else
            Pc_StGrade.Cells[2,Lc_I] := FloatToStrF(FieldByName('PRO_VL_PROMOCAO').AsCurrency,ffFixed,10,2);
          Pc_StGrade.Cells[4,Lc_I] := FieldByName('PRO_FORA_LINHA').AsString;
          next;
          inc(Lc_I);
        end;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Pizzaria.Pc_ConfirmaItemListaSimples(Sender: TObject);
Var
  Lc_Botao : TSpeedButton;
  Lc_Panel : TPanel;
  Lc_Page : TPageControl;
  Lc_Tabs : TTabSheet;
  Lc_StrGrd : TStringGrid;
  Lc_Mostra_Valor : Boolean;
  Lc_Nr_Item : Integer;
  Lc_Valor : Real;
Begin
  Lc_Panel := TPanel.Create(Self);
  Lc_Panel := TPanel(TSpeedButton(Sender).Parent);

  Lc_StrGrd := TStringGrid.Create(Self);
  Lc_StrGrd := TStringGrid(Fc_LocalizaComponente(Lc_Panel.Parent,TStringGrid));

  if trim(Lc_StrGrd.Cells[4,Lc_StrGrd.Row]) =  'S' then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Este Produto está pausado para vendas.' + EOLN +
                   'Não é possível continuar.'+ EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  End;
  if trim(Lc_StrGrd.Cells[0,Lc_StrGrd.Row])<> '' then
  Begin
    //Grava o pedido caso não tenha sido gravado ainda
    IF (Pedido.Registro.codigo = 0) then
    Begin
      if Fc_ValidaGravaPedido then
      Begin
        Pc_GravaPedido;
      end
      else
      Begin
        Exit;
      end;
    end;
    Lc_Nr_Item := Fc_GeraProximoNrItem(Pedido.Registro.codigo);
    //Valor Unitario
    Lc_Valor := StrtoFloatDef(Lc_StrGrd.Cells[2,Lc_StrGrd.Row],0);
    //Valor Adicional
    Lc_Valor := Lc_Valor + Vlr_RecheioListaSimples;
    Pc_GravaItemVenda( Pedido.Registro.codigo,
                      Lc_Nr_Item,
                      StrToIntdef(Lc_StrGrd.Cells[0,Lc_StrGrd.Row],0),//produto
                      0,
                      0,//Subgrupo
                      Lc_StrGrd.Cells[1,Lc_StrGrd.Row],
                      Obs_RecheioListaSimples,
                      'N',
                      1,
                      Lc_Valor,
                      0,
                      Gb_Datacaixa,
                      1,
                      Lc_Valor,
                      True);
    //Zera observações de adicioais dos itens e os valores
    Vlr_RecheioListaSimples := 0;
    Obs_RecheioListaSimples := '';
    Pc_PreencherItensVenda(Pedido.Registro.codigo);
    Pc_totalizaItensPedido;
    Pc_totalizaPedido;
    Pc_GravaPedido;
    Pc_PreencherItensVenda(Pedido.Registro.codigo);
    Pc_totalizaItensPedido;
    Pc_totalizaPedido;
    Pc_GravaPedido;
  end;
end;




procedure TFr_Pizzaria.Comisso1Click(Sender: TObject);
Var
  Lc_Form :TFr_Imp_Comissao;
begin
  if Fc_VerificaPermissao('Fr_Imp_Comissao','Relatorio Comissão','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TFr_Imp_Comissao.create(nil);
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    end;
  End;
end;

procedure TFr_Pizzaria.DesativaProdutoByCodigo(Produto:Integer);
Var
  Lc_DskRestMenu : TControllerDskRestMenu;
begin
  try
    Lc_DskRestMenu := TControllerDskRestMenu.Create(nil);
    Lc_DskRestMenu.DesativarItemByCodigo(Produto);
  finally
    FreeAndNil(Lc_DskRestMenu);
  end;


end;

procedure TFr_Pizzaria.DesativaProdutoByName(Produto:String;GRupo:Integer);
Var
  Lc_DskRestMenu : TControllerDskRestMenu;
begin
  try
    Lc_DskRestMenu := TControllerDskRestMenu.Create(nil);
    Lc_DskRestMenu.DesativarItemByName(Produto,Grupo);
  finally
    FreeAndNil(Lc_DskRestMenu);
  end;

end;


procedure TFr_Pizzaria.MnuDesativarByCodigoClick(Sender: TObject);
Var
 Caller: TObject;
 Lc_Produto : Integer;
 Lc_Grid : TStringGrid;
begin
  if Fc_VerificaPermissao('Fr_Cardapio','Fr_Cardapio','EXCLUIR',GB_Cd_Usuario,'S') then
  Begin
    Caller := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
    Lc_Grid := (Caller as TStringGrid);
    Lc_Produto := StrToIntDef( Lc_Grid.Cells[0,Lc_Grid.Row],0);
    if ValidaDesativaProdutoByCodigo then
    Begin
      DesativaProdutoByCodigo(Lc_Produto);
      Del_Linha_StringGrid(Lc_Grid,Lc_Grid.Row,0);
    End;
  End;
end;

procedure TFr_Pizzaria.MnuDesativarByNameClick(Sender: TObject);
Var
 Caller: TObject;
 Lc_Produto : String;
 Lc_Index : Integer;
begin
  if Fc_VerificaPermissao('Fr_Cardapio','Fr_Cardapio','EXCLUIR',GB_Cd_Usuario,'S') then
  Begin
    Caller := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
    Lc_Index := (Caller as TListBox).itemIndex;
    if (Lc_Index < 0 ) then
    Begin
      MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                     'Por favor revise o item marcado.' + EOLN +
                     'Verifique se está devidamente selecionado.' + EOLN,
                     ['OK'], [bEscape], mpErro);
      Exit;
    End;

    Lc_Produto := Trim( (Caller as TListBox).Items.Strings[(Caller as TListBox).itemIndex]);
    if ValidaDesativaProdutoByName then
    Begin
      DesativaProdutoByName(Lc_Produto,(Caller as TListBox).Tag);
      (Caller as TListBox).DeleteSelected;
    End;
  End;
end;

procedure TFr_Pizzaria.Relatrios1Click(Sender: TObject);
Var
  Lc_Form :TFr_Imp_Pizzaria;
begin
  if Fc_VerificaPermissao('Fr_Imp_Pizzaria','Relatorio Pizzaria','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TFr_Imp_Pizzaria.create(nil);
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    end;
  End;
end;

procedure TFr_Pizzaria.Rg_ModalidadeClick(Sender: TObject);
begin
  if (Rg_Modalidade.ItemIndex = 0) then
  Begin
    Pc_LimpaClienteEntrega;
    E_Telefone.Clear;
    It_Edicao_Ordem := 'I';
    Pg_modalidade.ActivePageIndex := 0;
  End
  else
  Begin
    if (Pedido.Registro.Empresa > 0 ) and (Pedido.Registro.Empresa <> CodigoConsumidor )  then
    Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Este Cliente possui Cadastro' + EOLN + EOLN +
                         'Deseja manter neste pedido ?',
                       [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
      Begin

        Pg_modalidade.ActivePageIndex := 0;
      End
      else
      Begin
        Pc_LimpaClienteEntrega;
        E_Telefone.Clear;
        Pg_modalidade.ActivePageIndex := Rg_Modalidade.ItemIndex;
      End;
    end
    else
    Begin
      Pg_modalidade.ActivePageIndex := Rg_Modalidade.ItemIndex;
    End;
    E_VL_Entrega.Text := '0,00';
    Pc_totalizaPedido;
  End;
  FocoCampoReferencia;
end;

procedure TFr_Pizzaria.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariveis;
  Pc_PermissaoBotao('Pizzaria');
  It_Edicao_Ordem := 'B';
  Pc_EstadoEdicaoOrdem;
end;

procedure TFr_Pizzaria.LanamentosCaixa1Click(Sender: TObject);
begin
  if Fc_VerificaPermissao('Fr_Caixa','Lançamento Caixa','Visualizar',GB_Cd_Usuario,'S') then
  Begin
    Fr_Principal.AbrirTelaCaixa;
    if not Fc_VerificaCaixaAberto(True) then
    Begin
      Self.Close;
      exit;
    End;
  End;
end;

procedure TFr_Pizzaria.ListBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with Control as TListBox do
  begin
    Canvas.FillRect(Rect);
    Canvas.Font.Color := TColor(Items.Objects[Index]);
    Canvas.TextOut(Rect.Left + 2, Rect.Top, Items[Index]);
  end;

end;

function TFr_Pizzaria.MesaOcupada: Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                 'SELECT p.PED_CODIGO ',
                 ' FROM TB_PEDIDO p ',
                 '   INNER JOIN TB_EMPRESA e ',
                 '   ON (e.emp_codigo = p.ped_codemp) ',
                 '   INNER JOIN TB_RESTAURANTE r ',
                 '   ON (r.TB_PEDIDO_ID = p.PED_CODIGO )',
                 'WHERE (PED_FATURADO=:PED_FATURADO) ',
                 '  and (r.descricao like :MESA ) ',
                 ' and ( PED_CODIGO <>:PED_CODIGO) '
      ));
      ParamByName('MESA').AsString := concat('MESA ', StrZero( StrToInt(E_NR_Mesa.Text),2,0));
      ParamByName('PED_FATURADO').Asstring := 'N';
      ParamByName('PED_CODIGO').AsInteger := pedido.Registro.Codigo;
      Active := True;
      FetchAll;
      Result := RecordCount > 0;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Pizzaria.NotasFiscais1Click(Sender: TObject);
begin
  Pc_AbreTelaPesqNF_65;
end;

procedure TFr_Pizzaria.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Pedido);
end;

procedure TFr_Pizzaria.FormCreate(Sender: TObject);
begin
  Pedido := TControllerPedidoVda.create(self);
end;

procedure TFr_Pizzaria.SB_InserirClick(Sender: TObject);
begin
  Pc_NovoRegistro;
  Pc_EstadoEdicaoOrdem;
  if E_Telefone.CanFocus then E_Telefone.SetFocus;
end;

function TFr_Pizzaria.Fc_ValidaAlteracao():Boolean;
Begin
  Result := True;
  if Pedido.VerificaFaturado(True) then
  Begin
    REsult := False;
    Exit;
  end;

  if (Pedido.Registro.CodigoWeb > 0)  then
  Begin
    If (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Este pedido foi enviado pelo Aplicativo Delivery.' + EOLN +
                       'Caso você altere os dados ficarão diferentes do pedido original.' + EOLN +
                       'Confirmar a alteração ?',
                      [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao2) then
    Begin
      REsult := False;
      Exit;
    End
    else
    Begin
      Pc_Log_Sistema( Gb_CodMha,
                      GB_Cd_Usuario,
                      now,
                      'Pedido Pizzaria',
                      Pedido.Registro.Codigo,
                      'Alteração Pedido Aplicativo',
                      'PEDIDO NUMERO: ' + IntToStr(Pedido.Registro.Numero));
    End;
  End;

end;

procedure TFr_Pizzaria.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Pizzaria.SB_AlterarClick(Sender: TObject);
begin
  if Fc_ValidaAlteracao then
  Begin
    Pedido.using('L');
    It_Edicao_Ordem := 'E';
    Pc_EstadoEdicaoOrdem;
    Pc_AlteraRegistro;
  end;
end;

procedure TFr_Pizzaria.AbaListaSimplesDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with TStringGrid(Sender) do
  Begin
    If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
    Begin
      if (Cells[4,ARow] = 'N') then
      Begin
        Canvas.Font.Color:= clBlack;
        canvas.Brush.Color:= clCream;
      End
      else
      Begin
        Canvas.Font.Color:= clRed;
        canvas.Brush.Color:= clCream;
      end;

      Canvas.FillRect(Rect); // redesenha a celula
      Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
      // Pega o texto da célula
      Texto := Cells[acol, ARow];

      //{ Calcura largura e altura (em pontos) do texto
      LarguraTexto := Canvas.TextWidth(Texto);
      AlturaTexto := Canvas.TextHeight(Texto);

      // Calcula a posição horizontal do início do texto
      if  (ACol = 1)  then // esquerda
        X := Rect.Left + 2
      else
        if  (ACol = 3)   then // Centro
          X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
        else // Direita
          X := Rect.Right - LarguraTexto - 2;

      // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
      Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
      Canvas.TextRect(Rect, X, Y, Texto);
    end;
  end;
end;

procedure TFr_Pizzaria.MnuHabilitarByCodigoClick(Sender: TObject);
Var
  Caller: TObject;
  Lc_Grid : TStringGrid;
  Lc_Produto : Integer;
begin
  Caller := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  Lc_Grid := (Caller as TStringGrid);
  Lc_Produto := StrToIntDef( Lc_Grid.Cells[0,Lc_Grid.Row],0);
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja relamente Pausar a Venda deste Item?.' + EOLN +
                     'Confirmar a Operação ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
  Begin
    PausarHabilitarItemByCodigo(False,Lc_Produto);
    Lc_Grid.Cells[4,Lc_Grid.Row] := 'N';
  End;
end;

procedure TFr_Pizzaria.MnuHabilitarByNameClick(Sender: TObject);
Var
 Caller: TObject;
 Lc_Produto : String;
 Lc_Index  : Integer;
begin
  Caller := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  Lc_Produto := Trim( (Caller as TListBox).Items.Strings[(Caller as TListBox).itemIndex]);
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja relamente Habilitar a Venda deste Item?.' + EOLN +
                     'Confirmar a Operação ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
  Begin
    PausarHabilitarItemByName(False,Lc_Produto,(Caller as TListBox).Tag);
    Lc_Index := (Caller as TListBox).itemIndex;
    (Caller as TListBox).DeleteSelected;
    (Caller as TListBox).Items.InsertObject(Lc_Index,Lc_Produto, TObject(clBlack));
  End;
end;

procedure TFr_Pizzaria.AtualizaHistoricoClientes;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('select count(PED_CODIGO) NR_PEDIDO ,MAX(PED_DATA) DATA '+
              'FROM tb_pedido '+
              '  INNER JOIN tb_restaurante '+
              '  ON (TB_PEDIDO_ID = PED_CODIGO) '+
              'WHERE PED_CODEMP=:EMP_CODIGO');
      ParamByName('EMP_CODIGO').AsInteger := Pedido.Cliente.Registro.Codigo;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
      Begin
        E_Nr_Pedidos.Text := FieldByName('NR_PEDIDO').AsString;
        E_DataUltimoPedido.Text := FieldByName('DATA').AsString;
      end
      else
      Begin
        E_Nr_Pedidos.Clear;
        E_DataUltimoPedido.Clear;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure TFr_Pizzaria.AtualizaoCtrlF51Click(Sender: TObject);
begin
  if FileExists(concat(GbPathExe,'RoteadorGestao.exe')) then
  Begin
    WinExec('RoteadorGestao.exe',SW_SHOWNORMAL);
  end
  else
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'O Roteador de Dados do Gestão não está instalado.' + EOLN +
                   'Não é possível continuar.'+ EOLN,
                   ['OK'], [bEscape], mpAlerta);
  end;

end;

procedure TFr_Pizzaria.Sb_AtualizaHistoricoClick(Sender: TObject);
begin
  AtualizaHistoricoClientes;
end;

procedure TFr_Pizzaria.SB_CancelarClick(Sender: TObject);
begin
  if Fc_ValidaCancelaRegistro then
  Begin
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
    Pc_CancelaRegistro;
    Pc_PreencherOrdem;
    Pc_PreencherItensVenda(Pedido.Registro.Codigo);
    Pc_totalizaItensPedido;
    Pc_totalizaPedido;
  end;
end;

procedure TFr_Pizzaria.SB_GravarClick(Sender: TObject);
begin
  if Fc_ValidaGravaPedido then
  Begin
    Pedido.AplicarValorDescontoItens(Pedido.Registro.Codigo,StrToFloatDef(e_VL_Desconto.Text,0));
    Pc_GravaPedido;
    Pc_AtualizaRestaurante;
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pizzaria.SB_EntregarClick(Sender: TObject);
begin
  if Fc_ValidaEntregaRegistro then
  Begin
     Pc_EntregaRegistro;
  end;
end;

procedure TFr_Pizzaria.SB_FaturarClick(Sender: TObject);
Var
  LC_I:Integer;
  Faturado : Boolean;
begin
  if Fc_ValidaFaturamento then
  Begin
    try
      Pc_ProcesoAguarde(Self,'I');
      Self.Enabled := False;
      Pc_GeraNumeroPedido;
      Pedido.Registro.Vendedor := GB_Cd_Vendedor;
      Pedido.AtualizaVendedor;
      Faturado := Fc_FaturarRegistro;
      if Faturado then
      Begin
        Pedido.using('L');
        Pc_LimpaTudo;
      End;
    finally
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := True;
    end;
  end;
end;

procedure TFr_Pizzaria.Sb_Identifica_balcaoClick(Sender: TObject);
begin
  Pg_modalidade.ActivePageIndex := 0;
  Pc_LimpaClienteEntrega;
  E_Telefone.Clear;
end;

procedure TFr_Pizzaria.Sb_Identifica_MesaClick(Sender: TObject);
begin
  Pg_modalidade.ActivePageIndex := 0;
  Pc_LimpaClienteEntrega;
  E_Telefone.Clear;
end;

procedure TFr_Pizzaria.Sb_ImprimirClick(Sender: TObject);
Var
  Faturado : Boolean;
begin
  if Fc_ValidaImpressaoRegistro then
  Begin
    try
      Pc_ProcesoAguarde(Self,'I');
      Self.Enabled := False;
      Pc_GeraNumeroPedido;
      Pedido.Registro.Vendedor := GB_Cd_Vendedor;
      Pedido.AtualizaVendedor;
      Fc_ImprimeRegistro;
    finally
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := True;
    end;
  end;
end;



procedure TFr_Pizzaria.Sb_Imp_ItemClick(Sender: TObject);
begin
  if Fc_validaImprimeItem then
  BEgin
    ImprimeItem;
  end;
end;

procedure TFr_Pizzaria.E_TelefoneEnter(Sender: TObject);
begin
  FoneEntrou := E_Telefone.Text;
  E_Telefone.SelectAll;
end;

procedure TFr_Pizzaria.E_TelefoneExit(Sender: TObject);
Var
  LcFoneSaiu : String;
begin
  LcFoneSaiu := Fc_RemoveCaracterInformado(E_Telefone.Text, ['(',')','-',' ']);
  FoneEntrou := Fc_RemoveCaracterInformado(FoneEntrou, ['(',')','-',' ']);
  if ( FoneEntrou <>  LcFoneSaiu )  then
  Begin
    with pedido do
    Begin
      Endereco.Registro.Fone    := LcFoneSaiu;
      Endereco.Registro.Celular := LcFoneSaiu;
      //Endereco.getIdByFone; - 14/12/2023
      Endereco.getByAllFones;
      if ( Endereco.Registro.Codigo > 0 ) then
      Begin
        Cliente.Registro.Codigo := Endereco.Registro.CodigoEmpresa;
        Registro.Empresa := Endereco.Registro.CodigoEmpresa;
        Cliente.getById;
        Pc_PreencherClienteEntrega;
      End
      else
      Begin
        Pc_LimpaClienteEntrega;
      End;
    End;
  End;
  FoneEntrou := '';
end;

procedure TFr_Pizzaria.E_TelefoneKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Shift = [] then
    case Key of
      VK_F7:Pc_ChamaCadastroCliente;
    end;
end;

procedure TFr_Pizzaria.Pc_ChamaCadastroCliente;
Begin

end;

procedure TFr_Pizzaria.Pc_NovoRegistro;
begin
  Pedido.using('L');
  Pc_LimpaTudo;
  It_Edicao_Ordem := 'I';
  It_Modal_ant := 0;
  Pc_MostraEntrega;
  Rg_Modalidade.ItemIndex := 0;
end;

procedure TFr_Pizzaria.FocoCampoReferencia;
begin
  case Rg_Modalidade.ItemIndex of
    0 : IF (E_Telefone.CanFocus) then E_Telefone.SetFocus;
    1 : IF (E_Cliente_Balcao.CanFocus) then E_Cliente_Balcao.SetFocus;
    2 : IF (E_NR_Mesa.CanFocus) then E_NR_Mesa.SetFocus;
  end;
end;

procedure TFr_Pizzaria.Pc_AlteraRegistro;
begin

end;


procedure TFr_Pizzaria.Pc_CancelaRegistro;
begin
  if (Pedido.Cliente.Empresa.Registro.Codigo = 0) then
    Pc_LimpaTudo;
end;

procedure TFr_Pizzaria.Pc_LimpaTudo;
Begin
  Pc_LimpaPedido;
  Pc_LimpaItens;
  Pc_LimpaClienteEntrega;
  E_Telefone.Clear;
  Pc_LimpaMesa;
  Pc_LimpaBalcao;
end;

procedure TFr_Pizzaria.Pc_LimpaPedido;
var
  Lc_Save: TNotifyEvent;
Begin
  Pedido.clear;
  E_VL_SubTotal.Text  := '0,00';
  E_VL_Adicional.Text := '0,00';
  E_Vl_Desconto.Text  := '0,00';
  E_OBS.Lines.Clear;
  //Desativa o evento do cmponente para setar o valor
  Lc_Save := Rg_ModalidadeClick;
  Rg_Modalidade.OnClick:= nil;
  //Seta o campo com o valor
  Rg_Modalidade.ItemIndex:=0;
  //Ativa o evento do cmponente
  Rg_Modalidade.OnClick:= Lc_Save;
  E_Vl_Pedido.Text := '0,00';
  Pedido.Cliente.clear;
  E_VL_Entrega.Text   := '0,00';
end;

procedure TFr_Pizzaria.Pc_LimpaItens;
Begin
  Pc_LimpaStringGrid(StrGrd_ItensVenda);
end;

procedure TFr_Pizzaria.Pc_LimpaMesa;
Begin
  E_NR_Mesa.Clear;
end;

procedure TFr_Pizzaria.Pc_LimpaBalcao;
Begin
  E_Cliente_Balcao.Clear;
end;

function TFr_Pizzaria.Fc_ValidaCancelaRegistro():Boolean;
begin
  Result := True;
end;

function TFr_Pizzaria.Fc_ValidaGravaPedido():Boolean;
begin
  Result := True;
  case Rg_Modalidade.ItemIndex of
    0:Begin
        if not Fc_validaGravaEntrega then
        Begin
          Result := False;
          Exit;
        end;
      end;
    1:Begin
        if not Fc_validaGravaBalcao  then
        Begin
          Result := False;
          Exit;
        end;
      end;
    2:Begin
        if not Fc_validaGravaMesa    then
        Begin
          Result := False;
          Exit;
        end;
      end;
  end;

end;

function TFr_Pizzaria.Fc_validaGravaEntrega():Boolean;
Begin
  Result := True;
  if Trim(E_Telefone.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor informe o telefone do Cliente.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpAlerta);
    IF (E_Telefone.CanFocus) then E_Telefone.SetFocus;
    Result := False;
    exit;
  end;
  Self.Pedido.Endereco.clear;
  Self.Pedido.Endereco.Registro.Fone := Fc_RemoveCaracterInformado(E_Telefone.Text, ['(',')','-',' ']);
  Self.Pedido.Endereco.getIdByFone;
  if Self.Pedido.Endereco.Registro.CodigoEmpresa = Gb_CodMha then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não é possível usar o ppróprio telefone para fazer pedidos.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpAlerta);
    if E_Telefone.CanFocus then E_Telefone.SetFocus;
    Result := False;
    exit;
  end;
  //valida se o telfone do Cliente foi Preenchido



  //valida se o nome do Cliente foi Preenchido
  if Trim(E_Nome.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor informe o nome do Cliente.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpErro);
    if E_Nome.CanFocus then E_Nome.SetFocus;
    Result := False;
    exit;
    end;

  //valida se o Ednereço do Cliente foi Preenchido
  if Trim(E_Endereco.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor informe o endereço do Cliente.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpErro);
    if E_Endereco.CanFocus then E_Endereco.SetFocus;
    Result := False;
    exit;
    end;

  //valida se o Ednereço do Cliente foi Preenchido
  if Trim(E_Numero.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor informe o número da residência do Cliente.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpErro);
    if E_Numero.CanFocus then E_Numero.SetFocus;
    Result := False;
    exit;
    end;

  //valida se o Numero do Endereço do Cliente foi Preenchido
  if Trim(E_Endereco.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor informe o número do endereço do Cliente.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpErro);
    if E_Endereco.CanFocus then E_Endereco.SetFocus;
    Result := False;
    exit;
    end;

  //valida se o Bairro do Cliente foi Preenchido
  if Trim(E_Bairro.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor informe o bairro do Cliente.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpErro);
    if E_Bairro.CanFocus then E_Bairro.SetFocus;
    Result := False;
    exit;
    end;

end;

procedure TFr_Pizzaria.Pc_GravaEntrega;
Begin
end;

procedure TFr_Pizzaria.Pc_AtualizaRestaurante;
Var
  Lc_Restaurante : TControllerRestaurante;
Begin
  Try
    Lc_Restaurante := TControllerRestaurante.Create(nil);
    with Lc_Restaurante.Registro do
    Begin
      CodigoPedido := Pedido.Registro.Codigo;
      TipoAtendimento := Rg_Modalidade.ItemIndex ; //Modalidade Entrega = 0 / Balcao = 1 / Mesa = 2
      case Pg_modalidade.ActivePageIndex of
        0: Descricao := E_Nome.Text;
        1: Descricao := E_Cliente_Balcao.Text;
        2: Descricao := concat('MESA ', StrZero( StrToInt(E_NR_Mesa.Text),2,0));
      end;
      ValorRecebido := 0;
      ValorTroco  := 0;
      CodigoEstabelecimento := Gb_CodMha;
      TempoInicio := Copy(TimetoStr(Now),1,5);
      Lc_Restaurante.Salva;
    End;
  Finally
    FreeAndNil(Lc_Restaurante);
  End;
end;


function TFr_Pizzaria.Fc_validaGravaBalcao():Boolean;
Begin
  Result := True;
  case Pg_Modalidade.ActivePageIndex of
    0:Begin
      if Trim(E_Nome.Text) = '' then
        Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Por favor informe o nome do cliente.'+EOLN+
                       'Verifique antes de continuar.'+EOLN,
                      ['Voltar'],[bEscape],mpAlerta);
        if E_Nome.CanFocus then E_Nome.SetFocus;
        Result := False;
        exit;
        end;
      end;
    1:Begin
      if Trim(E_Cliente_Balcao.Text) = '' then
        Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Por favor informe o nome do cliente.'+EOLN+
                       'Verifique antes de continuar.'+EOLN,
                      ['Voltar'],[bEscape],mpAlerta);
        if E_Cliente_Balcao.CanFocus then E_Cliente_Balcao.SetFocus;
        Result := False;
        exit;
        end;
      end;
    end;
end;

procedure TFr_Pizzaria.Pc_GravaPedido;
Begin
  if ( Pg_modalidade.ActivePageIndex = 0 ) then
    Pc_CadastroCliente;

  with Pedido.Registro do
  Begin
    Tipo := 1;
    Empresa := Pedido.Cliente.Empresa.Registro.Codigo;
    Endereco := Pedido.Endereco.Registro.Codigo;
    Data := Gb_DataCaixa;
    Vendedor := Gb_Cd_Vendedor;
    Usuario := GB_Cd_Usuario;
    FormaPagto := Fc_PegaParteFormaPgto('DINHEIRO');
    Prazo := 'À VISTA';
    Faturado := 'N';
    TipoContato := IntToStr(Rg_Modalidade.ItemIndex);
    DataEntrega := Gb_DataCaixa;
    Observacao := Trim(E_OBS.Text);
    Aprovado := 'S';
    QtdeProdutos :=  StrToFloatDef(E_Qt_Total.Caption,0);
    ValorProdutos := StrToFloatDef(E_VL_SubTotal.Text,0);
    ValorFrete := StrToFloatDef(E_VL_Entrega.Text,0);
    ValorDesconto := StrToFloatDef(E_Vl_Desconto.Text,0);
    ValorOutrasDEspesas := StrToFloatDef(E_VL_Adicional.Text,0);
    ValorPedido := StrToFloatDef(E_VL_Pedido.Text,0);
    CodigoEstabelecimento := Gb_CodMha;
    Pedido.salva;
  End;

end;

function TFr_Pizzaria.Fc_validaGravaMesa():Boolean;
Begin
  Result := True;
  if StrToIntDEf( Trim(E_NR_Mesa.Text),0) = 0 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor informe o número da Mesa.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpAlerta);
    if E_NR_Mesa.CanFocus then E_NR_Mesa.SetFocus;
    Result := False;
    exit;
  end;

  if MesaOcupada then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Mesa ainda está Ocupada.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpAlerta);
    if E_NR_Mesa.CanFocus then E_NR_Mesa.SetFocus;
    Result := False;
    exit;
  End;
end;

procedure TFr_Pizzaria.Pc_CadastroCliente;
Begin
  with Pedido.Cliente.Empresa.Registro do
  Begin
    Codigo := Pedido.Endereco.Registro.CodigoEmpresa;
    Tipo := 1;
    NomeRazaoSocial := E_Nome.Text;
    ApelidoFantasia := E_Nome.Text;
    if trim(E_ObsCliente.Text) <> '' then
      Observacao := E_ObsCliente.Text + #13 + E_OBS.Text
    else
      Observacao := ' ' + #13 + E_OBS.Text;
    TipoPessoa := 'F';
    Multiplicador := 1;
    ConsumidorFinal := 'S';
    OptantePeloSimples := 'N';
    IndicadorInscricaoEstadual := '2';
    Ativa := 'N';
    Pedido.Cliente.Empresa.salva;
  End;

  with Pedido.Endereco.Registro do
  Begin
    CodigoEmpresa := Pedido.Cliente.Empresa.Registro.Codigo;
    Fone := Fc_RemoveCaracterInformado(E_Telefone.Text, ['(',')','-',' ']);
    Cep := Fc_RemoveCaracterInformado(E_CEP.Text, ['-',' ']);
    Logradouro := E_Endereco.Text;
    NumeroPredial := E_Numero.Text;
    Complemento := E_Compl.Text;
    Bairro := E_Bairro.Text;
    EnderecoPrincipal := 'S';
    Tipo := 'ENTREGA';
    Pc_AtivaEstabelecimento;
    CodigoPais := DM.Qr_Estabelecimento.FieldByName('END_PAIS').AsInteger;
    CodigoEstado := DM.Qr_Estabelecimento.FieldByName('END_CODUFE').AsInteger;
    CodigoCidade := DM.Qr_Estabelecimento.FieldByName('END_CODCDD').AsInteger;
    Pedido.Endereco.salva;
  End;

  with Pedido.Cliente.Registro do
  Begin
    Codigo := Pedido.Cliente.Empresa.Registro.Codigo;
    Pedido.Cliente.getById;
    Ativo := 'S';
    ObservacaoNF := '';
    EnviarSomenteXML := 'N';
    IndicadorIE_Dest := '2';
    IssRetido := 'N';
    IssExigibilidade := 'N';
    IssIncentivoFiscal := 'N';
    IssNumeroProcesso := '';
    if PermiteReducaoValorEntrega then
    Begin
      ValorEntrega := StrToFloatDef(E_Vl_Entrega.Text,0);
    End
    else
    Begin
    if ( StrToFloatDef(E_Vl_Entrega.Text,0) > ValorEntrega)  then
      ValorEntrega := StrToFloatDef(E_Vl_Entrega.Text,0);
    End;
    IndicadorIE_Dest := '2';
    Pedido.Cliente.salva;
  End;

end;

function TFr_Pizzaria.Fc_ValidaEntregaRegistro():Boolean;
Begin
  Result := True;
end;

procedure TFr_Pizzaria.Pc_EntregaRegistro;
Var
  Lc_Form : TFr_PizzariaEntrega;
begin
  try
    Lc_Form := TFr_PizzariaEntrega.create(nil);
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

function TFr_Pizzaria.Fc_ValidaFaturamento():Boolean;
begin
  Result := True;
  if Pedido.Registro.Codigo = 0 then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Pedido não encontrado.' + EOLN +
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    result := False;
    exit;
  end;
  if Pedido.VerificaFaturado(True) then
  BEgin
    result := False;
    exit;
  end;
  //VErifica se tem item

  if Trim(StrGrd_ItensVenda.Cells[0,1]) = '' then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Pedido sem itens para imprimir.' + EOLN +
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    result := False;
    exit;
  end;

end;

function TFr_Pizzaria.Fc_FaturarRegistro:Boolean;
Var
  Lc_Form : TFr_Cupom_Fiscal;
Begin
  Result := False;
  try
    Lc_Form := TFr_Cupom_Fiscal.Create(nil);
    Lc_Form.It_Pizzaria := True;
    Lc_Form.It_Cd_Cliente := Pedido.Cliente.Empresa.Registro.Codigo;
    Lc_Form.It_Cd_Pedido := Pedido.Registro.Codigo;
    Lc_Form.It_Nr_Pedido := Pedido.Registro.Numero;
    Lc_Form.E_VL_Total.Text := E_Vl_Pedido.Text;
    //Lc_Form.ValorDesconto
    Lc_Form.It_NFCe := It_NFCe;
    Lc_Form.ShowModal;
    Result := Lc_Form.it_fatura_ok;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

function TFr_Pizzaria.Fc_ValidaImpressaoRegistro():Boolean;
begin
  Result := True;
  if Pedido.Registro.Codigo = 0 then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Pedido não encontrado.' + EOLN +
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    result := False;
    exit;
  end;
  //VErifica se tem item
  if Trim(StrGrd_ItensVenda.Cells[0,1]) = '' then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Pedido sem itens para imprimir.' + EOLN +
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    result := False;
    exit;
  end;  
end;

procedure TFr_Pizzaria.Pc_GeraNumeroPedido;
Begin
  with Pedido.Registro do
  Begin
    If (Numero = 0) then Pedido.nextNumber('G');
  End;
end;



procedure TFr_Pizzaria.Pc_LimpaClienteEntrega;
Begin
  Pedido.Cliente.Empresa.clear;
  E_Nome.clear;

  E_Cliente_Balcao.Text:='';
  E_Nome.Text:='';
  E_CEP.Text:='';
  E_Nr_Pedidos.Text:='';

  Pedido.Endereco.clear;
  E_Endereco.Text:='';
  E_Numero.Text:='';
  E_Compl.Text:='';
  E_Bairro.Text:='';
  E_ObsCliente.Text:='';
end;



procedure TFr_Pizzaria.Pc_MostraEntrega;
Begin
  Pg_Modalidade.ActivePageIndex := 0;
  E_VL_Entrega.Enabled:=True;

  if Trim(E_Telefone.Text) = '' then
  Begin
    Pc_LimpaClienteEntrega;
  end;
  IF (E_Telefone.CanFocus) then E_Telefone.SetFocus;
end;


procedure TFr_Pizzaria.Pc_PreencherClienteEntrega;
Var
  strLinha: String;
  Parte : TStringList;
  Lc_I : Integer;
begin
  with Self.pedido do
  Begin
    Cliente.Empresa.Registro.Codigo := Endereco.Registro.CodigoEmpresa;
    Cliente.Empresa.getById;
    if (Cliente.Empresa.Registro.Codigo > 0) then
    Begin
      E_Nome.text := Cliente.Empresa.Registro.NomeRazaoSocial;
      strLinha := Cliente.Empresa.Registro.Observacao;
      Parte := TStringList.Create;
      try
        Parte.Clear;
        ExtractStrings([#13],[], PChar(strLinha), Parte);
        if (Parte.Count > 0) then
        Begin
          E_ObsCliente.text := Trim( Parte.Strings[0] );
          Parte.Delete(0);
          E_OBS.Lines.AddStrings(Parte);
        end;
      finally
        FreeAndNil(Parte);
      end;
    End;

    if ( Endereco.Registro.CodigoEmpresa > 0 ) then
    Begin
      FoneEntrou := fc_MascaraFone( Endereco.Registro.Fone );
      E_Telefone.text := FoneEntrou;
      E_CEP.text := Endereco.Registro.cep;
      E_Endereco.text := Endereco.Registro.Logradouro;
      E_Numero.text := Endereco.Registro.NumeroPredial;
      E_Compl.text := Endereco.Registro.Complemento;
      E_Bairro.text := Endereco.Registro.Bairro;
    End;
    E_Vl_Entrega.text := '0,00';
    E_Nr_Pedidos.Clear;
    E_DataUltimoPedido.Clear;
    if Rg_Modalidade.ItemIndex = 0 then
    BEgin
      Cliente.Registro.Codigo := Cliente.Empresa.Registro.Codigo;
      Cliente.getById;
      if ( Cliente.Registro.Codigo > 0 ) then
        E_VL_Entrega.Text := FloatToStrF(Cliente.Registro.ValorEntrega,ffFixed,10,2);
    end;

  end;
end;

procedure TFr_Pizzaria.Pc_PreencherClienteBalcao;
Begin

end;

procedure TFr_Pizzaria.Pc_PreencherClienteMesa;
Begin
end;

procedure TFr_Pizzaria.Pc_PreencherClienteBalcaoCadastro;
Begin
end;


procedure TFr_Pizzaria.Pc_EstadoEdicaoOrdem;
Begin
  SB_Inserir.Enabled    :=  (It_Edicao_Ordem = 'B') AND It_Inserir;
  SB_Alterar.Enabled    :=  (It_Edicao_Ordem = 'B') and (Pedido.Registro.Codigo > 0) AND It_Alterar;
  SB_Excluir.Enabled    :=  (It_Edicao_Ordem = 'B') and (Pedido.Registro.Codigo > 0) AND It_Excluir;
  SB_Cancelar.Enabled  := (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E');
  SB_Gravar.Enabled    := (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E');
  SB_Entregar.Enabled  := (It_Edicao_Ordem = 'B') ;
  Sb_Pesquisar.Enabled := (It_Edicao_Ordem = 'B');
  SB_Faturar.Enabled  := (It_Edicao_Ordem = 'B');
  Sb_Imprimir.Enabled  := (It_Edicao_Ordem = 'B');
  SB_Sair_1.Enabled      := (It_Edicao_Ordem = 'B');
  //Items
  Sb_Exc_Item.Enabled  := (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E');
  Sb_Imp_Item.Enabled  := (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E');
  //Outros
  Pg_modalidade.Enabled := (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E');
  Rg_Modalidade.Enabled := (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E');
  Pg_Cardapio.Enabled   := (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E');
  GbObsPedido.Enabled   := (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E');
  Pnl_Total.Enabled     := (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E');
end;

procedure TFr_Pizzaria.Sb_PesquisarClick(Sender: TObject);
Var
  Lc_Form : TFr_PesqPedPizza;
begin
  Try
    Lc_Form := TFr_PesqPedPizza.Create(nil);
    Lc_Form.ShowModal;
    if (Lc_Form.It_cd_Pedido > 0) then
    Begin
      Pc_LimpaTudo;
      Pedido.Registro.CodigoEstabelecimento := Gb_Codmha;
      Pedido.Registro.Codigo := Lc_Form.It_cd_Pedido;
      Pedido.getbyId;
      Pedido.using('B');
      Pc_PreencherOrdem;
      Pc_PreencherItensVenda(Pedido.Registro.Codigo);
      Pc_totalizaItensPedido;
      Pc_totalizaPedido;
      Pc_EstadoEdicaoOrdem;
    end;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Pizzaria.Pc_PreencherOrdem;
var
  Lc_Save: TNotifyEvent;
  Lc_Reg_Pedido : TStringList;
  strLinha: String;
  Parte : TStringList;
  Lc_I : Integer;
  Restaurante : TControllerRestaurante;
Begin
  with Pedido.Registro do
  Begin
    //Desativa o evento do cmponente para setar o valor
    Lc_Save := Rg_ModalidadeClick;
    Rg_Modalidade.OnClick:= nil;
    //Seta o campo com o valor
    Rg_Modalidade.ItemIndex := StrToIntDef(TipoContato,0);
    Pg_Modalidade.ActivePageIndex := StrToIntDef(TipoContato,0);
    if ( ( StrToIntDef(TipoContato,0) = 1) OR ( StrToIntDef(TipoContato,0) = 2) ) AND ( Empresa <> CodigoConsumidor ) then
      Pg_Modalidade.ActivePageIndex := 0
    else
      Pg_Modalidade.ActivePageIndex := StrToIntdeF(TipoContato,0);
    E_VL_SubTotal.Text := FloatToStrF(ValorProdutos,ffFixed,10,2);
    E_VL_Adicional.Text := FloatToStrF(ValorOutrasDEspesas,ffFixed,10,2);
    E_Vl_Desconto.Text := FloatToStrF(ValorDesconto,ffFixed,10,2);
    E_VL_Entrega.Text := FloatToStrF(ValorFrete,ffFixed,10,2);
    E_Vl_Pedido.Text := FloatToStrF(ValorPedido,ffFixed,10,2);
    E_OBS.Text := Observacao;
    Pedido.Endereco.Registro.Codigo := Endereco;
    Pedido.Endereco.getById;
    E_Telefone.text := fc_MascaraFone( Pedido.Endereco.Registro.Fone);
    E_CEP.text := Pedido.Endereco.Registro.Cep;
    E_Endereco.text := Pedido.Endereco.Registro.Logradouro;
    E_Numero.text := Pedido.Endereco.Registro.NumeroPredial;
    E_Compl.text := Pedido.Endereco.Registro.Complemento;
    E_Bairro.text := Pedido.Endereco.Registro.Bairro;
    Pedido.Cliente.Empresa.Registro.Codigo := Empresa;
    Pedido.Cliente.Empresa.getById;
    E_Nome.text := Pedido.Cliente.Empresa.Registro.NomeRazaoSocial;
    strLinha := Pedido.Cliente.Empresa.Registro.Observacao;
    Parte := TStringList.Create;
    try
      Parte.Clear;
      ExtractStrings([#13],[], PChar(strLinha), Parte);
      if (Parte.Count > 0) then
        E_ObsCliente.text := Trim( Parte.Strings[0] );
    finally
      FreeAndNil(Parte);
    end;

    //Ativa o evento do componente depois de setar o valor
    Rg_Modalidade.OnClick:= Lc_Save;
  End;
  try
    Restaurante := TControllerRestaurante.Create(nil);
    with Restaurante.Registro do
    Begin
      CodigoPedido := Pedido.Registro.Codigo;
      CodigoEstabelecimento := Pedido.Registro.CodigoEstabelecimento;
      Restaurante.getbyId;

      case Pg_modalidade.ActivePageIndex of
        1: E_Cliente_Balcao.Text := Descricao;
        2: E_NR_Mesa.Text := Copy(Descricao,6,(Length(Descricao)-5));
      end;
    End;
  finally
    FreeAndNil(Restaurante);
  end;

end;

procedure TFr_Pizzaria.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If (Key = #13) and not (ActiveControl is TMemo) and not (ActiveControl is TListBox) then
  Begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Pizzaria.FormResize(Sender: TObject);
begin
  if self.WindowState = wsMaximized then
    Pnl_Left.Width := 600
  else
    Pnl_Left.Width := 363;
end;

procedure TFr_Pizzaria.E_Cliente_BalcaoExit(Sender: TObject);
begin
  case PG_Modalidade.ActivePageIndex of
    0:Pc_PreencherClienteBalcaoCadastro;
    1:Pc_PreencherClienteBalcao;
    end;

end;

procedure TFr_Pizzaria.E_EnderecoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    if Key = VK_F7 then Sb_EnderecoClick(Sender);
end;

procedure TFr_Pizzaria.Pg_modalidadeExit(Sender: TObject);
begin
  Pc_PreencherClienteMesa
end;

procedure TFr_Pizzaria.PrgoramaPAYBACK1Click(Sender: TObject);
Var
  Lc_Form:TSeaPAyBack;
begin
  Try
    Lc_Form := TSeaPAyBack.Create(nil);
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form)
  end;
end;

procedure TFr_Pizzaria.Sb_CepClick(Sender: TObject);
begin
  if (E_cep.Text = '') then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Informe o Número do Cep.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    if E_cep.CanFocus then E_cep.SetFocus;
  end
  else
  Begin
    Pc_BuscaCep(E_cep.Text);
  end;
end;

procedure TFr_Pizzaria.E_CEPExit(Sender: TObject);
begin
  if (It_Edicao_Ordem = 'I') and (E_cep.Text <> '') then
    Sb_CepClick(Sender);
end;

procedure TFr_Pizzaria.SB_Sair_1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Pizzaria.Sb_UltimoPedidoClick(Sender: TObject);
Var
  Form : TFr_PizzariaHistorico;
begin
  Try
    Form := TFr_PizzariaHistorico.Create(nil);
    Form.ClienteID := Pedido.Cliente.Registro.Codigo;
    Form.ConsumidorID := CodigoConsumidor;
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;

end;

procedure TFr_Pizzaria.Sb_ClienteClick(Sender: TObject);
Var
  Lc_Form : TFr_CliResumo;
begin
  Try
    Lc_Form := TFr_CliResumo.Create(nil);
    //comentei por que não lembro por que comecei a programar as proximas 3 linhas
    //Lc_Form.Cliente.Empresa.ClonarObj(pedido.Cliente.Empresa.Registro,Lc_Form.Cliente.Empresa.Registro);
    //Lc_Form.Cliente.Empresa.Endereco.ClonarObj(pedido.Endereco.Registro,Lc_Form.Cliente.Empresa.Endereco.Registro);
    //Lc_Form.Cliente.ClonarObj(Pedido.Cliente.Registro,Lc_Form.Cliente.Registro);
    Lc_Form.ShowModal;
    if (Lc_Form.Qr_Pesquisa.RecordCount > 0) then
    Begin
      Self.pedido.Endereco.Registro.Fone := Lc_Form.Qr_Pesquisa.FieldByName('END_FONE').asstring;
      Self.pedido.Endereco.getIdByFone;
      Pc_PreencherClienteEntrega;
      if E_Nome.CanFocus then E_Nome.SetFocus;
    end;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Pizzaria.Sb_EnderecoClick(Sender: TObject);
begin
  if not Assigned(Fr_PesqEndereco) then Application.CreateForm(TFr_PesqEndereco, Fr_PesqEndereco);
  Pc_AtivaEstabelecimento;
  with Fr_PesqEndereco do
  Begin
    E_Busca_Tipo.Text := 'Rua';
    E_busca_Cidade.Text := DM.Qr_Estabelecimento.FieldByName('CDD_DESCRICAO').AsString;
    DBLCB_busca_Estado.KeyValue := DM.Qr_Estabelecimento.FieldByName('UFE_CODIGO').AsInteger;
    if showmodal = mrOk then
    Begin
      if (StrGrd_Logradouro.RowCount > 1) and (StrGrd_Logradouro.Cells[1,StrGrd_Logradouro.row]<>'') then
      Begin
        E_cep.Text := StrGrd_Logradouro.Cells[1,StrGrd_Logradouro.row];
        E_Endereco.Text := StrGrd_Logradouro.Cells[2,StrGrd_Logradouro.row];
        E_Bairro.Text := StrGrd_Logradouro.Cells[3,StrGrd_Logradouro.row];
        if E_Numero.CanFocus then E_Numero.SetFocus;
      end;
    End;
  end;
end;



procedure TFr_Pizzaria.Pc_PreencherItensVenda(Pc_Cd_Pedido:Integer);
Var
  Lc_I,Lc_J : Integer;
  Lc_registro : Integer;

Begin
  Pc_LimpaStringGrid(StrGrd_ItensVenda);
  with Qr_Itens_RTR,StrGrd_ItensVenda do
  Begin
    Active := false;
    ParamByName('PED_CODIGO').AsInteger := Pc_Cd_Pedido;
    Active := True;
    First;
    Lc_registro := 0;
    while not Eof do
    Begin
      Lc_registro := Lc_registro + 1;
      RowCount := Lc_registro + 1;
      For Lc_I:= 0 to FieldCount -1 do
        if (Fields.Fields[Lc_I].DataType = ftFloat) OR (Fields.Fields[Lc_I].DataType = ftBCD) then
          Cells[Lc_I,Lc_registro] := FloatToStrF(Fields[Lc_I].AsFloat,ffFixed,10,2)
        else
          Cells[Lc_I,Lc_registro] := Fields[Lc_I].AsString;
      Next;
    end;
    Repaint;
  end;
end;

procedure TFr_Pizzaria.StrGrd_ItensVendaDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with Qr_Itens_RTR, StrGrd_ItensVenda do
  Begin
    If (arow > 0) then // testa se não é a primeira linha (fixa)
    Begin
      Canvas.FillRect(Rect); // redesenha a celula
      Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
      // Pega o texto da célula
      Texto := Cells[acol, ARow];
      //{ Calcura largura e altura (em pontos) do texto
      LarguraTexto := Canvas.TextWidth(Texto);
      AlturaTexto := Canvas.TextHeight(Texto);
      // Calcula a posição horizontal do início do texto
      if (Fields.Fields[ACol].DataType = ftFloat) OR (Fields.Fields[ACol].DataType = ftBCD) then
        X := Rect.Right - LarguraTexto - 2
      else
      if (Fields.Fields[ACol].DataType = ftDateTime) then
        X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
      else
        X := Rect.Left + 2;
      // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
      Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
      Canvas.TextRect(Rect, X, Y, Texto);
    end;
  end;
end;

procedure TFr_Pizzaria.tbs_BalcaoShow(Sender: TObject);
begin
  UtilizaClienteconsumidor;
end;

procedure TFr_Pizzaria.tbs_MesaShow(Sender: TObject);
begin
  UtilizaClienteconsumidor;
end;

procedure TFr_Pizzaria.UtilizaClienteconsumidor;
Begin
  Pedido.Cliente.Empresa.Registro.Codigo := CodigoConsumidor;
  Pedido.Cliente.Empresa.getById;
  Pedido.Cliente.Registro.Codigo := CodigoConsumidor;
  Pedido.Cliente.getById;
  Pedido.Endereco.Registro.CodigoEmpresa := CodigoConsumidor;
  Pedido.Endereco.getByEmpresa;
end;


function TFr_Pizzaria.ValidaDesativaProdutoByCodigo: Boolean;
begin
  Result := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Tem certeza que deseja desativar este item do cardápio.' + EOLN + EOLN +
                      'Confirmar a operação ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Ao desativar este produto, só poderá ativa-lo pela tela do Cardápio.' + EOLN + EOLN +
                      'Confirmar novamente a operação ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBlue) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;

end;

function TFr_Pizzaria.ValidaDesativaProdutoByName: Boolean;
begin
  Result := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Tem certeza que deseja desativar este item do cardápio.' + EOLN + EOLN +
                      'Confirmar a operação ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;

  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Ao desativar este produto, só poderá ativa-lo pela tela do Cardápio.' + EOLN + EOLN +
                      'Confirmar novamente a operação ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBlue) = mrBotao2) then
  Begin
    Result := False;
    Exit;
  End;

end;

function TFr_Pizzaria.validaidentificacao: Boolean;
begin
  if (Pedido.Registro.Empresa <> CodigoConsumidor )  then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Cliente já identificado.' + EOLN +
                   'Verifique!!.'+ EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Pg_modalidade.ActivePage := tbs_Entrega;
    Exit;
  End;
end;

function TFr_Pizzaria.VerificaProdutoPausadoByCodigo(Produto: Integer): Boolean;
begin

end;

function TFr_Pizzaria.VerificaProdutoPausadoByName(Produto: String;
  GRupo: Integer): Boolean;
Var
  Lc_DskRestMenu : TControllerDskRestMenu;
begin
  try
    Lc_DskRestMenu := TControllerDskRestMenu.Create(nil);
    Result := Lc_DskRestMenu.VerificaProdutoPausadoByName(Produto,Grupo);
  finally
    FreeAndNil(Lc_DskRestMenu);
  end;
end;

procedure TFr_Pizzaria.E_VL_AdicionalExit(Sender: TObject);
begin
  Pc_totalizaPedido;
end;

procedure TFr_Pizzaria.E_Vl_DescontoExit(Sender: TObject);
begin
  Pc_totalizaPedido;
end;

procedure TFr_Pizzaria.E_VL_EntregaExit(Sender: TObject);
begin
  Pc_totalizaPedido;
end;

function TFr_Pizzaria.Fc_ValidaExclusao():Boolean;
Begin
  Result := True;
  if Pedido.VerificaFaturado(True) then
  Begin
    REsult := False;
    Exit;
  end;
end;

procedure TFr_Pizzaria.SB_ExcluirClick(Sender: TObject);
begin
  if Fc_ValidaExclusao then
  Begin
    If (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja realmente excluir este Pedido.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                      [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao1) then
    Begin
      Pc_Delete_Estoque('P',Pedido.Registro.Codigo,0);
      Pedido.enviaLixeira;
      Pc_Log_Sistema( Gb_CodMha,
                      GB_Cd_Usuario,
                      now,
                      'Pedido Pizzaria',
                      Pedido.Registro.Codigo,
                      'Exclusão do Pedido Pizzaria',
                      'PEDIDO NUMERO: ' + IntToStr(Pedido.Registro.Numero));
      Pedido.using('L');
      Pc_LimpaTudo;
    end;
  end;
end;


procedure TFr_Pizzaria.Pc_MostraMensagem(Pc_Fone: String);
Var
  Lc_Pos : Integer;
begin
  Pc_Fone := Trim(Pc_Fone);
  Lc_Pos := Pos('E',Pc_Fone);
  Pc_Fone := Copy(Pc_Fone,It_Tra_Str_Ini_Piz,It_Tra_Str_Tam_Piz);
  Pedido.Using('L');
  It_Edicao_Ordem := 'I';
  Pc_EstadoEdicaoOrdem;
  Pc_NovoRegistro;
  E_Telefone.Text := Pc_Fone;
  E_TelefoneExit(Self);
  if E_Nome.CanFocus then E_Nome.SetFocus;
end;


Function TFr_Pizzaria.Fc_validaExcluiItem():Boolean;
Var
  Lc_Form : TFr_Liberacao;
Begin
  Result := True;
  IF (StrToIntDef(StrGrd_ItensVenda.Cells[0,StrGrd_ItensVenda.row],0) = 0) then
  BEgin
    Result := False;
    exit;
  end;

  if (not Gb_Liberado) or (Gb_Nivel = 0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+ EOLN + EOLN +
                   'A Exclusão de item do pedido é permitido apenas para usuário Administrador.' + EOLN +
                   '        Solicite autorização e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    try
      Lc_Form := TFr_Liberacao.Create(nil);
      Lc_Form.Liberado := False;
      Lc_Form.It_Interface := 'Fr_Pizzaria';
      Lc_Form.It_Nome_Menu := 'Pizzaria';
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
      FreeAndNil(Lc_Form);
    end;
  end;
end;

procedure TFr_Pizzaria.SelecinaItensParaExcluir;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('SELECT DISTINCT ITR_CODITF '+
              'FROM TB_ITENS_RTR '+
              '  INNER JOIN TB_ITENS_NFL ' +
              '  ON (ITF_CODIGO = ITR_CODITF) '+
              'WHERE (ITF_CODPED =:PED_CODIGO) '+
              '  AND (ITR_NR_ITEM =:ITR_NR_ITEM) ');
      ParamByName('PED_CODIGO').AsInteger := StrToIntDef(StrGrd_ItensVenda.Cells[1,StrGrd_ItensVenda.row],0);
      ParamByName('ITR_NR_ITEM').AsInteger := StrToIntDef(StrGrd_ItensVenda.Cells[3,StrGrd_ItensVenda.row],0);
      Active := True;
      First;
      while not eof do
      Begin
        Fc_ApagarRegistro('TB_ITENS_AVL',['IAV_CODITF'],[fieldByName('ITR_CODITF').AsString]);
        Fc_ApagarRegistro('TB_ITENS_RTR',['ITR_CODITF'],[fieldByName('ITR_CODITF').AsString]);
        Fc_ApagarRegistro('TB_ITENS_NFL',['ITF_CODIGO'],[fieldByName('ITR_CODITF').AsString]);
        Pc_Delete_Estoque('P',0,fieldByName('ITR_CODITF').AsInteger);
        Next;
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
End;

procedure TFr_Pizzaria.Sb_Exc_ItemClick(Sender: TObject);
Var
  Lc_ValorItem : Real;
  Lc_I,Lc_Item : Integer;
begin
  if Fc_validaExcluiItem then
  BEgin
    If (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja realmente excluir este Item do Pedido.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                      [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao1) then
    Begin
      Lc_Item := StrToIntDef(StrGrd_ItensVenda.Cells[3,StrGrd_ItensVenda.row],0);
      for Lc_I := 0 to StrGrd_ItensVenda.rowCount do
      Begin
        if (StrToIntDef(StrGrd_ItensVenda.Cells[3,Lc_I],0) = Lc_Item ) then
        Begin
          Lc_ValorItem := StrToFloatDef(StrGrd_ItensVenda.Cells[5,Lc_I],0)  * StrToFloatDef(StrGrd_ItensVenda.Cells[6,Lc_I],0);
          Pc_Log_Sistema( Gb_CodMha,
                        GB_Cd_Usuario,
                        now,
                        'Pizzaria',
                        StrToIntDef(StrGrd_ItensVenda.Cells[1,Lc_I],0),
                       'Exclusão do item de venda',
                       'Produto: ' + StrGrd_ItensVenda.Cells[4,Lc_I] + ' - Valor: ' + FloatToStrF(Lc_ValorItem,ffFixed,10,2));
        End;
      End;
      SelecinaItensParaExcluir;
      Pc_PreencherItensVenda(Pedido.Registro.Codigo);
      Pc_totalizaItensPedido;
    end;
  end;
end;

Function TFr_Pizzaria.Fc_validaImprimeItem():Boolean;
Begin
  Result := True;
  IF (StrToIntDef(StrGrd_ItensVenda.Cells[0,StrGrd_ItensVenda.row],0) = 0) then
  BEgin

    Result := False;
    exit;
  end;
end;

procedure TFr_Pizzaria.Fechamento1Click(Sender: TObject);
Var
  LcForm : TFr_Imp_Fechamento;
begin
  try
    LcForm := TFr_Imp_Fechamento.Create(nil);
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TFr_Pizzaria.ImprimeItem;
Var
  Lc_Imp : TPrintPizzaria;
begin
  Application.ProcessMessages;
  Lc_Imp := TPrintPizzaria.Create(nil);
  with Lc_Imp do
  Begin
    CodigoPedido := Pedido.Registro.Codigo;
    NumeroItemPedido := StrToIntDef(StrGrd_ItensVenda.Cells[3,StrGrd_ItensVenda.row],0);
    PrintModeloItemCozinha;
  end;
  FreeAndNil(Lc_Imp);
  Application.ProcessMessages;
End;


procedure TFr_Pizzaria.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2:if SB_Inserir.enabled then SB_InserirClick(Sender);
      VK_F3:if SB_Alterar.enabled then SB_AlterarClick(Sender);
      VK_F4:if SB_Excluir.enabled then SB_ExcluirClick(Sender);
      VK_F5:if SB_Gravar.enabled then SB_GravarClick(Sender);
      VK_F6:if SB_Cancelar.enabled then SB_CancelarClick(Sender);
      VK_F7:if Sb_Pesquisar.enabled then Sb_PesquisarClick(Sender);
      VK_F10:if SB_Faturar.enabled then SB_FaturarClick(Sender);
      VK_F11:if Sb_Imprimir.enabled then Sb_ImprimirClick(Sender);
      VK_Escape: if Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
      end;
  end;
end;

end.













