unit UN_Pedido_Ajt;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, System.Math, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.DBCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Mask, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Actions, Vcl.ActnList, STQuery, ControllerBase, QEdit_Setes, Un_Fm_ListaMultiEmpresa, ControllerCtrlLote, ControllerPedido, ControllerItensNFL, ControllerDevolIPI, Datasnap.DBClient, base_frame_list;

type
  TFr_Pedido_Ajt = class(TForm)
    Pg_Pedido_Ajt: TPageControl;
    tbs_pedido: TTabSheet;
    tbs_pesquisa: TTabSheet;
    PrintDialog: TPrintDialog;
    Pnl_fundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DBLCB_Empresa: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    Label36: TLabel;
    E_BuscaCliente: TEdit;
    E_BuscaPedido: TEdit;
    E_Cd_Empresa: TEdit;
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    Qr_Endereco: TSTQuery;
    Ds_Endereco: TDataSource;
    ds_itens_ajt: TDataSource;
    ChBx_Busca_Nome: TCheckBox;
    ChBx_Busca_Fantasia: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    E_Data: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Panel2: TPanel;
    Label22: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label8: TLabel;
    Label23: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    E_Qt_Produto: TEdit_Setes;
    E_VL_IPI: TEdit_Setes;
    E_VL_Frete: TEdit_Setes;
    E_VL_ICMS: TEdit_Setes;
    E_VL_Bs_ICMS: TEdit_Setes;
    E_VL_Produto: TPanel;
    E_Aq_Desconto: TEdit_Setes;
    Label26: TLabel;
    E_VL_Desconto: TEdit_Setes;
    Label6: TLabel;
    chbx_Nome: TCheckBox;
    chbx_fantasia: TCheckBox;
    E_Nr_Pedido: TEdit_Setes;
    Label9: TLabel;
    DBLCB_Vendedor: TDBLookupComboBox;
    Pop_lote: TPopupMenu;
    RegistraNmerodeSerie: TMenuItem;
    RegistraNmerodeLote: TMenuItem;
    lc_fornecedor: TLabel;
    Pnl_botao: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    SB_Faturar: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Pesquisar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    E_VL_Pedido: TPanel;
    InformaesdaDI1: TMenuItem;
    Pg_Observacao: TPageControl;
    tbs_obs: TTabSheet;
    Pnl_Observacao: TPanel;
    E_Observ: TMemo;
    tbs_dado_entrega: TTabSheet;
    Pnl_entrega: TPanel;
    Label20: TLabel;
    DBLCB_End_Entrega: TDBLookupComboBox;
    CadastrodoProduto: TMenuItem;
    GroupBox3: TGroupBox;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    SB_Cadastrar: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    DBG_Pesquisa: TDBGrid;
    TabSheet1: TTabSheet;
    Pnl_Informacoes: TPanel;
    Sb_Negocio: TSpeedButton;
    Label13: TLabel;
    Dblcb_Negocio: TDBLookupComboBox;
    InformarNmerodeCompra: TMenuItem;
    tbs_Config_Global: TTabSheet;
    tbs_Config_Local: TTabSheet;
    Panel1: TPanel;
    Panel3: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    cbx_modeloLaser_ajt: TComboBox;
    rdg_PedAjt_Imp: TRadioGroup;
    GroupBox2: TGroupBox;
    e_porta_ImpAjt: TEdit;
    e_salto_ajt: TEdit_Setes;
    cbx_modeloMat_Ajt: TComboBox;
    GroupBox18: TGroupBox;
    e_itens_ajt: TEdit_Setes;
    Chbx_controle_ajuste: TCheckBox;
    Btn_Ok_Local: TButton;
    Btn_Cn_Local: TButton;
    Btn_Ap_Local: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Mnu_Controle: TMainMenu;
    Mnu_Tarefas: TMenuItem;
    Pop_ConfigLocal: TMenuItem;
    Pop_ConfigGlobal: TMenuItem;
    Chbx_controle_estoque: TCheckBox;
    Sb_Pesq_Cliente: TSpeedButton;
    SB_Cliente: TSpeedButton;
    Fm_LME: TFm_ListaMultiEmpresa;
    PopAjustarRetornocomVendas: TMenuItem;
    PG_Itens: TPageControl;
    TS_Produto: TTabSheet;
    Pnl_Produto: TPanel;
    Sb_Ins_Produto: TSpeedButton;
    Sb_Alt_Produto: TSpeedButton;
    Sb_Exc_Produto: TSpeedButton;
    cds_itens_ajt: TClientDataSet;
    cds_itens_ajtITF_CODIGO: TIntegerField;
    cds_itens_ajtITF_CODPED: TIntegerField;
    cds_itens_ajtITF_CODNFL: TIntegerField;
    cds_itens_ajtITF_CODPRO: TIntegerField;
    cds_itens_ajtPRO_CODIGOFAB: TWideStringField;
    cds_itens_ajtPRO_CODIGOFOR: TWideStringField;
    cds_itens_ajtPRO_DESCRICAO: TWideStringField;
    cds_itens_ajtPRO_SERIE: TWideStringField;
    cds_itens_ajtITF_QTDE: TBCDField;
    cds_itens_ajtITF_VL_CUSTO: TFMTBCDField;
    cds_itens_ajtITF_AQ_COM: TBCDField;
    cds_itens_ajtITF_AQ_IPI: TBCDField;
    cds_itens_ajtEMB_ABREVIATURA: TWideStringField;
    cds_itens_ajtITF_AQ_ICMS: TBCDField;
    cds_itens_ajtITF_CODEST: TIntegerField;
    cds_itens_ajtITF_CODTPR: TIntegerField;
    cds_itens_ajtMED_ABREVIATURA: TWideStringField;
    cds_itens_ajtITF_AQ_DESC: TBCDField;
    cds_itens_ajtITF_VL_DESC: TBCDField;
    cds_itens_ajtITF_ESTOQUE: TWideStringField;
    cds_itens_ajtITF_VL_IPI: TFMTBCDField;
    cds_itens_ajtITF_ALTURA: TBCDField;
    cds_itens_ajtITF_LARGURA: TBCDField;
    cds_itens_ajtITF_VL_SUBTOTAL: TFloatField;
    cds_itens_ajtITF_VL_TOTAL: TFloatField;
    Qr_Itens: TSTQuery;
    Qr_ItensITF_CODIGO: TIntegerField;
    Qr_ItensITF_CODPED: TIntegerField;
    Qr_ItensITF_CODNFL: TIntegerField;
    Qr_ItensITF_CODPRO: TIntegerField;
    Qr_ItensPRO_CODIGOFAB: TStringField;
    Qr_ItensPRO_CODIGOFOR: TStringField;
    Qr_ItensPRO_DESCRICAO: TStringField;
    Qr_ItensPRO_SERIE: TStringField;
    Qr_ItensITF_QTDE: TBCDField;
    Qr_ItensITF_VL_CUSTO: TFMTBCDField;
    Qr_ItensITF_VL_UNIT: TFMTBCDField;
    Qr_ItensITF_AQ_COM: TBCDField;
    Qr_ItensITF_AQ_IPI: TBCDField;
    Qr_ItensEMB_ABREVIATURA: TStringField;
    Qr_ItensITF_AQ_ICMS: TBCDField;
    Qr_ItensITF_CODEST: TIntegerField;
    Qr_ItensITF_CODTPR: TIntegerField;
    Qr_ItensMED_ABREVIATURA: TStringField;
    Qr_ItensITF_AQ_DESC: TBCDField;
    Qr_ItensITF_VL_DESC: TBCDField;
    Qr_ItensITF_ESTOQUE: TStringField;
    Qr_ItensITF_VL_IPI: TFloatField;
    Qr_ItensITF_ALTURA: TBCDField;
    Qr_ItensITF_LARGURA: TBCDField;
    Qr_ItensITF_VL_SUBTOTAL: TFloatField;
    Qr_ItensITF_VL_TOTAL: TFloatField;
    DBG_Produtos: TDBGrid;
    pnl_pesq_right: TPanel;
    Sb_Transferir: TSpeedButton;
    cds_itens_ajtITF_VL_UNIT: TExtendedField;
    Qr_ItensITF_SEQUENCIA: TIntegerField;
    Qr_ItensPRO_CODIGONCM: TStringField;
    Qr_ItensPRO_TIPO: TStringField;
    Qr_ItensTPR_MODALIDADE: TStringField;
    Qr_ItensTPR_NOME: TStringField;
    Qr_ItensPRO_ORIGEM: TStringField;
    Qr_ItensITF_NR_PECAS: TBCDField;
    Qr_ItensPRO_VL_CUSTOMED: TFMTBCDField;
    InformaoCombustivel1: TMenuItem;
    Corrigirsequnciadositens1: TMenuItem;
    Label29: TLabel;
    Cb_IndPresComprador: TComboBox;
    procedure DBG_ProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure E_DataEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Sb_PesquisarClick(Sender: TObject);    
    procedure E_VL_FreteExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbs_pesquisaShow(Sender: TObject);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_CadastrarClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure Sb_Sair_1Click(Sender: TObject);
    procedure E_VL_DescontoExit(Sender: TObject);
    procedure Sb_Ins_ProdutoClick(Sender: TObject);
    procedure Sb_Alt_ProdutoClick(Sender: TObject);
    procedure Sb_Exc_ProdutoClick(Sender: TObject);
    procedure SB_FaturarClick(Sender: TObject);
    procedure ChBx_Busca_NomeClick(Sender: TObject);
    procedure ChBx_Busca_FantasiaClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure E_VL_IPIExit(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure E_Aq_DescontoExit(Sender: TObject);
    procedure tbs_pedidoShow(Sender: TObject);
    procedure RegistraNmerodeSerieClick(Sender: TObject);
    procedure RegistraNmerodeLoteClick(Sender: TObject);
    procedure chbx_NomeClick(Sender: TObject);
    procedure chbx_fantasiaClick(Sender: TObject);
    procedure E_NotaKeyPress(Sender: TObject; var Key: Char);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure InformaesdaDI1Click(Sender: TObject);
    procedure DBLCB_EmpresaExit(Sender: TObject);
    procedure CadastrodoProdutoClick(Sender: TObject);
    procedure E_Cd_EmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Sb_NegocioClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure InformarNmerodeCompraClick(Sender: TObject);
    procedure Qr_EnderecoAfterOpen(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Btn_Ok_LocalClick(Sender: TObject);
    procedure Btn_Cn_LocalClick(Sender: TObject);
    procedure Btn_Ap_LocalClick(Sender: TObject);
    procedure Pop_ConfigLocalClick(Sender: TObject);
    procedure Pop_ConfigGlobalClick(Sender: TObject);
    procedure Sb_Pesq_ClienteClick(Sender: TObject);
    procedure SB_ClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure E_Cd_EmpresaExit(Sender: TObject);
    procedure PopAjustarRetornocomVendasClick(Sender: TObject);
    procedure DBG_ProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure DBG_ProdutosTitleClick(Column: TColumn);
    procedure Sb_TransferirClick(Sender: TObject);
    procedure cds_itens_ajtAfterOpen(DataSet: TDataSet);
    procedure Qr_ItensCalcFields(DataSet: TDataSet);
    procedure InformaoCombustivel1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Corrigirsequnciadositens1Click(Sender: TObject);
  private
    { Private declarations }
    It_Inserir : Boolean;
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    It_Baixar  : Boolean;
    It_Imprimir : Boolean;
    It_Visualizar : Boolean;

    It_Edicao_Ordem : String;
    procedure OnSize(var Msg : TWMSize); message wm_size;
    procedure Pc_AjustarRetorno(Lista:String);
    procedure Pc_Gravar;
    procedure Pc_Gravar_Itens;
    procedure Pc_EstadoEdicaoOrdem;
    procedure Pc_Ini_Variavel;
    procedure Pc_AbrirEndereco;
    Function Fc_ValidaCancelameto():Boolean;
    function Fc_ValidaAlteracao():Boolean;
    procedure ApagaDevolIpi(id:Integer);
    procedure ChangeQtde(Sender: TField);
    procedure ChangeValorUnitario(Sender: TField);
    procedure DeletedItems;
    procedure Pc_grava_Perfil_Local;
    Function Valida_impressao:Boolean;
    procedure Impressao;
  public
    { Public declarations }
    CtrlLote : TControllerCtrlLote;
    Pedido : TControllerPedido;
    It_Operacao : Integer;
    procedure Pc_AtivarTabelas;
    procedure PC_Buscar;
    procedure Pc_Visualizar;
    procedure Pc_Totalizador;
    procedure Pc_AtualizaCampos;
    procedure Pc_GeraNumeroPedido;
    Function ValidaPedidoExistente:Boolean;
    Function Fc_ValidaFaturamento():Boolean;
    Function Fc_ValidaPreencheEmitente():Boolean;
    procedure Pc_FormataCasas;
    function Fc_ValidaGravacao(): Boolean;
    procedure Pc_Valida_Info_Empresa(Pc_Cd_Empresa : Integer);
    Procedure Pc_DefineSetfocus;
    Procedure Pc_LimpaCampos;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    function Fc_MovimentoSerie(Fc_Operacao:String):Integer;
    function Fc_ValidaSeries:Boolean;
    procedure Pc_FormataTela;

    procedure Pc_AbrirPedido;
    procedure Pc_AbrirItens;
    procedure Pc_ShowItens;
    procedure Pc_IniciaVariaveis;
    procedure Pc_ImagemBotao;
    function Fc_VerificaExistenciaItem():Boolean;
    procedure Pc_AbrePedidoNovo;
    Function Fc_ChamaFaturaAjt():Boolean;
    procedure Pc_Grava_Config_Local;
    procedure Pc_Abre_Config_Local;
    procedure Pc_Abre_Config_Global;
    procedure Pc_Grava_Config_Global;
    procedure pc_Formatagrade(Tipo :String);
  end;

var
  Fr_Pedido_Ajt: TFr_Pedido_Ajt;

implementation

uses     Un_DM, Un_Msg, UN_Principal, env, UN_Sistema, RN_Lotes, tas_nfe_itens_fuel, Un_Itens_Produto_Ajt, Un_Funcoes, Un_Pesq_Produto, UN_Fatura_Ajt, Un_Fc_Sored_Procedures, Un_Produto_Series, un_Padrao, Un_Imp_Mod_Impressao, Un_Regra_Negocio, Un_Info_Dec_Imp, Un_Produtos, Un_Info_Compra_Venda, RN_Permissao, Un_Ctrl_Lote_Entrada, Un_Ctrl_Lote_Saida, RN_Inventario, RN_Estoque, RN_Pedido, RN_NotaFiscalEletronica3X, RN_Empresa, RN_NotaFiscal, UN_TabelasEmListas, sea_nf_product, tas_stock_transfer, sea_business;
{$R *.dfm}

procedure TFr_Pedido_Ajt.Pc_IniciaVariaveis;
Begin
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  //Indicador de presença do comprador no estabelecimento comercial no momento da operação
  Cb_IndPresComprador.ItemIndex := 2;
  If (Pedido.Registro.Codigo > 0) then
  Begin
    Pedido.getbyId;
    Pedido.using('B');
    Pc_AtivarTabelas;
    Pc_AbrirEndereco;
    Pc_AbrirPedido;
    Pg_Pedido_Ajt.ActivePageIndex := 0;
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
  end
  else
    Pg_Pedido_Ajt.ActivePageIndex:=1;
end;

procedure TFr_Pedido_Ajt.Pc_Ini_Variavel;
begin
  pedido.Clear;
  E_Nr_Pedido.Clear;
end;

procedure TFr_Pedido_Ajt.Pc_FormataTela;
Var
  Lc_top,lc_left : Integer;
  Lc_X : Integer;
begin
  Pc_ImagemBotao;
  Height := 620 - 15;
  For Lc_X:=1 to Pg_Pedido_Ajt.PageCount do Pg_Pedido_Ajt.Pages[Lc_X-1].TabVisible:=False;
  Pg_Pedido_Ajt.ActivePageIndex:=1;
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  IF Fc_Aq_Geral('L','PEDIDOAJT','CRB_TELA_MAXIM','N') = 'S' then
  Begin
    WindowState := wsMaximized;
    DBG_Pesquisa.Columns[2].Width := 600;
  End
  else
  Begin
    DBG_Pesquisa.Columns[2].Width := 332;
    WindowState := wsNormal;
  End;
end;

procedure TFr_Pedido_aJT.Pc_AbrirPedido;
Begin
  Try
    with pedido.Registro do
    Begin
      E_Nr_Pedido.Text := IntToStr(Numero);
      if Codigo > 0 then
        E_Data.Date := Data
      else
        E_Data.Date := Date;

      E_VL_Frete.Text   := FloatToStrF(ValorFrete,ffFixed,10,2);
      E_VL_Desconto.Text:= FloatToStrF(ValorDesconto,ffFixed,10,2);
      E_Aq_Desconto.Text:= FloatToStrF(AliqDesconto,ffFixed,10,2);
      Pc_AbrirItens;
      Pc_ShowItens;
      Pc_AtualizaCampos;
      Pc_Totalizador;
      E_Cd_Empresa.Text := IntToStr(Empresa);
      DBLCB_Empresa.KeyValue := empresa;
      DBLCB_Vendedor.KeyValue := Vendedor;
      if Endereco = 0 then
        Pc_Valida_Info_Empresa(Empresa);
      DBLCB_End_Entrega.KeyValue := Endereco;
      E_Observ.Text := Observacao;
      Dblcb_Negocio.KeyValue := CodigoNegocio;
      Cb_IndPresComprador.ItemIndex := IndicaPresenca - 1;
    End;
  Except
    Pc_ErroCorrigirValores(Pedido.Registro.Codigo);
    Pc_AbrirPedido;
  end;
End;

procedure TFr_Pedido_Ajt.Pc_AjustarRetorno(Lista: String);
Var
  LcQry : TSTQuery;
begin
  Try
    LcQry := TSTQuery.Create(nil);
    with LcQry do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IBT_Consulta;
      Active := False;
      sql.Clear;
      sql.Add(concat(
              'select sum(IT.itf_qtde) total ',
              'FROM TB_ITENS_NFL IT ',
              'WHERE IT.itf_CODPRO =:PRO_CODIGO ',
              'and IT.itf_CODNFL IN',Lista
      ));
    End;
    Qr_Itens.First;
    while not Qr_Itens.Eof do
    Begin
      LcQry.Active := False;
      LcQry.ParamByName('PRO_CODIGO').AsInteger := Qr_ItensITF_CODPRO.AsInteger;
      LcQry.Active := True;
      LcQry.FetchAll;
      if LcQry.RecordCount > 0 then
      Begin
        Pedido.Itens.Registro.Codigo := Qr_ItensITF_CODIGO.AsInteger;
        Pedido.Itens.getById;
        if Qr_ItensITF_QTDE.AsFloat > LcQry.FieldByName('total').AsCurrency then
        Begin
          Pedido.Itens.Registro.Quantidade := Qr_ItensITF_QTDE.AsFloat - LcQry.FieldByName('total').AsCurrency;
          Pedido.Itens.atualiza;
        End
        else
        Begin
          Pedido.Itens.delete;
        End;
      End;
      Qr_Itens.Next;
    End;
  Finally
    Pc_AbrirItens;
    Pc_ShowItens;
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    LcQry.Close;
    FreeAndNil(LcQry);
  End;
end;

procedure TFr_Pedido_Ajt.Pc_AbrirEndereco;
begin
  with Qr_endereco, Pedido.Registro do
  Begin
    Active:=False;
    ParamByName('EMP_CODIGO').AsInteger :=  Empresa;
    Active:=True;
  End;
end;

procedure TFr_Pedido_aJT.Pc_AbrirItens;
Begin
  Qr_Itens.Active:=False;
  Qr_Itens.paramByName('PED_CODIGO').AsInteger := Pedido.Registro.codigo;
  Qr_Itens.Active:=True;
  Qr_Itens.Fetchall;
End;

Function TFr_Pedido_Ajt.Fc_ValidaPreencheEmitente():Boolean;
Begin
  Result := true;

  If (TRIM(DBLCB_Empresa.Text) ='') then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Preenchimento do Campo Emitente/Destinatário é obrigatório.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    end;

end;


function TFr_Pedido_Ajt.Fc_ValidaAlteracao: Boolean;
begin
  Result := True;
  if Pedido.VerificaFaturado(TRue) then
  Begin
    Result := False;
    exit;
  end;

  if Pedido.InconsistenciaFaturado(true) then
  BEgin
    Result := False;
    exit;
  end;
end;

function TFr_Pedido_Ajt.Fc_ValidaCancelameto: Boolean;
begin
  Result := True;
  If E_Aq_Desconto.Focused then
    If E_Data.CanFocus then  E_Data.SetFocus;
  if E_VL_Desconto.Focused then
    If E_Data.CanFocus then  E_Data.SetFocus;
end;

Function TFr_Pedido_Ajt.Fc_ValidaFaturamento():Boolean;
Begin
  Result := true;
  if not ValidaPedidoExistente then
  Begin
    Result:=FALSE;
    exit;
  end;

  if Pedido.VerificaFaturado(TRue) then
  Begin
    Result := False;
    exit;
  end;

  Pc_AbrirItens;
  if cds_itens_ajt.RecordCount = 0 then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Não é possivel baixar pedido sem produto.'+ EOLN +
                   'Insera um produto no pedido.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result:=FALSE;
    exit;
  end;

  //Valida as Series
  if not Fc_ValidaSeries then
  begin
    Result:=FALSE;
  end;

end;


procedure TFr_Pedido_Ajt.Pc_GeraNumeroPedido;
begin
  with Pedido.Registro do
  Begin
    If (Numero = 0) then Pedido.nextNumber('T');
    E_Nr_Pedido.Text := IntToStr( Numero );
  End;
end;



procedure TFr_Pedido_Ajt.Pc_AtivarTabelas;
begin
  DM_ListaConsultas.Pc_ListaVendedor;
  DM.Qr_Prazo.Active:=True;
  DM.Qr_Prazo.FetchAll;
  Pc_AbreListaEmpresa(-1,'EMP_NOME');
  Qr_Endereco.Active:=false;
  DM.Qr_Negocio.Active:=True;
end;

procedure TFr_Pedido_Ajt.PC_Buscar;
var
  Lc_Sqltxt :string;
  Lc_Pedido : Boolean;
  Lc_Cliente : Boolean;
begin
  IF DM.IBT_Consulta.InTransaction then DM.IBT_Consulta.Commit;
  with Qr_Pesquisa do
  Begin
    Lc_Sqltxt := '';
    Screen.Cursor:=crHourGlass;
    Close;
    Qr_Pesquisa.Sql.Clear;
    Lc_Sqltxt := 'SELECT PED_CODIGO, PED_DATA, PED_NUMERO, EMP_FANTASIA, EMP_NOME ' +
                 'FROM TB_PEDIDO tb_pedido ' +
                 '  INNER JOIN TB_EMPRESA tb_empresa '+
                 '  ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP ) '+
                 'WHERE (PED_TIPO = 3) AND (PED_FATURADO = ''N'') ';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
    Begin
      Lc_Sqltxt := Lc_Sqltxt + ' AND (PED_CODMHA =:PED_CODMHA) ';
    end;

    if (E_BuscaPedido.Text = '') then Lc_Pedido := False Else Lc_Pedido := True;
    if (E_BuscaCliente.Text = '') then Lc_Cliente := False Else Lc_Cliente := True;
    if ChBx_Periodo.Checked then
      Lc_Sqltxt := Lc_Sqltxt + 'AND (PED_DATA BETWEEN :PED_DATAINI AND :PED_DATAFIM) ';
    if Lc_Pedido then Lc_Sqltxt := Lc_Sqltxt + 'AND (PED_NUMERO = :PED_NUMERO) ';
    if Lc_Cliente then Lc_Sqltxt := Lc_Sqltxt + 'AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ';

    SQL.Add(Lc_Sqltxt + ' ORDER BY EMP_FANTASIA ');

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
    Begin
      ParamByName('PED_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;
    end;

    if ChBx_Periodo.Checked then
    Begin
      ParamByName('PED_DATAINI').AsDate :=E_Data_Ini.Date;
      ParamByName('PED_DATAFIM').AsDate :=E_Data_Fim.Date;
    end;
    if Lc_Pedido then ParamByName('PED_NUMERO').AsString := E_BuscaPedido.Text;
    if Lc_Cliente then ParamByName('EMP_FANTASIA').AsString := '%'+E_BuscaCliente.Text+'%';

    Open;
    Screen.Cursor:=crDefault;
  End;
end;

procedure TFr_Pedido_Ajt.Pc_Visualizar;
begin
  If not Pedido.using('C') then
  Begin
    Pedido.Registro.Codigo := 0;
    exit;
  end;
  Pedido.getbyId;
  Pedido.using('B');
  Pc_AtivarTabelas;
  Pc_AbrirEndereco;
  Pc_AbrirPedido;
  It_Edicao_Ordem := 'B';
  Pc_EstadoEdicaoOrdem;
  Pg_Pedido_ajt.ActivePageIndex := 0;
end;

procedure TFr_Pedido_Ajt.Pc_AtualizaCampos;
Var
  Lc_Qt_Produto : Real;
  Lc_Vl_Produto : Real;
  Lc_Vl_IPI     : Real;
  Lc_Vl_Desconto:Real;
  Lc_Vl_TL_Icms :Real;
  Lc_VL_bs_Icms :Real;
  Lc_Aux : Real;
Begin
  Lc_Qt_Produto := 0;
  Lc_Vl_Produto := 0;
  Lc_Vl_IPI     := 0;
  Lc_Vl_Desconto:=0;
  Lc_Vl_TL_Icms :=0;
  Lc_VL_bs_Icms :=0;
  with cds_itens_ajt  do
  Begin
    First;
    DBG_Produtos.DataSource := nil;
    while not Eof do
    Begin
      Lc_Vl_Produto := Lc_Vl_Produto + FieldByName('ITF_VL_SUBTOTAL').AsCurrency;
      Lc_Qt_Produto := Lc_Qt_Produto + FieldByName('ITF_QTDE').AsFloat;
      Lc_Vl_IPI := Lc_Vl_IPI + FieldByName('ITF_VL_IPI').AsCurrency;
      Lc_Vl_Desconto := Lc_Vl_Desconto + FieldByName('ITF_VL_DESC').AsCurrency;
      IF (FieldByName('ITF_AQ_ICMS').AsCurrency > 0) then
      Begin
        Lc_Vl_TL_Icms := Lc_Vl_TL_Icms + (((FieldByName('ITF_QTDE').AsFloat * FieldByName('ITF_VL_UNIT').AsCurrency)-FieldByName('ITF_VL_DESC').AsCurrency) * (FieldByName('ITF_AQ_ICMS').AsCurrency/100));
        Lc_VL_bs_Icms := Lc_VL_bs_Icms + ((FieldByName('ITF_QTDE').AsFloat * FieldByName('ITF_VL_UNIT').AsCurrency)-FieldByName('ITF_VL_DESC').AsCurrency);
      end;
      Next;
    end;
    First;
    DBG_Produtos.DataSource := ds_itens_ajt;
  end;
  //Atualiza os campos no Formulario
  E_Qt_Produto.Text       := FloatToStrF(Lc_Qt_Produto,ffFixed,10,2);
  E_VL_Produto.Caption    := FloatToStrF(Lc_Vl_Produto,ffFixed,10,2);
  E_VL_Bs_ICMS.Text       := FloatToStrF(Lc_VL_bs_Icms,ffFixed,10,2);
  E_VL_ICMS.Text          := FloatToStrF(Lc_Vl_TL_Icms,ffFixed,10,2);
  E_VL_IPI.Text           := FloatToStrF(Lc_Vl_IPI,ffFixed,10,2);
  E_Vl_Desconto.Text      := FloatToStrF(lc_VL_Desconto,ffFixed,10,2);
  if (Lc_Vl_Produto) > 0 then
  Begin
    Lc_Aux := (Lc_VL_Desconto / Lc_Vl_Produto) * 100;
    Lc_Aux := RoundTo(Lc_Aux,-2);
    E_Aq_Desconto.Text := FloatToStrF(Lc_Aux,ffFixed,10,2)
  End
  else
    E_Aq_Desconto.Text := '0,00';
end;

procedure TFr_Pedido_Ajt.Pc_Totalizador;
Var
  Lc_Vl_aux : Real;
  Lc_Vl_Total : Real;
begin
  Lc_Vl_Total := 0;
  //PRodutos
  Lc_Vl_aux := StrToFloatDef(E_VL_Produto.Caption, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_VL_Produto.Caption := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //IPI
  Lc_Vl_aux := StrToFloatDef(E_VL_IPI.Text, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_VL_IPI.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Frete
  Lc_Vl_aux := StrToFloatDef(E_VL_Frete.Text, 0);
  Lc_Vl_Total := Lc_Vl_Total + Lc_Vl_aux;
  E_VL_Frete.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Desconto
  Lc_Vl_aux := StrToFloatDef(E_VL_Desconto.Text, 0);
  Lc_Vl_Total := Lc_Vl_Total - Lc_Vl_aux;
  E_VL_Desconto.Text := FloatToStrF(Lc_Vl_aux, ffFixed, 10, 2);
  //Valor total
  E_VL_Pedido.Caption := FloatToStrF(Lc_Vl_Total, ffFixed, 10, 2);
end;
// Procedures Internas

{Ordem de Servico/Venda}
procedure TFr_Pedido_Ajt.DBG_ProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  : if Sb_Exc_Produto.Enabled then Sb_Exc_ProdutoClick(Sender);
  end;
end;

procedure TFr_Pedido_Ajt.DBG_ProdutosKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
    if TDBGrid(Sender).Columns.Grid.SelectedIndex < TDBGrid(Sender).Columns.Count - 1 then
      TDBGrid(Sender).Columns[TDBGrid(Sender).Columns.grid.SelectedIndex + 1].Field.FocusControl
    else
    begin
      cds_itens_ajt.Next;
      TDBGrid(Sender).Columns[0].field.FocusControl;
    end;
  end;
end;

procedure TFr_Pedido_Ajt.DBG_ProdutosTitleClick(Column: TColumn);
var
  vIndice: string;
  vExiste: boolean;
begin
  if cds_itens_ajt.Active then
  BEgin
    if cds_itens_ajt.IndexFieldNames = Column.FieldName then
    begin
      vIndice := AnsiUpperCase(Column.FieldName);

      try
        cds_itens_ajt.IndexDefs.Find(vIndice);
        vExiste := True;
      except
        vExiste := False;
      end;

      if not (vExiste) then
      begin
        with cds_itens_ajt.IndexDefs.AddIndexDef do
        begin
          Name := vIndice;
          Fields := Column.FieldName;
          Options := [ixDescending];
        end;
      end;

      cds_itens_ajt.IndexName := vIndice;
    end
    else
      cds_itens_ajt.IndexFieldNames := Column.FieldName;
  End;
end;

procedure TFr_Pedido_Ajt.E_DataEnter(Sender: TObject);
begin
  E_Data.Date := Date;
end;

procedure TFr_Pedido_Ajt.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (not (ActiveControl is TMemo)) AND (not (ActiveControl is TDBGrid)) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;


procedure TFr_Pedido_Ajt.Sb_PesquisarClick(Sender: TObject);
begin
  Pedido.using('L');
  Pc_AtivaEstabelecimento;
  Pc_Ini_Variavel;
  Pc_Buscar;
  Pg_Pedido_Ajt.ActivePageIndex := 1;


end;

procedure TFr_Pedido_Ajt.E_VL_FreteExit(Sender: TObject);
Var
  Lc_Vl_frete : Real;
begin
  Lc_Vl_frete := StrtoFloatDef(E_VL_Frete.Text,0);
  E_VL_Frete.Text := FloatToStrF(Lc_Vl_frete,ffFixed,10,2);
  Pc_totalizador;
end;

procedure TFr_Pedido_Ajt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If ( (It_Edicao_Ordem = 'I') or (It_Edicao_Ordem = 'E') ) then  //Inicio verIfica edição
  Begin
  case PG_Itens.ActivePageIndex of
    0:begin
      if shift = [] then
        begin
          case Key of
          VK_F2  : if Sb_Ins_Produto.Enabled then Sb_Ins_ProdutoClick(Sender);
          VK_F3  : if Sb_Alt_Produto.Enabled then Sb_Alt_ProdutoClick(Sender);
          VK_F4  : if Sb_Exc_Produto.Enabled then Sb_Exc_ProdutoClick(Sender);
          end;
        end;
      end;
   end;
  end;
  case Pg_Pedido_Ajt.ActivePageIndex of
  0:begin
    if shift = [] then
      begin
        case Key of
        VK_F2  : if SB_Inserir.Enabled then SB_InserirClick(Sender);
        VK_F3  : if SB_Alterar.Enabled then SB_AlterarClick(Sender);
        VK_F4  : if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
        VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
        VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
        VK_F7  : if SB_Pesquisar.Enabled then SB_PesquisarClick(Sender);
        VK_F10  : if SB_Faturar.Enabled then SB_FaturarClick(Sender);
        VK_F11  : if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
        VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
        end;
      end;
    end;
  else
    begin
    if shift = [] then
      begin
      case Key of
      VK_F2  : if SB_Cadastrar.Enabled then SB_CadastrarClick(Sender);
      VK_F3  : if Sb_Transferir.Enabled then Sb_TransferirClick(Sender);
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_F8 : if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_Escape : if Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
      end;
      end;
    end;
  end;

end;

procedure TFr_Pedido_Ajt.tbs_pesquisaShow(Sender: TObject);
begin
  E_Data_Ini.Date:=Date-30;
  E_Data_Fim.Date :=Date;
  E_BuscaPedido.SetFocus;
  E_BuscaPedido.SelectAll;
  Pop_ConfigLocal.Visible := True;
  Pop_ConfigGlobal.Visible := True;
  PopAjustarRetornocomVendas.Visible := False;
end;

function TFr_Pedido_Ajt.ValidaPedidoExistente: Boolean;
begin
  Result := True;
  if pedido.Registro.Codigo = 0 then
  Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Não há dados neste pedido para continuar esta operação.' + EOLN +
                   'Verifique e tente novamente.' + EOLN ,
                   ['OK'], [bEscape], mpInformacao);
    Result:=FALSE;
    exit;
  end;
end;

procedure TFr_Pedido_Ajt.Pc_AbrePedidoNovo;
Begin
  Pc_AtivarTabelas;

  Pedido.using('L');
  Pc_Ini_Variavel;
  E_Cd_Empresa.Clear;
  E_Cd_EmpresaExit(Self);
  E_VL_IPI.Text := '0,00';
  E_VL_Frete.Text := '0,00';
  E_Aq_Desconto.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
  Pc_AbrirItens;
  Pc_ShowItens;
  Pc_AtualizaCampos;
  Pc_Totalizador;
  E_Data.Date := Date;
  It_Edicao_Ordem := 'I';
  Pc_EstadoEdicaoOrdem;
  E_Cd_Empresa.SetFocus;
end;

procedure TFr_Pedido_Ajt.SB_InserirClick(Sender: TObject);
Var
  Lc_Codigo : Integer;
begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja mesmo abrir um novo Pedido.'+EOLN+EOLN+
                     'Confirmar a Abertura ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  Begin
    if (Fc_Tb_Geral('L','VDA_G_COPIA_PEDIDO', 'N') = 'S') then
    Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Deseja efetuar uma cópia de Pedido/Nota existente.'+EOLN+EOLN+
                         'Confirmar a Cópia ?',
                        [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
      begin
        Lc_Codigo := Fc_CopiaPedidoNota(1);
        if Lc_codigo > 0 then
        Begin
          Pc_Ini_Variavel;
          Pedido.Registro.codigo := Lc_Codigo;
          Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
          Pc_Visualizar;
        End;
      end
      else
      Begin
        Pc_AbrePedidoNovo;
      end;
    end
    else
    Begin
        Pc_AbrePedidoNovo;
    end;
    It_Edicao_Ordem := 'I';
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pedido_Ajt.SB_AlterarClick(Sender: TObject);
begin
  if Fc_ValidaAlteracao then
  Begin
    It_Edicao_Ordem := 'E';
    Pc_EstadoEdicaoOrdem;
    Pc_DefineSetfocus;
  end;
end;

procedure TFr_Pedido_Ajt.SB_ExcluirClick(Sender: TObject);
Var
  Lc_Lst_Lote : TStringList;
begin
  if not Pedido.VerificaFaturado(True) then
  Begin
    If (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja realmente excluir este Pedido.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                       [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao1) then
    Begin
      Pc_AbrirItens;
      Pc_ShowItens;
      cds_itens_ajt.First;
      Lc_Lst_Lote := TStringList.Create;
      Lc_Lst_Lote.Clear;
      while not cds_itens_ajt.Eof do
      Begin
        CtrlLote.Movimento.Registro.Vinculo :=cds_itens_ajt.FieldByName('ITF_CODIGO').AsInteger;
        CtrlLote.Movimento.Registro.Tipo := 'AJUSTE';
        CtrlLote.Movimento.Registro.Sentido := '';
        CtrlLote.Movimento.deleteByVinculo;
        cds_itens_ajt.Next;
      End;
      pedido.enviaLixeira;
      Pc_Log_Sistema( Gb_CodMha,
                      GB_Cd_Usuario,
                      now,
                      'Pedido de Ajuste',
                      Pedido.Registro.Codigo,
                     'Exclusão do Pedido de Ajuste',
                     'PEDIDO NUMERO: ' + IntToStr(Pedido.Registro.Numero));
      Pedido.using('L');
      Pc_Buscar;
      Pg_Pedido_Ajt.ActivePageIndex := 1;
      It_Edicao_Ordem := 'B';
      Pc_EstadoEdicaoOrdem;
    End;
  end;
end;

procedure TFr_Pedido_Ajt.SB_GravarClick(Sender: TObject);
begin
  If Fc_ValidaGravacao then
  Begin
    Screen.Cursor := crHourGlass;
    Pc_Totalizador;
    DeletedItems;
    Pc_Gravar;
    Pc_Gravar_Itens;
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFr_Pedido_Ajt.SB_CancelarClick(Sender: TObject);
begin
  if Fc_ValidaCancelameto then
  Begin
    If ( It_Edicao_Ordem = 'I' ) then
      Sb_PesquisarClick(sELF);
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pedido_Ajt.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Pedido_Ajt.SB_CadastrarClick(Sender: TObject);
Var
  Lc_Codigo : Integer;
Begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja efetuar uma cópia de Pedido/Nota existente.'+EOLN+EOLN+
                     'Confirmar a Cópia ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  begin
    Lc_Codigo := Fc_CopiaPedidoNota(3);
    if Lc_Codigo > 0 then
    BEgin
      Pc_Ini_Variavel;
      Pedido.Registro.codigo := Lc_Codigo;
      Pedido.Registro.CodigoEstabelecimento := Gb_CodMha;
      Pc_Visualizar;
    End;
  end
  else
  Begin
    Pg_Pedido_Ajt.ActivePage := tbs_pedido;
    Pc_AbrePedidoNovo;
  end;
End;

procedure TFr_Pedido_Ajt.SB_BuscarClick(Sender: TObject);
begin
  TRY
    Pc_ProcesoAguarde(Self,'I');
    SB_Cadastrar.Enabled  := False;
    SB_Buscar.Enabled     := False;
    SB_Visualizar.Enabled := False;
    Sb_Sair_1.Enabled     := False;
    If DM.IBT_Consulta.InTransaction THEN DM.IBT_Consulta.Commit;
    Pc_Buscar;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    SB_Cadastrar.Enabled  := It_Inserir;
    SB_Buscar.Enabled     := True;
    SB_Visualizar.Enabled := True;
    Sb_Sair_1.Enabled     := True;
  end;
end;

procedure TFr_Pedido_Ajt.SB_VisualizarClick(Sender: TObject);
begin
  If Qr_Pesquisa.RecordCount > 0 then
  Begin
    Pedido.Registro.Codigo := Qr_Pesquisa.FieldByName('PED_CODIGO').AsInteger;
    Pc_Visualizar;
  end;
end;

procedure TFr_Pedido_Ajt.Sb_Sair_1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Pedido_Ajt.Sb_TransferirClick(Sender: TObject);
Var
  LcForm : TTasStockTransfer;
begin
  Try
    LcForm := TTasStockTransfer.Create(Self);
    LcForm.ShowModal;
  Finally
    FreeAndNil(LcForm);
  End;
end;

procedure TFr_Pedido_Ajt.E_VL_DescontoExit(Sender: TObject);
Var
  Lc_VL_Desconto:Real;
  Lc_Vl_Pedido : Real;
  Lc_Aq_Desconto : Real;
begin
  Lc_Vl_Pedido := StrtoFloatDef(E_VL_Produto.Caption,0) ;
  Lc_VL_Desconto := StrtoFloatDef(E_VL_Desconto.Text,0);
  Lc_Aq_Desconto := (Lc_VL_Desconto / Lc_VL_Pedido)*100;
  Lc_Aq_Desconto := RoundTo( Lc_Aq_Desconto,-2);
  pedido.AplicarValorDescontoItens(pedido.Registro.Codigo,Lc_VL_Desconto);
  E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
  Pc_AbrirItens;
  Pc_ShowItens;
  Pc_AtualizaCampos;
  Pc_totalizador;
end;

procedure TFr_Pedido_Ajt.Sb_Ins_ProdutoClick(Sender: TObject);
Var
  Lc_Form:TFr_Itens_Produto_Ajt;
begin
  If E_Cd_Empresa.Focused  then E_Cd_EmpresaExit(self);
  If DBLCB_Empresa.Focused then DBLCB_EmpresaExit(Self);
  If  (It_Edicao_Ordem = 'I')  then
  Begin
    If Fc_ValidaGravacao THEN
      Pc_Gravar
    else
      Exit;
  end;
  //Cria O Formulario
  Try
    Lc_Form := TFr_Itens_Produto_Ajt.create(nil);
    Lc_Form.it_Cd_Empresa := Pedido.Registro.Empresa;
    Lc_Form.Terminal := Pedido.Registro.Terminal;
    Lc_Form.Pc_StateChange(2);
    Lc_Form.Qr_Tabela.Active := True;
    Lc_Form.ItensNFL.Registro.CodigoPedido := Pedido.Registro.codigo;
    Lc_Form.it_Modalidade_preco := 'A';
    Pc_AbrirItens;
    Lc_Form.LoadItems(Qr_Itens);
    //Controle de Tributação por Item de forma Manual
    Lc_Form.Sentido := 'S';
    Pc_AbrirEndereco;
    Lc_Form.Estado := Qr_endereco.FieldByName('END_CODUFE').AsInteger;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
    Pc_AbrirItens;
    Pc_ShowItens;
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  End;
end;

procedure TFr_Pedido_Ajt.Sb_Alt_ProdutoClick(Sender: TObject);
Var
  Lc_Form:TFr_Itens_Produto_Ajt;
begin
  //Cria O Formulario
  try
    Lc_Form := TFr_Itens_Produto_Ajt.create(nil);
    Lc_Form.it_Cd_Empresa     := Pedido.Registro.Empresa;
    Lc_Form.Pc_StateChange(3);
    Lc_Form.It_Inserir        := True;
    Lc_Form.ItensNFL.Registro.CodigoPedido := Pedido.REgistro.Codigo;
    Lc_Form.Terminal          := Pedido.Registro.Terminal;
    Lc_Form.Fm_ListaEstoques.AtivaLista(Gb_CodMha);
    Lc_Form.Qr_Tabela.Active  := True;

    Lc_Form.editItems(cds_itens_ajtITF_CODIGO.AsInteger);
    Lc_Form.Pc_Totalizador;
    Lc_Form.it_Modalidade_preco   := 'A';
    //Controle de Tributação por Item de forma Manual
    Lc_Form.Sentido := 'S';
    Pc_AbrirEndereco;
    Lc_Form.Estado := Qr_endereco.FieldByName('END_CODUFE').AsInteger;
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
    Pc_AbrirItens;
    Pc_ShowItens;
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pedido_Ajt.Sb_Exc_ProdutoClick(Sender: TObject);
Var
  Lc_Lst_Lote:TStringList;
Begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+ cds_itens_ajt.FieldByName('PRO_DESCRICAO').AsString +' deste Ajuste.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Pc_Log_Sistema(Gb_CodMha,
                   GB_Cd_Usuario,
                   Now,
                   'Item do Pedido Compra',
                   cds_itens_ajt.FieldByName('ITF_CODIGO').AsInteger,
                   'Excluir Item',
                   'Produto '+ cds_itens_ajt.FieldByName('ITF_CODPRO').AsString + ' do pedido Nº ' + IntToStr(pedido.Registro.Numero)  );

    Lc_Lst_Lote := TStringList.Create;
    Lc_Lst_Lote.Clear;

    CtrlLote.Movimento.Registro.Vinculo :=cds_itens_ajt.FieldByName('ITF_CODIGO').AsInteger;
    CtrlLote.Movimento.Registro.Tipo := 'AJUSTE';
    CtrlLote.Movimento.Registro.Sentido := '';
    CtrlLote.Movimento.deleteByVinculo;

    ApagaDevolIPi( cds_itens_ajt.FieldByName('ITF_CODIGO').AsInteger);
    Pedido.Itens.Registro.Codigo := cds_itens_ajt.FieldByName('ITF_CODIGO').AsInteger;
    Pedido.Itens.delete;
    pedido.CorrigirSequenciaItens;
    cds_itens_ajt.Delete;
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  end;

end;

Function TFr_Pedido_Ajt.Fc_ChamaFaturaAjt():Boolean;
Var
  Lc_Form : TFr_Fatura_Ajt;
begin
  Try
    Result := True;
    Lc_Form := TFr_Fatura_Ajt.create(nil);
    Lc_Form.Top := Self.Top  -10;
    Lc_Form.It_Cd_Pedido := Pedido.Registro.codigo;
    Lc_Form.It_Nr_Pedido := E_Nr_Pedido.Text;
    //Verifica se as series foram lançadas para saida ou para entrada
    Lc_Form.It_Operacao := It_Operacao;
    Lc_Form.E_VL_Bs_ICMS.Text := E_VL_Bs_ICMS.Text;
    Lc_Form.E_VL_ICMS.Text := E_VL_ICMS.Text;
    Lc_Form.E_VL_IPI.Text := E_VL_IPI.Text;
    Lc_Form.E_VL_Frete.Text := E_VL_Frete.Text;
    Lc_Form.E_Vl_desconto.Caption := E_VL_Desconto.Text;
    Lc_Form.E_VL_Produto.Caption := E_VL_Produto.Caption;
    Lc_Form.E_VL_Nota.Caption := E_VL_Pedido.Caption;
    Lc_Form.DBLCB_Transportadora.KeyValue := Fc_Preenche_Transportadora(Pedido.Registro.Empresa);
    Lc_Form.ShowModal;
    Result := Lc_Form.It_Fatura_Ok;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;


procedure TFr_Pedido_Ajt.SB_FaturarClick(Sender: TObject);

Var
  Lc_Ok : Boolean;
begin
  if Fc_ValidaFaturamento then
  Begin
    Pc_GeraNumeroPedido;
    Lc_Ok := Fc_ChamaFaturaAjt;
    //VerIfica se o faturamento deu certo
    If Lc_Ok then
    Begin
      Pg_Pedido_Ajt.ActivePageIndex := 1;
      Pedido.using('L');
      SB_BuscarClick(Self);
    end
    else
    Begin
      Pc_AtivarTabelas;
      Pc_AbrirPedido;
      Pg_Pedido_aJT.ActivePageIndex := 0;
    end;
  end;
end;

procedure TFr_Pedido_Ajt.ChBx_Busca_NomeClick(Sender: TObject);
begin
  if ChBx_Busca_Nome.Checked then
    Begin
    ChBx_Busca_Fantasia.Checked := False;
    DBG_Pesquisa.Columns[2].FieldName := 'EMP_NOME';
    end;
end;

procedure TFr_Pedido_Ajt.ChangeQtde(Sender: TField);
Var
  LcValor : Real;
  LcStrValor : String;
begin
  Try
    cds_itens_ajtITF_VL_UNIT.OnChange := nil;
    cds_itens_ajt.Edit;
    LcValor := cds_itens_ajtITF_VL_UNIT.AsCurrency * cds_itens_ajtITF_QTDE.AsFloat;
    LcValor := RoundTo( LcValor ,-2);
    LcStrValor := FloatToStrF(LcValor , ffFixed, 10, 2);

    cds_itens_ajtITF_VL_SUBTOTAL.AsCurrency  := StrToFloatDef(LcStrValor,0);
    cds_itens_ajtITF_VL_TOTAL.AsCurrency     :=
       cds_itens_ajtITF_VL_SUBTOTAL.AsCurrency - cds_itens_ajtITF_VL_DESC.AsCurrency;
  Finally
    cds_itens_ajt.Post;
    cds_itens_ajtITF_VL_UNIT.OnChange := ChangeValorUnitario;
  End;
end;

procedure TFr_Pedido_Ajt.ChangeValorUnitario(Sender: TField);
Var
  LcValor : Real;
  LcStrValor : String;
begin
  Try
    cds_itens_ajtITF_QTDE.OnChange := nil;
    cds_itens_ajt.Edit;
    LcValor := cds_itens_ajtITF_VL_UNIT.AsCurrency * cds_itens_ajtITF_QTDE.AsFloat;
    LcValor := RoundTo( LcValor,-2);
    LcStrValor := FloatToStrF(LcValor , ffFixed, 10, 2);

    cds_itens_ajtITF_VL_SUBTOTAL.AsCurrency  := StrToFloatDef(LcStrValor,0);
    cds_itens_ajtITF_VL_TOTAL.AsCurrency     :=
       cds_itens_ajtITF_VL_SUBTOTAL.AsCurrency - cds_itens_ajtITF_VL_DESC.AsCurrency;
  Finally
    cds_itens_ajt.Post;
    cds_itens_ajtITF_QTDE.OnChange := ChangeQtde;
  End;

end;

procedure TFr_Pedido_Ajt.ChBx_Busca_FantasiaClick(Sender: TObject);
begin
  if ChBx_Busca_Fantasia.Checked then
    Begin
    ChBx_Busca_Nome.Checked := False;
    DBG_Pesquisa.Columns[2].FieldName := 'EMP_FANTASIA';
    end;
end;

procedure TFr_Pedido_Ajt.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Pedido_Ajt.Corrigirsequnciadositens1Click(Sender: TObject);
begin
  if pedido.CorrigirSequenciaItens then
    Pc_AbrirItens;
end;

procedure TFr_Pedido_Ajt.E_VL_IPIExit(Sender: TObject);
begin
  Pc_Totalizador;
end;

procedure TFr_Pedido_Ajt.DBG_PesquisaTitleClick(Column: TColumn);
var
  Lc_Idx :Integer;
begin
  with DBG_Pesquisa.DataSource.DataSet as TSTQuery do
  begin;
    Lc_Idx := Pos('ORDER BY ', UpperCase(SQL.Text));
    if Lc_Idx > 0 then
    begin
      SQL.Text := Copy(SQL.Text, 1, Lc_Idx -1);
      SQL.Text := SQL.Text +'ORDER BY '+ Column.FieldName;
    end;
    Close;
    Open;
  end;
  DBG_Pesquisa.Columns[DBG_Pesquisa.Tag].Title.Color := clBtnFace;
  DBG_Pesquisa.Columns[DBG_Pesquisa.Tag].Title.Font.Color := clWindowText;
  DBG_Pesquisa.Columns[DBG_Pesquisa.Tag].Title.Font.Style := [];
  DBG_Pesquisa.Tag := Column.Index;
  DBG_Pesquisa.Columns[DBG_Pesquisa.Tag].Title.Color := $00BE7C7C;
  DBG_Pesquisa.Columns[DBG_Pesquisa.Tag].Title.Font.Color := clWhite;
  DBG_Pesquisa.Columns[DBG_Pesquisa.Tag].Title.Font.Style := [fsBold];
end;

procedure TFr_Pedido_Ajt.Pc_FormataCasas;
begin
  if ( Qr_Itens.Active = True) then
    begin
    (Qr_Itens.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat     := '0.00######';
    (Qr_Itens.FieldByName('ITF_VL_SUBTOTAL') as TNumericField).DisplayFormat := '0.00######';
    (Qr_Itens.FieldByName('ITF_AQ_COM') as TNumericField).DisplayFormat := '0.00######';
    end;
end;


procedure TFr_Pedido_Ajt.pc_Formatagrade(Tipo: String);
begin
  if Assigned(DBG_Produtos) then
  Begin
    if Tipo = 'R' then
    Begin
      DBG_Produtos.Columns[0].Width :=  87;
      DBG_Produtos.Columns[1].Width :=  229;
      DBG_Produtos.Columns[2].Width :=  47;
      DBG_Produtos.Columns[3].Width :=  48;
      DBG_Produtos.Columns[4].Width :=  83;
      DBG_Produtos.Columns[5].Width :=  78;
      DBG_Produtos.Columns[6].Width :=  72;
      DBG_Produtos.Columns[7].Width :=  74;
      DBG_Produtos.Columns[8].Width :=  83
    End
    else
    Begin
      DBG_Produtos.Columns[0].Width :=  97;
      DBG_Produtos.Columns[1].Width :=  450;
      DBG_Produtos.Columns[2].Width :=  57;
      DBG_Produtos.Columns[3].Width :=  58;
      DBG_Produtos.Columns[4].Width :=  93;
      DBG_Produtos.Columns[5].Width :=  88;
      DBG_Produtos.Columns[6].Width :=  82;
      DBG_Produtos.Columns[7].Width :=  84;
      DBG_Produtos.Columns[8].Width :=  93;
    End;
  End;
end;

procedure TFr_Pedido_Ajt.E_Aq_DescontoExit(Sender: TObject);
Var
  Lc_VL_Desconto:Real;
  Lc_Vl_Pedido : Real;
  Lc_Aq_Desconto : Real;
begin
  Lc_Vl_Pedido := StrtoFloatDef(E_VL_Produto.Caption,0);
  Lc_Aq_Desconto := StrToFloatDef(E_Aq_Desconto.Text,0);

  Lc_VL_Desconto := ((Lc_Vl_Pedido * Lc_Aq_Desconto) /100 );
  Lc_VL_Desconto := RoundTo(Lc_VL_Desconto,-2);
  pedido.AplicarValorDescontoItens(pedido.Registro.Codigo,Lc_VL_Desconto);
  E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
  E_VL_Desconto.Text := FloatToStrF(Lc_VL_Desconto,ffFixed,10,2);
  Pc_AbrirItens;
  Pc_ShowItens;
  Pc_AtualizaCampos;
  Pc_totalizador;
end;

procedure TFr_Pedido_Ajt.tbs_pedidoShow(Sender: TObject);
begin
  Pc_ControlaNumero(E_Nr_Pedido,'AJT_G_CTRL_SEQUENCIA');
  Pop_ConfigLocal.Visible := False;
  Pop_ConfigGlobal.Visible := False;
  PopAjustarRetornocomVendas.Visible := True;
end;

procedure TFr_Pedido_Ajt.Pc_Valida_Info_Empresa(Pc_Cd_Empresa : Integer);
Begin
 //Posiciona o ponteiro no endereco do cliente
  Qr_Endereco.Close;
  Qr_Endereco.ParamByName('EMP_CODIGO').AsInteger := Pc_Cd_Empresa;
  Qr_Endereco.Active := True;
  Qr_Endereco.FetchAll;
  Qr_Endereco.First;
  If (It_Edicao_Ordem = 'I') or (pedido.Registro.Empresa <> Pc_Cd_Empresa) or (DBLCB_end_Entrega.Text = '') then
  begin
    DBLCB_End_Entrega.KeyValue := null;
    Qr_Endereco.Locate('END_PRINCIPAL','S',[]);
    Pedido.Registro.Endereco := Qr_Endereco.FieldByName('END_CODIGO').AsInteger;
    DBLCB_End_Entrega.KeyValue := Qr_Endereco.FieldByName('END_CODIGO').AsInteger;
  end;
END;


function TFr_Pedido_Ajt.Fc_ValidaGravacao: Boolean;
var
  Lc_Cd_Aux :Integer;
Begin
  Result:=TRUE;
  //Verifica se o campo Emitente destinario esta com o foco
  if (DBLCB_Empresa.CanFocus) then DBLCB_Vendedor.SetFocus;

  //Verifica Inventario
  if not Fc_ValidaDataPedido(E_Data.DateTime) then
    Begin
    Result := FAlse;
    E_Data.SetFocus;
    E_Data.Date := Date;
    Exit;
    end;

  if not Fc_ValidaPreencheEmitente then//Valida preenchimento do Emitente Destinatario
    BEGIN
    Result:=FALSE;
    exit;
    END;

  If ( E_Nr_Pedido.Text <>'' ) and (E_Nr_Pedido.Text <>'0') then
    begin
    if not Fc_ValidaNumeroPedido(Pedido.Registro.codigo,StrToIntDef(E_Nr_Pedido.Text,0),3) then
      begin
      Result:=FALSE;
      end;
    end;

  //Valida preenchimento do endereco d entrega
  if Trim(DBLCB_end_Entrega.Text)='' then Lc_Cd_Aux := 0 else Lc_Cd_Aux := DBLCB_end_Entrega.KeyValue;
  If not Fc_Valida_enderecoPedido(Lc_Cd_Aux,DBLCB_end_Entrega.Text) then
    Begin
    Pg_Observacao.ActivePageIndex := 1;
    DBLCB_end_Entrega.SetFocus;
    Result:=FALSE;
    exit;
    end;
end;

procedure TFr_Pedido_Ajt.Pc_DefineSetfocus;
begin
  IF E_Nr_Pedido.Enabled = true then
  begin
    E_Nr_Pedido.SetFocus;
    E_Nr_Pedido.SelectAll;
  end
  else
    E_Cd_Empresa.SetFocus;
end;

procedure TFr_Pedido_Ajt.Pc_EstadoEdicaoOrdem;
begin
  Pnl_fundo.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );

  //botos aba produto
  Sb_Ins_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Alt_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  AND (cds_itens_ajt.RecordCount > 0);
  Sb_Exc_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  AND (cds_itens_ajt.RecordCount > 0);

  // botoes gerais
  SB_Inserir.Enabled       := (It_Edicao_Ordem = 'B') and It_Inserir;
  SB_Excluir.Enabled       := (It_Edicao_Ordem = 'B') and It_Excluir and (Pedido.Registro.Codigo > 0);
  SB_Imprimir.Enabled      := (It_Edicao_Ordem = 'B') and It_IMPRIMIR;
  SB_Faturar.Enabled       := (It_Edicao_Ordem = 'B') and It_baixar;
  SB_Alterar.Enabled       := (It_Edicao_Ordem = 'B') and It_Alterar and (Pedido.Registro.Codigo > 0);
  SB_Gravar.Enabled        := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  SB_Cancelar.Enabled      := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Pesquisar.Enabled     := (It_Edicao_Ordem = 'B');
  Sb_Sair_0.Enabled        := (It_Edicao_Ordem = 'B');



  RegistraNmerodeLote.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  RegistraNmerodeSerie.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  InformaesdaDI1.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Pnl_Observacao.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Pnl_Entrega.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
end;

function TFr_Pedido_Ajt.Fc_MovimentoSerie(Fc_Operacao:String):Integer;
var
  Lc_SQLTxt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if (Fc_Operacao = 'E') then
      Begin
      //Verifica se houve entrada
        Lc_SQLTxt := 'SELECT SRP_CODIGO, SRP_NUMERO, SRP_CODSAI  FROM TB_SERIE_PRODUTO  '+
                     'WHERE (SRP_CODENT =:SRP_CODMVM)                       '+
                     '  AND (SRP_CODPRO=:SRP_CODPRO)                        ';
      end
      else
      Begin
        if (Fc_Operacao = 'S') then
        Begin
          Lc_SQLTxt := 'SELECT SRP_CODIGO, SRP_NUMERO, SRP_CODSAI  FROM TB_SERIE_PRODUTO  '+
                       'WHERE (SRP_CODSAI =:SRP_CODMVM)                       '+
                       '  AND (SRP_CODPRO=:SRP_CODPRO)                        ';
        end
        else
        Begin
        Lc_SQLTxt := 'SELECT SRP_CODIGO, SRP_NUMERO, SRP_CODSAI  FROM TB_SERIE_PRODUTO  '+
                     'WHERE ((SRP_CODENT =:SRP_CODMVM) or (SRP_CODSAI =:SRP_CODMVM) )   '+
                     '  AND (SRP_CODPRO=:SRP_CODPRO)                                    ';
        end;
      end;
      SQL.Add(Lc_SQLTxt);
      ParamByName('SRP_CODMVM').AsInteger := cds_itens_ajt.FieldByName('ITF_CODIGO').AsInteger;
      ParamByName('SRP_CODPRO').AsInteger := cds_itens_ajt.FieldByName('ITF_CODPRO').AsInteger;
      Active := true;
      FetchAll;
      Result := RecordCount;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function TFr_Pedido_Ajt.Fc_ValidaSeries:Boolean;
Var
  Lc_entrada : boolean;
  Lc_saida : boolean;
Label
  sai;
Begin
  It_Operacao :=0;
  Lc_entrada := False;
  Lc_saida := False;

  Pc_AbrirItens;
  if not cds_itens_ajt.active then cds_itens_ajt.createDataset;

  cds_itens_ajt.First;
  while not cds_itens_ajt.Eof do
    Begin
    if (cds_itens_ajt.FieldByName('PRO_SERIE').AsString = 'S') then
      Begin
      //Verifica se houve entrada
      if not Lc_entrada then
        Lc_entrada := (Fc_MovimentoSerie('E') > 0);
      //Verifica se houve saida
      if not Lc_saida then
        Lc_saida := (Fc_MovimentoSerie('S') > 0);
      //Uma das duas variveis deve ser verdadeira
      if Fc_MovimentoSerie('M') < cds_itens_ajt.FieldByName('ITF_QTDE').Asfloat  then
        Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Informe os número de séries conforme ' + EOLN +
                       'a quantidade de itens do produto '+ cds_itens_ajt.FieldByName('PRO_DESCRICAO').AsString + '.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        Result := False;
        goto sai;
        end;

      //Não pode chegar até aqui com as duas variaveis verdadeiras
      if (Lc_entrada = Lc_saida) then
        Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'O sistema não permite entrada e saida de séries no mesmo Documento. ' + EOLN +
                       'Verifique os itens e tente novamente.' + EOLN,
                       ['OK'], [bEscape], mpAlerta);
        Result := False;
        goto sai;
        end;
      //Ativa a Varivel It_operação para a proxima etapa do faturamento
      if Lc_entrada then It_Operacao := 1 else It_Operacao := 2;
      end;
    cds_itens_ajt.Next;
    end;
  Result := True;    
sai:
end;

function TFr_Pedido_Ajt.Valida_impressao: Boolean;
begin
  Result:=true;
  if not ValidaPedidoExistente then
  Begin
    Result:=FALSE;
    exit;
  end;

  if not cds_itens_ajt.Active then cds_itens_ajt.CreateDataSet;  
  if (cds_itens_ajt.RecordCount = 0) then
  begin
    MensagemPadrao('Mensagems',ATENCAO+EOLN+EOLN+
                   'Pedido sem produto.'+EOLN+
                   'Inclua um produto e tente novamente!'+EOLN,
                  ['OK'],[bEscape],mpInformacao);
    Result:=false;
    exit;
  end;

end;

procedure TFr_Pedido_Ajt.RegistraNmerodeSerieClick(Sender: TObject);
var
  Lc_Escolha: Integer;
begin
  if Fc_VerificaExistenciaItem then
    Begin
    if not Assigned(Fr_Produto_Serie) then Application.CreateForm(TFr_Produto_Serie, Fr_Produto_Serie);
    if Fc_MovimentoSerie('E')> 0 then
      Fr_Produto_Serie.Tag := 1
    else
    if Fc_MovimentoSerie('S')> 0 then
      Fr_Produto_Serie.Tag := 2
    else
      Begin
      Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                                  'Qual a Operação desejada ?',
                                  ['ENTRADA','SAÍDA','CANCELA'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
      case Lc_Escolha of
        0: Fr_Produto_Serie.Tag := 1;
        1: Fr_Produto_Serie.Tag := 2;
      else
        Exit;
      end;
     end;
     Fr_Produto_Serie.It_cd_Item      := cds_itens_ajt.FieldByName('ITF_CODIGO').AsInteger;
     Fr_Produto_Serie.It_cd_Produto   := cds_itens_ajt.FieldByName('ITF_CODPRO').AsInteger;
     Fr_Produto_Serie.It_Qt_Produto   := cds_itens_ajt.FieldByName('ITF_QTDE').AsFloat;
     Fr_Produto_Serie.ShowModal;
     end;
end;

procedure TFr_Pedido_Ajt.RegistraNmerodeLoteClick(Sender: TObject);
var
  Lc_Escolha: Integer;
  Lc_Form:TForm;
begin
  if Fc_VerificaExistenciaItem then
    Begin
    Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                                'Qual a Operação desejada ?',
                                ['ENTRADA','SAÍDA','CANCELA'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
    case Lc_Escolha of
      0:Begin
          try
            Lc_Form := TForm.Create(nil);
            Application.CreateForm(TFr_Ctrl_Lote_Entrada, Lc_Form);
            TFr_Ctrl_Lote_Entrada(Lc_Form).It_Cd_Item := cds_itens_ajt.FieldByname('ITF_CODIGO').AsInteger;
            TFr_Ctrl_Lote_Entrada(Lc_Form).It_Tipo := 'AJUSTE';
            TFr_Ctrl_Lote_Entrada(Lc_Form).it_Cd_produto := cds_itens_ajt.FieldByname('ITF_CODPRO').AsInteger;
            TFr_Ctrl_Lote_Entrada(Lc_Form).It_Cd_Empresa := Pedido.Registro.Empresa;
            TFr_Ctrl_Lote_Entrada(Lc_Form).It_Qtde_Lote := cds_itens_ajt.FieldByname('ITF_QTDE').AsFloat;
            TFr_Ctrl_Lote_Entrada(Lc_Form).ShowModal;
          finally
            FreeAndNil(Lc_Form);
          end;
        end;
      1:Begin
          try
            Lc_Form := TForm.Create(nil);
            Application.CreateForm(TFr_Ctrl_Lote_Saida, Lc_Form);
            TFr_Ctrl_Lote_Saida(Lc_Form).It_Cd_Item := cds_itens_ajt.FieldByname('ITF_CODIGO').AsInteger;
            TFr_Ctrl_Lote_Saida(Lc_Form).It_Tipo := 'AJUSTE';
            TFr_Ctrl_Lote_Saida(Lc_Form).it_Cd_produto := cds_itens_ajt.FieldByname('ITF_CODPRO').AsInteger;
            TFr_Ctrl_Lote_Saida(Lc_Form).It_Cd_Empresa := Pedido.Registro.Empresa;
            TFr_Ctrl_Lote_Saida(Lc_Form).It_Qtde_Lote := cds_itens_ajt.FieldByname('ITF_QTDE').AsFloat;
            TFr_Ctrl_Lote_Saida(Lc_Form).ShowModal;
          finally
            FreeAndNil(Lc_Form);
          end;
        end;
    else
      exit;
    end;
    end;
end;

procedure TFr_Pedido_Ajt.chbx_NomeClick(Sender: TObject);
begin
  Pc_ListaEmpresaDbLookUpComboBox(-1,'EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFr_Pedido_Ajt.chbx_fantasiaClick(Sender: TObject);
begin
  Pc_ListaEmpresaDbLookUpComboBox(-1,'EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFr_Pedido_Ajt.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
  begin
    It_Inserir := True;
    It_Alterar := True;
    It_Excluir := True;
    It_Baixar  := True;
    It_Visualizar := True;
    It_Imprimir := True;
  end
  else
  begin
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Baixar     := Fc_HabilitaPermissao(Pc_Menu,'BAIXAR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    It_Imprimir := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
  end;
  SB_Cadastrar.Enabled := It_Inserir;
  SB_Inserir.Enabled := It_Inserir;
end;




procedure TFr_Pedido_Ajt.Pc_ShowItens;
begin
  if not cds_itens_ajt.Active then cds_itens_ajt.CreateDataSet;
  cds_itens_ajtITF_QTDE.OnChange := nil;
  cds_itens_ajtITF_VL_UNIT.OnChange := nil;

  cds_itens_ajt.LogChanges := False;
  cds_itens_ajt.EmptyDataSet;
  Qr_Itens.First;
  while not Qr_Itens.eof do
  Begin
    cds_itens_ajt.Append;
    cds_itens_ajtITF_CODIGO.AsInteger     := Qr_ItensITF_CODIGO.AsInteger;
    cds_itens_ajtITF_CODPED.AsInteger     := Qr_ItensITF_CODPED.AsInteger;
    cds_itens_ajtITF_CODNFL.AsInteger     := Qr_ItensITF_CODNFL.AsInteger;
    cds_itens_ajtITF_CODPRO.AsInteger     := Qr_ItensITF_CODPRO.AsInteger;
    cds_itens_ajtPRO_CODIGOFAB.AsString   := Qr_ItensPRO_CODIGOFAB.AsString;
    cds_itens_ajtPRO_CODIGOFOR.AsString   := Qr_ItensPRO_CODIGOFOR.AsString;
    cds_itens_ajtPRO_DESCRICAO.AsString   := Qr_ItensPRO_DESCRICAO.AsString;
    cds_itens_ajtPRO_SERIE.AsString       := Qr_ItensPRO_SERIE.AsString;
    cds_itens_ajtITF_QTDE.AsFloat         := Qr_ItensITF_QTDE.AsFloat;
    cds_itens_ajtITF_VL_CUSTO.AsCurrency     := Qr_ItensITF_VL_CUSTO.AsCurrency;
    cds_itens_ajtITF_VL_UNIT.AsCurrency      := Qr_ItensITF_VL_UNIT.AsCurrency;
    cds_itens_ajtITF_AQ_COM.AsFloat       := Qr_ItensITF_AQ_COM.AsFloat;
    cds_itens_ajtITF_AQ_IPI.AsCurrency       := Qr_ItensITF_AQ_IPI.AsCurrency;
    cds_itens_ajtEMB_ABREVIATURA.AsString := Qr_ItensEMB_ABREVIATURA.AsString;
    cds_itens_ajtITF_AQ_ICMS.AsCurrency      := Qr_ItensITF_AQ_ICMS.AsCurrency;
    cds_itens_ajtITF_CODEST.AsInteger     := Qr_ItensITF_CODEST.AsInteger;
    cds_itens_ajtITF_CODTPR.AsInteger     := Qr_ItensITF_CODTPR.AsInteger;
    cds_itens_ajtMED_ABREVIATURA.AsString := Qr_ItensMED_ABREVIATURA.AsString;
    cds_itens_ajtITF_AQ_DESC.AsFloat      := Qr_ItensITF_AQ_DESC.AsFloat;
    cds_itens_ajtITF_VL_DESC.AsCurrency      := Qr_ItensITF_VL_DESC.AsCurrency;
    cds_itens_ajtITF_ESTOQUE.AsString     := Qr_ItensITF_ESTOQUE.AsString;
    cds_itens_ajtITF_VL_IPI.AsCurrency       := Qr_ItensITF_VL_IPI.AsCurrency;
    cds_itens_ajtITF_ALTURA.AsFloat       := Qr_ItensITF_ALTURA.AsFloat;
    cds_itens_ajtITF_LARGURA.AsFloat      := Qr_ItensITF_LARGURA.AsFloat;
    cds_itens_ajtITF_VL_SUBTOTAL.AsCurrency  := Qr_ItensITF_VL_SUBTOTAL.AsCurrency;

    cds_itens_ajtITF_VL_TOTAL.AsCurrency     :=
        cds_itens_ajtITF_VL_SUBTOTAL.AsCurrency - cds_itens_ajtITF_VL_DESC.AsCurrency;

    cds_itens_ajt.Post;

    Qr_Itens.next;
  End;
  cds_itens_ajt.LogChanges := True;
  cds_itens_ajtITF_QTDE.OnChange := ChangeQtde;
  cds_itens_ajtITF_VL_UNIT.OnChange := ChangeValorUnitario;
end;

procedure TFr_Pedido_Ajt.E_NotaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8),',','.']) then Key:= #0;

end;

procedure TFr_Pedido_Ajt.Pc_LimpaCampos;
begin
  E_Qt_Produto.Text:= '0,00';
  E_VL_Produto.Caption:= '0,00';
  E_VL_Bs_ICMS.Text:= '0,00';
  E_VL_ICMS.Text:= '0,00';
  E_VL_IPI.Text:= '0,00';
  E_VL_Frete.Text:= '0,00';
  E_Aq_Desconto.Text:= '0,00';
  E_VL_Desconto.Text:= '0,00';
  E_VL_Pedido.Caption:= '0,00';                
end;

procedure TFr_Pedido_Ajt.SB_ImprimirClick(Sender: TObject);
Begin
  if Valida_impressao then
    Impressao;
end;

procedure TFr_Pedido_Ajt.Impressao;
Var
  Lc_Imp: TimpModImpressao;
Begin
  Lc_Imp := TimpModImpressao.create(nil);
  Try
    Pc_GeraNumeroPedido;
    Lc_Imp.Pc_Imp_Tipo(Pedido.Registro.Tipo,Pedido.Registro.codigo,0);
  Finally
    FreeAndNil(Lc_Imp);
  End;
end;

procedure TFr_Pedido_Ajt.InformaesdaDI1Click(Sender: TObject);
begin
  if Fc_VerificaExistenciaItem then
  Begin
    if not Assigned(Fr_Info_Dec_Imp) then (Application.CreateForm(TFr_Info_Dec_Imp, Fr_Info_Dec_Imp));
    Fr_Info_Dec_Imp.It_Cd_Item := cds_itens_ajt.FieldByname('ITF_CODIGO').AsInteger;
    Fr_Info_Dec_Imp.ShowModal;
  end;
end;

procedure TFr_Pedido_Ajt.InformaoCombustivel1Click(Sender: TObject);
Var
  Form : TTasNfeItensFuel;
begin
  Form := TTasNfeItensFuel.create(nil);
  try
    Form.CodigoRegistro := cds_itens_ajtITF_CODIGO.AsInteger;
    Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFr_Pedido_Ajt.DBLCB_EmpresaExit(Sender: TObject);
begin
  If ( (It_Edicao_Ordem = 'I') or (It_Edicao_Ordem = 'E') ) then  //Inicio verIfica edição
  Begin
    IF trim(DBLCB_Empresa.Text) <> '' THEN
    begin
      Pc_Valida_Info_Empresa(DBLCB_Empresa.KeyValue);
    end
    else
    Begin
      Pedido.Registro.Empresa := 0;
      E_Cd_Empresa.Clear;
    end;
  end;
end;

procedure TFr_Pedido_Ajt.DeletedItems;
Var
  LcOperacao : String;
  Lc_cds_temp : TClientDataSet;
  Lc_Lst_Lote : TStringList;
begin
  if cds_itens_ajt.ChangeCount > 0 then
  Begin
    Try
      Lc_cds_temp := TClientDataSet.Create(nil);
      Lc_cds_temp.Data := cds_itens_ajt.Delta;
      Lc_cds_temp.First;
      //Trata somente os dados deletados
      while not Lc_cds_temp.eof do
      Begin
        if Lc_cds_temp.UpdateStatus = usDeleted then
        Begin
          Pc_Log_Sistema(Gb_CodMha,
                             GB_Cd_Usuario,
                             Now,
                             'Item do Pedido Compra',
                             Lc_cds_temp.FieldByName('ITF_CODIGO').AsInteger,
                             'Excluir Item',
                             'Produto '+ Lc_cds_temp.FieldByName('ITF_CODPRO').AsString + ' do pedido Nº ' + IntToStr(pedido.Registro.Numero)  );

          Lc_Lst_Lote := TStringList.Create;
          Lc_Lst_Lote.Clear;
          CtrlLote.Movimento.Registro.Vinculo :=cds_itens_ajt.FieldByName('ITF_CODIGO').AsInteger;
          CtrlLote.Movimento.Registro.Tipo := 'AJUSTE';
          CtrlLote.Movimento.Registro.Sentido := '';
          CtrlLote.Movimento.deleteByVinculo;
          ApagaDevolIPi( Lc_cds_temp.FieldByName('ITF_CODIGO').AsInteger);
          Pedido.Itens.Registro.Codigo := Lc_cds_temp.FieldByName('ITF_CODIGO').AsInteger;
          Pedido.Itens.delete;
        End;
        Lc_cds_temp.Next;
      end;
    Finally
      Lc_cds_temp.close;
      FreeAndNil(Lc_cds_temp);
    End;
  End;

end;

procedure TFr_Pedido_Ajt.CadastrodoProdutoClick(Sender: TObject);
Var
  Lc_Form : TFr_Produtos;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TFr_Produtos.Create(Self);
      Lc_Form.Produto.Registro.Codigo := cds_itens_ajt.FieldByName('ITF_CODPRO').AsInteger;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil( Lc_Form );
      Pc_AbrirItens;
    End;
  end;
end;

procedure TFr_Pedido_Ajt.cds_itens_ajtAfterOpen(DataSet: TDataSet);
begin
  (cds_itens_ajt.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat     := Gb_Casa_Dec_Venda;
  (cds_itens_ajt.FieldByName('ITF_VL_DESC') as TNumericField).DisplayFormat     := '0.00######';
  (cds_itens_ajt.FieldByName('ITF_VL_SUBTOTAL') as TNumericField).DisplayFormat := '0.00';
  (cds_itens_ajt.FieldByName('ITF_VL_TOTAL') as TNumericField).DisplayFormat := '0.00';

end;

procedure TFr_Pedido_Ajt.E_Cd_EmpresaExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_Cd_Empresa.Text,0);
  If DBLCB_Empresa.CanFocus then DBLCB_Empresa.SetFocus;
end;

procedure TFr_Pedido_Ajt.E_Cd_EmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

procedure TFr_Pedido_Ajt.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_PermissaoBotao('Ajuste do Estoque');
  Pc_IniciaVariaveis;
end;

procedure TFr_Pedido_Ajt.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    CarregaImagemBotao(SB_Inserir,'INSERIR');
    CarregaImagemBotao(SB_Alterar,'ALTERAR');
    CarregaImagemBotao(SB_Excluir,'EXCLUIR');
    CarregaImagemBotao(SB_Gravar,'GRAVAR');
    CarregaImagemBotao(SB_Cancelar,'CANCELAR');
    CarregaImagemBotao(Sb_Sair_0,'SAIR');
    CarregaImagemBotao(SB_Pesquisar,'PESQUISAR');
    CarregaImagemBotao(SB_Faturar,'FATURAR');
    CarregaImagemBotao(SB_Imprimir,'IMPRIMIR');

    CarregaImagemBotao(SB_Cadastrar,'CADASTRAR');
    CarregaImagemBotao(SB_Buscar,'BUSCAR');
    CarregaImagemBotao(SB_Visualizar,'VISUALIZAR');
    CarregaImagemBotao(Sb_Sair_1,'SAIR');
  END;
end;


procedure TFr_Pedido_Ajt.Sb_NegocioClick(Sender: TObject);
Var
  Lc_Form : TSeaBusiness;
begin
  Lc_Form := TSeaBusiness.create(nil);
  try
    IF Trim(Dblcb_Negocio.Text) <> '' then
      Lc_Form.CodigoRegistro := Dblcb_Negocio.KeyValue;
    Lc_Form.ShowModal;
  finally
    DM.Qr_Negocio.Active := False;
    DM.Qr_Negocio.Active := True;
    Dblcb_Negocio.KeyValue := Lc_Form.CodigoRegistro;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Pedido_Ajt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(CtrlLote);
  FreeAndNil(Pedido);
  Pc_grava_Perfil_Local;
end;

procedure TFr_Pedido_Ajt.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  If ( (It_Edicao_Ordem = 'I') or (It_Edicao_Ordem = 'E') ) then
  Begin
    canClose := False;
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O pedido está sendo editado.'+EOLN+
                   'Grave ou cancele a edição antes de sair da tela.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  end;
  Begin
    cds_itens_ajt.Active := False;
    Pedido.using('L');
  end;
end;

procedure TFr_Pedido_Ajt.FormCreate(Sender: TObject);
begin
  Pedido := TControllerPedido.create(Self);
  CtrlLote := TControllerCtrlLote.Create(Self);
end;

function TFr_Pedido_Ajt.Fc_VerificaExistenciaItem():Boolean;
Begin
  Result := True;
  If cds_itens_ajt.RecordCount = 0 then
    Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor insira um item antes de continuar.'+EOLN+
                   'Verifique e tente novamente.' +EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
    end;
end;

procedure TFr_Pedido_Ajt.InformarNmerodeCompraClick(Sender: TObject);
Var
  Lc_Form : TFr_Info_Compra_Venda;
begin
  if Fc_VerificaExistenciaItem then
  Begin
    Try
      Lc_Form := TFr_Info_Compra_Venda.Create(nil);
      Lc_Form.It_Cd_Pedido := Pedido.Registro.codigo;
      Lc_Form.It_Cd_Item := cds_itens_ajt.FieldByName('ITF_CODIGO').AsInteger;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;
end;

procedure TFr_Pedido_Ajt.OnSize(var Msg: TWMSize);
begin
  Inherited;
  case Msg.SizeType of
    SIZENORMAL: pc_Formatagrade('R');
    SIZEFULLSCREEN: pc_Formatagrade('M');
  end;
end;

procedure TFr_Pedido_Ajt.Qr_EnderecoAfterOpen(DataSet: TDataSet);
begin
  Qr_Endereco.FetchAll;
end;

procedure TFr_Pedido_Ajt.Qr_ItensCalcFields(DataSet: TDataSet);
Var
  LcValor : Real;
  LcStrValor : String;
begin
  with Qr_Itens do
  Begin
    LcValor := FieldByName('ITF_VL_UNIT').AsCurrency * FieldByName('ITF_QTDE').AsFloat;
    LcValor := RoundTo( LcValor ,-2);
    LcStrValor := FloatToStrF(LcValor , ffFixed, 10, 2);
    FieldByName('ITF_VL_SUBTOTAL').AsCurrency := StrToFloatDef(LcStrValor,0);

    FieldByName('ITF_VL_TOTAL').AsCurrency :=
        FieldByName('ITF_VL_SUBTOTAL').AsCurrency - FieldByName('ITF_VL_DESC').AsCurrency;
  End;
end;

procedure TFr_Pedido_Ajt.Pc_Grava_Config_Local;
begin
  //imprimi pedido impressora
  Fc_Aq_Geral('G','CONTROLE DE AJUSTE','AJT_P_IMPRESSORA',IntToStr(rdg_PedAjt_Imp.ItemIndex));

  Fc_Aq_Geral('G','CONTROLE DE AJUSTE','AJT_P_PORTA',e_porta_ImpAjt.Text);
  Fc_Aq_Geral('G','CONTROLE DE AJUSTE','AJT_P_SALTO',e_salto_Ajt.Text);

  //modelo de impressao estilo matricial
  Fc_Aq_Geral('G','CONTROLE DE AJUSTE','AJT_P_MOD_MATRICIAL', IntToStr(cbx_modeloMat_Ajt.ItemIndex+1));

  //modelo de impressao estilo lase
  Fc_Aq_Geral('G','CONTROLE DE AJUSTE','AJT_P_MOD_JATOLASER', IntToStr(cbx_modeloLaser_Ajt.ItemIndex+1));

  //Ites por folha
  Fc_Aq_Geral('G','CONTROLE DE AJUSTE','AJT_P_ITENS_FOLHA',e_itens_AJT.Text);


end;

procedure TFr_Pedido_Ajt.Pc_grava_Perfil_Local;
begin
  if (WindowState = wsNormal) then
    Fc_Aq_Geral('G','PEDIDOAJT','CRB_TELA_MAXIM','N')
  else
    Fc_Aq_Geral('G','PEDIDOAJT','CRB_TELA_MAXIM','S');

end;

procedure TFr_Pedido_Ajt.Pc_Abre_Config_Local;
begin
  //imprimi pedido impressora
  rdg_PedAjt_Imp.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE AJUSTE','AJT_P_IMPRESSORA',''),0);

  e_porta_ImpAjt.Text := Fc_Aq_Geral('L','CONTROLE DE AJUSTE','AJT_P_PORTA',e_porta_ImpAjt.Text);
  e_salto_ajt.Text :=Fc_Aq_Geral('L','CONTROLE DE AJUSTE','AJT_P_SALTO','0');

  //modelo de impressao estilo matricial
  cbx_modeloMat_ajt.ItemIndex :=  StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE AJUSTE','AJT_P_MOD_MATRICIAL', ''),0)-1;

  //modelo de impressao estilo lase
  cbx_modeloLaser_ajt.ItemIndex := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE AJUSTE','AJT_P_MOD_JATOLASER', ''),1)-1;

  //Ites por folha
  e_itens_ajt.Text := Fc_Aq_Geral('L','CONTROLE DE AJUSTE','AJT_P_ITENS_FOLHA','');

end;

procedure TFr_Pedido_Ajt.Pc_Abre_Config_Global;
begin
  Chbx_controle_ajuste.Checked := (Fc_Tb_Geral('L','AJT_G_CTRL_SEQUENCIA','') = 'S');
  Chbx_controle_estoque.Checked := (Fc_Tb_Geral('L','AJT_G_CTRL_ESTOQUE','N') = 'S');
end;

procedure TFr_Pedido_Ajt.Pc_Gravar;
begin
  with pedido.Registro do
  Begin
    EmUso := Fc_NomeComputador;
    Tipo := 3;
    Faturado := 'N';
    Numero := StrToIntDef( E_Nr_Pedido.Text,0 );
    Usuario := Gb_Cd_Usuario;
    Prazo := '';
    Empresa := DBLCB_Empresa.KeyValue;
    if DBLCB_Vendedor.Text <> '' then
      Vendedor := DBLCB_Vendedor.KeyValue
    else
      Vendedor := 0;
    FormaPagto := 0;
    QtdeProdutos := StrToFloatDef(E_Qt_Produto.Text,0);
    ValorProdutos := StrToFloatDef(E_VL_Produto.Caption,0);
    ValorIPI := StrToFloatDef(E_VL_IPI.Text,0);
    ValorFrete := StrToFloatDef(E_VL_Frete.Text,0);
    AliqDesconto := StrToFloatDef(E_Aq_Desconto.Text,0);
    ValorDesconto := StrToFloatDef(E_VL_Desconto.Text,0);
    ValorPedido := StrToFloatDef(E_VL_Pedido.Caption,0);
    Data := E_Data.Date;
    CodigoEstabelecimento := Gb_CodMha;
    Entrega := '';
    Garantia := '';
    IndicaPresenca := Cb_IndPresComprador.ItemIndex + 1;
    Aprovado := 'N';
    if DBLCB_End_Entrega.Text = '' then
    Begin
      Pc_AbrirEndereco;
      Endereco := Qr_Endereco.FieldByName('END_CODIGO').AsInteger;
    End
    else
    Begin
      Endereco := DBLCB_End_Entrega.KeyValue
    end;
    Observacao := E_Observ.Text;
    if Dblcb_Negocio.Text <> '' then
      CodigoNegocio := Dblcb_Negocio.KeyValue
    else
      CodigoNegocio := 0;
    Transportadora := 0;
    EnderecoFaturamento := 0;
    EnderecoCobranca := 0;

  End;
  Pedido.Salva;
end;

procedure TFr_Pedido_Ajt.Pc_Gravar_Itens;
begin
  if cds_itens_ajt.ChangeCount > 0 then
  Begin
    cds_itens_ajt.DisableControls;
    cds_itens_ajt.First;
    while not cds_itens_ajt.eof do
    Begin
      if ( cds_itens_ajt.UpdateStatus = usModified )  then
      Begin
        Pedido.Itens.Registro.Codigo         := cds_itens_ajtITF_CODIGO.AsInteger;
        Pedido.Itens.Registro.Quantidade     := cds_itens_ajtITF_QTDE.AsFloat;
        Pedido.Itens.Registro.ValorUnitario  := cds_itens_ajtITF_VL_UNIT.AsCurrency;
        Pedido.Itens.atualizaParcial;
      end;
      cds_itens_ajt.next;
    End;
    cds_itens_ajt.MergeChangeLog;
    cds_itens_ajt.First;
    cds_itens_ajt.EnableControls
  End;

end;

procedure TFr_Pedido_Ajt.Pc_Grava_Config_Global;
begin
  if Chbx_controle_ajuste.Checked then  Fc_Tb_Geral('G','AJT_G_CTRL_SEQUENCIA','S') else Fc_Tb_Geral('G','AJT_G_CTRL_SEQUENCIA','N');
  if Chbx_controle_estoque.Checked then  Fc_Tb_Geral('G','AJT_G_CTRL_ESTOQUE','S') else Fc_Tb_Geral('G','AJT_G_CTRL_ESTOQUE','N');  
end;


procedure TFr_Pedido_Ajt.Button1Click(Sender: TObject);
begin
  Pc_Grava_Config_Local;
  Pg_Pedido_Ajt.ActivePage := tbs_pesquisa;
end;

procedure TFr_Pedido_Ajt.Button3Click(Sender: TObject);
begin
  Pc_Grava_Config_Local;
end;

procedure TFr_Pedido_Ajt.Button2Click(Sender: TObject);
begin
  Pg_Pedido_Ajt.ActivePage := tbs_pesquisa;
end;

procedure TFr_Pedido_Ajt.Btn_Ok_LocalClick(Sender: TObject);
begin
  Pc_Grava_Config_Global;
  Pg_Pedido_Ajt.ActivePage := tbs_pesquisa;
end;

procedure TFr_Pedido_Ajt.Btn_Cn_LocalClick(Sender: TObject);
begin
    Pg_Pedido_Ajt.ActivePage := tbs_pesquisa;
end;

procedure TFr_Pedido_Ajt.PopAjustarRetornocomVendasClick(Sender: TObject);
var
  Form : TSeaNfProduct;
begin
  Try
    Form := TSeaNfProduct.Create(nil);
    Form.ShowModal;
    if Form.Visualizar then
    Begin
      Pc_AjustarRetorno(Form.Escolhidos);
    End;
  Finally
    FreeAndNil( Form );
  End;
end;

procedure TFr_Pedido_Ajt.ApagaDevolIpi(id: Integer);
Var
  DevolIPi : TControllerDevolIPI;
begin
  Try
    DevolIPi := TControllerDevolIPI.Create(nil);
    DevolIPi.Registro.Item  := id;
    DevolIPi.deleteByItem;
  Finally
    FreeandNil(DevolIPi);
  End;
end;

procedure TFr_Pedido_Ajt.Btn_Ap_LocalClick(Sender: TObject);
begin
  Pc_Grava_Config_Global;
end;

procedure TFr_Pedido_Ajt.Pop_ConfigLocalClick(Sender: TObject);
begin
  Pg_Pedido_Ajt.ActivePage := tbs_Config_Local;
  Pc_Abre_Config_Local;
end;

procedure TFr_Pedido_Ajt.Pop_ConfigGlobalClick(Sender: TObject);
begin
  if Gb_Nivel = 1 then
    Begin
    Pg_Pedido_Ajt.ActivePage := tbs_Config_Global;
    Pc_Abre_Config_Global;
    end
  else
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'As configurações Globais são permitidas apenas' + EOLN +
                   'para usuários administradores pois influenciam todo o sistema.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    end;
end;

procedure TFr_Pedido_Ajt.Sb_Pesq_ClienteClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(-1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    DBLCB_Empresa.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
    DBLCB_EmpresaExit(Sender);
  end;
end;

procedure TFr_Pedido_Ajt.SB_ClienteClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  If trim(DBLCB_Empresa.Text) <> '' then
  Begin
    Lc_Retorno := Fc_AbreTelaEmpresa(DBLCB_Empresa.KeyValue);
    if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
    begin
      E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
      DBLCB_Empresa.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
      DBLCB_EmpresaExit(Sender);
    end;
  end;
end;

end.





