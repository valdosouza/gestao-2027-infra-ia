unit Un_Pagar_Multipla;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, StdCtrls, Mask, Grids, DBGrids, ExtCtrls, DB, Buttons, ComCtrls, STStoredProc, STQuery, Printers, jpeg, Menus, QEdit_Setes, Datasnap.DBClient, Datasnap.Provider, System.Math, Un_Fm_FormaPagto, Un_Fm_ListaContaBancaria, STDataSet, ControllerBoleto;


type
  TFr_Pagar_Multipla = class(TForm)
    Pg_Controle: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    Label4: TLabel;
    E_BuscaPedido: TEdit_Setes;
    E_Busca_Empresa: TEdit;
    E_BuscaNota: TEdit;
    TabSheet4: TTabSheet;
    Panel3: TPanel;
    Label35: TLabel;
    E_VLT_Cheque: TEdit_Setes;
    StrGrd_Cheque: TStringGrid;
    tbs_boleto: TTabSheet;
    Panel4: TPanel;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    E_BuscaBoleto: TEdit;
    E_BuscaBoletoEmpresa: TEdit;
    Panel2: TPanel;
    Pnl_Total: TPanel;
    Label23: TLabel;
    Label14: TLabel;
    Label6: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label24: TLabel;
    E_VL_Pagar: TEdit_Setes;
    E_VL_Juros: TEdit_Setes;
    E_VL_Mora: TEdit_Setes;
    E_VL_Desconto: TEdit_Setes;
    E_VL_Pago: TEdit_Setes;
    Panel1: TPanel;
    Qr_Parcelas: TSTQuery;
    Ds_Parcelas: TDataSource;
    Qr_Boleto: TSTQuery;
    Ds_Qr_Boleto: TDataSource;
    Qr_Acao: TSTQuery;
    PpM_Duplicata: TPopupMenu;
    Label3: TLabel;
    E_BuscaFinanceiro: TEdit;
    Ds_ContaBancaria: TDataSource;
    Qr_Cheques: TSTQuery;
    Ds_Cheque: TDataSource;
    tb_pesq_ChequeTerceiro: TTabSheet;
    Qr_MostraSemDestino: TSTQuery;
    Ds_Qr_MostraSemDestino: TDataSource;
    Sb_Terceiro: TSpeedButton;
    GroupBox1: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    E_BuscaBanco: TEdit_Setes;
    E_BuscaAgencia: TEdit;
    E_BuscaCheque: TEdit_Setes;
    E_BuscaValor: TEdit_Setes;
    E_BuscaEmitente: TEdit;
    DBGrid3: TDBGrid;
    Sb_VoltarChq_Terc: TSpeedButton;
    Sb_Rela_Cheque: TSpeedButton;
    Sb_BuscarCheque: TSpeedButton;
    Up_Financerio: TSTQuery;
    RetiraDestinao1: TMenuItem;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    Rg_Data: TRadioGroup;
    Observaes1: TMenuItem;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    E_Dt_Ini_Bol: TDateTimePicker;
    E_Dt_Fim_Bol: TDateTimePicker;
    E_Dt_Ini_Chq: TDateTimePicker;
    E_Dt_Fim_Chq: TDateTimePicker;
    SB_Sair_0: TSpeedButton;
    Sb_Baixar: TSpeedButton;
    SB_Boleto: TSpeedButton;
    Sb_Cheque: TSpeedButton;
    Sb_Destinar: TSpeedButton;
    Sb_Negociar: TSpeedButton;
    Sb_GravaCheque: TSpeedButton;
    Sb_ExcluiCheque: TSpeedButton;
    Sb_InsereCheque: TSpeedButton;
    Sb_AlteraCheque: TSpeedButton;
    Sb_VoltaCheque: TSpeedButton;
    Sb_CancelaCheque: TSpeedButton;
    ChBx_Periodo: TCheckBox;
    ChBx_Periodo_b: TCheckBox;
    Chbx_Periodo_C: TCheckBox;
    E_Busca_Cd_Empresa: TEdit;
    L_CodigoFornecedor: TLabel;
    E_Dt_Pagto: TDateTimePicker;
    Sb_Resumo: TSpeedButton;
    Lb_Saldo_Parcial: TLabel;
    E_Vl_Saldo: TLabel;
    DBG_Boleto: TDBGrid;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label1: TLabel;
    E_Banco: TEdit_Setes;
    E_Agencia: TEdit_Setes;
    E_NumChq: TEdit_Setes;
    E_VL_Cheque: TEdit_Setes;
    E_Emitente: TEdit;
    E_DataCheque: TDateTimePicker;
    E_ContaCorrente: TEdit;
    Label9: TLabel;
    AplicarPlanoContas1: TMenuItem;
    Label36: TLabel;
    Cb_Situacao: TComboBox;
    AtivarInativar1: TMenuItem;
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Sb_Pesq_Empresa: TSpeedButton;
    Fm_TipoCobranca: TFm_FormaPagto;
    Fm_TipoPagamento: TFm_FormaPagto;
    DetalhesdoPedido1: TMenuItem;
    Panel5: TPanel;
    SB_Add_Tudo: TSpeedButton;
    SB_Adicionar: TSpeedButton;
    SB_Retirar: TSpeedButton;
    SB_Retirar_Tudo: TSpeedButton;
    Sb_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Buscar: TSpeedButton;
    Dbg_Parcela: TDBGrid;
    Dbg_Duplicatas: TDBGrid;
    cds_Parcelas: TClientDataSet;
    cds_duplicatas: TClientDataSet;
    ds_duplicatas: TDataSource;
    cds_ParcelasFIN_CODIGO: TIntegerField;
    cds_ParcelasNFL_NUMERO: TWideStringField;
    cds_ParcelasNFL_MODELO: TWideStringField;
    cds_ParcelasPED_NUMERO: TIntegerField;
    cds_ParcelasFIN_NUMERO: TWideStringField;
    cds_ParcelasFIN_DT_VENCIMENTO: TDateField;
    cds_ParcelasFIN_NR_PARCELA: TIntegerField;
    cds_ParcelasFIN_CODEMP: TIntegerField;
    cds_ParcelasEMP_FANTASIA: TWideStringField;
    cds_ParcelasEMP_NOME: TWideStringField;
    cds_ParcelasFIN_VL_PARCELA: TBCDField;
    cds_ParcelasFIN_BAIXA: TWideStringField;
    cds_ParcelasFIN_SITUACAO: TWideStringField;
    cds_ParcelasFIN_VL_PAGO: TBCDField;
    cds_ParcelasFIN_CODQTC: TIntegerField;
    cds_ParcelasFIN_CODFPG: TIntegerField;
    cds_ParcelasPED_CODIGO: TIntegerField;
    cds_ParcelasNFL_CODIGO: TIntegerField;
    cds_ParcelasFIN_TIPO: TWideStringField;
    cds_ParcelasFIN_DT_PAGTO: TDateField;
    cds_ParcelasFIN_OPERACAO: TWideStringField;
    cds_ParcelasFIN_ETAPA: TWideStringField;
    cds_ParcelasFIN_CODMHA: TIntegerField;
    cds_ParcelasFIN_CODCHQ: TIntegerField;
    cds_ParcelasPLC_CODIGO: TIntegerField;
    cds_ParcelasPLC_DESCRICAO: TWideStringField;
    cds_ParcelasFIN_DT_REPROGRAMADA: TDateField;
    cds_duplicatasFIN_CODIGO: TIntegerField;
    cds_duplicatasNFL_NUMERO: TWideStringField;
    cds_duplicatasNFL_MODELO: TWideStringField;
    cds_duplicatasPED_NUMERO: TIntegerField;
    cds_duplicatasFIN_NUMERO: TWideStringField;
    cds_duplicatasFIN_DT_VENCIMENTO: TDateField;
    cds_duplicatasFIN_NR_PARCELA: TIntegerField;
    cds_duplicatasFIN_CODEMP: TIntegerField;
    cds_duplicatasEMP_FANTASIA: TWideStringField;
    cds_duplicatasEMP_NOME: TWideStringField;
    cds_duplicatasFIN_VL_PARCELA: TBCDField;
    cds_duplicatasFIN_BAIXA: TWideStringField;
    cds_duplicatasFIN_SITUACAO: TWideStringField;
    cds_duplicatasFIN_VL_PAGO: TBCDField;
    cds_duplicatasFIN_CODQTC: TIntegerField;
    cds_duplicatasFIN_CODFPG: TIntegerField;
    cds_duplicatasPED_CODIGO: TIntegerField;
    cds_duplicatasNFL_CODIGO: TIntegerField;
    cds_duplicatasFIN_TIPO: TWideStringField;
    cds_duplicatasFIN_DT_PAGTO: TDateField;
    cds_duplicatasFIN_OPERACAO: TWideStringField;
    cds_duplicatasFIN_ETAPA: TWideStringField;
    cds_duplicatasFIN_CODMHA: TIntegerField;
    cds_duplicatasFIN_CODCHQ: TIntegerField;
    cds_duplicatasPLC_CODIGO: TIntegerField;
    cds_duplicatasPLC_DESCRICAO: TWideStringField;
    cds_duplicatasFIN_DT_REPROGRAMADA: TDateField;
    Pg_Observacao: TPageControl;
    TabSheet5: TTabSheet;
    Panel9: TPanel;
    Panel6: TPanel;
    Label2: TLabel;
    E_Vl_Receber: TLabel;
    Panel11: TPanel;
    Label13: TLabel;
    E_Vl_Cred_Ceder: TLabel;
    Panel12: TPanel;
    Label37: TLabel;
    E_Vl_Total_Receber: TLabel;
    Panel13: TPanel;
    Label10: TLabel;
    E_Vl_Recebido: TLabel;
    Panel14: TPanel;
    Lb_Close_totalizador: TLabel;
    Lb_Titulo_totalizador: TLabel;
    cds_ParcelasFIN_AUTORIZADO: TStringField;
    cds_duplicatasFIN_AUTORIZADO: TStringField;
    Rg_Doc_Authorization: TRadioGroup;
    Autorizarselecionado1: TMenuItem;
    pnl_boleto_bottom: TPanel;
    Sb_GravaBoleto: TSpeedButton;
    Sb_ExcluiBoleto: TSpeedButton;
    Sb_InsereBoleto: TSpeedButton;
    Sb_AlteraBoleto: TSpeedButton;
    Sb_CancelaBoleto: TSpeedButton;
    Sb_BuscaBoleto: TSpeedButton;
    Sb_VoltaBoleto: TSpeedButton;
    pnl_boleto_fundo: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    E_BDesconto: TEdit;
    E_NumBoleto: TEdit;
    DBRG_Descontada: TRadioGroup;
    Fm_ListaContaBancaria: TFm_ListaContaBancaria;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_PesquisarClick(Sender: TObject);
    procedure E_VL_JurosExit(Sender: TObject);
    procedure E_VL_MoraExit(Sender: TObject);
    procedure E_VL_DescontoExit(Sender: TObject);
    procedure E_VL_JurosEnter(Sender: TObject);
    procedure E_VL_MoraEnter(Sender: TObject);
    procedure E_VL_DescontoEnter(Sender: TObject);
    procedure SB_Retirar_TudoClick(Sender: TObject);
    procedure SB_RetirarClick(Sender: TObject);
    procedure Qr_NegociacaoAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_ChequeClick(Sender: TObject);
    procedure SB_BoletoClick(Sender: TObject);
    procedure E_VL_ChequeExit(Sender: TObject);
    procedure StrGrd_ChequeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_InsereBoletoClick(Sender: TObject);
    procedure Sb_AlteraBoletoClick(Sender: TObject);
    procedure Sb_ExcluiBoletoClick(Sender: TObject);
    procedure Sb_GravaBoletoClick(Sender: TObject);
    procedure Sb_CancelaBoletoClick(Sender: TObject);
    procedure Sb_BuscaBoletoClick(Sender: TObject);
    procedure Sb_VoltaBoletoClick(Sender: TObject);
    procedure DBRG_DescontadaClick(Sender: TObject);
    procedure Sb_GravaChequeClick(Sender: TObject);
    procedure Sb_InsereChequeClick(Sender: TObject);
    procedure Sb_AlteraChequeClick(Sender: TObject);
    procedure Sb_CancelaChequeClick(Sender: TObject);
    procedure Sb_VoltaChequeClick(Sender: TObject);
    procedure Sb_DestinarClick(Sender: TObject);
    procedure Sb_ExcluiChequeClick(Sender: TObject);
    procedure Sb_BaixarClick(Sender: TObject);
    procedure E_VL_PagoExit(Sender: TObject);
    procedure DBG_BoletoDblClick(Sender: TObject);
    procedure Sb_VoltarChq_TercClick(Sender: TObject);
    procedure Sb_BuscarChequeClick(Sender: TObject);
    procedure Sb_TerceiroClick(Sender: TObject);
    procedure Sb_Rela_ChequeClick(Sender: TObject);
    procedure StrGrd_ChequeDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Ds_Qr_MostraSemDestinoStateChange(Sender: TObject);
    procedure tbs_boletoShow(Sender: TObject);
    procedure RetiraDestinao1Click(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure Sb_NegociarClick(Sender: TObject);
    procedure E_VL_PagoChange(Sender: TObject);
    procedure SB_AdicionarClick(Sender: TObject);
    procedure SB_Add_TudoClick(Sender: TObject);
    procedure DBLCB_formaPagtoClick(Sender: TObject);
    procedure Observaes1Click(Sender: TObject);
    procedure Sb_InserirClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure ChBx_Periodo_bClick(Sender: TObject);
    procedure Chbx_Periodo_CClick(Sender: TObject);
    procedure tb_pesq_ChequeTerceiroShow(Sender: TObject);

    procedure Sb_ResumoClick(Sender: TObject);
    procedure Rg_DataClick(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AplicarPlanoContas1Click(Sender: TObject);
    procedure Cb_SituacaoChange(Sender: TObject);
    procedure AtivarInativar1Click(Sender: TObject);
    procedure E_Busca_Cd_EmpresaExit(Sender: TObject);
    procedure Sb_Pesq_EmpresaClick(Sender: TObject);
    procedure Fm_TipoPagamentoDBLCB_FormaPagtoClick(Sender: TObject);
    procedure DetalhesdoPedido1Click(Sender: TObject);
    procedure Lb_Close_totalizadorClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Dbg_ParcelaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Dbg_DuplicatasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Rg_Doc_AuthorizationClick(Sender: TObject);
    procedure Autorizarselecionado1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Qr_BoletoAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    FBoleto : TControllerBoleto;
    FEditionStateBoleto : String;
    procedure BuscaAutomatica;
    //Boleto
    procedure AtivarCarteiraCobranca;
    procedure ShowDataBoleto;
    procedure EditionControlBoleto;
    //Boleto - Isnerir
    function ValidaInsertBoleto:Boolean;
    procedure InsertBoleto;
    //Boleto - Change
    function ValidateChangeBoleto:boolean;
    procedure ChangeBoleto;
    //Boleto - Delete
    function ValidateDeleteBoleto:boolean;
    procedure DeleteBoleto;
    //Boleto - save
    function ValidateSaveBoleto:boolean;
    procedure SaveBoleto;
    //Boleto - Cancel
    function ValidateCancelBoleto:boolean;
    procedure CancelBoleto;


    procedure TotalizaPagar;
    procedure TotalizaBaixa;
    function ValidateAutorizacaoDocumento:Boolean;
    procedure AutorizacaoDocumento;
    function ValidaSelecaoUnicaParaBaixa:Boolean;
    function ValidaSelecaoTodaParaBaixa:Boolean;
  public
    { Public declarations }
    It_Inserir  :Boolean;
    It_Alterar  :Boolean;
    It_Excluir  :Boolean;
    It_Visualizar :Boolean;
    It_Oper_Reg      : String;
    It_Cd_Financeiro : Integer;
    It_Cd_Empresa    : Integer;
    It_Data          : TDate;
    It_Cd_Pedido     : Integer;
    It_Cd_Nota       : Integer;
    It_Cd_FmaPagto   : Integer;
    It_Prazo         : String;
    It_Dt_Vencimento : TDate;
    It_Nr_Financeiro : String;
    It_Vl_Parcela: Currency;
    It_Nr_Parcela    : Integer;
    It_Vl_Juros: Currency;
    It_Vl_Mora: Currency;
    It_Vl_Desconto: Currency;
    It_Vl_Pago: Currency;
    It_Dt_Pago       : TDate;
    It_Dt_Baixa      : TDate;
    It_Baixa         : String;
    It_Cta_Credito   : Integer;
    It_cta_Debito    : Integer;
    It_Tipo          : String;
    It_Situacao      : String;
    It_Cd_Quitacao   : Integer;
    It_Operacao      : String;
    It_Etapa         : String;
    It_cd_Cheque     : Integer;

    //Controle da Baixa no Geral
    It_Vl_Baixa: Currency;
    It_Vl_Pagto: Currency;
    It_Vl_Credito: Currency;
    It_Cta_Bancaria : Integer;

    // Manipulação dos Cheques
    It_Cheque : Integer;
    it_Oper_Reg_Chq : String;
    it_Reg_Atl_chq : Integer;

    // Manipulação dos Duplicatas

    It_TipoTransacao : String;
    it_BaixaOK : Boolean;

    //Processo de Interface
    procedure Pc_FormataTela;
    procedure Pc_IniciaVariaveis;
    procedure Pc_ImagemBotao;
    //Processo de Baixa
    procedure Pc_Processo_Baixa;
    function Fc_validar_Baixa():Boolean;
    function Fc_Verificar_Baixa_Parcela: Boolean;
    procedure Pc_Baixar_Duplicatas;

    procedure Pc_Retirar_Destinacao(Pc_cd_Financeiro:Integer);
    procedure Pc_Gerar_Baixa_Parcial(Pc_Vl_Saldo:Real);
    procedure Pc_Baixar_Valor;
    procedure Pc_Finalizar_Baixa;

    //Provesso de movimento Financeiro
    procedure Pc_Processo_Movim_Financeiro;
    function Fc_Preencher_Historico():String;
    procedure Pc_Lanca_Caixa;
    procedure Pc_Lanca_Banco;

    //Escolha das Parcelas
    procedure Pc_Define_Valores_Baixa;
    procedure Pc_Ativar_Tabelas;
    procedure Pc_Buscar_Parcela(Pc_Tipo : String);
    procedure Pc_Preencher_Parcelas;

    //Processo com os Cheques
    procedure PC_Buscar_Cheque(Pc_Tipo : String);
    procedure Pc_Limpar_Campo_Cheque;
    procedure Pc_Deletar_Cheque;
    procedure Pc_Preencher_Campo_Cheque;
    procedure Pc_Liberar_Campo_Cheque(Pc_Tipo : Boolean);
    procedure Pc_Somar_Cheque;
    procedure Pc_Buscar_Chq_Terceiro;
    Function Fc_ValidaGravacaoCheque():Boolean;
    //Processo com os boletos
    procedure Pc_Buscar_Boleto(Pc_Tipo : String);
    procedure Pc_Verificar_Situacao;

    //mostra a tela quando a duplicata for baixad
    procedure Pc_Mostrar_Baixados;

    procedure Pc_Destinar(Pc_Tipo : String);
    procedure Pc_RetiraDestinacao;

    procedure Pc_Excluir_Contas_Pagar;
    //Processo dos botões
    procedure Pc_Adicionar;
    procedure Pc_Adicionar_Tudo;
    procedure Pc_Ativar_Botoes;
    //Micelaneia
    Procedure Pc_Definir_Grade_Cheque;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    function  Fc_ValidaAdicionaBaixa():boolean;
    function  Fc_ValidaOperacaoPArcela():boolean;
    function Fc_Valida_Negociacao: Boolean;
    procedure posicionaTotalizador;
end;
var
  Fr_Pagar_Multipla: TFr_Pagar_Multipla;

implementation

uses     Un_DM, UN_MSG, UN_Fin_Baixado, Un_Lanca_Caixa, Un_Lanca_Banco, UN_Lanca_Pagto, UN_Sistema, Un_Negociar, UN_Principal, env, Types, Un_Fin_Edita, Un_Fc_Sored_Procedures, un_Obs_nfe, Un_Regra_Negocio, Un_Lanca_PlanoContas, RN_PlanoContas, RN_Financeiro, RN_FormaPagto, RN_Permissao, RN_Fornecedor, RN_Compras, RN_Empresa, RI_MovimentoFinanceiro, ControllerCheque, RN_NotaFiscal, RN_NotaFiscalConsumidor, tas_financial_authorization;
{$R *.dfm}


procedure TFr_Pagar_Multipla.Pc_Baixar_Valor;
Begin
  Pc_Financeiro(dm.IB_Transacao,
                It_Oper_Reg,
                It_Cd_Financeiro,
                It_Cd_Empresa,
                It_DATA,
                It_Cd_Pedido,
                It_Cd_Nota,
                It_Cd_FmaPagto,
                It_Prazo,
                It_Dt_Vencimento,
                It_Nr_Financeiro,
                It_Vl_Parcela,
                It_Vl_Juros,
                It_Vl_Mora,
                It_Vl_Desconto,
                It_Vl_Pago,
                It_Dt_Pago,
                It_Dt_Baixa,
                It_Baixa,
                It_Nr_Parcela,
                It_Tipo,
                It_Situacao,
                It_Cd_Quitacao,
                It_Operacao,
                It_Etapa,
                It_cd_Cheque);
end;

function TFr_Pagar_Multipla.Fc_Preencher_Historico():String;
Var
  Lc_I : Integer;
Begin
  Result := '';
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  Begin
    if Length(cds_duplicatasPED_NUMERO.AsString) > 0 then
    Begin
      if cds_duplicatas.bof then
        Result := 'COMPRA Nº : '+ cds_duplicatasPED_NUMERO.AsString
      else
        Result := Result + ' , ' + cds_duplicatasPED_NUMERO.AsString;
    end
    else
    Begin
      if Length(cds_duplicatasNFL_NUMERO.AsString) > 0 then
      Begin
        //se for nota preenche aqui
        if cds_duplicatas.bof then
          Result := 'COMPRA Nº : '+ cds_duplicatasNFL_NUMERO.AsString
        else
          Result := Result + ' , ' + cds_duplicatasNFL_NUMERO.AsString;
      end
      else
      Begin
        //se for Duplicata
        if cds_duplicatas.bof then
          Result := 'COMPRA Nº : '+ cds_duplicatasFIN_NUMERO.AsString
        else
          Result := Result + ' , ' + cds_duplicatasFIN_NUMERO.AsString
      end;
    end;
    cds_duplicatas.next;
  end;
  Result := Result + ' , ' + cds_duplicatasEMP_NOME.AsString;

end;

procedure TFr_Pagar_Multipla.Pc_Lanca_Caixa;
Var
  Lc_VL_Credito, Lc_VL_Debito:Real;
  Lc_VL_Pago : Real;
  LfFormCaixa : TFr_Lanca_Caixa;
Begin
  Lc_VL_Pago := StrToFloatDef(E_VL_Pago.Text,0);
  // Verifica se os campos estão zerados
  if ( Lc_VL_Pago <> 0 ) then
  Begin
    if ( Lc_VL_Pago > 0 ) then
    begin
      Lc_VL_Credito := 0;
      Lc_VL_Debito := Lc_VL_Pago;
    end
    else
    Begin
      Lc_VL_Credito := Lc_VL_Pago * -1;
      Lc_VL_Debito := 0;
    End;

    if Fc_VErificaCaixaAberto(True) then
    Begin
      Try
        LfFormCaixa := TFr_Lanca_Caixa.Create(nil);
        LfFormCaixa.Codigo           := 0;
        LfFormCaixa.Quitacao         := It_Cd_Quitacao;
        LfFormCaixa.Caption          := '';
        LfFormCaixa.Operacao         := 'I';
        LfFormCaixa.PlanoResultado   := cds_duplicatasPLC_CODIGO.AsInteger;
        LfFormCaixa.PlanoCentroCusto := cds_duplicatasPLC_CODIGO.AsInteger;
        LfFormCaixa.Historico        := Copy(Fc_Preencher_Historico,1,100);
        LfFormCaixa.ValorCredito     := Lc_VL_Credito;
        LfFormCaixa.ValorDebito      := Lc_VL_Debito;
        LfFormCaixa.FormaPagto       := Fm_TipoPagamento.DBLCB_formaPagto.KeyValue;
        LfFormCaixa.Mensagem         := True;
        LfFormCaixa.LiberaCampo      := False;
        LfFormCaixa.AutoFill;
        LfFormCaixa.ShowModal;
        It_Vl_Pago := StrToFloatDef(LfFormCaixa.E_Credito.Text,0);
        it_BaixaOK := LfFormCaixa.Resultado;
      Finally
        FreeAndNil(LfFormCaixa);
      End;
    End;
  End;
end;

procedure TFr_Pagar_Multipla.Pc_Lanca_Banco;
Var
  Lc_Cta_Bancaria : Integer;
  Lc_VL_Credito, Lc_VL_Debito:Real;
  Lc_VL_Pago : Real;
  LfFormBanco : TFr_Lanca_Banco;
Begin
  Lc_VL_Pago := StrToFloatDef(E_VL_Pago.Text,0);
  // Verifica se os campos estão zerados
  if ( Lc_VL_Pago <> 0 ) then
  Begin
    if ( Lc_VL_Pago > 0 ) then
    begin
      Lc_VL_Credito := 0;
      Lc_VL_Debito := Lc_VL_Pago;
    end
    else
    Begin
      Lc_VL_Credito := Lc_VL_Pago * -1;
      Lc_VL_Debito := 0;
    End;
    Lc_Cta_Bancaria := 0;
    if FBoleto.exist then
      Lc_Cta_Bancaria := FBoleto.Registro.CodCtb;

    Try
      LfFormBanco := TFr_Lanca_Banco.Create(nil);
      LfFormBanco.Codigo           := 0;
      LfFormBanco.Quitacao         := It_Cd_Quitacao;
      LfFormBanco.Data             := Date;
      LfFormBanco.ContaCorrente    := Lc_Cta_Bancaria;
      LfFormBanco.Operacao         := 'I';
      LfFormBanco.PlanoResultado   := cds_duplicatasPLC_CODIGO.AsInteger;
      LfFormBanco.PlanoCentroCusto := cds_duplicatasPLC_CODIGO.AsInteger;
      LfFormBanco.Historico        := Copy(Fc_Preencher_Historico,1,100);
      LfFormBanco.HistoricoBanco   := 0;
      LfFormBanco.ValorCredito     := Lc_Vl_Credito;
      LfFormBanco.ValorDebito      := Lc_Vl_DEbito;
      LfFormBanco.FormaPagto       := Fm_TipoPagamento.DBLCB_formaPagto.KeyValue;
      LfFormBanco.Mensagem         := True;
      LfFormBanco.LiberaCampo      := False;
      LfFormBanco.AutoFill;
      LfFormBanco.ShowModal;
      it_BaixaOK := LfFormBanco.Resultado;
    Finally
      FreeAndNil(LfFormBanco);
    End;
    // Verifica se a conta utilizada foi a mesma conta informada no boleto, caso contrario altera
    if FBoleto.exist then
      if Lc_Cta_Bancaria <> FBoleto.Registro.CodCtb then
      BEgin
        FBoleto.Registro.CodCtb := Lc_Cta_Bancaria;
        FBoleto.save;
      End;
  end;
end;

function TFr_Pagar_Multipla.Fc_validar_Baixa():Boolean;
Begin
  Result := true;
  if not ((Fc_Tb_Geral('L','FIN_VAL_PAGTO_CP','S') = 'S')) then  exit;

  if (Fm_TipoPagamento.DBLCB_formaPagto.Text = 'BOLETO') and (Pg_Controle.ActivePageIndex <> 2) then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Verifique os dados do boleto.'+EOLN+
                   'Os dados devem ser visualizados para a baixa.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  end;


  if (StrtofloatDef(E_VL_Desconto.Text,0)>0) and (StrtofloatDef(E_VL_Pago.Text,0)=0) and (StrtofloatDef(E_Vl_Saldo.Caption,0)>0) then
    Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Não é possivel executar a baixa.'+EOLN+
                   'Conceder desconto, com valor pago igual '+EOLN+
                   'a "0,00"(zero), não pode gerar baixa parcial.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    if E_VL_Desconto.CanFocus then E_VL_Desconto.SetFocus;
    exit;
    end;
    
  if (Fm_TipoPagamento.DBLCB_formaPagto.Text = 'CHEQUE') and (Pg_Controle.ActivePageIndex <> 1) then
    Begin
        MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                       'Verifique os dados do(s) cheque(s).'+EOLN+
                       'Os dados devem ser visualizados para a baixa.'+EOLN,
                      ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
    end;

  if ((Fm_TipoPagamento.DBLCB_formaPagto.Text = 'CARTÃO') OR (Fm_TipoPagamento.DBLCB_formaPagto.Text = 'CARTAO') )and (Pg_Controle.ActivePageIndex <> 3) then
    Begin
        MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                       'Verifique os dados do cartão.'+EOLN+
                       'Os dados devem ser visualizados para a baixa.'+EOLN,
                      ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
    end;

  if Fc_Verificar_Baixa_Parcela then
    begin
    Result := False;
    exit;
    end;    

end;

procedure TFr_Pagar_Multipla.Pc_Excluir_Contas_Pagar;
Var
 Lc_Sql_Txt : String;
Begin
  try
    with Qr_Acao do
    Begin
      //Contas a Receber
      Active := False;
      Transaction := DM.IB_Transacao;
      SQL.Clear;
      Lc_Sql_Txt := 'DELETE FROM TB_FINANCEIRO '+
                   'WHERE (FIN_CODIGO =:FIN_CODIGO) ';
      SQL.Add(Lc_Sql_Txt);
      ParamByName('FIN_CODIGO').AsInteger := cds_ParcelasFIN_CODIGO.AsInteger;
      ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      //Nota
      IF (cds_ParcelasFIN_TIPO.AsString = 'PM') then
      Begin
        Active := False;
        Transaction := DM.IB_Transacao;
        SQL.Clear;
        Lc_Sql_Txt := 'DELETE FROM TB_NOTA_FISCAl '+
                      'WHERE (NFL_CODIGO =:NFL_CODIGO) ';
        SQL.Add(Lc_Sql_Txt);
        ParamByName('NFL_CODIGO').AsInteger := cds_ParcelasNFL_CODIGO.AsInteger;
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      End;
    End;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Pagar_Multipla.Pc_RetiraDestinacao;
Var
  Lc_Sqltxt : String;
Begin
  if not (Cb_Situacao.ItemIndex = 1) then exit;
  with Qr_Acao do
    Begin
    //Retira a destinação dos Cheque
    Active := False;
    Transaction := DM.IB_Transacao;
    SQL.Clear;
    Lc_Sqltxt := 'UPDATE TB_CHEQUES SET '+
                 '  CHQ_QT_PAG = 0 '+
                 'WHERE (CHQ_QT_PAG =:CHQ_QT_PAG) ';
    SQL.Add(Lc_Sqltxt);
    ParamByName('CHQ_QT_PAG').AsInteger := cds_ParcelasFIN_CODQTC.AsInteger;
    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
   
    //Retira a destinação da Conta
    Active := False;
    Transaction := DM.IB_Transacao;
    SQL.Clear;
    Lc_Sqltxt := 'UPDATE TB_FINANCEIRO '+
                 'SET '+
                 '  FIN_CODQTC = 0, '+
                 '  FIN_SITUACAO = ''N'', '+
                 '  FIN_ETAPA = ''N'' '+
                 'WHERE (FIN_CODIGO =:FIN_CODIGO) ';
    SQL.Add(Lc_Sqltxt);
    ParamByName('FIN_CODIGO').AsInteger := cds_ParcelasFIN_CODIGO.AsInteger;
    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    end;
  Pc_Buscar_Parcela('N');
end;

procedure TFr_Pagar_Multipla.Pc_Buscar_Chq_Terceiro;
var
  SqlTxt : string;
  Lc_Emitente, Lc_Banco, Lc_Agencia,Lc_Cheque, Lc_Valor : boolean;
begin
  SqlTxt := '';
  Screen.Cursor:=crHourGlass;
  Qr_MostraSemDestino.Close;
  Qr_MostraSemDestino.Sql.Clear;
  SqlTxt := 'SELECT DISTINCT *'+
            'FROM TB_CHEQUES Tb_cheques '+
            'WHERE ((CHQ_QT_PAG IS NULL) OR (CHQ_QT_PAG =0)) AND (CHQ_TIPO = ''T'') AND '+
            '((CHQ_ESTADO= ''N'') OR (CHQ_ESTADO= ''R'')) ';

  if E_BuscaEmitente.Text = '' then Lc_Emitente := False else Lc_Emitente := True;
  if E_BuscaBanco.Text = '' then Lc_Banco := False else Lc_Banco := True;
  if E_BuscaAgencia.Text = '' then Lc_Agencia := False else Lc_Agencia := True;
  if E_BuscaCheque.Text = '' then Lc_Cheque := False else Lc_Cheque := True;

  if E_BuscaValor.Text = '' then Lc_Valor := False else Lc_Valor := True;

  if Lc_Emitente then sqltxt := sqltxt + 'AND CHQ_EMITENTE LIKE :CHQ_EMITENTE ';
  if Lc_Banco    then sqltxt := sqltxt + 'AND CHQ_BANCO =:CHQ_BANCO ';
  if Lc_Agencia  then sqltxt := sqltxt + 'AND CHQ_AGENCIA =:CHQ_AGENCIA ';
  if Lc_Cheque   then sqltxt := sqltxt + 'AND CHQ_NUMERO =:CHQ_NUMERO ';
  if Chbx_Periodo_C.Checked then
    sqltxt := sqltxt + ' AND CHQ_DATA BETWEEN :CHQ_DATAINI AND :CHQ_DATAFIM ';
  if Lc_Valor    then sqltxt := sqltxt + 'AND CHQ_VALOR =:CHQ_VALOR ';

  Qr_MostraSemDestino.SQL.Add(SqlTxt + ' ORDER BY CHQ_EMITENTE');


  if Lc_Emitente then Qr_MostraSemDestino.ParamByName('CHQ_EMITENTE').AsString := '%'+E_BuscaEmitente.Text+'%';
  if Lc_Banco    then Qr_MostraSemDestino.ParamByName('CHQ_BANCO').AsString := E_BuscaBanco.Text;
  if Lc_Agencia  then Qr_MostraSemDestino.ParamByName('CHQ_AGENCIA').AsString := E_BuscaAgencia.Text;
  if Lc_Cheque   then Qr_MostraSemDestino.ParamByName('CHQ_NUMERO').AsString := E_BuscaCheque.Text;
  if Chbx_Periodo_C.Checked then
    Begin
    Qr_MostraSemDestino.ParamByName('CHQ_DATAINI').Asdate := E_Dt_Ini_Chq.Date;
    Qr_MostraSemDestino.ParamByName('CHQ_DATAFIM').AsDate := E_Dt_Fim_Chq.Date;
    end;
  if Lc_Valor    then Qr_MostraSemDestino.ParamByName('CHQ_VALOR').AsCurrency := StrToFloatDef(E_BuscaValor.Text,0);

  Qr_MostraSemDestino.Open;

  Screen.Cursor:=crDefault;
end;


procedure TFr_Pagar_Multipla.Pc_Finalizar_Baixa;
Var
  Lc_I, Lc_J : Integer;
Begin
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
  Pg_Controle.ActivePageIndex := 0;
  Pc_Ativar_Tabelas;
  Pc_LimpaStringGrid(StrGrd_Cheque);
  It_Cheque := 0;
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.EmptyDataSet;

  It_Oper_Reg      := 'I';
  It_Cd_Financeiro := 0;
  It_Cd_Empresa    := 0;
  It_Cd_Pedido     := 0;
  It_Cd_Nota       := 0;
  It_Cd_FmaPagto   := 0;
  It_Prazo         := '000 - VISTA';
  It_Nr_Financeiro := '1';
  It_Vl_Parcela    := 0;
  It_Nr_Parcela    := 0;
  It_Vl_Juros      := 0;
  It_Vl_Mora       := 0;
  It_Vl_Desconto   := 0;
  It_Vl_Pago       := 0;
  It_Baixa         := 'N';
  It_cta_Credito   := 0;
  It_cta_Debito    := 0;
  It_Tipo          := 'PA';
  It_Situacao      := 'N';
  It_Operacao      := 'D';
  It_Etapa         := 'N';
  It_cd_Cheque     := 0;
  It_Vl_Credito    := 0;
  It_Cheque := 0;
  It_Cd_Quitacao := 0;
  //Controle da Baixa no Geral
  It_Vl_Baixa    := 0;
  E_VL_Juros.Text := '0,00';
  E_VL_Mora.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
  E_Vl_Pago.Text := '0,00';
  E_Vl_Saldo.Caption := '0,00';
  Pc_Ativar_Botoes;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaPagar;
  TotalizaBaixa;
end;


procedure TFr_Pagar_Multipla.Pc_Verificar_Situacao;
Begin
  if cds_ParcelasFIN_BAIXA.AsString = 'S' then
  Begin
    It_TipoTransacao := 'BAIXADAS';
    Pc_Mostrar_Baixados;
  end
  else
  Begin
    if cds_ParcelasFIN_SITUACAO.AsString = 'D' then
    Begin
      It_TipoTransacao := 'DESTINADAS';
      It_Cd_Quitacao := cds_ParcelasFIN_CODQTC.AsInteger;
      It_Cd_FmaPagto := cds_ParcelasFIN_CODQTC.AsInteger;
      It_Cd_Empresa := cds_ParcelasFIN_CODEMP.AsInteger;
    end
    else
    Begin
      It_TipoTransacao := 'NORMAL';
      It_Cd_Quitacao := 0;
    end;
  end;
End;

procedure TFr_Pagar_Multipla.posicionaTotalizador;
Var
  I : Integer;
begin
  For I := 1 to Pg_Observacao.PageCount do Pg_Observacao.Pages[I-1].TabVisible:=False;
  Pg_Observacao.Top := Dbg_Parcela.Top;
  Pg_Observacao.Left := trunc((self.Width - Pg_Observacao.Width)/2);
  Pg_Observacao.ActivePageIndex := 0;
  Pg_Observacao.Visible := False;
end;


procedure TFr_Pagar_Multipla.Pc_Destinar(Pc_Tipo : String);
Var
  Lc_I : Integer;
  Cheque : TControllerCheque;
Begin
  It_Cd_FmaPagto := Fm_TipoPagamento.DBLCB_formaPagto.KeyValue;

  if It_Cd_Quitacao = 0 then  It_Cd_Quitacao := Fc_GeraCod_BAixa;

  //Destina as Duplicatas
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  Begin
    Pc_Financeiro(DM.IB_Transacao,'D',
                  cds_duplicatasFIN_CODIGO.AsInteger,
                  0, 0, 0, 0, It_Cd_FmaPagto,'', 0,'', 0,0,0, 0, 0,0 ,0, 'N', 0,'PA', 'D', It_Cd_Quitacao,'D','N',0);
    cds_duplicatas.Next;
  end;

  //Destina os Boletos
  if It_Cd_FmaPagto = Fc_PegaFormaPgto('BOLETO') then
  Begin
    if (FBoleto.Registro.Codigo > 0 ) then
    Begin
      FBoleto.Registro.CodQtc := It_Cd_Quitacao;
      FBoleto.Registro.Baixa := Pc_Tipo;
      FBoleto.Update;
    End;
  end;

  //Destina os Cheques
  if It_Cd_FmaPagto = Fc_PegaFormaPgto('CHEQUE') then
  Begin
    if StrGrd_Cheque.Cells[2,1] <> '' then
    Begin
      Try
        Cheque := TControllerCheque.Create(nil);
        For Lc_I := 1 to StrGrd_Cheque.RowCount -1 do
        Begin
          with Cheque.Registro do
          Begin
            Codigo :=  StrToIntDef(StrGrd_Cheque.Cells[1,Lc_I],0);
            Emitente := StrGrd_Cheque.Cells[2,Lc_I];
            NumeroBanco := StrToIntdef(StrGrd_Cheque.Cells[3,Lc_I],0);
            Agencia := StrGrd_Cheque.Cells[4,Lc_I];
            Numero := StrGrd_Cheque.Cells[5,Lc_I];
            Valor :=  StrToFloatDef( StrGrd_Cheque.Cells[6,Lc_I],0);
            Data :=  StrToDate( StrGrd_Cheque.Cells[7,Lc_I]);
            Devolvido := 'N';
            Estado := 'B';
            ValorAmortizado := 0;
            QuitacaoPagamento := It_Cd_Quitacao;
            CodigoFornecedor := IT_Cd_Empresa;
            CodigoEstabelecimento := Gb_CodMha;
            if StrGrd_Cheque.Cells[10,Lc_I] = 'P' then
            Begin
              Tipo := 'P';
              ContaCorrente := StrGrd_Cheque.Cells[16,Lc_I];
              Cheque.salva;
            End
            else
            Begin
              Tipo := 'T';
              Cheque.Destinar;
            End;
            StrGrd_Cheque.Cells[1,Lc_I] := Cheque.Registro.Codigo.ToString;
          End;
        End;
      Finally
        FreeAndNil(Cheque);
      End;
    end;
  end;
end;

procedure TFr_Pagar_Multipla.Pc_Mostrar_Baixados;
Var
  LcForm : TFr_Fin_Baixado;
Begin
  LcForm := TFr_Fin_Baixado.create(self);
  try
    LcForm.CodigoFinanceiro := cds_ParcelasFIN_CODIGO.AsInteger;
    LcForm.TipoOperacao := 'ContasPagar';
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
    Pc_Buscar_Parcela('N');
  end;
End;


procedure TFr_Pagar_Multipla.Pc_Deletar_Cheque;
Var
  Lc_I, Lc_J : Integer;
  Lc_Lista : Array of Array of string;
  Lc_Cheque : Integer;
begin
  if StrGrd_Cheque.Cells[2,StrGrd_Cheque.row] = '' then exit;
  Lc_Cheque := 0;
  SetLength(Lc_Lista,StrGrd_Cheque.RowCount,StrGrd_Cheque.ColCount);
  //Guarda os dados que não estão marcados

  for Lc_I := 1 to StrGrd_Cheque.RowCount-1 do
  Begin
    if Lc_I <> StrGrd_Cheque.Row then
    Begin
      Lc_Cheque := Lc_Cheque + 1;
      Lc_Lista[Lc_Cheque,1] := StrGrd_Cheque.Cells[1, Lc_I];
      Lc_Lista[Lc_Cheque,2] := StrGrd_Cheque.Cells[2, Lc_I];
      Lc_Lista[Lc_Cheque,3] := StrGrd_Cheque.Cells[3, Lc_I];
      Lc_Lista[Lc_Cheque,4] := StrGrd_Cheque.Cells[4, Lc_I];
      Lc_Lista[Lc_Cheque,5] := StrGrd_Cheque.Cells[5, Lc_I];
      Lc_Lista[Lc_Cheque,6] := StrGrd_Cheque.Cells[6, Lc_I];
      Lc_Lista[Lc_Cheque,7] := StrGrd_Cheque.Cells[7, Lc_I];
    end;
  end;

  //Limpa a Matriz antes de incluir a diferenca
  For Lc_I :=1 to StrGrd_Cheque.RowCount - 1 do
    For Lc_J := 1 to 7 do
      StrGrd_Cheque.Cells[Lc_J, Lc_I] := '';
  StrGrd_Cheque.RowCount := 2;
  It_Cheque := 0;
  //Grava novamente os dados que não foram marcados e que estão na matriz
  if Lc_Cheque > 0 then
  Begin
    for Lc_I := 1 to Lc_Cheque do
    Begin
      It_Cheque := It_Cheque +1 ;
      StrGrd_Cheque.RowCount := It_Cheque + 1;
      StrGrd_Cheque.Cells[1,It_Cheque] := Lc_Lista[Lc_I,1];
      StrGrd_Cheque.Cells[2,It_Cheque] := Lc_Lista[Lc_I,2];
      StrGrd_Cheque.Cells[3,It_Cheque] := Lc_Lista[Lc_I,3];
      StrGrd_Cheque.Cells[4,It_Cheque] := Lc_Lista[Lc_I,4];
      StrGrd_Cheque.Cells[5,It_Cheque] := Lc_Lista[Lc_I,5];
      StrGrd_Cheque.Cells[6,It_Cheque] := Lc_Lista[Lc_I,6];
      StrGrd_Cheque.Cells[7,It_Cheque] := Lc_Lista[Lc_I,7];
    end;
  end
  else
  Begin
  end;
  Pc_Somar_Cheque;
end;

procedure TFr_Pagar_Multipla.Pc_Somar_Cheque;
Var
  Lc_I:Integer;
  Lc_VL_Cheque : Real;
Begin
  if StrGrd_Cheque.Cells[2,StrGrd_Cheque.Row] = '' then exit;
  Lc_VL_Cheque := 0;
  For Lc_I :=1 to (StrGrd_Cheque.RowCount -1) do
    Lc_VL_Cheque := Lc_VL_Cheque + StrToFloatDef(StrGrd_Cheque.Cells[6,lc_I],0);

  E_VLT_Cheque.Text := FloatToStrF(Lc_VL_Cheque,ffFixed,10,2);
  E_VL_Pago.Text := FloatToStrF(Lc_VL_Cheque,ffFixed,10,2);  
end;

procedure TFr_Pagar_Multipla.Pc_Liberar_Campo_Cheque(Pc_Tipo : Boolean);
Begin
  E_Emitente.Enabled := Pc_Tipo;
  E_Banco.Enabled := Pc_Tipo;
  E_Agencia.Enabled := Pc_Tipo;
  E_ContaCorrente.Enabled := Pc_Tipo;
  E_NumChq.Enabled := Pc_Tipo;
  E_DataCheque.Enabled := Pc_Tipo;
  E_VL_Cheque.Enabled := Pc_Tipo;

  Sb_InsereCheque.Enabled  := not Pc_Tipo;
  Sb_AlteraCheque.Enabled   := not Pc_Tipo;
  Sb_ExcluiCheque.Enabled  := not Pc_Tipo;
  Sb_GravaCheque.Enabled   := Pc_Tipo;
  Sb_CancelaCheque.Enabled := Pc_Tipo;
  Sb_VoltaCheque.Enabled   := not Pc_Tipo;

  Sb_Inserir.Enabled  := not Pc_Tipo;
  Sb_Cheque.Enabled  := not Pc_Tipo;
  SB_Buscar.Enabled  := not Pc_Tipo;
  Sb_Destinar.Enabled  := not Pc_Tipo;
  Sb_Baixar.Enabled  := not Pc_Tipo;
  Sb_Negociar.Enabled  := not Pc_Tipo;
  SB_Sair_0.Enabled  := not Pc_Tipo;
end;

procedure TFr_Pagar_Multipla.Pc_Limpar_Campo_Cheque;
Begin
  E_Emitente.Text := '';
  E_Banco.Text := '';
  E_Agencia.Text := '';
  E_ContaCorrente.Text := '';
  E_NumChq.Text := '';
  E_DataCheque.Date := Date;
  E_VL_Cheque.Text := '';
end;

procedure TFr_Pagar_Multipla.Pc_Preencher_Campo_Cheque;
Begin
  it_Reg_Atl_chq := StrGrd_Cheque.Row;
  E_Emitente.Text := StrGrd_Cheque.Cells[2,it_Reg_Atl_Chq];
  E_Banco.Text := StrGrd_Cheque.Cells[3,it_Reg_Atl_Chq];
  E_Agencia.Text := StrGrd_Cheque.Cells[4,it_Reg_Atl_Chq];
  E_ContaCorrente.Text := StrGrd_Cheque.Cells[16,it_Reg_Atl_Chq];
  E_NumChq.Text := StrGrd_Cheque.Cells[5,it_Reg_Atl_Chq];
  E_DataCheque.Date := StrToDate(StrGrd_Cheque.Cells[7,it_Reg_Atl_Chq]);
  E_VL_Cheque.Text := StrGrd_Cheque.Cells[6,it_Reg_Atl_Chq];
end;


procedure TFr_Pagar_Multipla.Pc_Buscar_Parcela(Pc_Tipo : String);
  var
  SqlTxt : string;
  Lc_Pedido, Lc_NotaFiscal,Lc_Finaceiro, Lc_Cliente, Lc_Situacao, Lc_FormaPagto : boolean;
  Lc_Str_Excecao : String;
  Lc_Bln_Excecao : Boolean;
  Lc_I,Lc_j:Integer;
begin
  SqlTxt := '';
  Screen.Cursor:=crHourGlass;
  Qr_Parcelas.Close;
  Qr_Parcelas.Sql.Clear;

  Sqltxt :='  SELECT DISTINCT '+
           '   FIN_CODIGO, '+
           '   NFL_NUMERO, '+
           '   NFL_MODELO, '+
           '   PED_NUMERO, '+
           '   FIN_NUMERO, '+
           '   FIN_DT_VENCIMENTO, '+
           '   FIN_NR_PARCELA, '+
           '   FIN_CODEMP, '+
           '   EMP_FANTASIA, '+
           '   EMP_NOME, '+
           '   FIN_VL_PARCELA, '+
           '   FIN_BAIXA, '+
           '   FIN_SITUACAO, '+
           '   FIN_VL_PAGO, '+
           '   FIN_CODQTC, '+
           '   FIN_CODFPG, '+
           '   PED_CODIGO, '+
           '   NFL_CODIGO, '+
           '   FIN_TIPO, '+
           '   FIN_DT_PAGTO, '+
           '   FIN_OPERACAO, '+
           '   FIN_ETAPA, '+
           '   FIN_CODMHA, '+
           '   FIN_CODCHQ, '+
           '   PLC_CODIGO, '+
           '   PLC_DESCRICAO, '+
           '   FIN_DT_REPROGRAMADA, '+
           '   FIN_AUTORIZADO '+
           ' FROM TB_FINANCEIRO tb_financeiro '+
           '   INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal '+
           '   ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL)  '+
           '   LEFT OUTER JOIN TB_PEDIDO tb_pedido '+
           '   ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '+
           '   INNER JOIN TB_EMPRESA tb_empresa '+
           '   ON (tb_empresa.EMP_CODIGO = tb_financeiro.FIN_CODEMP) '+
           '   LEFT OUTER JOIN TB_PLANOCONTAS '+
           '   ON (PLC_CODIGO = FIN_PLC_DEBITO) '+
           ' WHERE  '+
           '  ((FIN_TIPO = ''PA'') OR '+
           '  (FIN_TIPO = ''PM'')) AND  '+
           '  (FIN_CODMHA=:FIN_CODMHA) ';
    case Rg_Doc_Authorization.ItemIndex of
      0:sqltxt := sqltxt + 'AND (FIN_AUTORIZADO =''S'') ';
      1:sqltxt := sqltxt + 'AND (FIN_AUTORIZADO =''N'') ';
    end;

  If (Pc_Tipo = 'D') then
  Begin
    IF IT_Cd_Empresa > 0 THEN sqltxt := sqltxt + 'AND (FIN_CODEMP =:FIN_CODEMP) ';
    SqlTxt := SqlTxt + 'AND (FIN_CODQTC =:FIN_CODQTC) ';
    Qr_Parcelas.SQL.Add(SqlTxt+ 'ORDER BY EMP_NOME, PED_NUMERO, FIN_NUMERO ');
    IF IT_Cd_Empresa > 0 THEN  Qr_Parcelas.ParamByName('FIN_CODEMP').AsInteger :=  IT_Cd_Empresa;
    Qr_Parcelas.ParamByName('FIN_CODQTC').AsInteger :=  It_Cd_Quitacao;
  end;

  If (Pc_Tipo = 'N') then
  Begin

    if E_BuscaPedido.Text = ''         then Lc_Pedido      := False else Lc_Pedido      := True;
    if E_BuscaNota.Text = ''           then Lc_NotaFiscal  := False else Lc_NotaFiscal  := True;
    if E_BuscaFinanceiro.Text = ''     then Lc_Finaceiro   := False else Lc_Finaceiro   := True;
    if E_Busca_Empresa.Text = ''        then Lc_Cliente     := False else Lc_Cliente     := True;
    if Fm_TipoCobranca.DBLCB_formaPagto.Text = '' then Lc_FormaPagto  := False else Lc_FormaPagto  := True;
    if Cb_Situacao.ItemIndex = 4       then Lc_Situacao    := False else Lc_Situacao    := True;

    IF IT_Cd_Empresa > 0 then sqltxt := sqltxt + 'AND (FIN_CODEMP =:FIN_CODEMP) ';

    if ChBx_Periodo.Checked then
    Begin
      if Rg_Data.ItemIndex = 0 then
        sqltxt := sqltxt + 'AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM) '
      else
        sqltxt := sqltxt + 'AND (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM) ';
    end;
    if Lc_Pedido     then sqltxt := sqltxt + 'AND (PED_NUMERO = :PED_NUMERO) ';
    if Lc_NotaFiscal then sqltxt := sqltxt + 'AND (NFL_NUMERO LIKE :NFL_NUMERO) ';
    if Lc_Finaceiro  then sqltxt := sqltxt + 'AND (FIN_NUMERO LIKE :FIN_NUMERO) ';
    if Lc_Cliente    then sqltxt := sqltxt + 'AND ((EMP_FANTASIA LIKE :EMP_FANTASIA) OR (EMP_NOME LIKE :EMP_FANTASIA)) ';
    if Lc_FormaPagto then sqltxt := sqltxt + 'AND (FIN_CODFPG =:FIN_CODFPG) ';
    if Lc_Situacao   then
    Begin
      if Cb_Situacao.ItemIndex = 0 then  sqltxt := sqltxt + 'AND (FIN_BAIXA =''N'') AND (FIN_SITUACAO =''N'') ';
      if Cb_Situacao.ItemIndex = 1 then  sqltxt := sqltxt + 'AND (FIN_BAIXA =''N'') AND (FIN_SITUACAO =''D'') ';
      if Cb_Situacao.ItemIndex = 2 then  sqltxt := sqltxt + 'AND (FIN_BAIXA =''S'') ';
      if Cb_Situacao.ItemIndex = 3 then  sqltxt := sqltxt + 'AND (FIN_BAIXA =''I'') ';
    end;


    if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
    cds_duplicatas.First;
    if cds_duplicatas.RecordCount > 0  then
    Begin
      Lc_Str_Excecao := 'AND (FIN_CODIGO NOT IN (';
      while NOT cds_duplicatas.Eof do
      Begin
        if cds_duplicatas.Bof then
          Lc_Str_Excecao := Lc_Str_Excecao + cds_duplicatasFIN_CODIGO.AsString
        else
          Lc_Str_Excecao := Lc_Str_Excecao + ','+ cds_duplicatasFIN_CODIGO.AsString;
        cds_duplicatas.next;
      end;
      SqlTxt := SqlTxt + Lc_Str_Excecao +')) ';
    End;

    if Rg_Data.ItemIndex = 0 then
      Qr_Parcelas.SQL.Add(SqlTxt+ 'ORDER BY FIN_DT_VENCIMENTO, EMP_NOME, PED_NUMERO, FIN_NUMERO ')
    else
      Qr_Parcelas.SQL.Add(SqlTxt+ 'ORDER BY FIN_DT_PAGTO, EMP_NOME, PED_NUMERO, FIN_NUMERO ');

    IF It_Cd_Empresa > 0 THEN Qr_Parcelas.ParamByName('FIN_CODEMP').AsInteger  := It_Cd_Empresa;
    if ChBx_Periodo.Checked then
    Begin
      Qr_Parcelas.ParamByName('DATAINI').Asdate     := E_Data_Ini.Date;
      Qr_Parcelas.ParamByName('DATAFIM').AsDate     := E_Data_Fim.date;
    end;
    if Lc_Pedido     then Qr_Parcelas.ParamByName('PED_NUMERO').AsString   := E_BuscaPedido.Text;
    if Lc_NotaFiscal then Qr_Parcelas.ParamByName('NFL_NUMERO').AsString   := '%'+ Copy(E_BuscaNota.Text,1,8)+'%';
    if Lc_Finaceiro  then Qr_Parcelas.ParamByName('FIN_NUMERO').AsString   := '%'+ E_BuscaFinanceiro.Text+'%';
    if Lc_Cliente    then Qr_Parcelas.ParamByName('EMP_FANTASIA').AsString := '%'+ E_Busca_Empresa.Text +'%';
    if Lc_FormaPagto then Qr_Parcelas.ParamByName('FIN_CODFPG').AsInteger  := Fm_TipoCobranca.DBLCB_formaPagto.KeyValue;
  end;
  Qr_Parcelas.ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
  Qr_Parcelas.Open;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Pagar_Multipla.Pc_Buscar_Boleto(Pc_Tipo : String);
var
  SqlTxt : string;
  Lc_Boleto, Lc_Fornece : boolean;
begin
  Screen.Cursor:=crHourGlass;
  SqlTxt := '';
  Qr_Boleto.Close;
  Qr_Boleto.Sql.Clear;

  Sqltxt :='SELECT DISTINCT BLT_CODIGO,  BLT_CODEMP,  Tb_Fornece.EMP_FANTASIA, BLT_NUMERO, BLT_DATA, BLT_CODCTB, '+
           'BLT_DESCONTO, BLT_TX_DESCONTO, BLT_BAIXA, BLT_VALOR, BLT_CODQTC , '+
           ' (tb_banco.EMP_FANTASIA || '' - '' || CTB_AGENCIA || '' - '' || CTB_CONTA) CTB_COMPLETO '+
           'FROM  TB_BOLETO Tb_boleto '+
           '  INNER JOIN TB_FINANCEIRO tb_financeiro '+
           '  ON (tb_financeiro.FIN_CODQTC = tb_boleto.BLT_CODQTC) '+
           '  INNER JOIN TB_EMPRESA Tb_Fornece '+
           '  ON (Tb_Fornece.EMP_CODIGO = tb_boleto.BLT_CODEMP) '+
           '  INNER JOIN TB_CONTABANCARIA tb_contabancaria '+
           '  ON (tb_contabancaria.CTB_CODIGO = tb_boleto.BLT_CODCTB) '+
           '  INNER JOIN TB_EMPRESA tb_banco '+
           '  ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO) '+
           'WHERE ((FIN_TIPO = ''PA'') OR (FIN_TIPO = ''PM'')) ';

  IF (Pc_Tipo = 'D') Then
  Begin
    SqlTxt := SqlTxt + 'AND (BLT_CODQTC =:BLT_CODQTC)';

    Qr_Boleto.SQL.add(SqlTxt + 'Order By EMP_FANTASIA ');

    Qr_Boleto.ParamByName('BLT_CODQTC').AsInteger := It_Cd_Quitacao;
  end
  else
  Begin
    if E_BuscaBoleto.Text = '' then Lc_Boleto := False else Lc_Boleto := True;
    if E_BuscaBoletoEmpresa.Text = '' then Lc_Fornece := False else Lc_Fornece := True;
    if ChBx_Periodo_b.Checked then
      sqltxt := sqltxt + 'AND (BLT_DATA BETWEEN :DATAINI AND :DATAFIM) ';
    if Lc_Boleto then sqltxt := sqltxt + 'AND (BLT_NUMERO = :BLT_NUMERO) ';
    if Lc_Fornece then sqltxt := sqltxt + 'AND ((Tb_Fornece.EMP_FANTASIA LIKE :EMP_FANTASIA) OR (Tb_Fornece.EMP_NOME LIKE :EMP_FANTASIA)) ';

    Qr_Boleto.SQL.add(SqlTxt + 'Order By EMP_FANTASIA ');
    if ChBx_Periodo_b.Checked then
      Begin
      Qr_Boleto.ParamByName('DATAINI').AsDate:=  E_Dt_Ini_Bol.date;
      Qr_Boleto.ParamByName('DATAFIM').Asdate := E_Dt_Fim_Bol.date;
      end;
    if Lc_Boleto then Qr_Boleto.ParamByName('BLT_NUMERO').AsString := E_BuscaBoleto.Text;
    if Lc_Fornece then Qr_Boleto.ParamByName('EMP_FANTASIA').AsString := '%'+ E_BuscaBoletoEmpresa.Text +'%';
    Qr_Boleto.Active := True;
  end;
  Qr_Boleto.Active := True;
  FBoleto.Registro.Codigo := Qr_Boleto.FieldByName('BLT_CODIGO').AsInteger;
  FBoleto.Registro.Codemp := Qr_Boleto.FieldByName('BLT_CODEMP').AsInteger;
  FBoleto.getByKey;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Pagar_Multipla.PC_Buscar_Cheque(Pc_Tipo : String);
var
  SqlTxt : string;
  Lc_Data, Lc_Boleto, Lc_Cliente : boolean;
begin
  Screen.Cursor:=crHourGlass;
  SqlTxt := '';
  Qr_Cheques.Close;
  Qr_Cheques.Sql.Clear;

  Sqltxt :='SELECT DISTINCT CHQ_AGENCIA, CHQ_CODIGO, CHQ_QT_REC,CHQ_QT_PAG, CHQ_CODFOR, CHQ_DATA, CHQ_DEVOLVIDO, '+
           'CHQ_DT_QUITACAO, CHQ_EMITENTE, CHQ_ESTADO, CHQ_NR_BANCO, CHQ_NUMERO, CHQ_RETORNO, CHQ_TIPO, CHQ_VALOR '+
           'FROM TB_CHEQUES Tb_cheques '+
           'WHERE ((CHQ_QT_PAG > 0)  OR  (CHQ_QT_PAG IS NOT  NULL)) AND (CHQ_QT_PAG=:CHQ_QT_PAG)';

  Qr_Cheques.SQL.add(SqlTxt + 'Order By CHQ_EMITENTE ');

  Qr_Cheques.ParamByName('CHQ_QT_PAG').AsInteger := It_Cd_Quitacao;
  Qr_Cheques.Active := True;
  Qr_Cheques.First;
  while not Qr_Cheques.Eof do
    Begin
    It_Cheque := It_Cheque +1 ;
    StrGrd_Cheque.RowCount := It_Cheque + 1;
    StrGrd_Cheque.Cells[1,It_Cheque] := Qr_Cheques.FieldByName('CHQ_CODIGO').AsString;
    StrGrd_Cheque.Cells[2,It_Cheque] := Qr_Cheques.FieldByName('CHQ_EMITENTE').AsString;
    StrGrd_Cheque.Cells[3,It_Cheque] := Qr_Cheques.FieldByName('CHQ_NR_BANCO').AsString;
    StrGrd_Cheque.Cells[4,It_Cheque] := Qr_Cheques.FieldByName('CHQ_AGENCIA').AsString;
    StrGrd_Cheque.Cells[5,It_Cheque] := Qr_Cheques.FieldByName('CHQ_NUMERO').AsString;
    StrGrd_Cheque.Cells[6,It_Cheque] := FloatToStrF(Qr_Cheques.FieldByName('CHQ_VALOR').AsCurrency,ffFixed,10,2);
    StrGrd_Cheque.Cells[7,It_Cheque] := Qr_Cheques.FieldByName('CHQ_DATA').AsString;
    StrGrd_Cheque.Cells[8,It_Cheque] := Qr_Cheques.FieldByName('CHQ_DEVOLVIDO').AsString;
    StrGrd_Cheque.Cells[9,It_Cheque] := Qr_Cheques.FieldByName('CHQ_DT_QUITACAO').AsString;
    StrGrd_Cheque.Cells[10,It_Cheque] := Qr_Cheques.FieldByName('CHQ_TIPO').AsString;
    StrGrd_Cheque.Cells[11,It_Cheque] := Qr_Cheques.FieldByName('CHQ_ESTADO').AsString;
    StrGrd_Cheque.Cells[12,It_Cheque] := Qr_Cheques.FieldByName('CHQ_RETORNO').AsString;
    StrGrd_Cheque.Cells[13,It_Cheque] := Qr_Cheques.FieldByName('CHQ_QT_REC').AsString;
    StrGrd_Cheque.Cells[14,It_Cheque] := Qr_Cheques.FieldByName('CHQ_QT_PAG').AsString;
    StrGrd_Cheque.Cells[15,It_Cheque] := Qr_Cheques.FieldByName('CHQ_CODIGO').AsString;
    Qr_Cheques.Next;
    end;
  Pc_Somar_Cheque;
  Screen.Cursor:=crDefault;
end;

// Procedimento internos
procedure TFr_Pagar_Multipla.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_Pagar_Multipla.FormResize(Sender: TObject);
begin
  posicionaTotalizador;
end;

procedure TFr_Pagar_Multipla.Pc_FormataTela;
Var
 Lc_X:Integer;
begin
  For Lc_X:=1 to Pg_Controle.PageCount do Pg_Controle.Pages[Lc_X-1].TabVisible:=False;
  Pc_MultiEmpresaMostraTodas(Grb_MnhaEmpresa,chbx_Empresas);
  Pc_HabilitarMultiEmpresa(Dblcb_Mha_Empresa,chbx_Empresas);
  Pg_Controle.ActivePageIndex:=0;
  Pc_Definir_Grade_Cheque;   //Definir tamanho Da grade de Cheques

  Lb_Titulo_totalizador.Transparent := False;
  Lb_Titulo_totalizador.Color := clNavy;
  Lb_Titulo_totalizador.Font.Color := clWhite;
  posicionaTotalizador;
end;

procedure TFr_Pagar_Multipla.Pc_IniciaVariaveis;
Begin
  FBoleto := TControllerBoleto.create(Self);
  ChBx_Periodo.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  ChBx_Periodo_b.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  Chbx_Periodo_C.Checked := (Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','S') = 'S');
  It_Cd_Quitacao := 0;
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  E_Dt_Pagto.Date := Date;
end;

procedure TFr_Pagar_Multipla.Pc_Ativar_Tabelas;
Begin
  Fm_ListaContaBancaria.Listar;
  Fm_TipoCobranca.Pc_Listar(3,False,0);
  Fm_TipoCobranca.DBLCB_formaPagto.KeyValue := null;
  Fm_TipoPagamento.Pc_Listar(3,False,0);
  Fm_TipoPagamento.DBLCB_formaPagto.KeyValue := null;
end;

procedure TFr_Pagar_Multipla.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_Pagar_Multipla.SB_PesquisarClick(Sender: TObject);
begin
  if Pg_Controle.ActivePageIndex=0 then Pc_Buscar_Parcela('N');
end;


procedure TFr_Pagar_Multipla.E_VL_JurosExit(Sender: TObject);
begin
  It_VL_Juros := StrToFloatDef(E_VL_Juros.Text,0);
  TotalizaBaixa;
end;

procedure TFr_Pagar_Multipla.E_VL_MoraExit(Sender: TObject);
begin
  It_VL_Mora := StrToFloatDef(E_VL_Mora.Text,0);
  TotalizaBaixa;
end;

procedure TFr_Pagar_Multipla.E_VL_DescontoExit(Sender: TObject);
begin
  It_VL_Desconto := StrToFloatDef(E_VL_Desconto.Text,0);
  TotalizaBaixa;
end;

procedure TFr_Pagar_Multipla.E_VL_JurosEnter(Sender: TObject);
begin
  E_VL_Juros.SelectAll;
end;

procedure TFr_Pagar_Multipla.E_VL_MoraEnter(Sender: TObject);
begin
  E_VL_Mora.SelectAll;
end;

procedure TFr_Pagar_Multipla.E_VL_DescontoEnter(Sender: TObject);
begin
  E_VL_Desconto.SelectAll;
end;

procedure TFr_Pagar_Multipla.Pc_Adicionar_Tudo;
Var
  I : Integer;
begin
  IF (It_TipoTransacao = 'BAIXADAS') then Exit;
  IF (It_TipoTransacao = 'DESTINADAS') then Pc_Buscar_Parcela('D') ;
  if ( Qr_Parcelas.RecordCount = 0 ) OR   ( cds_ParcelasFIN_BAIXA.asString = 'S' ) then exit;
  if ( Qr_Parcelas.RecordCount = 0 ) then exit;
  It_Cd_Empresa := cds_ParcelasFIN_CODEMP.AsInteger;
  IF (It_TipoTransacao <> 'DESTINADAS') then Pc_Buscar_Parcela('N');

  Pc_Preencher_Parcelas;
  Totalizapagar;
  if ( Qr_Parcelas.RecordCount = 0 ) then exit;
  Dbg_Duplicatas.Visible := False;
  with cds_Parcelas  do
  Begin
    if not cds_duplicatas.active then cds_duplicatas.CreateDataSet;
    cds_duplicatas.LogChanges := False;
    cds_duplicatas.EmptyDataSet;
    First;
    while not Eof do
    Begin
      cds_duplicatas.Append;
      For I:= 0 to FieldCount -1 do
        cds_duplicatas.Fields[I].Value := Fields[I].Value;
      cds_duplicatas.Post;
      Next;
    end;
  End;
  Dbg_Duplicatas.Visible := True;
  cds_duplicatas.LogChanges := True;

  It_Cd_FmaPagto := cds_duplicatasFIN_CODFPG.AsInteger;
  Fm_TipoPagamento.DBLCB_formaPagto.KeyValue := It_Cd_FmaPagto;
  DBLCB_formaPagtoClick(Self);
  IF (It_TipoTransacao = 'DESTINADAS') then
  Begin
    IF Fm_TipoPagamento.DBLCB_formaPagto.Text = 'BOLETO' then
    Begin
      Pg_Controle.ActivePageIndex := 2;
      Pc_Buscar_Boleto('D');
      end;
    IF Fm_TipoPagamento.DBLCB_formaPagto.Text = 'CHEQUE' then
    Begin
      Pc_LimpaStringGrid(StrGrd_Cheque);
      It_Cheque := 0;
      Pg_Controle.ActivePageIndex := 1;
      Pc_Buscar_Cheque('D');
    end;
  end;
  Pc_Define_Valores_Baixa;
  TotalizaBaixa;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaPagar;
end;



procedure TFr_Pagar_Multipla.SB_Retirar_TudoClick(Sender: TObject);
begin
  cds_duplicatas.EmptyDataSet;
  It_Cd_Empresa := 0;
  Pc_Define_Valores_Baixa;
  TotalizaBaixa;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaPagar;
  Pc_Ativar_Botoes;
end;

procedure TFr_Pagar_Multipla.SB_RetirarClick(Sender: TObject);
Var
  Lc_I, Lc_J : Integer;
  Lc_Lista : Array of Array of string;
begin
  if cds_duplicatas.RecordCount > 0 then
  Begin
    cds_duplicatas.Delete;
    if cds_duplicatas.RecordCount = 0 then
      It_Cd_Empresa := 0;
    Pc_Define_Valores_Baixa;
    TotalizaBaixa;
    Pc_Buscar_Parcela('N');
    Pc_Preencher_Parcelas;
    TotalizaPagar;
    Pc_Ativar_Botoes;
  end;
end;

procedure TFr_Pagar_Multipla.Qr_BoletoAfterScroll(DataSet: TDataSet);
begin
  FBoleto.Registro.Codigo := Qr_Boleto.FieldByName('BLT_CODIGO').AsInteger;
  FBoleto.Registro.Codemp := Qr_Boleto.FieldByName('BLT_CODEMP').AsInteger;
  FBoleto.getByKey;
end;

procedure TFr_Pagar_Multipla.Qr_NegociacaoAfterScroll(DataSet: TDataSet);
begin
  TotalizaPagar;

end;

procedure TFr_Pagar_Multipla.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(FBoleto);
end;

procedure TFr_Pagar_Multipla.FormCreate(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
  Pc_ImagemBotao;
end;

procedure TFr_Pagar_Multipla.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Pg_Controle.ActivePageIndex of
  0:begin
    if shift = [] then
      begin
        case Key of
        VK_F2  : if Sb_Inserir.Enabled then SB_InserirClick(Sender);
        VK_F5  : if Sb_Cheque.Enabled then Sb_ChequeClick(Sender);
        VK_F6  : if SB_Boleto.Enabled then SB_BoletoClick(Sender);
        VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
        VK_F8  : if Sb_Destinar.Enabled then Sb_DestinarClick(Sender);
        VK_F9  : if Sb_Baixar.Enabled then Sb_BaixarClick(Sender);
        VK_F10  : if Sb_Negociar.Enabled then Sb_NegociarClick(Sender);
        VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
        end;
      end;
    end;
  1:begin
    if shift = [] then
      begin
        case Key of
        VK_F2  : if Sb_InsereCheque.Enabled then Sb_InsereChequeClick(Sender);
        VK_F3  : if Sb_AlteraCheque.Enabled then Sb_AlteraChequeClick(Sender);
        VK_F4  : if Sb_ExcluiCheque.Enabled then Sb_ExcluiChequeClick(Sender);
        VK_F5  : if Sb_GravaCheque.Enabled then Sb_GravaChequeClick(Sender);
        VK_F6  : if Sb_CancelaCheque.Enabled then Sb_CancelaChequeClick(Sender);
        VK_F8  : if Sb_Destinar.Enabled then Sb_DestinarClick(Sender);
        VK_F9  : if Sb_Baixar.Enabled then Sb_BaixarClick(Sender);
        VK_F11  : if Sb_Terceiro.Enabled then Sb_TerceiroClick(Sender);
        VK_Escape : if Sb_VoltaCheque.Enabled then Sb_VoltaChequeClick(Sender);
        end;
      end;
    end;
  2:begin
    if shift = [] then
      begin
      case Key of
        VK_F2  : if Sb_InsereBoleto.Enabled then Sb_InsereBoletoClick(Sender);
        VK_F3  : if Sb_AlteraBoleto.Enabled then Sb_AlteraBoletoClick(Sender);
        VK_F4  : if Sb_ExcluiBoleto.Enabled then Sb_ExcluiBoletoClick(Sender);
        VK_F5  : if Sb_GravaBoleto.Enabled then Sb_GravaBoletoClick(Sender);
        VK_F6  : if Sb_CancelaBoleto.Enabled then Sb_CancelaBoletoClick(Sender);
        VK_F7  : if Sb_BuscaBoleto.Enabled then Sb_BuscaBoletoClick(Sender);
        VK_F8  : if Sb_Destinar.Enabled then Sb_DestinarClick(Sender);
        VK_F9  : if Sb_Baixar.Enabled then Sb_BaixarClick(Sender);
        VK_Escape : if Sb_VoltaBoleto.Enabled then Sb_VoltaBoletoClick(Sender);
        end;
      end;
    end;
  3:begin
    if shift = [] then
      begin
      case Key of
      VK_F7  : if Sb_BuscarCheque.Enabled then Sb_BuscarChequeClick(Sender);
      VK_F8  : if Sb_Rela_Cheque.Enabled then Sb_Rela_ChequeClick(Sender);
      VK_Escape : if Sb_VoltarChq_Terc.Enabled then Sb_VoltarChq_TercClick(Sender);
      end;
      end;
    end;
  end;

end;

procedure TFr_Pagar_Multipla.Pc_Adicionar;
Var
  I : Integer;
begin
  It_Cd_Empresa   := cds_ParcelasFIN_CODEMP.AsInteger;
  if not cds_duplicatas.active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.Append;
  For I:= 0 to cds_Parcelas.FieldCount -1 do
    cds_duplicatas.Fields[I].Value := cds_Parcelas.Fields[I].Value;
  cds_duplicatas.Post;
  Fm_TipoPagamento.DBLCB_formaPagto.KeyValue := cds_duplicatasFIN_CODFPG.AsInteger;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaPAgar;
  Pc_Define_Valores_Baixa;
  TotalizaBaixa;

end;

procedure TFr_Pagar_Multipla.Sb_ChequeClick(Sender: TObject);
begin
  Pg_Controle.ActivePageIndex := 1;
  Pc_Liberar_Campo_Cheque(true);
end;

procedure TFr_Pagar_Multipla.SB_BoletoClick(Sender: TObject);
begin
  Pg_Controle.ActivePageIndex := 2;
  Sb_InsereBoletoClick(Sender);
end;

procedure TFr_Pagar_Multipla.E_VL_ChequeExit(Sender: TObject);
Var
  Lc_Vl_Cheque : Real;
begin
  Lc_Vl_Cheque := StrToFloatDef(E_VL_Cheque.Text,0);
  E_VL_Cheque.Text := FloatToStrF(Lc_Vl_Cheque,ffFixed,10,2);
end;

procedure TFr_Pagar_Multipla.StrGrd_ChequeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
  begin
    end;
  end;
 end;

procedure TFr_Pagar_Multipla.Sb_InsereBoletoClick(Sender: TObject);
begin
  if ValidaInsertBoleto then
  Begin
    FEditionStateBoleto := 'I';
    EditionControlBoleto;
    InsertBoleto;
  End;
end;

procedure TFr_Pagar_Multipla.Sb_AlteraBoletoClick(Sender: TObject);
begin
  if ValidateChangeBoleto then
  Begin
    FEditionStateBoleto := 'E';
    EditionControlBoleto;
    ChangeBoleto;
  End;
end;

procedure TFr_Pagar_Multipla.Sb_ExcluiBoletoClick(Sender: TObject);
begin
  if ValidateDeleteBoleto then
  Begin
    DeleteBoleto;
    FEditionStateBoleto := 'B';
    EditionControlBoleto;
    Sb_BuscaBoletoClick(sender);
  End;
end;

procedure TFr_Pagar_Multipla.Sb_GravaBoletoClick(Sender: TObject);
vAR
  Lc_estado : Boolean;
begin
  if ValidateSaveBoleto then
  Begin
    SaveBoleto;
    if (FEditionStateBoleto = 'I') then  Sb_DestinarClick(Sender);
    Pc_Buscar_Boleto('N');
    FEditionStateBoleto := 'B';
    EditionControlBoleto;
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue := FBoleto.Registro.CodCtb;
  End;
end;

procedure TFr_Pagar_Multipla.Sb_CancelaBoletoClick(Sender: TObject);
begin
  if ValidateCancelBoleto then
  Begin
    CancelBoleto;
    FEditionStateBoleto := 'B';
    EditionControlBoleto;
  End;
end;

procedure TFr_Pagar_Multipla.Sb_BuscaBoletoClick(Sender: TObject);
begin
  Pc_Buscar_Boleto('N');
end;

procedure TFr_Pagar_Multipla.Sb_VoltaBoletoClick(Sender: TObject);
begin
  Pg_Controle.ActivePageIndex := 0;
  SB_Retirar_TudoClick(sender);
end;

procedure TFr_Pagar_Multipla.DBRG_DescontadaClick(Sender: TObject);
begin
  E_BDesconto.Enabled := (DBRG_Descontada.ItemIndex = 0);
end;

procedure TFr_Pagar_Multipla.DeleteBoleto;
begin
  FBoleto.delete;
end;

procedure TFr_Pagar_Multipla.DetalhesdoPedido1Click(Sender: TObject);
begin
  if cds_ParcelasPED_CODIGO.AsInteger > 0 then
  Begin
    if cds_ParcelasNFL_MODELO.AsInteger = 65 then
      Pc_AbreTelaNotaFiscal65('N', cds_ParcelasNFL_CODIGO.AsInteger )
    else
      Pc_AbreTelaNotaFiscal( cds_ParcelasNFL_CODIGO.AsInteger ,self);
  End;
end;

Function TFr_Pagar_Multipla.Fc_ValidaGravacaoCheque():Boolean;
Var
  Lc_I : Integer;
Begin
  Result := True;
  if trim(E_Emitente.Text) = '' then
  begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo emitente.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Emitente.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_Banco.Text) = '' then
  begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo número do Banco.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Banco.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_Agencia.Text) = '' then
  begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo agência.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_Agencia.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_NumChq.Text) = '' then
  begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo número do cheque.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_NumChq.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_VL_Cheque.Text) = '' then
  begin
    MensagemPadrao(' Mensagem ',ATENCAO+EOLN+EOLN+
                   ' Não preenchido o campo valor do cheque.'+EOLN+
                   ' Preencha e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    E_VL_Cheque.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_ContaCorrente.Text) <> '' then
  begin
    if not Fc_VerificaDuplicacaoCheque(It_cd_Cheque,E_Banco.Text,E_Agencia.Text,E_ContaCorrente.Text,E_NumChq.Text) then
    Begin
      Result := False;
      exit;
    end;

    For Lc_I := 1 to StrGrd_Cheque.RowCount -1 do
    Begin
      if (Trim(E_Banco.Text)   = StrGrd_Cheque.Cells[3,Lc_I]) and
         (Trim(E_NumChq.Text)  = StrGrd_Cheque.Cells[5,Lc_I]) and
         (Trim(E_Agencia.Text) = StrGrd_Cheque.Cells[4,Lc_I]) and
         (Trim(E_ContaCorrente.Text) = StrGrd_Cheque.Cells[16,Lc_I]) and
         (it_Oper_Reg_Chq = 'I') then
      begin
        MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                       ' JÁ existe este cheque na lista digitada abaixo.' + EOLN +
                       ' Verifique Nr. Banco, Nr. Agência, Nr. Conta, e Nr. de Cheque.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        Result := False;
        exit;
      end;
    end;
  end;
end;

procedure TFr_Pagar_Multipla.Sb_GravaChequeClick(Sender: TObject);
Begin
  if Fc_ValidaGravacaoCheque then
    Begin
    if it_Oper_Reg_Chq = 'I' then
    Begin
      It_Cheque := It_Cheque +1 ;
      StrGrd_Cheque.RowCount := It_Cheque + 1;
      StrGrd_Cheque.Cells[1,It_Cheque] := '';
      StrGrd_Cheque.Cells[2,It_Cheque] := E_Emitente.Text;
      StrGrd_Cheque.Cells[3,It_Cheque] := E_Banco.Text;
      StrGrd_Cheque.Cells[4,It_Cheque] := E_Agencia.Text;
      StrGrd_Cheque.Cells[5,It_Cheque] := E_NumChq.Text;
      StrGrd_Cheque.Cells[6,It_Cheque] := E_VL_Cheque.Text;
      StrGrd_Cheque.Cells[7,It_Cheque] := DateToStr(E_DataCheque.Date);
      StrGrd_Cheque.Cells[10,It_Cheque] := 'P';
      StrGrd_Cheque.Cells[16,It_Cheque] := E_ContaCorrente.Text;
    end
    else
    Begin
      StrGrd_Cheque.Cells[1,it_Reg_Atl_chq] := '';
      StrGrd_Cheque.Cells[2,it_Reg_Atl_chq] := E_Emitente.Text;
      StrGrd_Cheque.Cells[3,it_Reg_Atl_chq] := E_Banco.Text;
      StrGrd_Cheque.Cells[4,it_Reg_Atl_chq] := E_Agencia.Text;
      StrGrd_Cheque.Cells[5,it_Reg_Atl_chq] := E_NumChq.Text;
      StrGrd_Cheque.Cells[6,it_Reg_Atl_chq] := E_VL_Cheque.Text;
      StrGrd_Cheque.Cells[7,it_Reg_Atl_chq] := DateToStr(E_DataCheque.Date);
      StrGrd_Cheque.Cells[10,It_Cheque] := 'P';
      StrGrd_Cheque.Cells[16,it_Reg_Atl_chq] := E_ContaCorrente.Text;
    end;
    Pc_Limpar_Campo_Cheque;
    Pc_Somar_Cheque;
    Pc_Liberar_Campo_Cheque(False);
    end;
end;

procedure TFr_Pagar_Multipla.Sb_InsereChequeClick(Sender: TObject);
begin
  Pc_Limpar_Campo_Cheque;
  Pc_Liberar_Campo_Cheque(true);
  it_Oper_Reg_Chq := 'I';
  E_Emitente.SetFocus;
end;

procedure TFr_Pagar_Multipla.Sb_AlteraChequeClick(Sender: TObject);
begin
  if StrGrd_Cheque.Cells[10,StrGrd_Cheque.Row] = 'T' then
    Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Este é um Cheque de Terceiro e não pode ser Editado.'+EOLN+
                   '               Favor Verificar.'+EOLN,
                  ['OK'],[bEscape],mpErro);

    end
  else
    Begin
    it_Oper_Reg_Chq := 'E';
    Pc_Liberar_Campo_Cheque(True);
    Pc_Preencher_Campo_Cheque;
    E_Emitente.SetFocus;
    end;
end;

procedure TFr_Pagar_Multipla.Sb_CancelaChequeClick(Sender: TObject);
begin
  Pc_Limpar_Campo_Cheque;
  Pc_Liberar_Campo_Cheque(False);
end;

procedure TFr_Pagar_Multipla.Sb_VoltaChequeClick(Sender: TObject);
begin
  Pg_Controle.ActivePageIndex := 0;
end;

procedure TFr_Pagar_Multipla.Sb_DestinarClick(Sender: TObject);
begin
  try
    Pc_Destinar('D');
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                   'Documentos Destinados com Sucesso.'+EOLN+
                   'Código da Destinação: '+IntToStr(It_Cd_Quitacao) +EOLN,
                   ['OK'],[bEscape],mpInformacao);
    if (Fm_TipoPagamento.DBLCB_formaPagto.Text <> 'BOLETO') and
       (Fm_TipoPagamento.DBLCB_formaPagto.Text <> 'CARTÃO') and
       (Fm_TipoPagamento.DBLCB_formaPagto.Text <> 'CARTAO') and
       (Fm_TipoPagamento.DBLCB_formaPagto.Text <> 'CHEQUE')  THEN SB_Retirar_TudoClick(Sender);
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a Destinação dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Pagar_Multipla.Sb_ExcluiChequeClick(Sender: TObject);
Var
  Cheque : TControllerCheque;
begin
  IF StrGrd_Cheque.Cells[2,StrGrd_Cheque.Row] = '' THEN Exit;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir o item '+StrGrd_Cheque.Cells[2,StrGrd_Cheque.Row]+' desta Relação.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
    exit;
  try
    Try
      Cheque := TControllerCheque.Create(nil);
      IF (StrGrd_Cheque.Cells[1,StrGrd_Cheque.Row] <> '') AND (StrGrd_Cheque.Cells[10,StrGrd_Cheque.Row] = 'T') THEN
      Begin
        with Cheque.Registro do
        Begin
          Codigo := StrToIntdef( StrGrd_Cheque.Cells[1,StrGrd_Cheque.row],0);
          Estado := 'N';
          ValorAmortizado := 0;
          QuitacaoPagamento := 0;
          CodigoFornecedor := 0;
          CodigoEstabelecimento := Gb_CodMha;
        End;
        Cheque.DesvincularTerceiro;
        Pc_Deletar_cheque;
      end
      else
      Begin
        IF (StrGrd_Cheque.Cells[1,StrGrd_Cheque.Row] <> '')THEN
        Begin
          with Cheque.Registro do
          Begin
            Codigo := StrToIntdef( StrGrd_Cheque.Cells[1,StrGrd_Cheque.row],0);
            CodigoEstabelecimento := Gb_CodMha;
          End;
          Cheque.delete;
        End;
        Pc_Deletar_Cheque;
      end;
    Finally
      FreeAndNil(Cheque);
    End;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                   'Entre em contato com o suporte técnico.'+EOLN,
                  ['OK'],[bEscape],mpErro);
  end;
end;

procedure TFr_Pagar_Multipla.Pc_Processo_Movim_Financeiro;
Var
  Lc_Escolha: Integer;
Begin
  it_BaixaOK := False;
  if (It_Vl_Pagto <> 0) then
  Begin
    IF ( cds_duplicatasFIN_ETAPA.AsString = 'N') then
    Begin
      Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                                    'Baixar as Duplicatas Selecionadas.'+EOLN+EOLN+
                                    'Confirmar a Baixa ?',
                                    ['Caixa','Banco','Cancelar'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));

      IF It_Cd_Quitacao = 0 THEN It_Cd_Quitacao := Fc_GeraCod_BAixa;
        case Lc_Escolha of
          0:Pc_Lanca_Caixa;
          1:Pc_Lanca_Banco;
          2:Exit;
        end;
    end
    else
    Begin
      it_BaixaOK := True;
    end;
  end
  else
  Begin
    it_BaixaOK := True;
  end;
end;

procedure TFr_Pagar_Multipla.Sb_BaixarClick(Sender: TObject);
Var
  Lc_Escolha, Lc_I : Integer;
  Lc_StrDupl : String;
begin
  if Fc_validar_Baixa then
  Begin
    Pc_Processo_Movim_Financeiro;
    try
      if it_BaixaOK then Pc_Processo_Baixa;
    except
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Não foi possível baixar as Duplicatas.'+EOLN+
                     'Verifique os valores informados e tente novamente.'+EOLN,
                     ['OK'],[bEscape],mpErro);
    end;
  End;
end;

procedure TFr_Pagar_Multipla.E_VL_PagoExit(Sender: TObject);
begin
  E_VL_Pago.Text := FloatToStrF(It_Vl_Pagto,ffFixed,10,2);
end;

procedure TFr_Pagar_Multipla.DBG_BoletoDblClick(Sender: TObject);
Var
  Lc_I, Lc_J : Integer;

begin
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.EmptyDataSet;
  It_TipoTransacao := 'DESTINADAS';
  It_Cd_Empresa := Qr_Boleto.FieldByName('BLT_CODEMP').AsInteger;
  It_Cd_Quitacao := Qr_Boleto.FieldByName('BLT_CODQTC').AsInteger;
  Pc_Adicionar_Tudo;
end;

procedure TFr_Pagar_Multipla.Dbg_DuplicatasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if ( TDBGrid(Sender).DataSource.DataSet.FieldByName('FIN_OPERACAO').AsString = 'D' ) then
    TDBGrid(Sender).Canvas.Font.Color := clBlack
  else
    TDBGrid(Sender).Canvas.Font.Color := clRed;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TFr_Pagar_Multipla.Dbg_ParcelaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if ( TDBGrid(Sender).DataSource.DataSet.FieldByName('FIN_OPERACAO').AsString = 'D' ) then
    TDBGrid(Sender).Canvas.Font.Color := clBlack
  else
    TDBGrid(Sender).Canvas.Font.Color := clRed;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;

procedure TFr_Pagar_Multipla.Sb_VoltarChq_TercClick(Sender: TObject);
begin
  Pg_Controle.ActivePageIndex := 1;
end;

procedure TFr_Pagar_Multipla.ShowDataBoleto;
Begin
  Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue := Null;
  E_NumBoleto.Clear;
  E_VL_Pagar.Text := '0,00';
  if (Qr_Boleto.active) then
  Begin
    FBoleto.Registro.Codigo := Qr_Boleto.FieldByName('BLT_CODIGO').AsInteger;
    FBoleto.Registro.Codemp := Qr_Boleto.FieldByName('BLT_CODEMP').AsInteger;
    FBoleto.getByKey;
    if FBoleto.exist then
    Begin
      Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue := FBoleto.Registro.CodCtb;
      E_NumBoleto.Text :=  FBoleto.Registro.Numero;
      E_VL_Pagar.Text := FloatToStrF(FBoleto.Registro.Valor,ffFixed,10,2);
    End
  End;
end;

procedure TFr_Pagar_Multipla.Sb_BuscarChequeClick(Sender: TObject);
begin
  Pc_Buscar_Chq_Terceiro;
end;

procedure TFr_Pagar_Multipla.Sb_TerceiroClick(Sender: TObject);
begin
  Pg_Controle.ActivePageIndex := 3;
  Ds_Qr_MostraSemDestinoStateChange(Qr_MostraSemDestino);
  Pc_Liberar_Campo_Cheque(False);
end;

procedure TFr_Pagar_Multipla.Sb_Rela_ChequeClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  For Lc_I := 1 to StrGrd_Cheque.RowCount -1 do
    Begin
    if StrGrd_Cheque.Cells[1,Lc_I] = Qr_MostraSemDestino.FieldByName('CHQ_CODIGO').AsString then
        Begin
        MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                       'Este Cheque já esta na Lista.'+EOLN+
                       '      Favor Verificar.'+EOLN,
                       ['OK'],[bEscape],mpErro);
        exit;
        end
    end;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Incluir este cheque no pagamento da(s) parcela(s) ?'+EOLN+EOLN+
                     'Confirmar a inclusão ?',
                     [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBlue) = mrBotao1) then
    begin
    It_Cheque := It_Cheque +1 ;
    StrGrd_Cheque.RowCount := It_Cheque + 1;


    StrGrd_Cheque.Cells[1,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_CODIGO').AsString;
    StrGrd_Cheque.Cells[2,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_EMITENTE').AsString;
    StrGrd_Cheque.Cells[3,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_NR_BANCO').AsString;
    StrGrd_Cheque.Cells[4,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_AGENCIA').AsString;
    StrGrd_Cheque.Cells[5,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_NUMERO').AsString;
    StrGrd_Cheque.Cells[6,It_Cheque] :=FloatToStrF(Qr_MostraSemDestino.FieldByName('CHQ_VALOR').AsCurrency,ffFixed,10,2);
    StrGrd_Cheque.Cells[7,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_DATA').AsString;
    StrGrd_Cheque.Cells[8,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_DEVOLVIDO').AsString;
    StrGrd_Cheque.Cells[9,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_DT_QUITACAO').AsString;
    StrGrd_Cheque.Cells[10,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_TIPO').AsString;
    StrGrd_Cheque.Cells[11,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_ESTADO').AsString;
    StrGrd_Cheque.Cells[12,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_RETORNO').AsString;
    StrGrd_Cheque.Cells[13,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_QT_REC').AsString;
    StrGrd_Cheque.Cells[14,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_QT_PAG').AsString;
    StrGrd_Cheque.Cells[15,It_Cheque] := Qr_MostraSemDestino.FieldByName('CHQ_CODIGO').AsString;

    end;
  Pc_Somar_Cheque;
end;

procedure TFr_Pagar_Multipla.StrGrd_ChequeDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
  if (StrGrd_Cheque.Cells[14,arow]='X') then
    begin // verifica se a linha impar
    StrGrd_Cheque.Canvas.Font.Color:= clBlack;
    StrGrd_Cheque.Canvas.Brush.Color:= clBtnFace;
    end
  else
    begin
    StrGrd_Cheque.Canvas.Font.Color:= clBlack;
    StrGrd_Cheque.Canvas.Brush.Color:= clMoneyGreen;
    end;
  StrGrd_Cheque.Canvas.FillRect(Rect); // redesenha a celula
  StrGrd_Cheque.Canvas.TextOut(Rect.Left+2,Rect.Top,StrGrd_Cheque.Cells[acol,arow]); // reimprime o texto.


  { Pega o texto da célula }
  Texto := StrGrd_Cheque.Cells[acol, ARow];

  { Calcura largura e altura (em pontos) do texto }
  LarguraTexto := StrGrd_Cheque.Canvas.TextWidth(Texto);
  AlturaTexto := StrGrd_Cheque.Canvas.TextHeight(Texto);



  { Calcula a posição horizontal do início do texto }
  if  (ACol = 0) or (ACol = 1) or (ACol = 2) or (ACol = 3) or (ACol = 4)then { esquerda }
    X := Rect.Left + 2
  else if  (ACol = 7) then { Centro }
    X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
      LarguraTexto div 2
  else { Direita }
    X := Rect.Right - LarguraTexto - 2;


  { Calcula a posição vertical do início do texto para
    que seja impresso no centro (verticalmente) da célula }
  Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
    AlturaTexto div 2;

  { Pinta o texto }
  StrGrd_Cheque.Canvas.TextRect(Rect, X, Y, Texto);

end;

procedure TFr_Pagar_Multipla.Ds_Qr_MostraSemDestinoStateChange(
  Sender: TObject);
begin
  Sb_Rela_Cheque.Enabled := Qr_MostraSemDestino.RecordCount >0;
end;

procedure TFr_Pagar_Multipla.tbs_boletoShow(Sender: TObject);
begin
  EditionControlBoleto;
  E_Dt_Ini_Bol.Date:=Now;
  E_Dt_Fim_Bol.Date:=Now;
end;

procedure TFr_Pagar_Multipla.RetiraDestinao1Click(Sender: TObject);
begin
  Pc_RetiraDestinacao;
  SB_BuscarClick(self);
end;

procedure TFr_Pagar_Multipla.ChangeBoleto;
begin
  ShowDataBoleto;
  Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
end;

procedure TFr_Pagar_Multipla.ChBx_FantasiaClick(Sender: TObject);
begin
  if ChBx_Fantasia.Checked then
  Begin
    Dbg_Parcela.Columns[7].Visible := True;
    Dbg_Parcela.Columns[8].Visible := FAlse;
    Dbg_Duplicatas.Columns[7].Visible := True;
    Dbg_Duplicatas.Columns[8].Visible := FAlse;
    Pc_Buscar_Parcela('N');
    Pc_Preencher_Parcelas;
    TotalizaPagar;
    ChBx_Nome.enabled := True;
    ChBx_Nome.Checked := False;
    ChBx_Fantasia.enabled := False;
  end;
end;

procedure TFr_Pagar_Multipla.ChBx_NomeClick(Sender: TObject);
begin
  if ChBx_Nome.Checked then
  Begin
    Dbg_Parcela.Columns[7].Visible := False;
    Dbg_Parcela.Columns[8].Visible := TRue;
    Dbg_Duplicatas.Columns[7].Visible := False;
    Dbg_Duplicatas.Columns[8].Visible := True;
    ChBx_Fantasia.Checked := False;
    Pc_Buscar_Parcela('N');
    Pc_Preencher_Parcelas;
    TotalizaPagar;
    ChBx_Nome.Enabled := False;
    ChBx_Fantasia.Checked := False;
    ChBx_Fantasia.Enabled := True;
  end;
end;

function TFr_Pagar_Multipla.Fc_Valida_Negociacao: Boolean;
begin
  result:=True;
  IF not Fc_VerificaPermissao('Fr_Pagar_Multipla','Contas a Pagar','NEGOCIAR',GB_Cd_Usuario,'S') then
  Begin
    Result:=FALSE;
    Exit;
  end;

  IF (cds_duplicatas.RecordCount = 0) then
  BEGIN
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por Favor Selecione um registro antes de continunar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Result:=FALSE;
    Exit;
  END;

  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  begin
    if cds_duplicatasFIN_OPERACAO.AsString = 'C' THEN
    BEGIN
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Por Favor Compense os créditos antes de Negociar.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      Result:=FALSE;
      Exit;
    END;
    cds_duplicatas.next;
  end;



end;

procedure TFr_Pagar_Multipla.Sb_NegociarClick(Sender: TObject);
Var
  Lc_Form : TFr_Negociar;
begin
  if Fc_Valida_Negociacao then
  Begin;
    tRY
      Lc_Form := TFr_Negociar.Create(nil);
      Lc_Form.It_Ctrl_Tela := 'Fr_Pagar_Multipla';
      Lc_Form.cds_Financeiro.Data := cds_duplicatas.data;
      Lc_Form.It_Cd_Empresa := It_Cd_Empresa;
      Lc_Form.It_Dt_Emissao := Date;
      Lc_Form.E_VL_Doc.Text := E_VL_Pagar.Text;
      if Fm_TipoPagamento.DBLCB_formaPagto.Text = '' then
        Lc_Form.It_FormaPagto := Fc_PegaParteFormaPgto('CARTEIRA')
      else
        Lc_Form.It_FormaPagto := Fm_TipoPagamento.DBLCB_formaPagto.KeyValue;
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
      SB_Retirar_TudoClick(Self);
    end;
  end;
end;

procedure TFr_Pagar_Multipla.Pc_Ativar_Botoes;
begin
  if (cds_duplicatasFIN_CODIGO.AsInteger = 0) then
  Begin
    Sb_Baixar.Enabled := False;
    Sb_Negociar.Enabled := False;
    SB_Boleto.Enabled := False;
    Sb_Cheque.Enabled := False;
    Sb_Negociar.Enabled := False;
    Sb_Destinar.Enabled := False;
    exit;
  end;

  Sb_Baixar.Enabled := True;
  Sb_Negociar.Enabled := True;
  SB_Boleto.Enabled := False;
  Sb_Cheque.Enabled := False;
  Sb_Destinar.Enabled := False;

  if Fm_TipoPagamento.DBLCB_formaPagto.Text = 'BOLETO' then
    Begin
    SB_Boleto.Enabled := True;
    Sb_Cheque.Enabled := False;
    Sb_Negociar.Enabled :=(cds_duplicatasFIN_CODIGO.AsInteger > 0);
    Sb_Destinar.Enabled := (cds_duplicatasFIN_CODIGO.AsInteger > 0);
    exit;
    end;

  if Fm_TipoPagamento.DBLCB_formaPagto.Text = 'CHEQUE' then
    Begin
    SB_Boleto.Enabled := False;
    Sb_Cheque.Enabled := True;
    Sb_Negociar.Enabled :=(cds_duplicatasFIN_CODIGO.AsInteger > 0);
    Sb_Destinar.Enabled := (cds_duplicatasFIN_CODIGO.AsInteger > 0);
    exit;
    end;
end;

procedure TFr_Pagar_Multipla.E_VL_PagoChange(Sender: TObject);
begin
  It_Vl_Pagto := StrToFloatDef(E_VL_Pago.Text,0);
  TotalizaBaixa;
end;

procedure TFr_Pagar_Multipla.SB_AdicionarClick(Sender: TObject);
begin
  Pc_Verificar_Situacao;
  if ValidaSelecaoUnicaParaBaixa then
  Begin
    if It_TipoTransacao = 'DESTINADAS' then Pc_Adicionar_Tudo;
    if It_TipoTransacao = 'NORMAL' then Pc_Adicionar;
    Pc_Ativar_Botoes;
    E_Dt_Pagto.Date := Date;
  End;
end;

procedure TFr_Pagar_Multipla.SaveBoleto;
begin
  FBoleto.Registro.Codemp     := It_Cd_Empresa;
  if Trim(E_NumBoleto.Text) ='' then
  Begin
    E_NumBoleto.Text := concat(
                          cds_duplicatasPED_NUMERO.AsString,
                          cds_duplicatasFIN_NR_PARCELA.AsString
                          );
  End;
  FBoleto.Registro.Numero := E_NumBoleto.Text;

  if FBoleto.Registro.CodQtc = 0 then
  Begin
    if It_Cd_Quitacao = 0 then  It_Cd_Quitacao := Fc_GeraCod_Baixa;
    FBoleto.Registro.CodQtc := It_Cd_Quitacao;
  End;
  FBoleto.Registro.Data       :=  Date;
  FBoleto.Registro.CodCtb     :=  DM.Qr_Carteiras.FieldByName('CTB_CODIGO').AsInteger;
  FBoleto.Registro.TxDesconto := 0;
  if ( FBoleto.Registro.Baixa = '') then
    FBoleto.Registro.Baixa      := 'N';
  FBoleto.Registro.Valor      := StrToFloatDef(E_VL_Pagar.Text,0);
  FBoleto.Registro.TxMora     := 0;
  FBoleto.Registro.CodCtb     := Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue;
  FBoleto.save;

end;

procedure TFr_Pagar_Multipla.SB_Add_TudoClick(Sender: TObject);
begin
  Pc_Verificar_Situacao;
  if ValidaSelecaoTodaParaBaixa then
  Begin
    Pc_Adicionar_Tudo;
    Pc_Ativar_Botoes;
    E_Dt_Pagto.Date := Date;
  End;
end;

procedure TFr_Pagar_Multipla.DBLCB_formaPagtoClick(Sender: TObject);
begin
  Pc_Ativar_Botoes;
end;

procedure TFr_Pagar_Multipla.Observaes1Click(Sender: TObject);
begin
  if not Assigned(fr_obs_nfe) then Application.CreateForm(tfr_obs_nfe,fr_obs_nfe);
  fr_obs_nfe.it_cd_nfl:= cds_ParcelasNFL_CODIGO.AsInteger;
  fr_obs_nfe.showmodal
end;

procedure TFr_Pagar_Multipla.Sb_InserirClick(Sender: TObject);
Var
  Lc_form : TFr_Lanca_Pagto;
begin
  It_Cd_Empresa := 0;
  E_VL_Juros.Text := '0,00';
  E_VL_Mora.Text := '0,00';
  E_VL_Desconto.Text:= '0,00';
  E_VL_Pagar.Text:= '0,00';
  Lc_form := TFr_Lanca_Pagto.create(self);
  Lc_form.Caption := 'Lançamento do Contas É Pagar';
  Lc_form.Grb_Empresa.Caption := 'Fornecedor';
  Lc_form.It_Tipo_Fin := 'PM';
  Lc_form.It_Operacao := 'D';
  try
    Lc_form.ShowModal;
  finally
    FreeAndNil(Lc_form);
  end;
end;

procedure TFr_Pagar_Multipla.SB_BuscarClick(Sender: TObject);
begin
  if Pg_Controle.ActivePageIndex = 0 then  Fm_TipoCobranca.DBLCB_formaPagto.SetFocus;
  Screen.Cursor:=crHourGlass;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaPagar;
  Screen.Cursor:=crDefault;
end;

procedure TFr_Pagar_Multipla.SB_AlterarClick(Sender: TObject);
begin
  if cds_Parcelas.RecordCount > 0 then
  BEgin
    if not Assigned(Fr_Fin_Edita) then Application.CreateForm(TFr_Fin_Edita, Fr_Fin_Edita);
    Fr_Fin_Edita.Financeiro.Registro.Codigo := cds_ParcelasFIN_CODIGO.AsInteger;
    Fr_Fin_Edita.Enabled := True;
    Fr_Fin_Edita.ShowModal;
  End;
end;

procedure TFr_Pagar_Multipla.SB_ExcluirClick(Sender: TObject);
begin
  if (cb_Situacao.ItemIndex > 1) then  exit;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir '+cds_ParcelasFIN_NUMERO.AsString+' de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                     [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then

  begin
    Pc_Log_Sistema(Gb_CodMha,
                   GB_Cd_Usuario,
                   now,
                   'Contas a Receber',
                   cds_ParcelasFIN_CODIGO.AsInteger,
                   'Exclusão Contas é pagar',
                   'FINANCEIRO: ' + cds_ParcelasFIN_NUMERO.AsString + ' | VALOR: ' + cds_ParcelasFIN_VL_PARCELA.AsString);
    Pc_Excluir_Contas_Pagar;
    Pc_Buscar_Parcela('N');
    Pc_Preencher_Parcelas;
  end;
end;

procedure TFr_Pagar_Multipla.ChBx_PeriodoClick(Sender: TObject);
begin
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

procedure TFr_Pagar_Multipla.ChBx_Periodo_bClick(Sender: TObject);
begin
  E_Dt_Ini_Bol.Enabled := ChBx_Periodo_b.Checked;
  E_Dt_Fim_Bol.Enabled := ChBx_Periodo_b.Checked;
end;

procedure TFr_Pagar_Multipla.Chbx_Periodo_CClick(Sender: TObject);
begin
  E_Dt_Ini_Chq.Enabled := Chbx_Periodo_C.Checked;
  E_Dt_Fim_Chq.Enabled := Chbx_Periodo_C.Checked;
end;

procedure TFr_Pagar_Multipla.tb_pesq_ChequeTerceiroShow(Sender: TObject);
begin
  E_Dt_Ini_Chq.Date := Date;
  E_Dt_Fim_Chq.Date := Date + 360;
end;

procedure TFr_Pagar_Multipla.TotalizaBaixa;
begin
  It_VL_Mora := StrToFloatDef(E_VL_Mora.Text,0);
  It_VL_Juros := StrToFloatDef(E_VL_Juros.Text,0);
  It_VL_Desconto := StrToFloatDef(E_VL_Desconto.Text,0);

  if (It_Vl_Baixa < 0) then It_Vl_Baixa := 0;
  E_VL_Pagar.Text := FloatToStrF((It_Vl_Baixa + It_VL_Juros + It_VL_Mora - It_VL_Desconto),ffFixed,10,2);
  if not E_VL_Pago.Focused then E_VL_Pago.Text := FloatToStrF(It_Vl_Pagto,ffFixed,10,2);

  if ((It_Vl_Baixa + It_VL_Juros + It_VL_Mora - It_VL_Desconto) - (It_Vl_Pagto + It_Vl_Credito) >= 0) then
    Begin
    Lb_Saldo_Parcial.Font.Color := clNavy;
    E_Vl_Saldo.Caption := FloatToStrf((It_Vl_Baixa + It_VL_Juros + It_VL_Mora - It_VL_Desconto) - (It_Vl_Pagto + It_Vl_Credito),ffFixed,10,2);
    E_vl_Saldo.Font.Color := clNavy;
    end
  else
    Begin
    Lb_Saldo_Parcial.Font.Color := clRed;
    E_Vl_Saldo.Caption := FloatToStrf((It_Vl_Pagto + It_Vl_Credito )- (It_Vl_Baixa + It_VL_Juros + It_VL_Mora - It_VL_Desconto),ffFixed,10,2);
    E_vl_Saldo.Font.Color := clRed;
    end;
end;

procedure TFr_Pagar_Multipla.TotalizaPagar;
Var
  LcTotal : Real;
  LcCredito : Real;
  LcPAgo : Real;
  LcSAldo : Real;
begin
  with Qr_Parcelas  do
  Begin
    LcTotal     := 0;
    LcCredito   := 0;
    LcPAgo  := 0;
    LcSAldo     := 0;
    First;
    while not Eof do
    Begin
      if FieldByName('FIN_OPERACAO').AsString = 'D' then
      Begin
        if FieldByName('FIN_BAIXA').AsString = 'N' then
          LcTotal   := LcTotal + FieldByNAme('FIN_VL_PARCELA').AsCurrency
        else
          LcTotal   := LcTotal + FieldByNAme('FIN_VL_PAGO').AsCurrency;
      End
      else
      Begin
        if FieldByName('FIN_BAIXA').AsString = 'N' then
          LcCredito := LcCredito + FieldByNAme('FIN_VL_PARCELA').AsCurrency
        else
          LcCredito := LcCredito + FieldByNAme('FIN_VL_PAGO').AsCurrency;
      End;
      if  FieldByNAme('FIN_BAIXA').asString = 'S' then
        LcPAgo  := LcPAgo + FieldByNAme('FIN_VL_PAGO').AsCurrency;
      LcSAldo     := LcTotal - LcCredito - LcPAgo;
      Next;
    end;
    E_Vl_Receber.Caption        := FloattoStrF(LcTotal,ffNumber,10,2);
    E_Vl_Cred_Ceder.Caption     := FloattoStrF(LcCredito,ffNumber,10,2);
    E_Vl_Recebido.Caption       := FloattoStrF(LcPAgo,ffNumber,10,2);
    E_Vl_Total_Receber.Caption  := FloattoStrF(LcSAldo,ffNumber,10,2);
  End;
end;

function TFr_Pagar_Multipla.ValidaInsertBoleto: Boolean;
begin
  Result := True;
end;

function TFr_Pagar_Multipla.ValidaSelecaoTodaParaBaixa: Boolean;
Var
  Lc_Supervisor : Boolean;
begin
  Result := true;
  Lc_Supervisor := Fc_VerificaPermissao('Fr_Pagar_Multipla','Contas a Pagar','SUPERVISOR',GB_Cd_Usuario,'N');

  if (Gb_Nivel = 0) and (not Lc_Supervisor ) then
  Begin
    if ( Fc_Tb_Geral('L','FIN_CP_AUTO_BAIXA','N') = 'S') then
    Begin
      while not cds_Parcelas.eof do
      Begin
        if cds_ParcelasFIN_AUTORIZADO.AsString = 'N' then
        Begin
          MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                         concat('Documento ', cds_ParcelasFIN_NUMERO.AsString)+EOLN+
                         'Precisa de Autorização. Verifique!'+EOLN,
                        ['OK'],[bEscape],mpAlerta);
          Result := False;
          Break;
        End;
        cds_Parcelas.Next;
      End;
    End;
  End;
end;

function TFr_Pagar_Multipla.ValidaSelecaoUnicaParaBaixa: Boolean;
Var
  Lc_Supervisor : Boolean;
begin
  Result := true;
  Lc_Supervisor := Fc_VerificaPermissao('Fr_Pagar_Multipla','Contas a Pagar','SUPERVISOR',GB_Cd_Usuario,'N');

  if (Gb_Nivel = 0) and (not Lc_Supervisor ) then
  Begin
    if ( Fc_Tb_Geral('L','FIN_CP_AUTO_BAIXA','N') = 'S') then
    Begin
      if cds_ParcelasFIN_AUTORIZADO.AsString = 'N' then
      Begin
        MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                       concat('Documento ', cds_ParcelasFIN_NUMERO.AsString)+EOLN+
                       'Precisa de Autorização. Verifique!'+EOLN,
                      ['OK'],[bEscape],mpAlerta);
        Result := False;
      End;
    End;
  End;
end;

function TFr_Pagar_Multipla.ValidateAutorizacaoDocumento: Boolean;
Var
  Lc_Supervisor : Boolean;
begin
  Result := true;
  if not Fc_VerificaPermissao('Fr_Pagar_Multipla','Contas a Pagar','SUPERVISOR',GB_Cd_Usuario,'S') then
  Begin
    Result := False;
    exit;
  End;



  if Rg_Doc_Authorization.ItemIndex = 2 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Para operar autorização o filtro de '+EOLN+
                   'autroziação deve estar Sim ou Não.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    exit;
  End;
end;

function TFr_Pagar_Multipla.ValidateCancelBoleto: boolean;
begin
  Result := True;
end;

function TFr_Pagar_Multipla.ValidateChangeBoleto: boolean;
begin
  Result := true;
  if not FBoleto.exist then
  Begin
    TMsgSetes.PararExecucao('Registro de boleto não encontrato');
    Result := False;
    exit;
  End;

end;

function TFr_Pagar_Multipla.ValidateDeleteBoleto: boolean;
begin
  Result := True;
  ShowDataBoleto;
  if not FBoleto.exist then
  Begin
    TMsgSetes.PararExecucao('Registro de boleto não encontrato');
    Result := False;
    exit;
  End;

  if (not TMsgSetes.Excluir) then
  Begin
    Result := False;
    exit;
  End;

end;

function TFr_Pagar_Multipla.ValidateSaveBoleto: boolean;
begin
  Result:=true;
  if  trim(Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text) ='' then
  begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Por favor informe a conta corrente.' + EOLN +
                   ' Escolha e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result:=false;
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
    exit;
  end;
end;

{-------------------------------------------------------------------------------
Nome : Felipe Correa
Data : 17/09/2010
Alte : Efetua a pesquisa quando for digitado no campo Código Fornecedor.
-------------------------------------------------------------------------------}



{-------------------------------------------------------------------------------
Nome : Felipe Correa
Data : 17/09/2010
Alte : Efetua a pesquisa quando for digitado no campo Código Cliente.
-------------------------------------------------------------------------------}



procedure TFr_Pagar_Multipla.Sb_ResumoClick(Sender: TObject);
begin
  Rg_Data.SetFocus;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  TotalizaPagar;
  Pg_Observacao.Visible := TRue;
end;

procedure TFr_Pagar_Multipla.Pc_Preencher_Parcelas;
Var
  I : Integer;
Begin
  Dbg_Parcela.Visible := False;
  with Qr_Parcelas  do
  Begin
    if not cds_Parcelas.active then cds_Parcelas.CreateDataSet;
    cds_Parcelas.LogChanges := False;
    cds_Parcelas.EmptyDataSet;
    First;
    while not Eof do
    Begin
      cds_Parcelas.Append;
      For I:= 0 to FieldCount -1 do
        cds_Parcelas.Fields[I].Value := Fields[I].Value;
      cds_Parcelas.Post;
      Next;
    end;
    cds_Parcelas.First;
  End;
  Dbg_Parcela.Visible := True;
  cds_Parcelas.LogChanges := True;
end;

procedure TFr_Pagar_Multipla.Pc_Define_Valores_Baixa;
Var
  Lc_I : Integer;
  Lc_data : String;
  Lc_valor : Real;
Begin
  It_Vl_Baixa := 0;
  It_Vl_Credito := 0;
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  Begin
    if cds_duplicatasFIN_OPERACAO.AsString = 'D' then
    Begin
      It_Vl_Baixa := It_Vl_Baixa + cds_duplicatasFIN_VL_PARCELA.AsCurrency;
    end
    else
    Begin
      It_Vl_Credito := It_Vl_Credito + cds_duplicatasFIN_VL_PARCELA.AsCurrency;
    end;
    cds_duplicatas.Next;
  end;
  It_Vl_Pagto := It_Vl_Baixa - It_Vl_Credito;
end;

function TFr_Pagar_Multipla.Fc_Verificar_Baixa_Parcela: Boolean;
Var
 Lc_SqlTxt : String;
 Lc_I : Integer;
begin
  Result := False;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := DM.IB_Transacao;
  Qr_Acao.SQL.Clear;
  Lc_SqlTxt := 'SELECT FIN_CODIGO FROM TB_FINANCEIRO WHERE (FIN_CODIGO=:FIN_CODIGO) AND (FIN_BAIXA = ''S'') ';
  Qr_Acao.SQL.Add(Lc_SqlTxt);
  if DM.IBT_Financeiro.InTransaction then DM.IBT_Financeiro.Commit;
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  Begin
    if not DM.IBT_Financeiro.InTransaction then DM.IBT_Financeiro.StartTransaction;
    Qr_Acao.Active := False;
    Qr_Acao.Transaction := DM.IB_Transacao;
    Qr_Acao.ParamByName('FIN_CODIGO').AsInteger := cds_duplicatasFIN_CODIGO.AsInteger;
    Qr_Acao.Active := True;
    Qr_Acao.FetchAll;
    IF Qr_Acao.RecordCount > 0 then
    Begin
      MensagemPadrao('Aviso Importante', ATENCAO + EOLN + EOLN +
                     'A Duplicata Nº '+ cds_duplicatasFIN_NUMERO.AsString + ' já foi baixada em outra Instência.' + EOLN +
                     'Esta parcela será retirada desta baixa.' + EOLN+
                     'Verifique e reinicie o processo de baixa.' + EOLN,
                     ['OK'], [bEscape], mpErro);
       SB_RetirarClick(Self);
       Result := True;
       exit;
    end;
    cds_duplicatas.next;
    if DM.IBT_Financeiro.InTransaction then DM.IBT_Financeiro.Commit;
  end;
end;

procedure TFr_Pagar_Multipla.Fm_TipoPagamentoDBLCB_FormaPagtoClick(
  Sender: TObject);
begin
  Pc_Ativar_Botoes;
end;

procedure TFr_Pagar_Multipla.Pc_Baixar_Duplicatas;
Var
  Lc_I : Integer;
  Lc_Rel_Par_Total : real;
  Lc_Vl_Credito : Real;
  Lc_Vl_Debito : Real;
  Lc_Saldo_fornecedor : Real;
  Lc_Saldo_Parcial : Real;
BEgin
  Lc_Saldo_fornecedor := 0;
  Lc_Saldo_Parcial := 0;
  It_Oper_Reg         := 'B';
  It_Data             := Date;
  It_Cd_FmaPagto      := Fm_TipoPagamento.DBLCB_formaPagto.KeyValue;
  It_Dt_Baixa         := Date;
  It_Baixa            := 'S';
  It_Etapa            := 'N';
  It_Tipo             := 'PA';
  It_Situacao         := 'D';
  It_Dt_Pago          := E_Dt_Pagto.Date;
  It_cd_Cheque     := 0;
  Lc_Saldo_fornecedor := StrToFloatDef(E_VL_Pago.Text,0);
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  Begin
    if (cds_duplicatasFIN_OPERACAO.AsString = 'C' ) then
    Begin
      It_Cd_Financeiro := cds_duplicatasFIN_CODIGO.AsInteger;
      It_Nr_Financeiro := cds_duplicatasFIN_NUMERO.AsString;
      It_Nr_Parcela    := cds_duplicatasFIN_NR_PARCELA.AsInteger;
      It_Dt_Vencimento := cds_duplicatasFIN_DT_VENCIMENTO.AsDateTime;
      It_cd_pedido     := cds_duplicatasPED_CODIGO.AsInteger;
      It_Cd_Nota       := cds_duplicatasNFL_CODIGO.AsInteger;
      It_Vl_Parcela    := cds_duplicatasFIN_VL_PARCELA.AsCurrency;
      if (Lc_Vl_Credito < It_Vl_Parcela) then
      Begin
        Lc_Vl_Credito      := It_Vl_Parcela;
      end;
      It_cd_Cheque     := cds_duplicatasFIN_CODCHQ.AsInteger;
      It_Vl_Juros      := 0;
      It_Vl_Mora       := 0;
      It_Vl_Desconto   := 0;
      It_Operacao      := 'D';
      It_Vl_Pago       := It_Vl_Parcela;
      Pc_Baixar_Valor;
      Lc_Saldo_fornecedor := Lc_Saldo_fornecedor + It_Vl_Parcela;
    end;
    cds_duplicatas.next;
  end;

  //Verfiica o Valor total do Debito a pagar
  Lc_Vl_Debito := 0;
  if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
  cds_duplicatas.First;
  while not cds_duplicatas.Eof do
  Begin
    if (cds_duplicatasFIN_OPERACAO.AsString = 'D' ) then
      Lc_Vl_Debito := Lc_Vl_Debito + cds_duplicatasFIN_VL_PARCELA.AsCurrency;
    cds_duplicatas.Next;
  End;

  //Verifica se o Saldo do Cliente É Maior que Zero para continuar a operação
  If (Lc_Saldo_fornecedor + It_Vl_Desconto) > 0 then
  Begin
    if not cds_duplicatas.Active then cds_duplicatas.CreateDataSet;
    cds_duplicatas.First;
    while not cds_duplicatas.Eof do
    Begin
      //Verifica se É Débito do cliente
      if (cds_duplicatasFIN_OPERACAO.AsString = 'D' ) then
      Begin
        It_Cd_Financeiro := cds_duplicatasFIN_CODIGO.AsInteger;
        It_Nr_Financeiro := cds_duplicatasFIN_NUMERO.AsString;
        It_Nr_Parcela    := cds_duplicatasFIN_NR_PARCELA.AsInteger;
        It_Dt_Vencimento := cds_duplicatasFIN_DT_VENCIMENTO.AsDateTime;
        It_cd_pedido     := cds_duplicatasPED_CODIGO.AsInteger;
        It_Cd_Nota       := cds_duplicatasNFL_CODIGO.AsInteger;
        It_Vl_Parcela    := cds_duplicatasFIN_VL_PARCELA.AsCurrency;
        if (Lc_Vl_Credito < It_Vl_Parcela) then
        Begin
          Lc_Vl_Credito      := It_Vl_Parcela;
        end;

        //Verifica a proporcação entre parcelas e valor a receber para distribuiro os juros
        if Lc_Vl_Debito > 0 then
          Lc_Rel_Par_Total := It_Vl_Parcela / Lc_Vl_Debito
        else
          Lc_Rel_Par_Total := 1;       
        It_Vl_Juros    := StrToFloatDef(E_VL_Juros.Text,0)* Lc_Rel_Par_Total ;
        It_Vl_Mora     := StrToFloatDef(E_VL_Mora.Text,0)* Lc_Rel_Par_Total ;
        It_Vl_Desconto := StrToFloatDef(E_VL_Desconto.Text,0)* Lc_Rel_Par_Total;
        It_Operacao      := 'D';
        if ((Lc_Saldo_fornecedor + It_Vl_Desconto)  >= It_Vl_Parcela) then
          Begin
          It_Vl_Pago       := (It_Vl_Parcela + It_Vl_Juros + It_Vl_Mora ) - It_Vl_Desconto;
          Pc_Baixar_Valor;
          Lc_Saldo_fornecedor := Lc_Saldo_fornecedor - It_Vl_Pago;
          end
        else
          Begin
          if Lc_Saldo_fornecedor = 0 then
          Begin
            Pc_Retirar_Destinacao(cds_duplicatasFIN_CODIGO.AsInteger);
          end
          else
          Begin
            //Guarda o Saldo do cliente para Gerar a Baixa Parcial
            Lc_Saldo_Parcial := (( It_Vl_Parcela - Lc_Saldo_fornecedor ) + It_Vl_Juros + It_Vl_Mora ) - It_Vl_Desconto;
            //Faz a Baixa com o valor parcial
            It_Vl_Pago     := Lc_Saldo_fornecedor;
            Pc_Baixar_Valor;
            //Gera uma Parcial com o saldo parcial
            Lc_Saldo_Parcial := StrToFloatDef(FloatToStrf(Lc_Saldo_Parcial,ffFixed,10,2),0);
            It_Vl_Juros    := 0;
            It_Vl_Mora     := 0;
            It_Vl_Desconto := 0;
            Pc_Gerar_Baixa_Parcial(Lc_Saldo_Parcial);
            Lc_Saldo_fornecedor := 0;
          end;
        end;
      end;
      cds_duplicatas.Next;
    end;
  end;
  //verifica despois de passar na lista se sobrou saldo para gerar um parcela parcial
  if (Lc_Saldo_fornecedor - It_Vl_Desconto) > 0 then
  Begin
    //Gera uma Parcial com o saldo parcial
    Lc_Saldo_Parcial := Lc_Saldo_fornecedor * -1;
    Pc_Gerar_Baixa_Parcial(Lc_Saldo_Parcial);
    Lc_Saldo_fornecedor := 0;
  end;
end;

procedure TFr_Pagar_Multipla.Pc_Processo_Baixa;
Var
  Lc_I : Integer;
  Lc_Cd_Quitacao : Integer;
Begin
  Pc_Destinar('B');
  //Baixa os creditos dos clientes e soma ao saldo de Credtios a utilizar
  Pc_Baixar_Duplicatas;
  Lc_Cd_Quitacao := It_Cd_Quitacao;
  Pc_ControleBloqueioCliente(It_Cd_Empresa,'L');
  Pc_Finalizar_Baixa;
  MensagemPadrao(MENSAGEM,'S U C E S S O!.'+EOLN+EOLN+
                'Documentos Baixados com Sucesso.'+EOLN+
                'Código da Baixa: '+IntToStr(Lc_Cd_Quitacao) +EOLN,
               ['OK'],[bEscape],mpInformacao);

end;


procedure TFr_Pagar_Multipla.Pc_Gerar_Baixa_Parcial(Pc_Vl_Saldo:Real);
Var
  Lc_Saldo_Baixa : real;
  Lc_Saldo_Texto : String;
  Lc_cd_quitacao:integer;
Begin
  Lc_Saldo_Baixa := StrToFloatDef(E_VL_Pagar.Text,0) - (StrToFloatDef(E_VL_Pago.Text,0) + It_Vl_Credito);
  Lc_Saldo_Texto := FloatToStrf(Lc_Saldo_Baixa,ffFixed,10,2);
  Lc_Saldo_Baixa := StrToFloatDef(Lc_Saldo_Texto,0);
  if Lc_Saldo_Baixa = 0 then exit;
  It_Oper_Reg := 'I';
  It_Cd_Financeiro := 0;
  It_Vl_Juros := 0;
  It_Vl_Mora := 0;
  It_Vl_Desconto := 0;
  It_Vl_Pago := 0;
  It_Nr_Parcela := 1;
  It_Tipo := 'PA';
  It_Etapa := 'N';
  It_Baixa := 'N';
  It_Situacao := 'N';
  Lc_cd_quitacao:= It_Cd_Quitacao;
  It_Cd_Quitacao := 0;

  if not cds_duplicatas.Active then cds_duplicatas.active := True;
  cds_duplicatas.Last;
  It_Nr_Financeiro := cds_duplicatasFIN_NUMERO.AsString;
  It_Nr_Parcela    := cds_duplicatasFIN_NR_PARCELA.AsInteger;
  It_Dt_Vencimento := cds_duplicatasFIN_DT_VENCIMENTO.AsDateTime;
  It_cd_pedido     := cds_duplicatasPED_CODIGO.AsInteger;
  It_Cd_Nota       := cds_duplicatasNFL_CODIGO.AsInteger;
  It_cd_Cheque     := cds_duplicatasFIN_CODCHQ.AsInteger;
  It_cd_Cheque     := cds_duplicatasFIN_CODCHQ.AsInteger;

  if ( Lc_Saldo_Baixa > 0 ) then
  Begin
    It_Vl_Parcela := Lc_Saldo_Baixa;
    It_Operacao := 'D';
    Pc_Baixar_Valor;
  end;

  if ( Lc_Saldo_Baixa < 0 ) then
  Begin
    It_Vl_Parcela := (Lc_Saldo_Baixa * -1);
    It_Operacao := 'C';
    Pc_Baixar_Valor;
  end;
  //devolver o codido da quitacao
  It_Cd_Quitacao := Lc_cd_quitacao;
end;

Procedure TFr_Pagar_Multipla.Pc_Definir_Grade_Cheque;
Begin
  //Definir tamanho Da grade de Cheques
  It_Cheque := 0;
  it_Oper_Reg_Chq := 'I';
  StrGrd_Cheque.ColWidths[0]:=17;
  StrGrd_Cheque.ColWidths[1]:=-1;
  StrGrd_Cheque.ColWidths[2]:=310;
  StrGrd_Cheque.ColWidths[3]:=77;
  StrGrd_Cheque.ColWidths[4]:=76;
  StrGrd_Cheque.ColWidths[5]:=87;
  StrGrd_Cheque.ColWidths[6]:=64;
  StrGrd_Cheque.ColWidths[7]:=80;
  StrGrd_Cheque.ColWidths[8]:=-1;
  StrGrd_Cheque.ColWidths[9]:=-1;
  StrGrd_Cheque.ColWidths[10]:=-1;
  StrGrd_Cheque.ColWidths[11]:=-1;
  StrGrd_Cheque.ColWidths[12]:=-1;
  StrGrd_Cheque.ColWidths[13]:=-1;
  StrGrd_Cheque.ColWidths[14]:=-1;
  StrGrd_Cheque.ColWidths[15]:=-1;
  StrGrd_Cheque.ColWidths[16]:=-1;
  StrGrd_Cheque.Cols[2].Add('Emitente');
  StrGrd_Cheque.Cols[3].Add('Banco');
  StrGrd_Cheque.Cols[4].Add('Agência');
  StrGrd_Cheque.Cols[5].Add('N. Cheque');
  StrGrd_Cheque.Cols[6].Add('Valor');
  StrGrd_Cheque.Cols[7].Add('Pré-Datado');
  StrGrd_Cheque.Cols[8].Add('Devolvido');
  StrGrd_Cheque.Cols[9].Add('Dt_Quitação');
  StrGrd_Cheque.Cols[10].Add('Tipo');
  StrGrd_Cheque.Cols[11].Add('Estado');
  StrGrd_Cheque.Cols[12].Add('Retorno');
  StrGrd_Cheque.Cols[13].Add('Qt_Rec');
  StrGrd_Cheque.Cols[14].Add('Qt_pag');
  StrGrd_Cheque.Cols[15].Add('CodFor');
  StrGrd_Cheque.Cols[16].Add('Conta');
end;
    
procedure TFr_Pagar_Multipla.Rg_DataClick(Sender: TObject);
begin
  if (Rg_Data.ItemIndex = 0) then
  Begin
    Cb_Situacao.Enabled := True;
    cb_Situacao.ItemIndex := 0;
  end
  else
  Begin
    cb_Situacao.Enabled := False;
    Cb_Situacao.ItemIndex := 2;
  end;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  if cb_Situacao.ItemIndex = 0 then It_Cd_Quitacao := 0;    
end;

procedure TFr_Pagar_Multipla.Rg_Doc_AuthorizationClick(Sender: TObject);
begin
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
end;

procedure TFr_Pagar_Multipla.Label10Click(Sender: TObject);
begin
  pg_Observacao.Visible := False;
end;

procedure TFr_Pagar_Multipla.Lb_Close_totalizadorClick(Sender: TObject);
begin
  Pg_Observacao.Visible := False;
end;

procedure TFr_Pagar_Multipla.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
  begin
    It_Inserir    := True;
    It_Alterar    := True;
    It_Excluir    := True;
    It_Visualizar := True;
  end
  else
  begin
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
    if not It_Visualizar then exit;
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
  end;
  SB_Inserir.Enabled:= It_Inserir;
  SB_Alterar.Enabled:= It_Alterar;
  SB_Excluir.Enabled:= It_Excluir;
end;

procedure TFr_Pagar_Multipla.FormShow(Sender: TObject);
begin
  Pc_PermissaoBotao('Contas a Pagar');
  Pc_Ativar_Tabelas;
  BuscaAutomatica;
end;

procedure TFr_Pagar_Multipla.InsertBoleto;
begin
  AtivarCarteiraCobranca;
  FBoleto.clear;
  Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
end;

procedure TFr_Pagar_Multipla.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Busca
    CarregaImagemBotao(SB_Inserir,'INSERIR');
    CarregaImagemBotao(SB_Alterar,'ALTERAR');
    CarregaImagemBotao(SB_Excluir,'EXCLUIR');
    CarregaImagemBotao(SB_Buscar,'BUSCAR');
    //sb_RECIBO.Glyph.Assign(Fc_CarregaImagemBotao('RECIBO'));
    //CHEQUE
    CarregaImagemBotao(Sb_InsereCheque,'INSERIR');
    CarregaImagemBotao(Sb_AlteraCheque,'ALTERAR');
    CarregaImagemBotao(Sb_ExcluiCheque,'EXCLUIR');
    CarregaImagemBotao(Sb_GravaCheque,'GRAVAR');
    CarregaImagemBotao(Sb_CancelaCheque,'CANCELAR');
    CarregaImagemBotao(Sb_terceiro,'CHEQUETERCEIRO');
    CarregaImagemBotao(Sb_VoltaCheque,'VOLTAR');
    //BOLETO
    CarregaImagemBotao(Sb_InsereBoleto,'INSERIR');
    CarregaImagemBotao(Sb_AlteraBoleto,'ALTERAR');
    CarregaImagemBotao(Sb_ExcluiBoleto,'EXCLUIR');
    CarregaImagemBotao(Sb_GravaBoleto,'GRAVAR');
    CarregaImagemBotao(Sb_CancelaBoleto,'CANCELAR');
    CarregaImagemBotao(Sb_BuscaBoleto,'BUSCAR');
    CarregaImagemBotao(Sb_VoltaBoleto,'VOLTAR');
    //CHEQUE TERCEIRO
    CarregaImagemBotao(Sb_BuscarCheque,'BUSCAR');
    CarregaImagemBotao(Sb_Rela_Cheque,'DESTINAR');
    CarregaImagemBotao(Sb_VoltarChq_Terc,'VOLTAR');
    //BAIXAR
    CarregaImagemBotao(Sb_Cheque,'CHEQUE');
    CarregaImagemBotao(SB_Boleto,'BOLETO');
    CarregaImagemBotao(Sb_Destinar,'DESTINAR');
    CarregaImagemBotao(Sb_Baixar,'FATURAR');
    CarregaImagemBotao(Sb_Negociar,'NEGOCIAR');
    CarregaImagemBotao(SB_Sair_0,'SAIR');
  END;
end;

procedure TFr_Pagar_Multipla.Pc_Retirar_Destinacao(Pc_cd_Financeiro: Integer);
Var
  Lc_Sql_Txt : String;
Begin
  if not (Cb_Situacao.ItemIndex = 1) then exit;
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := DM.IB_Transacao;
  if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
  Qr_Acao.SQL.Clear;
  Lc_Sql_Txt := 'UPDATE TB_FINANCEIRO '+
               'SET '+
               '  FIN_CODQTC = 0, '+
               '  FIN_SITUACAO = ''N'' '+
               'WHERE (FIN_CODIGO =:FIN_CODIGO) ';
  Qr_Acao.SQL.Add(Lc_Sql_Txt);
  Qr_Acao.ParamByName('FIN_CODIGO').AsInteger := Pc_cd_Financeiro;
  Qr_Acao.Active := True;
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
end;

procedure TFr_Pagar_Multipla.AplicarPlanoContas1Click(Sender: TObject);
begin
  if Fc_ValidaOperacaoPArcela then
  Begin
    Pc_AplicarPlanoContasFinanceiro( cds_ParcelasFIN_CODIGO.AsInteger);
    SB_BuscarClick(Self);
  End;
end;

procedure TFr_Pagar_Multipla.CancelBoleto;
begin

end;

procedure TFr_Pagar_Multipla.Cb_SituacaoChange(Sender: TObject);
begin
  Pc_Buscar_Parcela('N');
  Pc_Preencher_Parcelas;
  if Cb_Situacao.ItemIndex = 0 then It_Cd_Quitacao := 0;
end;

function  TFr_Pagar_Multipla.Fc_ValidaAdicionaBaixa():boolean;
Begin
  Result := true;
  if Cb_Situacao.ItemIndex > 1 then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Para adicionar registro para baixa.'+EOLN+
                   'A situação deve ser normal ou Destinada.'+EOLN+
                   'Verifique para continuar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  end;
end;


function  TFr_Pagar_Multipla.Fc_ValidaOperacaoPArcela():boolean;
Begin
  Result := true;
  if cds_Parcelas.RecordCount = 0 then
  Begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Não há registro selecionado.' + EOLN +
                   ' Verifique antes de continuar.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
    Exit;
  end;
end;

procedure TFr_Pagar_Multipla.AtivarCarteiraCobranca;
begin
  DM.Qr_Carteiras.Active := False;
  DM.Qr_Carteiras.ParamByName('CTB_CODMHA').AsInteger := Gb_CodMha;
  DM.Qr_Carteiras.Active := True;
end;

procedure TFr_Pagar_Multipla.AtivarInativar1Click(Sender: TObject);
Var
  Lc_Escolha : Integer;
Begin
  if Fc_ValidaOperacaoParcela then
  Begin
    Lc_Escolha:=(MensagemPadrao(TITULO_INFORMACAO,
                                'Escolha o Tipo de Movimento.',
                                ['ATIVAR','DESATIVAR','CANCELAR'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
    case Lc_Escolha of
      0:Pc_AtivarFinanceiro(cds_ParcelasFIN_CODIGO.AsInteger,True);
      1:Pc_AtivarFinanceiro( cds_ParcelasFIN_CODIGO.AsInteger,False);
      end;
    if (Lc_Escolha < 2 ) then SB_BuscarClick(Sender);
  end;
end;

procedure TFr_Pagar_Multipla.AutorizacaoDocumento;
Var
  Lc_Form : TTasFinancialAuthorization;
begin
  try
    Lc_Form := TTasFinancialAuthorization.Create(nil);
    Lc_Form.Autorizados := (Rg_Doc_Authorization.ItemIndex = 0);
    Lc_Form.Documentos := cds_Parcelas;
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Pagar_Multipla.Autorizarselecionado1Click(Sender: TObject);
begin
  if ValidateAutorizacaoDocumento then
  Begin
    AutorizacaoDocumento;
    Pc_Buscar_Parcela('N');
    Pc_Preencher_Parcelas;
  End;
end;

procedure TFr_Pagar_Multipla.BuscaAutomatica;
begin
  if E_BuscaPedido.Text <> '' then
    SB_BuscarClick(Self);
end;

procedure TFr_Pagar_Multipla.EditionControlBoleto;
begin
  Sb_InsereBoleto.Enabled   := (FEditionStateBoleto = 'B') and ( FBoleto.Registro.Baixa <> 'S');
  Sb_AlteraBoleto.Enabled   := (FEditionStateBoleto = 'B') and ( FBoleto.Registro.Codigo > 0 ) and ( FBoleto.Registro.Baixa <> 'S');
  Sb_ExcluiBoleto.Enabled   := (FEditionStateBoleto = 'B') and ( FBoleto.Registro.Codigo > 0 ) and ( FBoleto.Registro.Baixa <> 'S');
  Sb_GravaBoleto.Enabled    := (FEditionStateBoleto = 'I') or (FEditionStateBoleto = 'E');
  Sb_CancelaBoleto.Enabled  := (FEditionStateBoleto = 'I') or (FEditionStateBoleto = 'E');
  pnl_boleto_fundo.Enabled  := (FEditionStateBoleto = 'I') or (FEditionStateBoleto = 'E');
  Sb_BuscaBoleto.Enabled    := (FEditionStateBoleto = 'B');
  Sb_VoltaBoleto.Enabled    := (FEditionStateBoleto = 'B');
  Sb_Inserir.Enabled        := not (FEditionStateBoleto = 'I');
  SB_Boleto.Enabled         := not (FEditionStateBoleto = 'I');
  SB_Buscar.Enabled         := not (FEditionStateBoleto = 'I');
  Sb_Destinar.Enabled       := not (FEditionStateBoleto = 'I');
  Sb_Baixar.Enabled         := not (FEditionStateBoleto = 'I');
  Sb_Negociar.Enabled       := not (FEditionStateBoleto = 'I');
  SB_Sair_0.Enabled         := not (FEditionStateBoleto = 'I');
  E_Dt_Ini_Bol.Enabled      := ChBx_Periodo_b.Checked;
  E_Dt_Fim_Bol.Enabled      := ChBx_Periodo_b.Checked;

end;

procedure TFr_Pagar_Multipla.E_Busca_Cd_EmpresaExit(Sender: TObject);
begin
  if ChBx_Nome.checked then
    E_Busca_Empresa.Text := Fc_BuscaNomeFornecedor('EMP_NOME',E_Busca_Cd_Empresa.Text)
  else
    E_Busca_Empresa.Text := Fc_BuscaNomeFornecedor('EMP_FANTASIA',E_Busca_Cd_Empresa.Text);
end;

procedure TFr_Pagar_Multipla.Sb_Pesq_EmpresaClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(2,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Busca_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    E_Busca_Empresa.Text := Lc_Retorno.It_Dados[1,1];
  end;
end;

end.
