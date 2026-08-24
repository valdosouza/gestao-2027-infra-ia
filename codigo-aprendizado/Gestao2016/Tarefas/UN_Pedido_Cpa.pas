unit UN_Pedido_Cpa;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, StdCtrls, Mask, Grids, DBGrids, ExtCtrls, DB, Buttons, ComCtrls, STStoredProc, STQuery, Printers, jpeg, IniFiles, ActnList, QEdit_Setes, Menus, System.Math, ControllerPedido, Actions, Un_Fm_FormaPagto, Un_Fm_ListaMultiEmpresa, ControllerCtrlLote, Un_Fm_ListaEmpresaEndereco, base_frame_list;



type
   TFr_Pedido_Cpa = class(TForm)
      Pg_Pedido_Cpa: TPageControl;
    tbs_cadastro: TTabSheet;
    tbs_pesquisa: TTabSheet;
      Ds_ItensVda: TDataSource;
      PrintDialog: TPrintDialog;
      Pnl_fundo: TPanel;
      Label2: TLabel;
      Label6: TLabel;
      lc_fornecedor: TLabel;
      SB_fornecedor: TSpeedButton;
    DBLCB_Empresa: TDBLookupComboBox;
      Panel2: TPanel;
      Label22: TLabel;
      Label11: TLabel;
      Label12: TLabel;
      Label8: TLabel;
      Label23: TLabel;
      E_Qt_Produto: TEdit_Setes;
      E_VL_IPI: TEdit_Setes;
      E_VL_Frete: TEdit_Setes;
      Label27: TLabel;
    E_Dt_Entrega: TEdit;
    E_Cd_Empresa: TEdit;
      Qr_Pesquisa: TSTQuery;
      Ds_Pesquisa: TDataSource;
      E_Nr_Parcelas: TEdit_Setes;
    E_Prazo: TMaskEdit;
      Qr_Endereco: TSTQuery;
      Ds_Endereco: TDataSource;
      Qr_ItensCpa: TSTQuery;
      Qr_Acao: TSTQuery;
      E_VL_ICMS: TEdit_Setes;
      E_VL_Bs_ICMS: TEdit_Setes;
      Label5: TLabel;
      Label9: TLabel;
      RG_frete: TRadioGroup;
      E_VL_Produto: TPanel;
      Qr_Cp_Itens: TSTQuery;
      Sb_Fich_Fin: TSpeedButton;
      E_Data: TDateTimePicker;
      Sb_Parcelamento: TSpeedButton;
      Ds_adicao: TDataSource;
      Qr_Itens_Ajuste: TSTQuery;
      E_Aq_Desconto: TEdit_Setes;
      Label26: TLabel;
      E_VL_Desconto: TEdit_Setes;
      Label7: TLabel;
      chbx_NomeFornecedor: TCheckBox;
      chbx_fantasiaFornecedor: TCheckBox;
      Qr_Entrega: TSTQuery;
      Qr_EntregaEND_CODIGO: TIntegerField;
      Qr_EntregaENDERECO: TStringField;
      Qr_EntregaEMP_CODIGO: TIntegerField;
      Ds_Entrega: TDataSource;
      E_Nr_Pedido: TEdit_Setes;
      chbx_aprovados: TCheckBox;
      Pop_Serie: TPopupMenu;
    RegistraNmerodeSerie: TMenuItem;
    RegistraNmerodeLote: TMenuItem;
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
    PG_Itens: TPageControl;
    TS_Produto: TTabSheet;
    Pnl_Produto: TPanel;
    Sb_Ins_Produto: TSpeedButton;
    Sb_Alt_Produto: TSpeedButton;
    Sb_Exc_Produto: TSpeedButton;
    DBG_Produtos: TDBGrid;
    Pg_Observacao: TPageControl;
    TabSheet4: TTabSheet;
    Pnl_Observacao: TPanel;
    E_Observ: TMemo;
    TabSheet5: TTabSheet;
    Pnl_Entrega: TPanel;
    Label4: TLabel;
    Sb_Transportadora: TSpeedButton;
    DBLCB_Transportadora: TDBLookupComboBox;
    E_CodTransp: TEdit;
    TabSheet6: TTabSheet;
    Pnl_Faturamento: TPanel;
    tbs_despesa: TTabSheet;
    Pnl_Despesa: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    Label24: TLabel;
    Lb_Vl_Fob: TLabel;
    Lb_vl_Despesas: TLabel;
    Lb_aliq_Depesas: TLabel;
    Label30: TLabel;
    Sb_Custo_Pedido: TSpeedButton;
    CadastrodoProduto: TMenuItem;
    InformaesdaDI1: TMenuItem;
    GroupBox1: TGroupBox;
    Label36: TLabel;
    E_BuscaCliente: TEdit;
    E_BuscaPedido: TEdit_Setes;
    ChBx_bUSCA_Nome: TCheckBox;
    ChBx_busca_Fantasia: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    Pnl_busca: TGroupBox;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    SB_Cadastrar: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    DBG_Pesquisa: TDBGrid;
    rdg_pedido: TRadioGroup;

    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Dblcb_Negocio: TDBLookupComboBox;
    Sb_Negocio: TSpeedButton;
    Label13: TLabel;
    Sb_Pesq_Cliente: TSpeedButton;
    Fm_FormaPagto: TFm_FormaPagto;
    Fm_LME: TFm_ListaMultiEmpresa;
    Fm_EndEntrega: TFm_ListaEmpresaEndereco;
    Fm_EndFaturamento: TFm_ListaEmpresaEndereco;
    Fm_EndCobranca: TFm_ListaEmpresaEndereco;
    Mnu_Controle: TMainMenu;
    Mnu_tarefas: TMenuItem;
    Importao1: TMenuItem;
    Label1: TLabel;
    Qr_ItensCpaITF_CODIGO: TIntegerField;
    Qr_ItensCpaITF_CODPED: TIntegerField;
    Qr_ItensCpaITF_CODNFL: TIntegerField;
    Qr_ItensCpaITF_CODPRO: TIntegerField;
    Qr_ItensCpaPRO_CODIGOFAB: TStringField;
    Qr_ItensCpaPRO_DESCRICAO: TStringField;
    Qr_ItensCpaPRO_SERIE: TStringField;
    Qr_ItensCpaEMB_ABREVIATURA: TStringField;
    Qr_ItensCpaITF_QTDE: TBCDField;
    Qr_ItensCpaITF_VL_CUSTO: TFMTBCDField;
    Qr_ItensCpaITF_VL_UNIT: TFMTBCDField;
    Qr_ItensCpaITF_AQ_COM: TBCDField;
    Qr_ItensCpaITF_LARGURA: TBCDField;
    Qr_ItensCpaITF_ALTURA: TBCDField;
    Qr_ItensCpaMED_ABREVIATURA: TStringField;
    Qr_ItensCpaITF_AQ_DESC: TBCDField;
    Qr_ItensCpaITF_VL_DESC: TBCDField;
    Qr_ItensCpaITF_AQ_IPI: TBCDField;
    Qr_ItensCpaITF_AQ_ICMS: TBCDField;
    Qr_ItensCpaITF_CODEST: TIntegerField;
    Qr_ItensCpaITF_CODTPR: TIntegerField;
    Qr_ItensCpaPRO_VL_CUSTO: TFMTBCDField;
    Qr_ItensCpaITF_ESTOQUE: TStringField;
    Qr_ItensCpaITF_VL_IPI: TFloatField;
    Qr_ItensCpaITF_VL_SUBTOTAL: TFloatField;
    Qr_ItensCpaITF_VL_TOTAL: TFloatField;
    Qr_ItensCpaTX_DIF_CUSTO: TFloatField;
    Qr_ItensCpaITF_SEQUENCIA: TIntegerField;
    Qr_ItensCpaPRO_CODIGONCM: TStringField;
    Qr_ItensCpaPRO_TIPO: TStringField;
    Qr_ItensCpaTPR_MODALIDADE: TStringField;
    Qr_ItensCpaTPR_NOME: TStringField;
    Qr_ItensCpaPRO_ORIGEM: TStringField;
    Qr_ItensCpaITF_NR_PECAS: TBCDField;
    Qr_ItensCpaPRO_VL_CUSTOMED: TFMTBCDField;
    Corrigirsequnciadositens1: TMenuItem;
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure DBG_ProdutosKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure E_DataEnter(Sender: TObject);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure SB_fornecedorClick(Sender: TObject);
      procedure Sb_PesquisarClick(Sender: TObject);
      procedure E_VL_FreteExit(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
      procedure FormCreate(Sender: TObject);
      procedure E_Nr_ParcelasExit(Sender: TObject);
      procedure E_VL_DescontoExit(Sender: TObject);
      procedure Sb_Ins_ProdutoClick(Sender: TObject);
      procedure Sb_Alt_ProdutoClick(Sender: TObject);
      procedure Qr_ItensCpaAfterOpen(DataSet: TDataSet);
      procedure Sb_Exc_ProdutoClick(Sender: TObject);
      procedure SB_ImprimirClick(Sender: TObject);
      procedure SB_FaturarClick(Sender: TObject);
      procedure Sb_TransportadoraClick(Sender: TObject);
      procedure DBLCB_EmpresaExit(Sender: TObject);
      procedure ChBx_bUSCA_NomeClick(Sender: TObject);
      procedure ChBx_busca_FantasiaClick(Sender: TObject);
      procedure Sb_Fich_FinClick(Sender: TObject);
      procedure DBG_ProdutosDblClick(Sender: TObject);
      procedure Sb_ParcelamentoClick(Sender: TObject);
      procedure ChBx_PeriodoClick(Sender: TObject);
      procedure Sb_Custo_PedidoClick(Sender: TObject);
      procedure DBLCB_TransportadoraKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure DBG_PesquisaTitleClick(Column: TColumn);
      procedure DBLCB_FormaPagtoExit(Sender: TObject);
      procedure E_Aq_DescontoExit(Sender: TObject);
      procedure tbs_cadastroShow(Sender: TObject);
      procedure chbx_NomeFornecedorClick(Sender: TObject);
      procedure chbx_fantasiaFornecedorClick(Sender: TObject);
      procedure RegistraNmerodeLoteClick(Sender: TObject);
      procedure RegistraNmerodeSerieClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CadastrodoProdutoClick(Sender: TObject);
    procedure InformaesdaDI1Click(Sender: TObject);
    procedure E_Cd_EmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure Qr_Itens_AjusteAfterOpen(DataSet: TDataSet);
    procedure Sb_NegocioClick(Sender: TObject);
    procedure Dblcb_NegocioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure E_Cd_EmpresaExit(Sender: TObject);
    procedure Sb_Pesq_ClienteClick(Sender: TObject);
    procedure TabSheet6Show(Sender: TObject);
    procedure TabSheet5Show(Sender: TObject);
    procedure Importao1Click(Sender: TObject);
    procedure Qr_ItensCpaCalcFields(DataSet: TDataSet);
    procedure Corrigirsequnciadositens1Click(Sender: TObject);
   private
    { Private declarations }
      It_Inserir: Boolean;
      It_Alterar: Boolean;
      It_Excluir: Boolean;
      It_Faturar: Boolean;
      It_IMPRIMIR: Boolean;
      it_ficha_financeira:  Boolean;
      It_Visualizar: Boolean;
      It_Aprovar: Boolean;
      It_Vl_TL_Icms: Currency;
      It_VL_bs_Icms: Currency;

      It_Edicao_Ordem : String;

      function Fc_ChamaFaturaCpa():Boolean;

      function Fc_ValidaAlteracao():Boolean;

      procedure Pc_Gravar;
      procedure Pc_grava_Perfil_Local;
   public
    { Public declarations }
      CtrlLote : TControllerCtrlLote;
      Pedido : TControllerPedido;
      procedure Pc_AtivarTabelas;
      procedure Pc_AbrirPedido;
      procedure Pc_AbrirItens;
      procedure PC_Buscar;
      procedure Pc_Visualizar;
      procedure Pc_AtualizaCampos;
      procedure Pc_LimpaCampos;
      procedure Pc_AutoPedido;
      procedure Pc_GeraNumeroPedido;
      Procedure Pc_AjustePedido;
      procedure Pc_Totalizador;
      function Fc_Parcelamento(): string;
      function Fc_ValidaGravacao(): Boolean;
      function Fc_Valida_FormaPgto: Boolean;
      function Fc_ValidaPrazo: Boolean;
      function Fc_ValidaPreencheFornecedor(): Boolean;
      Procedure Pc_DefineSetfocus;
      Function ValidaPedidoExistente:Boolean;
      Function Fc_ValidaFaturamento:Boolean;
      function Fc_ValidasSeries:Boolean;
      function ValidaDiferencacusto:Boolean;
      procedure Pc_PermissaoBotao(Pc_Menu: string);
      Procedure Pc_GravaLog;
      procedure Pc_Limpa_campo_busca;
      Function Fc_Valida_impressao:Boolean;
      procedure Pc_ImagemBotao;
      Function Fc_ValidaCancelameto():Boolean;
      procedure Pc_Ini_Variavel;
      procedure Pc_AbrirEndereco;
      procedure Pc_IniciaVariaveis;
      procedure Pc_FormataTela;
      procedure Pc_AbrePedidoNovo;
      procedure Pc_PropagarInformacao(Codigo:Integer);

      procedure Pc_EstadoEdicaoOrdem;
   end;

var
   Fr_Pedido_Cpa: TFr_Pedido_Cpa;

implementation

uses
Un_DM, Un_Msg, UN_Principal, env, UN_Sistema, Un_Itens_Produto_CPA, Un_Funcoes, Un_Pesq_Produto, UN_Fatura_Vda, UN_Fatura_Cpa, Un_Fich_Fin_For, Un_Parcelamento, reg_custo_pedido, Un_Fc_Sored_Procedures, Un_Produto_Series, un_Padrao, Un_Produtos, UN_FormaPagto, Un_Imp_Mod_Impressao, Un_Regra_Negocio, Un_Info_Dec_Imp, Un_Transportadora, Un_Ctrl_Lote_Entrada, RN_Permissao, RN_Inventario, RN_Estoque, RN_Compras, RN_Lotes, RN_FormaPagto, RN_NotaFiscalEletronica3X, Un_Fornecedor, RN_Fornecedor, UN_TabelasEmListas, RN_Empresa, RN_Pedido, RN_NotaFiscal, ControllerDocumentoImportacao, ControllerAdicaoImportacao, Un_Custo_Importacao, UN_NF, ajustapedidocompra, sea_business;

{$R *.dfm}

procedure TFr_Pedido_Cpa.Pc_AbrePedidoNovo;
Begin
  Pc_AtivarTabelas;
  Pedido.using('L');
  Pc_Ini_Variavel;
  E_Cd_Empresa.Clear;
  E_Cd_EmpresaExit(Self);
  chbx_aprovados.Checked := False;
  E_VL_IPI.Text := '0,00';
  E_VL_Frete.Text := '0,00';
  E_Aq_Desconto.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
  Pc_AtualizaCampos;
  Pc_Totalizador;
  E_Prazo.EditMask := '';
  E_Prazo.Text:='';
  E_Nr_Parcelas.Text := '000';
  E_Nr_ParcelasExit(Self);
  E_Data.Date := Date;
  It_Edicao_Ordem := 'I';
  Pc_EstadoEdicaoOrdem;
  E_Cd_Empresa.SetFocus;
End;

procedure TFr_Pedido_Cpa.Pc_AbrirEndereco;
Begin
  with Qr_endereco, Pedido.Registro do
  Begin
    Active:=False;
    ParamByName('EMP_CODIGO').AsInteger :=  Empresa;
    Active:=True;
  End;
End;

procedure TFr_Pedido_Cpa.Pc_IniciaVariaveis;
Begin
  Fm_LME.Listar('EMP_NOME');
  Fm_LME.HabilitarMultiEmpresa;
  If (Pedido.Registro.Codigo > 0) then
  Begin
    Pedido.getbyId;
    Pedido.using('B');
    Pc_AtivarTabelas;
    Pc_AbrirEndereco;
    Pc_AbrirPedido;
    Pg_Pedido_Cpa.ActivePageIndex := 0;
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
  end
  else
    Pg_Pedido_Cpa.ActivePageIndex:=1;
end;

procedure TFr_Pedido_Cpa.Pc_Ini_Variavel;
begin
  pedido.Clear;
  E_Nr_Pedido.Clear;
end;

Procedure TFr_Pedido_cPA.Pc_AjustePedido;
Var
  Lc_Nr_Nota : String;
  Lc_Msg : String;
  Lc_AjustaPedido : tajustaPedidoCompra;
Begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja Realmente ajustar este Pedido.'+EOLN+
                     'Esta operação não é reversável'+EOLN+
                     'Confirmar o ajuste ?',
                     [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  begin
    // Pede o Numero da Nota
    if not(InputQuery('Por Favor Informe', 'Um número de Nota Fiscal Válida', Lc_Nr_Nota)) then
      exit;
      Lc_Nr_Nota := StrZero(StrToIntDef(Lc_Nr_Nota,0),6,0);
    IF (Lc_Nr_Nota = '') or (Lc_Nr_Nota = '000000') then
    Begin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Número de Nota Fiscal Invalido.'+EOLN+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      exit;
    end;
    //Formata o Numero da Nota
    Lc_AjustaPedido := tajustaPedidoCompra.Create(Self);
    with Lc_AjustaPedido do
    Begin
      BancodeDados    := DM.IBD_Gestao;
      Transacao       := DM.IB_Transacao;
      Estabelecimento := Gb_CodMha;
      NumeroDaNota    := Lc_Nr_Nota;
      CodigoDoPedido  := pedido.Registro.codigo;
      CodigoDaEmpresa := pedido.Registro.Empresa;
      Lc_Msg := Fc_ExecutaAjuste;
      if (Lc_Msg = 'Sucesso') then
      Begin
        Pc_AtualizaCampos;
        Pc_Totalizador;
        It_Edicao_Ordem := 'B';
        Pc_EstadoEdicaoOrdem;
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       'Ajuste Efetuado com Sucesso.'+EOLN,
                       ['OK'],[bEscape],mpInformacao);
      end
      else
      Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       Lc_Msg+EOLN,
                       ['OK'],[bEscape],mpInformacao);
      end;
    end;
  end;
end;



procedure TFr_Pedido_Cpa.Pc_GeraNumeroPedido;
begin
  with Pedido.Registro do
  Begin
    If (Numero = 0) then Pedido.nextNumber('T');
    E_Nr_Pedido.Text := IntToStr( Numero );
  End;
end;

procedure TFr_Pedido_Cpa.Pc_AutoPedido;
var
   Lc_Oper_Reg: string;
begin
{
  Screen.Cursor := crHourGlass;
  Qr_Cp_Itens.Active := False;
  Qr_Cp_Itens.ParamByName('EMP_CODIGO').AsString := E_Cd_Empresa.Text;
  Qr_Cp_Itens.ParamByName('ETS_CODIGO').AsInteger := Gb_Estoque;
  Qr_Cp_Itens.Active := True;
  Qr_Cp_Itens.FetchAll;

  if Qr_Cp_Itens.recordcount > 0 then
    begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Existem produtos deste fornecedor abaixo do estoque mínimo.' + EOLN + EOLN +
                       'Deseja Gerar um pedido Automático ?',
                       [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
      begin
      if (Ds_Pedido.State in [dsinsert]) then
        begin
        TB_Pedido.Post;
        IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
        TB_Pedido.Edit;
        end;
      Qr_Cp_Itens.First;
      while not Qr_Cp_Itens.Eof do
        begin
        Fc_AtualizaItensNfl(DM.IB_Transacao,
                            'I',
                             0,
                             TB_Pedido.FieldByName('PED_CODIGO').AsInteger,
                             0,
                             Qr_Cp_Itens.fieldbyname('PRO_CODIGO').AsInteger,
                             Qr_Cp_Itens.fieldbyname('PRO_QTDE_MIN').AsFloat,
                             Qr_Cp_Itens.fieldbyname('PRO_VL_CUSTO').AsCurrency,
                             Qr_Cp_Itens.fieldbyname('PRO_VL_CUSTO').AsCurrency,
                             0,
                             0,
                             0,
                            'C',
                            'S',
                            'N',
                             0,
                             0 ,
                             1,
                             1,
                             '',
                             0,0,0);
          Qr_Cp_Itens.Next;
          end;
      IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
      Pc_AbrirItens;
      Pc_AtualizaCampos;
      Pc_Totalizador;
      TB_Pedido.Post;
      IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
      TB_Pedido.Edit;
      MensagemPadrao(MENSAGEM, 'S U C E S S O.' + EOLN + EOLN +
                     ' Pedido Criado com Sucesso.' + EOLN +
                     'Clique em OK para COntinuar.' + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      end;
    end;
   Screen.Cursor := crDefault;
    }
end;




function TFr_Pedido_Cpa.Fc_Parcelamento(): string;
var
   Lc_St_Parcela: string;
   Lc_Vl_Parcela: Real;
   Lc_I: Integer;
   Lc_Prazo: string;
   Lc_PArcelamento: string;
   Lc_Vl_Pedido: Real;
   Lc_Qt_Parcelas: Integer;
begin

   Lc_Qt_Parcelas := StrToIntDef(Self.E_Nr_Parcelas.Text, 1);
   Lc_Vl_Pedido := StrToFloatDef(E_VL_Pedido.Caption,0);
  //Resolvemos o problema da Divisão e dizima periodica
   Lc_St_Parcela := FloatToStrF((Lc_Vl_Pedido / Lc_Qt_Parcelas), ffFixed, 10, 2);
   Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
   Lc_PArcelamento := '';
   for Lc_I := 0 to (Lc_Qt_Parcelas - 1) do
   begin
      Lc_Prazo := Copy(Self.E_Prazo.Text, ((Lc_I * 4) + 1), 3);
      if (Lc_I = (Lc_Qt_Parcelas - 1)) then
      begin
         Lc_PArcelamento := Lc_PArcelamento + Copy(DateToStr(E_Data.Date + StrToInt(Lc_Prazo)), 1, 5) + ' - ' + Lc_St_Parcela;
      end
      else
      begin
         Lc_PArcelamento := Lc_PArcelamento + Copy(DateToStr(E_Data.Date + StrToInt(Lc_Prazo)), 1, 5) + ' - ' + FloatToStrF((Lc_Vl_Pedido - (Lc_Vl_Parcela * (lc_Qt_Parcelas - 1))), ffFixed, 10, 2) + ' / ';
      end;
   end;
   Result := Lc_PArcelamento;
end;

procedure TFr_Pedido_Cpa.Pc_AtivarTabelas;
begin
  Fm_FormaPagto.Pc_Listar(3,False,0);
  DM.Qr_Prazo.Active := True;
  DM_ListaConsultas.Pc_ListaTranportadoras('EMP_NOME');
  Qr_Entrega.Active:=true;
  Pc_AbreListaFornecedor('EMP_NOME');
  DM.Qr_Negocio.Active := True;
end;

procedure TFr_Pedido_Cpa.Pc_AbrirPedido;
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
      Pc_AtualizaCampos;
      Pc_Totalizador;
      E_Cd_Empresa.Text := IntToStr(Empresa);
      DBLCB_Empresa.KeyValue := empresa;
      Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := FormaPagto;
      E_Nr_Parcelas.Text:=COPY( Prazo,0,Length(prazo));
      E_Nr_ParcelasExit(Self);
      E_Prazo.Text   := COPY( Prazo,7,Length(Prazo));
      chbx_aprovados.Checked :=  (Aprovado = 'S');
      Dblcb_Negocio.KeyValue := Pedido.Registro.CodigoNegocio;
      E_Dt_Entrega.Text := DateToStr(DataEntrega);
      E_Observ.Text := Observacao;
      RG_frete.ItemIndex := FretePorConta;

      DBLCB_Transportadora.KeyValue := Transportadora;
      E_CodTransp.Text := IntToStr(Transportadora);
      Fm_EndEntrega.DBLCB_Endereco.KeyValue := EnderecoEntrega;
      Fm_EndEntrega.E_Codigo.Text := IntToStr(EnderecoEntrega);
      Fm_EndFaturamento.DBLCB_Endereco.KeyValue := EnderecoFaturamento;
      Fm_EndFaturamento.E_Codigo.Text := IntToStr(EnderecoFaturamento);
      Fm_EndCobranca.DBLCB_Endereco.KeyValue := EnderecoCobranca;
      Fm_EndCobranca.E_Codigo.Text := IntToStr(EnderecoCobranca);
      Dblcb_Negocio.KeyValue := CodigoNegocio;
    End;
  Except
    Pc_ErroCorrigirValores(Pedido.Registro.Codigo);
    Pc_AbrirPedido;
  end;
End;

procedure TFr_Pedido_Cpa.Pc_AbrirItens;
Begin
  with Qr_ItensCpa,Pedido.Registro do
  Begin
    Active:=False;
    paramByName('PED_CODIGO').AsInteger := Codigo;
    Active:=True;
    Fetchall;
  End;
End;

procedure TFr_Pedido_Cpa.PC_Buscar;
var
   Lc_Sqltxt: string;
   Lc_Pedido: Boolean;
   Lc_Cliente: Boolean;
begin
  If DM.IBT_Consulta.InTransaction THEN DM.IBT_Consulta.Commit;
  with Qr_Pesquisa do
  Begin
    Lc_Sqltxt := '';
    Screen.Cursor := crHourGlass;
    Active := False;
    Sql.Clear;
    Lc_Sqltxt := 'SELECT PED_CODIGO, PED_DATA, PED_NUMERO, EMP_FANTASIA, PED_VL_PEDIDO, EMP_NOME ' +
                 'FROM TB_PEDIDO tb_pedido ' +
                 '  INNER JOIN TB_EMPRESA tb_empresa ' +
                 '  ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP ) ' +
                 'WHERE (PED_TIPO = 2) AND (PED_FATURADO = ''N'') ';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
    Begin
      Lc_Sqltxt := Lc_Sqltxt + ' AND (PED_CODMHA =:PED_CODMHA) ';
    end;


    if (E_BuscaPedido.Text = '') then
      Lc_Pedido := False
    else
      Lc_Pedido := True;
    if (E_BuscaCliente.Text = '') then
      Lc_Cliente := False
    else
      Lc_Cliente := True;

    if ChBx_Periodo.Checked then
      Lc_Sqltxt := Lc_Sqltxt + 'AND (PED_DATA BETWEEN :PED_DATAINI AND :PED_DATAFIM) ';
    if Lc_Pedido then
      Lc_Sqltxt := Lc_Sqltxt + 'AND (PED_NUMERO = :PED_NUMERO) ';
    if Lc_Cliente then
      Lc_Sqltxt := Lc_Sqltxt + 'AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ';

    if rdg_pedido.ItemIndex = 0 then
      Lc_Sqltxt := Lc_Sqltxt + 'AND PED_APROVADO = ''S'' '
    else
    if rdg_pedido.ItemIndex = 1 then
      Lc_Sqltxt := Lc_Sqltxt + 'AND PED_APROVADO = ''N'' ';

    SQL.Add(Lc_Sqltxt + ' ORDER BY EMP_FANTASIA ');
    if ChBx_Periodo.Checked then
    begin
      ParamByName('PED_DATAINI').AsDate := E_Data_Ini.date;
      ParamByName('PED_DATAFIM').AsDate := E_Data_Fim.Date;
    end;
    if Lc_Pedido then
      ParamByName('PED_NUMERO').AsString := E_BuscaPedido.Text;
    if Lc_Cliente then
      ParamByName('EMP_FANTASIA').AsString := '%' + Copy(E_BuscaCliente.Text,1,98) + '%';

    if ( Trim(Fm_LME.Dblcb_Lista.Text) <> '' ) then
    Begin
      ParamByName('PED_CODMHA').AsInteger := Fm_LME.Dblcb_Lista.KeyValue;
    end;

     Active := True;
     Screen.Cursor := crDefault;
  End;

end;

procedure TFr_Pedido_Cpa.Pc_Visualizar;
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
  Pg_Pedido_Cpa.ActivePageIndex := 0;
end;


procedure TFr_Pedido_Cpa.Pc_AtualizaCampos;
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
  Pc_AbrirItens;
  with Qr_ItensCpa do
  Begin
    First;
    while not Eof do
    Begin
      Lc_Vl_Produto := Lc_Vl_Produto + FieldByName('ITF_VL_SUBTOTAL').AsCurrency;
      Lc_Qt_Produto := Lc_Qt_Produto + FieldByName('ITF_QTDE').AsFloat;
      Lc_Vl_IPI := Lc_Vl_IPI + FieldByName('ITF_VL_IPI').AsCurrency;
      Lc_Vl_Desconto := Lc_Vl_Desconto + FieldByName('ITF_VL_DESC').AsCurrency;
      IF (FieldByName('ITF_AQ_ICMS').AsCurrency > 0) then
      Begin
        Lc_Vl_TL_Icms := Lc_Vl_TL_Icms + (((FieldByName('ITF_QTDE').Asfloat * FieldByName('ITF_VL_UNIT').AsCurrency)-FieldByName('ITF_VL_DESC').AsCurrency) * (FieldByName('ITF_AQ_ICMS').AsCurrency/100));
        Lc_VL_bs_Icms := Lc_VL_bs_Icms + ((FieldByName('ITF_QTDE').Asfloat * FieldByName('ITF_VL_UNIT').AsCurrency)-FieldByName('ITF_VL_DESC').AsCurrency);
      end;
      Next;
    end;
  End;
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

procedure TFr_Pedido_Cpa.Pc_LimpaCampos;
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

procedure TFr_Pedido_Cpa.Pc_Totalizador;
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

{Ordem de Servico/Venda}

// Procedures Internas

procedure TFr_Pedido_Cpa.FormClose(Sender: TObject;
   var Action: TCloseAction);
begin
  FreeAndNil(CtrlLote);
  FreeAndNil(Pedido);
  Pc_grava_Perfil_Local;
end;


procedure TFr_Pedido_Cpa.DBG_ProdutosKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  : if Sb_Exc_Produto.Enabled then Sb_Exc_ProdutoClick(Sender);
  end;
end;

procedure TFr_Pedido_Cpa.E_DataEnter(Sender: TObject);
begin
   E_Data.Date := Date;
end;

procedure TFr_Pedido_Cpa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;


procedure TFr_Pedido_Cpa.SB_fornecedorClick(Sender: TObject);
Var
  Lc_Form : TFr_Fornecedor;
begin
  If trim(DBLCB_Empresa.Text) <> '' then
  Begin
    Try
      Lc_Form := TFr_Fornecedor.Create(Self);
      Lc_Form.Empresa.Registro.Codigo := DBLCB_Empresa.KeyValue;
      Lc_Form.ShowModal;
      Pc_AbreListaFornecedor('EMP_NOME');
      DBLCB_Empresa.KeyValue := Lc_Form.Empresa.Registro.Codigo;
      DBLCB_EmpresaExit(Self);
      Pedido.Registro.Empresa := Lc_Form.Empresa.Registro.Codigo;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end;
end;

procedure TFr_Pedido_Cpa.Sb_PesquisarClick(Sender: TObject);
begin
  Pedido.using('L');
  Pc_AtivaEstabelecimento;
  Pc_Ini_Variavel;
  Pc_Buscar;
  Pg_Pedido_Cpa.ActivePageIndex := 1;
end;

procedure TFr_Pedido_Cpa.E_VL_FreteExit(Sender: TObject);
Var
  Lc_Vl_frete : Real;
begin
  Lc_Vl_frete := StrtoFloatDef(E_VL_Frete.Text,0);
  E_VL_Frete.Text := FloatToStrF(Lc_Vl_frete,ffFixed,10,2);
  Pc_totalizador;
end;

procedure TFr_Pedido_Cpa.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  If ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') ) then
  begin
    case PG_Itens.ActivePageIndex of
      0:begin
          if shift = [] then
          begin
            case Key of
              VK_F2: if Sb_Ins_Produto.Enabled then Sb_Ins_ProdutoClick(Sender);
              VK_F3: if Sb_Alt_Produto.Enabled then Sb_Alt_ProdutoClick(Sender);
              VK_F4: if Sb_Exc_Produto.Enabled then Sb_Exc_ProdutoClick(Sender);
            end;
          end;
        end;
    end;
  end;

  case Pg_Pedido_Cpa.ActivePageIndex of
    0:begin
        if shift = [] then
        begin
          case Key of
            VK_F2: if SB_Inserir.Enabled then SB_InserirClick(Sender);
            VK_F3: if SB_Alterar.Enabled then SB_AlterarClick(Sender);
            VK_F4: if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
            VK_F5: if SB_Gravar.Enabled then SB_GravarClick(Sender);
            VK_F6: if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
            VK_F7: if SB_Pesquisar.Enabled then SB_PesquisarClick(Sender);
            VK_F8  : if ( It_Edicao_Ordem = 'B') then Pc_AjustePedido;
            VK_F10: if SB_Faturar.Enabled then SB_FaturarClick(Sender);
            VK_F11: if SB_Imprimir.Enabled then SB_ImprimirClick(Sender);
            VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
          end;
        end;
      end;
   else
      begin
        if shift = [] then
        begin
          case Key of
            VK_F2: if SB_Cadastrar.Enabled then SB_CadastrarClick(Sender);
            VK_F7: if SB_Buscar.Enabled then SB_BuscarClick(Sender);
            VK_F8: if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
            VK_Escape: if Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
          end;
        end;
      end;
   end;
end;

procedure TFr_Pedido_Cpa.tbs_pesquisaShow(Sender: TObject);
begin
  E_Data_Ini.Date := Date - 365;
  E_Data_Fim.date := Date;
  E_BuscaPedido.SetFocus;
  E_BuscaPedido.SelectAll;
end;

function TFr_Pedido_Cpa.ValidaDiferencacusto: Boolean;
Var
  LcMsg : String;
begin
  REsult := True;
  Qr_ItensCpa.First;
  LcMsg := '';
  while not Qr_ItensCpa.Eof do
  Begin
    if ( Qr_ItensCpaTX_DIF_CUSTO.AsCurrency > 0 ) then
    Begin
      LcMsg := concat(
                LcMsg,
                Qr_ItensCpaPRO_DESCRICAO.AsString,EOLN
              );
    end;
    Qr_ItensCpa.Next;
  End;
  if (LcMsg <> '' ) then
  Begin
        MensagemPadrao('Mensagems',ATENCAO+EOLN+EOLN+
                       'Estes Produtos apresentam diferenças de valor desde a última compra'+EOLN+EOLN+
                       LcMsg+EOLN,
                      ['OK'],[bEscape],mpAlerta);

    IF (Gb_Nivel = 0) then
    Begin
      if (pedido.Registro.Aprovado <> 'S') then
      Begin
        MensagemPadrao('Mensagems',ATENCAO+EOLN+EOLN+
                       'Pedido não aprovado, somente usuário adminstrador pode faturar.'+EOLN+EOLN,
                      ['OK'],[bEscape],mpAlerta);
        REsult := False;
        Exit;
      End;
    End;

  end;
end;

function TFr_Pedido_Cpa.ValidaPedidoExistente: Boolean;
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

procedure TFr_Pedido_Cpa.SB_InserirClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
      'Deseja mesmo abrir um novo Pedido.' + EOLN + EOLN +
      'Confirmar a Abertura ?',
      [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
  begin
    Pc_AbrePedidoNovo
   end;
end;

function TFr_Pedido_Cpa.Fc_ValidaAlteracao():Boolean;
Begin
  Result := True;
  if Pedido.verificaFaturado(True) then
  Begin
    Result := False;
    exit;
  end;

  if Pedido.InconsistenciaFaturado(true) then
  BEgin
    Result := False;
    exit;
  end;

  if pedido.Registro.Aprovado ='S' then
  begin
    if NOT It_Aprovar then
    begin
        MensagemPadrao('Mensagems',ATENCAO+EOLN+EOLN+
                       'Pedido aprovado. Seu usuário não tem permissão para alterá-lo.'+EOLN+
                       'Entre em contato com o Administrador.'+EOLN,
                      ['OK'],[bEscape],mpInformacao);
        Result:=false;
        exit;
    end;
   end;
end;

procedure TFr_Pedido_Cpa.SB_AlterarClick(Sender: TObject);
begin
  if Fc_ValidaAlteracao then
  Begin
    It_Edicao_Ordem := 'E';
    Pc_EstadoEdicaoOrdem;
    Pc_DefineSetfocus;
  end;
end;

procedure TFr_Pedido_Cpa.SB_ExcluirClick(Sender: TObject);
Var
  Lc_Lst_Lote : TStringList;
begin
  if not Pedido.verificaFaturado(True) then
  Begin
    If (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Deseja realmente excluir este Pedido.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                       [SIM,NAO],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao1) then
    Begin
      Qr_ItensCpa.First;
      Lc_Lst_Lote := TStringList.Create;
      Lc_Lst_Lote.Clear;
      while not Qr_ItensCpa.Eof do
      Begin
        CtrlLote.Movimento.Registro.Vinculo := Qr_ItensCpa.FieldByName('ITF_CODIGO').AsInteger;
        CtrlLote.Movimento.Registro.Tipo := 'COMPRA';
        CtrlLote.Movimento.Registro.Sentido := 'E';
        CtrlLote.Movimento.deleteByVinculo;
        Qr_ItensCpa.Next;
      End;
      FreeAndNil(Lc_Lst_Lote);

      pedido.enviaLixeira;
      Pc_Log_Sistema( Gb_CodMha,
                      GB_Cd_Usuario,
                      now,
                      'Pedido de Compra',
                      Pedido.Registro.Codigo,
                     'Exclusão do Pedido de compra',
                     'PEDIDO NUMERO: ' + IntToStr(Pedido.Registro.Numero));
      Pedido.using('L');
      Pc_Buscar;
      Pg_Pedido_Cpa.ActivePageIndex := 1;
      It_Edicao_Ordem := 'B';
      Pc_EstadoEdicaoOrdem;
    End;
  end;
end;

procedure TFr_Pedido_Cpa.Pc_Gravar;
begin
  with pedido.Registro do
  Begin
    EmUso := Fc_NomeComputador;
    Tipo := 2;
    Faturado := 'N';
    Numero := StrToIntDef( E_Nr_Pedido.Text,0 );
    Usuario := Gb_Cd_Usuario;
    Prazo := E_Nr_Parcelas.Text + ' - ' + E_Prazo.Text;
    Empresa := DBLCB_Empresa.KeyValue;
    Vendedor := 0;
    FormaPagto := Fm_FormaPagto.DBLCB_FormaPagto.keyvalue;
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
    IndicaPresenca := 0;
    IF chbx_aprovados.Checked then
      Aprovado := 'S'
    else
      Aprovado := 'N';
    Pc_AbrirEndereco;
    Endereco := Qr_Endereco.FieldByName('END_CODIGO').AsInteger;
    Observacao := E_Observ.Text;
    DataEntrega := StrToDateDef( E_Dt_Entrega.Text,Date);
    if Dblcb_Negocio.Text <> '' then
      CodigoNegocio := Dblcb_Negocio.KeyValue
    else
      CodigoNegocio := 0;

    if DBLCB_Transportadora.Text <> '' then
      Transportadora := DBLCB_Transportadora.KeyValue
    else
      Transportadora := 0;

    if Fm_EndEntrega.DBLCB_Endereco.Text <> '' then
      EnderecoEntrega := Fm_EndEntrega.DBLCB_Endereco.KeyValue
    else
      EnderecoEntrega := 0;

    if Fm_EndFaturamento.DBLCB_Endereco.Text <> '' then
      EnderecoFaturamento := Fm_EndFaturamento.DBLCB_Endereco.KeyValue
    else
      EnderecoFaturamento := 0;

    if Fm_EndCobranca.DBLCB_Endereco.Text <> '' then
      EnderecoCobranca := Fm_EndCobranca.DBLCB_Endereco.KeyValue
    else
      EnderecoCobranca := 0;

    if Dblcb_Negocio.Text <> '' then
      CodigoNegocio := Dblcb_Negocio.KeyValue
    else
      CodigoNegocio := 0;
  End;
  Pedido.Salva;
end;

procedure TFr_Pedido_Cpa.Pc_grava_Perfil_Local;
begin
  if (WindowState = wsNormal) then
    Fc_Aq_Geral('G','PEDIDOCPA','CRB_TELA_MAXIM','N')
  else
    Fc_Aq_Geral('G','PEDIDOCPA','CRB_TELA_MAXIM','S');
end;

procedure TFr_Pedido_Cpa.SB_GravarClick(Sender: TObject);
begin
  If Fc_ValidaGravacao then
  Begin
    Screen.Cursor := crHourGlass;
    Pc_Totalizador;
    Pc_Gravar;
    Pc_GravaLog;
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
    Screen.Cursor := crDefault;
  end;
end;

Function TFr_Pedido_Cpa.Fc_ValidaCancelameto():Boolean;
Begin
  Result := True;
  If not Fc_ValidaParcelamento(Pedido.Registro.Codigo, Pedido.Registro.ValorPedido) then
  Begin
    Result:=FALSE;
    exit;
  end;
end;

procedure TFr_Pedido_Cpa.SB_CancelarClick(Sender: TObject);
begin
  if Fc_ValidaCancelameto then
  Begin
    If ( It_Edicao_Ordem = 'I' ) then
      Sb_PesquisarClick(sELF);
    It_Edicao_Ordem := 'B';
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pedido_Cpa.Sb_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Pedido_Cpa.SB_CadastrarClick(Sender: TObject);
begin
   Pg_Pedido_Cpa.ActivePageIndex := 0;
   Pc_AbrePedidoNovo;
end;

procedure TFr_Pedido_Cpa.SB_BuscarClick(Sender: TObject);
begin
  TRY
    Pc_ProcesoAguarde(Self,'I');
    SB_Cadastrar.Enabled  := False;
    SB_Buscar.Enabled     := False;
    SB_Visualizar.Enabled := False;
    Sb_Sair_1.Enabled     := False;

    Pc_Buscar;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    SB_Cadastrar.Enabled  := It_Inserir;
    SB_Buscar.Enabled     := True;
    SB_Visualizar.Enabled := True;
    Sb_Sair_1.Enabled     := True;
  end;
end;

procedure TFr_Pedido_Cpa.SB_VisualizarClick(Sender: TObject);
begin
  If Qr_Pesquisa.RecordCount > 0 then
  Begin
    Pedido.Registro.Codigo := Qr_Pesquisa.FieldByName('PED_CODIGO').AsInteger;
    Pc_Visualizar;
  end;
end;

procedure TFr_Pedido_Cpa.TabSheet5Show(Sender: TObject);
begin
  Fm_EndEntrega.Listar;
end;

procedure TFr_Pedido_Cpa.TabSheet6Show(Sender: TObject);
begin
  Fm_EndFaturamento.Listar;
  Fm_EndCobranca.Listar;
end;

procedure TFr_Pedido_Cpa.Sb_Sair_1Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Pedido_Cpa.FormCreate(Sender: TObject);
begin
  Pedido := TControllerPedido.create(Self);
  CtrlLote := TControllerCtrlLote.create(Self);
end;

procedure TFr_Pedido_Cpa.E_Nr_ParcelasExit(Sender: TObject);
begin
   if StrToIntDef(E_Nr_Parcelas.Text, 0) > 0 then
   begin
      E_Prazo.Clear;
      E_Prazo.EditMask := Fc_MascaraPrazo(StrToIntDEf(E_Nr_Parcelas.Text,1))
   end
   else
   begin
      E_Prazo.EditMask := '';
      E_Prazo.Text := Fc_MascaraPrazo(StrToIntDef(E_Nr_Parcelas.Text,0));
   end;
end;

procedure TFr_Pedido_Cpa.E_VL_DescontoExit(Sender: TObject);
Var
  Lc_VL_Desconto:Real;
  Lc_Vl_Pedido : Real;
  Lc_Aq_Desconto : Real;
begin
  Lc_Vl_Pedido := StrtoFloatDef(E_VL_Produto.Caption,0);
  Lc_VL_Desconto := StrtoFloatDef(E_VL_Desconto.Text,0);
  pedido.AplicarValorDescontoItens(PEdido.Registro.Codigo,Lc_vl_Desconto);
  Lc_Aq_Desconto := (Lc_VL_Desconto / Lc_Vl_Pedido) * 100;
  Lc_Aq_Desconto := RoundTo( Lc_Aq_Desconto,-2);
  E_Aq_Desconto.Text := FloatToStrF(Lc_Aq_Desconto,ffFixed,10,2);
  Pc_AtualizaCampos;
  Pc_totalizador;
end;

procedure TFr_Pedido_Cpa.Sb_Ins_ProdutoClick(Sender: TObject);
Var
  Lc_Form:TFr_Itens_Produto_Cpa;
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
  try
    Lc_Form := TFr_Itens_Produto_Cpa.create(nil);
    Lc_Form.it_Cd_Empresa := pedido.Registro.Empresa;
    Lc_Form.Terminal := Pedido.Registro.Terminal;
    Lc_Form.Pc_StateChange(2);
    Lc_Form.ItensNFL.Registro.CodigoPedido := pedido.Registro.Codigo;
    Lc_Form.E_Qt_Produto.Text := '1';
    Lc_Form.it_Modalidade_preco := 'A';
    Lc_Form.loadItems(Qr_ItensCpa);
    //Controle de Tributação por Item de forma Manual
    Lc_Form.Sentido := 'E';
    Pc_AbrirEndereco;
    Lc_Form.Estado := Qr_endereco.FieldByName('END_CODUFE').AsInteger;
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pedido_Cpa.Sb_Alt_ProdutoClick(Sender: TObject);
Var
  Lc_Form : TFr_Itens_Produto_Cpa;
begin
  Try
  //Cria O Formulario
    Lc_Form := TFr_Itens_Produto_Cpa.Create(nil);
    Lc_Form.it_Cd_Empresa     := Pedido.Registro.Empresa;
    Lc_Form.Pc_StateChange(3);
    Lc_Form.It_Inserir        := True;
    Lc_Form.ItensNFL.Registro.CodigoPedido  := Pedido.Registro.Codigo;
    Lc_Form.Terminal          := Pedido.Registro.Terminal;
    Lc_Form.Fm_ListaEstoques.AtivaLista(Gb_CodMha);
    Lc_Form.Qr_Tabela.Active  := True;

    Lc_Form.editItems(Qr_ItensCpaITF_CODIGO.AsInteger );
    Lc_Form.Pc_Totalizador;
    Lc_Form.it_Modalidade_preco := 'A';
    //Controle de Tributação por Item de forma Manual
    Lc_Form.Sentido := 'E';
    Pc_AbrirEndereco;
    Lc_Form.Estado := Qr_endereco.FieldByName('END_CODUFE').AsInteger;
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  End;
end;

procedure TFr_Pedido_Cpa.Qr_ItensCpaAfterOpen(DataSet: TDataSet);
begin
  (Qr_ItensCpa.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat     := Gb_Casa_Dec_Compra;
  (Qr_ItensCpa.FieldByName('ITF_VL_DESC') as TNumericField).DisplayFormat     := '0.00######';
  (Qr_ItensCpa.FieldByName('ITF_VL_SUBTOTAL') as TNumericField).DisplayFormat := Gb_Casa_Dec_Compra;
  (Qr_ItensCpa.FieldByName('ITF_AQ_COM') as TNumericField).DisplayFormat := '0.00';
  (Qr_ItensCpa.FieldByName('ITF_VL_TOTAL') as TNumericField).DisplayFormat := Gb_Casa_Dec_Compra;
end;

procedure TFr_Pedido_Cpa.Qr_ItensCpaCalcFields(DataSet: TDataSet);
Var
  LcValor : Real;
  LcStrValor : String;
begin
  with Qr_ItensCpa do
  Begin
    LcValor := FieldByName('ITF_VL_UNIT').AsCurrency * FieldByName('ITF_QTDE').AsFloat;
    LcValor := RoundTo( LcValor ,-2);
    LcStrValor := FloatToStrF(LcValor , ffFixed, 10, 2);
    FieldByName('ITF_VL_SUBTOTAL').AsCurrency := StrToFloatDef(LcStrValor,0);

    FieldByName('ITF_VL_TOTAL').AsCurrency :=
        FieldByName('ITF_VL_SUBTOTAL').AsCurrency - FieldByName('ITF_VL_DESC').AsCurrency;

    FieldByName('TX_DIF_CUSTO').AsCurrency :=
      RoundTo(
        ( ( FieldByName('ITF_VL_UNIT').AsCurrency - FieldByName('PRO_VL_CUSTO').AsCurrency )/ FieldByName('PRO_VL_CUSTO').AsCurrency ) *100
        ,-2)
  End;
end;

procedure TFr_Pedido_Cpa.Sb_Exc_ProdutoClick(Sender: TObject);
Var
  Lc_Lst_Lote:TStringList;
Begin
  If (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+Qr_ItensCpa.FieldByName('PRO_DESCRICAO').AsString +' desta compra.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Pc_Log_Sistema(Gb_CodMha,
                   GB_Cd_Usuario,
                   Now,
                   'Item do Pedido Compra',
                   Qr_ItensCpa.FieldByName('ITF_CODIGO').AsInteger,
                   'Excluir Item',
                   'Produto '+ Qr_ItensCpa.FieldByName('ITF_CODPRO').AsString + ' do pedido Nº ' + IntToStr(pedido.Registro.Numero)  );


    CtrlLote.Movimento.Registro.Vinculo := Qr_ItensCpa.FieldByName('ITF_CODIGO').AsInteger;
    CtrlLote.Movimento.Registro.Tipo := 'COMPRA';
    CtrlLote.Movimento.Registro.Sentido := 'E';
    CtrlLote.Movimento.deleteByVinculo;
    Pedido.Itens.Registro.Codigo := Qr_ItensCpa.FieldByName('ITF_CODIGO').AsInteger;
    Pedido.Itens.delete;
    pedido.CorrigirSequenciaItens;
    Pc_AtualizaCampos;
    Pc_Totalizador;
    Pc_Gravar;
    Pc_EstadoEdicaoOrdem;
  end;
end;

procedure TFr_Pedido_Cpa.SB_ImprimirClick(Sender: TObject);
Var
  Lc_Imp : TimpModImpressao;
begin
  if Fc_Valida_impressao then
  Begin
    try
      Self.Enabled := False;
      Pc_GeraNumeroPedido;
      Lc_Imp := TimpModImpressao.create(nil);
      Lc_Imp.Pc_Imp_Tipo(pedido.Registro.Tipo,pedido.Registro.Codigo,0);
    finally
      FreeandNil(Lc_Imp);
      Self.Enabled := True;
    end;
    end;
end;

function TFr_Pedido_Cpa.Fc_ChamaFaturaCpa():Boolean;
Var
  Lc_Form :TFr_Fatura_Cpa;
Begin
  Result := False;
  TRy
    Lc_Form  := TFr_Fatura_Cpa.Create( nil);
    Lc_Form.It_Dt_Pedido := DateToStr( PEdido.Registro.Data );
    Lc_Form.It_Cd_Pedido := PEdido.Registro.Codigo;
    Lc_Form.It_Nr_Pedido := E_Nr_Pedido.Text;
    //Observação do Cliente que vai na Nota
    Lc_Form.E_Obs.Lines.Clear;
    //Transportador padrão do cliente
    Lc_Form.DBLCB_Transportadora.KeyValue := Fc_Preenche_Transportadora(PEdido.Registro.Empresa);
    //Totalizadores
    Lc_Form.E_VL_Bs_ICMS.Text := E_VL_Bs_ICMS.Text;
    Lc_Form.E_VL_ICMS.Text := E_VL_ICMS.Text;
    Lc_Form.E_Vl_Bs_Icms_St.Text := '0,00';
    Lc_Form.E_Vl_Icms_St.Text := '0,00';
    Lc_Form.E_VL_Produto.Caption := E_VL_Produto.Caption;
    Lc_Form.E_VL_Frete.Text := E_VL_Frete.Text;
    Lc_Form.E_Vl_Seguro.Text := '0,00';
    Lc_Form.E_VL_Nota.Caption := E_VL_Pedido.Caption;
    Lc_Form.E_Vl_desconto.Caption := E_VL_Desconto.Text;
    Lc_Form.E_VL_IPI.Text := E_VL_IPI.Text;
    Lc_Form.ShowModal;
    Result := Lc_Form.it_fatura_ok;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;
procedure TFr_Pedido_Cpa.SB_FaturarClick(Sender: TObject);
Var
  Lc_Ok : Boolean;
begin
  if Fc_ValidaFaturamento then
  Begin
    Pc_GeraNumeroPedido;
    Lc_Ok := Fc_ChamaFaturaCpa;
    If Lc_Ok then
    Begin
      Pg_Pedido_Cpa.ActivePageIndex := 1;
      Pedido.using('L');
      SB_BuscarClick(Self);
    end
    else
    Begin
      Pc_AtivarTabelas;
      Pc_AbrirPedido;
      Pg_Pedido_Cpa.ActivePageIndex := 0;
    end;
  end;
end;

procedure TFr_Pedido_Cpa.Sb_TransportadoraClick(Sender: TObject);
Var
  Lc_Form : TFr_Transportadora;
begin
  Try
    Lc_Form := TFr_Transportadora.Create(nil);
    if (Trim(DBLCB_Transportadora.Text) <> '') then
      Lc_Form.Empresa.Registro.Codigo := DBLCB_Transportadora.KeyValue;
    Lc_Form.ShowModal;
    DM_ListaConsultas.Pc_ListaTranportadoras('EMP_NOME');
    DBLCB_Transportadora.KeyValue := Lc_Form.Empresa.Registro.Codigo;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_Pedido_Cpa.DBLCB_EmpresaExit(Sender: TObject);
begin
  if Trim(DBLCB_Empresa.Text) <> '' then
  Begin
    E_Cd_Empresa.Text := IntToStr(DBLCB_Empresa.KeyValue);
    Pc_AutoPedido;
  end;
end;

procedure TFr_Pedido_Cpa.ChBx_bUSCA_NomeClick(Sender: TObject);
begin
   if ChBx_bUSCA_Nome.Checked then
   begin
      ChBx_busca_Fantasia.Checked := False;
      DBG_Pesquisa.Columns[2].FieldName := 'EMP_NOME';
   end;
end;

procedure TFr_Pedido_Cpa.ChBx_busca_FantasiaClick(Sender: TObject);
begin
   if ChBx_busca_Fantasia.Checked then
   begin
      ChBx_bUSCA_Nome.Checked := False;
      DBG_Pesquisa.Columns[2].FieldName := 'EMP_FANTASIA';
   end;
end;

procedure TFr_Pedido_Cpa.Sb_Fich_FinClick(Sender: TObject);
begin
  if Trim(DBLCB_Empresa.Text) <> '' then
    Begin
    if not Assigned(Fr_Fich_Fin_For) then Application.CreateForm(TFr_Fich_Fin_For, Fr_Fich_Fin_For);
    Fr_Fich_Fin_for.It_Cd_Fornece := StrToIntDef(E_Cd_Empresa.Text,0);
    Fr_Fich_Fin_For.It_Nm_Fornece := DBLCB_Empresa.Text;
    Fr_Fich_Fin_For.ShowModal;
    end;
end;

procedure TFr_Pedido_Cpa.DBG_ProdutosDblClick(Sender: TObject);
begin
   if Sb_Alt_Produto.Enabled then
      Sb_Alt_ProdutoClick(Self);
end;

procedure TFr_Pedido_Cpa.Sb_ParcelamentoClick(Sender: TObject);
Var
  Lc_Form : TFr_Parcelamento;
begin
  If (StrToFloatDef(E_VL_Pedido.Caption,0) > 0) then
  Begin
    Try
      Lc_Form := TFr_Parcelamento.Create(nil);
      Lc_Form.It_StrinPrazo       := E_Prazo.Text;
      Lc_Form.Pedido              := Pedido;
      Lc_Form.It_Desc_FormaPagto  := Fm_FormaPagto.DBLCB_FormaPagto.Text;
      Lc_Form.It_Bloqueio         := FAlse;
      Lc_Form.E_Nr_PArcelas.Text  :=  IntToStr(StrToIntDef(E_Nr_Parcelas.Text,1));
      if Lc_Form.E_Nr_PArcelas.Text = '0' then Lc_Form.E_Nr_PArcelas.Text := '1';
      Lc_Form.ShowModal;
      if Lc_Form.Confirma then
      Begin
        E_Nr_Parcelas.Text := StrZero(Lc_Form.It_Qt_Parcelas,3,0);
        if ( Lc_Form.It_Qt_Parcelas > 0 ) then
        Begin
          E_Prazo.Clear;
          E_Prazo.EditMask := '';
          E_Prazo.Text := Lc_Form.It_StrinPrazo;
          E_Prazo.EditMask := Fc_MascaraPrazo(Lc_Form.It_Qt_Parcelas);
        End
        else
        Begin
          E_Nr_ParcelasExit(Sender);
        End;
      End;
    Finally
      FreeAndNil(Lc_Form);
    End;
  end
  else
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'O pedido não pode ser zero para este acesso.'+EOLN+
                   'Defina o valor do pedido antes de Parcelar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
  End;
end;

procedure TFr_Pedido_Cpa.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Pedido_Cpa.Corrigirsequnciadositens1Click(Sender: TObject);
begin
  if pedido.CorrigirSequenciaItens then
    Pc_AbrirItens;
end;

procedure TFr_Pedido_Cpa.Sb_Custo_PedidoClick(Sender: TObject);
Var
  Form : TRegCustoPedido;
begin
  Form := TRegCustoPedido.Create(nil);
  Try
    Form.CodigoPedido := Pedido.Registro.Codigo;
    Form.ShowModal;
  Finally
    FreeAndNil( Form );
    Pc_Totalizador;
  End;
end;

procedure TFr_Pedido_Cpa.DBLCB_TransportadoraKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_Transportadora.KeyValue :=  Null;
    Pedido.Registro.Transportadora := 0;
    end;
  end;
end;

procedure TFr_Pedido_Cpa.DBG_PesquisaTitleClick(Column: TColumn);
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
  DBG_Pesquisa.Columns[DBG_Pesquisa.Tag].Title.Font.Style := [fsBold];end;

procedure TFr_Pedido_Cpa.DBLCB_FormaPagtoExit(Sender: TObject);
var
  Lc_Forma: String;
begin
  Lc_Forma := Fm_FormaPagto.DBLCB_FormaPagto.Text;
  If Lc_Forma = 'CREDITO' then
  begin
    if (Fc_Tb_Geral('L','FIN_G_ATIVA_CREDITO','') = 'N') then
    begin
      ShowMessage('Forma de Pagamento não Autorizada..');
      Fm_FormaPagto.DBLCB_FormaPagto.SetFocus;
    end;
  end;
end;




Function TFr_Pedido_Cpa.Fc_ValidaPreencheFornecedor():Boolean;
Begin
  Result := true;

  If (TRIM(DBLCB_Empresa.Text) ='') then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Preenchimento do Campo Fornecedor é obrigatório.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    end;

end;

function TFr_Pedido_Cpa.Fc_Valida_FormaPgto: Boolean;
begin
  Result:=true;
  if (Fm_FormaPagto.DBLCB_FormaPagto.Text ='') then
  BEGIN
    Result:=FALSE;
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'A forma de Pagamento não foi informado.'+EOLN+EOLN+
                   'Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                      ['OK'],[bEscape],mpErro);
  END;
end;

function TFr_Pedido_Cpa.Fc_ValidaPrazo: Boolean;
var
  lc_I : Integer;
  Lc_Prazo : String;
  lc_J : Integer;
begin
  Result := True;
  if E_Nr_Parcelas.Text <> '000' then
    Begin
    lc_J := StrToIntDef(E_Nr_Parcelas.Text,1);
    For Lc_I := 0 to  lc_J-1 do
      begin
      Lc_Prazo :=  Copy(E_Prazo.Text,((Lc_I * 4)+1),3);
      if (StrToIntDef(Lc_Prazo,0) = 0) and (lc_I > 0) then
        BEgin
        Result := False;
        MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                       'O Prazo não foi informado.'+EOLN+EOLN+
                       'Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                    ['OK'],[bEscape],mpErro);
        E_Nr_Parcelas.SetFocus;
        end;
      end;
    end;
end;

Function TFr_Pedido_Cpa.Fc_ValidaGravacao():Boolean;
Var
  Lc_Dt_Inventario : TDate;
Begin
  Result:=TRUE;
  Pc_Totalizador;
  //Valida o limite de compra mensal
  if not Fc_ValidaLimiteCompraMensal(Pedido.Registro.Codigo,0,StrToFloatDef(E_VL_Pedido.Caption,0), 0, E_Data.Date) then
    Begin
    Result := FAlse;
    Exit;
    end;

  //Verifica Inventario
  if not Fc_ValidaDataPedido(E_Data.DateTime) then
    Begin
    Result := FAlse;
    E_Data.SetFocus;
    E_Data.Date := Date;
    Exit;
    end;

  if not Fc_ValidaPreencheFornecedor then//Valida preenchimento do fornecedor
    BEGIN
    Result:=FALSE;
    exit;
    END;

  If ( E_Nr_Pedido.Text <>'' ) and (E_Nr_Pedido.Text <>'0') then
  begin
    if not Fc_ValidaNumeroPedido(Pedido.Registro.Codigo,StrToIntDef(E_Nr_Pedido.Text,1),2) then
    begin
      Result:=FALSE;
    end;
  end;

  //Valida preenchimento do endereco d entrega
  Qr_Endereco.Active := False;
  Qr_Endereco.ParamByName('EMP_CODIGO').AsString := E_Cd_Empresa.Text;
  Qr_Endereco.Active := true;
  Qr_Endereco.First;
  If not Fc_Valida_enderecoPedido(Qr_Endereco.FieldByName('END_CODIGO').AsInteger,'Proprio do fornecedor') then
    Begin
    Result:=FALSE;
    exit;
    end;


  if not Fc_Valida_FormaPgto then//Valida preenchimento dA FORMA DE PAGAMTNO
  BEGIN
    Result:=FALSE;
    exit;
  END;

  if not Fc_ValidaPrazo then
  begin
    Result:=FALSE;
    exit;
   end;

  If not Fc_ValidaParcelamento(Pedido.Registro.Codigo, (StrToFloatDef(E_VL_Pedido.Caption,0))) then
  Begin
    Result:=FALSE;
    exit;
  end;
end;


procedure TFr_Pedido_Cpa.E_Aq_DescontoExit(Sender: TObject);
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
  Pc_AtualizaCampos;
  Pc_totalizador;

end;

procedure TFr_Pedido_Cpa.tbs_cadastroShow(Sender: TObject);
begin
  Mnu_tarefas.Visible := ( Fc_Tb_Geral('L','CPA_G_OPER_COMPRA_NFE','S') = 'S' );
  Pc_ControlaNumero(E_Nr_Pedido,'CPA_G_CTRL_SEQUENCIA');
  Pg_Observacao.ActivePageIndex:=0;
end;

procedure TFr_Pedido_Cpa.Pc_DefineSetfocus;
begin
  IF E_Nr_Pedido.Enabled = true then
  begin
    E_Nr_Pedido.SetFocus;
    E_Nr_Parcelas.SelectAll;
  end  
  else
    E_Cd_Empresa.SetFocus;
end;

procedure TFr_Pedido_Cpa.Pc_EstadoEdicaoOrdem;
begin
  Pnl_fundo.Enabled := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );

  //botos aba produto
  Sb_Ins_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Alt_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  AND (Qr_ItensCpa.RecordCount > 0);
  Sb_Exc_Produto.Enabled   := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  AND (Qr_ItensCpa.RecordCount > 0);

  // botoes gerais
  SB_Inserir.Enabled       := (It_Edicao_Ordem = 'B') and It_Inserir;
  SB_Excluir.Enabled       := (It_Edicao_Ordem = 'B') and It_Excluir and (Pedido.Registro.Codigo > 0);
  SB_Imprimir.Enabled      := (It_Edicao_Ordem = 'B') and It_IMPRIMIR;
  SB_Faturar.Enabled       := (It_Edicao_Ordem = 'B') and It_Faturar;
  SB_Alterar.Enabled       := (It_Edicao_Ordem = 'B') and It_Alterar and (Pedido.Registro.Codigo > 0);
  SB_Gravar.Enabled        := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  SB_Cancelar.Enabled      := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Sb_Pesquisar.Enabled     := (It_Edicao_Ordem = 'B');
  Sb_Sair_0.Enabled        := (It_Edicao_Ordem = 'B');

  Sb_Custo_Pedido.Enabled := (It_Edicao_Ordem = 'B') and It_Excluir and (Pedido.Registro.Codigo > 0);

  RegistraNmerodeLote.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  RegistraNmerodeSerie.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  InformaesdaDI1.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Pnl_Observacao.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Pnl_Entrega.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Pnl_Faturamento.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
  Pnl_Despesa.Enabled  := ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') );
end;

procedure TFr_Pedido_Cpa.chbx_NomeFornecedorClick(Sender: TObject);
begin
  Pc_ListaFornecedorDbLookUpComboBox('EMP_NOME',chbx_NomeFornecedor,chbx_fantasiaFornecedor,DBLCB_Empresa);
end;

procedure TFr_Pedido_Cpa.chbx_fantasiaFornecedorClick(Sender: TObject);
begin
  Pc_ListaFornecedorDbLookUpComboBox('EMP_FANTASIA',chbx_fantasiaFornecedor,chbx_NomeFornecedor,DBLCB_Empresa);
end;

function TFr_Pedido_Cpa.Fc_ValidasSeries:Boolean;
Var
  Lc_SQLTxt : String;
Label
  sai;
Begin
  Result := True;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := DM.IB_Transacao;
  Qr_Acao.SQL.Clear;
  Lc_SQLTxt := 'SELECT SRP_CODIGO, SRP_NUMERO, SRP_CODSAI  FROM TB_SERIE_PRODUTO  '+
               'WHERE (SRP_CODENT =:SRP_CODENT)                       '+
               '  AND (SRP_CODPRO=:SRP_CODPRO)                        '+
               '  AND ( (SRP_CODSAI IS NULL) or (SRP_CODSAI = 0) )    ';
  Qr_Acao.SQL.Add(Lc_SQLTxt);
  Pc_AbrirItens;
  Qr_ItensCpa.First;
  while not Qr_ItensCpa.Eof do
  Begin
    if (Qr_ItensCpa.FieldByName('PRO_SERIE').AsString = 'S') then
    Begin
      Qr_Acao.Active := False;
      Qr_Acao.ParamByName('SRP_CODENT').AsInteger := Qr_ItensCpa.FieldByName('ITF_CODIGO').AsInteger;
      Qr_Acao.ParamByName('SRP_CODPRO').AsInteger := Qr_ItensCpa.FieldByName('ITF_CODPRO').AsInteger;
      Qr_Acao.Active := true;
      Qr_Acao.FetchAll;
      if (Qr_Acao.RecordCount <> Qr_ItensCpa.FieldByName('ITF_QTDE').AsFloat) then
      Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Informe os número de séries conforme ' + EOLN +
                       'a quantidade de itens do produto '+ Qr_ItensCpa.FieldByName('PRO_DESCRICAO').AsString + '.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        Result := False;
        goto sai;
      end;
    end;
    Qr_ItensCpa.Next;
  end;
sai:
end;

function TFr_Pedido_Cpa.Fc_ValidaFaturamento: Boolean;
begin
  Result:=TRUE;
  if not ValidaPedidoExistente then
  Begin
    Result:=FALSE;
    exit;
  end;

  if Pedido.verificaFaturado(True) then
  Begin
    Result := False;
    exit;
  end;

  if not Fc_ValidaParcelamento(Pedido.Registro.Codigo, Pedido.Registro.ValorPedido) then
  begin
    Result:=FALSE;
    exit;
  end;

  if Qr_ItensCpa.RecordCount = 0 then
  begin
     MensagemPadrao('Mensagems',ATENCAO+EOLN+EOLN+
                    'Pedido sem produto.'+EOLN+
                    'Inclua um produto e tente novamente!'+EOLN,
                   ['OK'],[bEscape],mpInformacao);
     Result:=false;
     exit;
  end;

  if not Fc_ValidasSeries then
  begin
    Result:=FALSE;
    exit;
  end;

  if Fc_Tb_Geral('L','CPA_G_OPER_DIFER_VALOR','S') = 'S' then
  bEGIN
    if not ValidaDiferencacusto then
    begin
      Result:=FALSE;
      exit;
    end;
  end;

end;

procedure TFr_Pedido_Cpa.Pc_GravaLog;
begin
  if chbx_aprovados.Checked then  // grava log se pedido tive marcado a opcao aprovado
    Begin
    Pc_Log_Sistema(Gb_CodMha,
                   GB_Cd_Usuario,
                   now,
                   'Pedido de Compra',
                   Pedido.Registro.Codigo,
                   'APROVAÇÃO DO PEDIDO DE COMPRA',
                   'PEDIDO NUMERO:' + IntToStr( Pedido.Registro.Numero ));
    end;
end;

procedure TFr_Pedido_Cpa.RegistraNmerodeLoteClick(Sender: TObject);
Var
  Lc_Form:TForm;
begin
  Lc_Form := TForm.Create(Fr_Ctrl_Lote_Entrada);
  Application.CreateForm(TFr_Ctrl_Lote_Entrada, Lc_Form);
  TFr_Ctrl_Lote_Entrada(Lc_Form).It_Cd_Item := Qr_ItensCpa.FieldByname('ITF_CODIGO').AsInteger;
  TFr_Ctrl_Lote_Entrada(Lc_Form).It_Tipo := 'COMPRA';
  TFr_Ctrl_Lote_Entrada(Lc_Form).it_Cd_produto := Qr_ItensCpa.FieldByname('ITF_CODPRO').AsInteger;
  TFr_Ctrl_Lote_Entrada(Lc_Form).It_Cd_Empresa := Pedido.Registro.Empresa;
  TFr_Ctrl_Lote_Entrada(Lc_Form).It_Qtde_Lote := Qr_ItensCpa.FieldByname('ITF_QTDE').AsFloat;
  TFr_Ctrl_Lote_Entrada(Lc_Form).ShowModal;
  FreeAndNil(Lc_Form);
end;

procedure TFr_Pedido_Cpa.RegistraNmerodeSerieClick(Sender: TObject);
begin
   if Qr_Itenscpa.RecordCount > 0 then
   Begin
     if not Assigned(Fr_Produto_Serie) then
      Application.CreateForm(TFr_Produto_Serie, Fr_Produto_Serie);
     Fr_Produto_Serie.Tag := 1;
    Fr_Produto_Serie.It_cd_Item := Qr_Itenscpa.fieldByname('ITF_CODIGO').AsInteger;
    Fr_Produto_Serie.It_cd_Produto := Qr_Itenscpa.fieldByname('ITF_CODPRO').AsInteger;
    Fr_Produto_Serie.It_Qt_Produto := Qr_Itenscpa.fieldByname('ITF_QTDE').AsFloat;
    Fr_Produto_Serie.ShowModal;
   End;
end;

procedure TFr_Pedido_Cpa.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
  begin
    It_Inserir := True;
    It_Alterar := True;
    It_Excluir := True;
    It_Faturar := True;
    It_Visualizar := True;
    It_IMPRIMIR   := true;
    it_ficha_financeira:=true;
    It_Aprovar:=true;
  end
  else
  begin
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Faturar    := Fc_HabilitaPermissao(Pc_Menu,'FATURAR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    It_IMPRIMIR   := Fc_HabilitaPermissao(Pc_Menu,'IMPRIMIR','S');
    It_Aprovar   := Fc_HabilitaPermissao(Pc_Menu,'APROVAR','S');
    it_ficha_financeira:= Fc_HabilitaPermissao(Pc_Menu,'FICHA FINANCEIRA','S');
  end;
  SB_Cadastrar.Enabled := It_Inserir;
  Sb_Fich_Fin.Enabled := it_ficha_financeira;
  chbx_aprovados.Enabled:= It_Aprovar;
end;

procedure TFr_Pedido_Cpa.Pc_Limpa_campo_busca;
begin
  E_BuscaCliente.Text:='';
  E_BuscaPedido.Text:='';
end;

procedure TFr_Pedido_Cpa.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    CarregaImagemBotao( SB_Inserir,'INSERIR');
    CarregaImagemBotao( SB_Alterar,'ALTERAR');
    CarregaImagemBotao( SB_Excluir,'EXCLUIR');
    CarregaImagemBotao( SB_Gravar,'GRAVAR');
    CarregaImagemBotao( SB_Cancelar,'CANCELAR');
    CarregaImagemBotao( SB_Pesquisar,'PESQUISAR');
    CarregaImagemBotao( SB_Faturar,'FATURAR');
    CarregaImagemBotao( SB_Imprimir,'IMPRIMIR');
    CarregaImagemBotao( Sb_Sair_0,'SAIR');
    CarregaImagemBotao( SB_Cadastrar,'CADASTRAR');
    CarregaImagemBotao( SB_Buscar,'BUSCAR');
    CarregaImagemBotao( SB_Visualizar,'VISUALIZAR');
    CarregaImagemBotao( Sb_Sair_1,'SAIR');
  END;
end;

procedure TFr_Pedido_Cpa.Pc_FormataTela;
var
   Lc_X: Integer;
   Lc_NameArq: string;
begin
  // Abre arquivo de configuracao
  //Posiciona o Panel de Tabela de Preço
   E_Data.Date := Date;
   for Lc_X := 1 to Pg_Pedido_Cpa.PageCount do
      Pg_Pedido_Cpa.Pages[Lc_X - 1].TabVisible := False;

   ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
   Pg_Pedido_Cpa.ActivePageIndex := 1;

  ChBx_busca_FantasiaClick(sELF);
  chbx_NomeFornecedor.Enabled := false;
  Pc_ImagemBotao;
  Pc_PermissaoBotao('Pedido de Compra');
  Mnu_tarefas.Visible := false;
  IF Fc_Aq_Geral('L','PEDIDOCPA','CRB_TELA_MAXIM','N') = 'S' then
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

procedure TFr_Pedido_Cpa.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
end;

function TFr_Pedido_Cpa.Fc_Valida_impressao: Boolean;
begin
  Result:=true;
  if not ValidaPedidoExistente then
  Begin
    Result:=FALSE;
    exit;
  end;

  if (Qr_ItensCpa.RecordCount = 0) then
  begin
    MensagemPadrao('Mensagems',ATENCAO+EOLN+EOLN+
                   'Pedido sem produto.'+EOLN+
                   'Inclua um produto e tente novamente!'+EOLN,
                  ['OK'],[bEscape],mpInformacao);
    Result:=false;
    exit;
  end;

  if Pedido.Registro.Aprovado ='N' then
  begin
    //Somente quem pode aprovar quem pode imprimir pedidos não aprovados
    if not It_Aprovar then
    begin
      MensagemPadrao('Mensagems',ATENCAO+EOLN+EOLN+
                     'Pedido não aprovado. Seu usuário não tem permissão para imprimi-lo.'+EOLN+
                     'Entre em contato com a pessoa responsável pela aprovação,'+EOLN+
                     ' ou solicite ao administrador esta permissão.'+EOLN,
                    ['OK'],[bEscape],mpInformacao);
      Result:=false;
      exit;
    end;
  end;
end;
procedure TFr_Pedido_Cpa.CadastrodoProdutoClick(Sender: TObject);
Var
  Lc_Form : TFr_Produtos;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TFr_Produtos.Create(nil);
      Lc_Form.Produto.Registro.Codigo := Qr_ItensCpa.FieldByName('ITF_CODPRO').AsInteger;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil( Lc_Form );
      Pc_AbrirItens;
    End;
  end;
end;


procedure TFr_Pedido_Cpa.Pc_PropagarInformacao(Codigo:Integer);
Var
  DI_Original : TControllerDocumentoImportacao;
  AD_Original : TControllerAdicaoImportacao;
  DI_Copia : TControllerDocumentoImportacao;
  AD_Copia : TControllerAdicaoImportacao;
  I : Integer;
Begin
  DI_Original := TControllerDocumentoImportacao.Create(Self);
  DI_Original.Registro.Codigo := Codigo;
  DI_Original.getbyId;

  AD_Original := TControllerAdicaoImportacao.Create(Self);
  AD_Original.Registro.CodigoImportacao := Codigo;
  AD_Original.getList;

  //Deletar
  DI_Original.delete;
  AD_Original.delete;

  DI_Copia := TControllerDocumentoImportacao.Create(Self);
  AD_Copia := TControllerAdicaoImportacao.Create(Self);
  Try
    if (DI_Original.exist) and (AD_Original.Lista.Count >0)  then
    Begin
      while not Qr_ItensCpa.eof  do
      Begin
        //Copia a DI
        with DI_Copia.Registro do
        Begin
          DI_Copia.Clear;
          Codigo            := 0;
          CodigoItem        := Qr_ItensCpa.FieldByName('ITF_CODIGO').asInteger;
          Numero            := DI_Original.Registro.Numero;
          Data              := DI_Original.Registro.Data;
          LocalDesembarque  := DI_Original.Registro.LocalDesembarque;
          CodigoEstado      := DI_Original.Registro.CodigoEstado;
          DataDesembarque   := DI_Original.Registro.DataDesembarque;
          CodigoExportador  := DI_Original.Registro.CodigoExportador;
          DigitoDocumento   := DI_Original.Registro.DigitoDocumento;
          DI_Copia.insere;
        End;
        //Copia a Adição
        for I := 0 to AD_Original.Lista.Count -1 do
        Begin
          with AD_Copia.Registro do
          Begin                                          //[]
            AD_Copia.Clear;
            Codigo := 0;
            CodigoImportacao  := DI_Copia.Registro.Codigo;
            Numero            := AD_Original.Lista[I].Numero;
            Sequencia         := AD_Original.Lista[I].Sequencia;
            CodigoFabricante  := AD_Original.Lista[I].CodigoFabricante;
            ValorDesconto     := AD_Original.Lista[I].ValorDesconto;
            CodigoCompra      := AD_Original.Lista[I].CodigoCompra;
            CodigoItemCompra  := AD_Original.Lista[I].CodigoItemCompra;
            AD_Copia.insere;
          End;
        End;

        Qr_ItensCpa.next;
      End;
    End;
  Finally
    FreeAndNil( DI_Original );
    FreeAndNil( AD_Original );
    FreeAndNil( DI_Copia );
    FreeAndNil( AD_Copia );
  End;
End;

procedure TFr_Pedido_Cpa.Importao1Click(Sender: TObject);
Var
  Form : TFr_Custo_Importacao;
begin
  if not (It_Edicao_Ordem = 'B' ) then
  BEgin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O pedido está sendo editado.'+EOLN+
                   'Grave ou cancele a edição antes acessar a tela.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    exit;
  end;
  Form := TFr_Custo_Importacao.create(Self);
  Form.CodigoPedido := pedido.Registro.Codigo;
  Form.Showmodal;
  FreeAndNil(Form);
  Pc_AtualizaCampos;
  Pc_Totalizador;
  Pc_Gravar;
  Pc_EstadoEdicaoOrdem;
end;

procedure TFr_Pedido_Cpa.InformaesdaDI1Click(Sender: TObject);
Var
  Form : TFr_Info_Dec_Imp;
begin
  Form := TFr_Info_Dec_Imp.Create(Self);
  Try
    Form.It_Cd_Item := Qr_ItensCpa.FieldByname('ITF_CODIGO').AsInteger;
    Form.ShowModal;
  Finally
    if Form.chbx_Todos.Checked then
      Pc_PropagarInformacao( Form.It_Codigo );
    FreeAndNil(Form);
  End;
end;

procedure TFr_Pedido_Cpa.E_Cd_EmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

procedure TFr_Pedido_Cpa.Qr_Itens_AjusteAfterOpen(DataSet: TDataSet);
begin
  (Qr_Itens_Ajuste.FieldByName('ITF_VL_UNIT') as TNumericField).DisplayFormat     := Gb_Casa_Dec_Compra;
  (Qr_Itens_Ajuste.FieldByName('ITF_VL_SUBTOTAL') as TNumericField).DisplayFormat := Gb_Casa_Dec_Compra;
end;

procedure TFr_Pedido_Cpa.Sb_NegocioClick(Sender: TObject);
Var
  Lc_Form : TSeaBusiness;
begin
  Lc_Form := TSeaBusiness.create(nil);
  try
    IF Trim(Dblcb_Negocio.Text) <> '' then
      Lc_Form.CodigoRegistro := Dblcb_Negocio.KeyValue;
    Lc_Form.ShowModal;
  finally
    Dblcb_Negocio.KeyValue := Lc_Form.CodigoRegistro;
    DM.Qr_Negocio.Active := False;
    DM.Qr_Negocio.Active := True;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Pedido_Cpa.Dblcb_NegocioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    Dblcb_Negocio.KeyValue:=Null;
    Pedido.Registro.CodigoNegocio := 0;
    end;
  end;
end;

procedure TFr_Pedido_Cpa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ( (It_Edicao_Ordem = 'I') OR (It_Edicao_Ordem = 'E') )  then
  Begin
    canClose := False;
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'O pedido está sendo editado.'+EOLN+
                   'Grave ou cancele a edição antes de sair da tela.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  end
  else
  Begin
    Pedido.using('L');
  end;
end;

procedure TFr_Pedido_Cpa.E_Cd_EmpresaExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_Cd_Empresa.Text,0);
  If DBLCB_Empresa.CanFocus then DBLCB_Empresa.SetFocus;
end;

procedure TFr_Pedido_Cpa.Sb_Pesq_ClienteClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(2,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    DBLCB_Empresa.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
  end;
end;

end.


