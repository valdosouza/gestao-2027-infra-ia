unit Un_ContasReceberBoleto;

interface


uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, ACBrUtil, UN_Sistema, Vcl.ComCtrls, Vcl.DBCtrls, ControllerBase, ACBrBoleto, ControllerEndereco, Datasnap.DBClient;

type
//  TStringArray = array of Integer;

  TFr_ContasReceberBoleto = class(TForm)
    Qr_BuscaParcela: TSTQuery;
    Ds_BuscaParcelas: TDataSource;
    Qr_BuscaParcelaFIN_CODIGO: TIntegerField;
    Qr_BuscaParcelaNFL_NUMERO: TStringField;
    Qr_BuscaParcelaPED_NUMERO: TIntegerField;
    Qr_BuscaParcelaFIN_NUMERO: TStringField;
    Qr_BuscaParcelaFIN_DT_VENCIMENTO: TDateField;
    Qr_BuscaParcelaFIN_CODEMP: TIntegerField;
    Qr_BuscaParcelaEMP_FANTASIA: TStringField;
    Qr_BuscaParcelaEMP_NOME: TStringField;
    Qr_BuscaParcelaFIN_VL_PARCELA: TBCDField;
    Qr_BuscaParcelaFIN_BAIXA: TStringField;
    Qr_BuscaParcelaFIN_SITUACAO: TStringField;
    Qr_BuscaParcelaFIN_CODQTC: TIntegerField;
    Qr_BuscaParcelaFIN_CODFPG: TIntegerField;
    Qr_BuscaParcelaPED_CODIGO: TIntegerField;
    Qr_BuscaParcelaNFL_CODIGO: TIntegerField;
    Qr_BuscaParcelaFIN_TIPO: TStringField;
    Qr_BuscaParcelaFIN_DT_PAGTO: TDateField;
    Qr_BuscaParcelaFIN_OPERACAO: TStringField;
    Qr_BuscaParcelaFIN_ETAPA: TStringField;
    Qr_BuscaParcelaFIN_CODMHA: TIntegerField;
    Qr_BuscaParcelaFIN_CODCHQ: TIntegerField;
    Qr_BuscaParcelaFIN_NR_PARCELA: TIntegerField;
    Qr_BuscaParcelaFIN_DATA: TDateField;
    Qr_BuscaParcelaFIN_CODPED: TIntegerField;
    Qr_BuscaParcelaFIN_ATIVO: TStringField;
    Qr_BuscaParcelaFIN_VL_PAGO: TBCDField;
    Qr_BuscaParcelaFIN_VL_JUROS: TBCDField;
    Qr_BuscaParcelaFIN_VL_MORA: TBCDField;
    Qr_BuscaParcelaFIN_VL_DESCONTO: TBCDField;
    Ds_ContaBancaria: TDataSource;
    Pg_ContasReceberBoleto: TPageControl;
    tbs_ContasReceber: TTabSheet;
    pn_geral: TPanel;
    SB_Cr_Add_Tudo: TSpeedButton;
    SB_Cr_Retirar_Tudo: TSpeedButton;
    StrGrd_Parcela: TStringGrid;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Lb_Vl_Credito: TLabel;
    Lb_Vl_Receber: TLabel;
    Lb_Vl_Vencer: TLabel;
    Lb_Vl_Vencida: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label1: TLabel;
    Lb_Vl_Cr_selecionado: TLabel;
    tbs_Boletos: TTabSheet;
    pnl_botoes: TPanel;
    SB_BuscaParcela: TSpeedButton;
    SB_Boleto: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Panel1: TPanel;
    Sb_Sair_1: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Sb_Remessa: TSpeedButton;
    Sb_RetornoRemessa: TSpeedButton;
    Panel2: TPanel;
    StrGrd_Boleto: TStringGrid;
    GroupBox2: TGroupBox;
    Label18: TLabel;
    Lb_Vl_Bl_selecionado: TLabel;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    E_Busca_Boleto: TEdit;
    Rg_Data_Boleto: TRadioGroup;
    Sb_Negociar: TSpeedButton;
    Sb_BuscaBoleto: TSpeedButton;
    Qr_BuscaBoleto: TSTQuery;
    Ds_BuscaBoleto: TDataSource;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    L_CodigoCliente: TLabel;
    E_BuscaPedido: TEdit;
    E_Busca_Empresa: TEdit;
    E_BuscaNota: TEdit;
    E_BuscaFinanceiro: TEdit;
    ChBx_Nome: TCheckBox;
    ChBx_Fantasia: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    E_cd_Empresa: TEdit;
    Qr_BuscaBoletoNFL_NUMERO: TStringField;
    Qr_BuscaBoletoPED_NUMERO: TIntegerField;
    Qr_BuscaBoletoFIN_NUMERO: TStringField;
    Qr_BuscaBoletoFIN_DT_VENCIMENTO: TDateField;
    Qr_BuscaBoletoFIN_CODEMP: TIntegerField;
    Qr_BuscaBoletoEMP_FANTASIA: TStringField;
    Qr_BuscaBoletoEMP_NOME: TStringField;
    Qr_BuscaBoletoFIN_VL_PARCELA: TBCDField;
    Qr_BuscaBoletoFIN_DT_PAGTO: TDateField;
    Qr_BuscaBoletoFIN_VL_PAGO: TBCDField;
    Qr_BuscaBoletoCTB_COMPLETO: TStringField;
    Qr_Boleto: TSTQuery;
    Qr_BoletoBLT_DT_VENCIMENTO: TDateField;
    Qr_BoletoBLT_DATA: TDateField;
    Qr_BoletoBLT_NUMERO: TStringField;
    Qr_BoletoBLT_NOSSONUMERO: TStringField;
    Qr_BoletoEPD_SIGLA: TStringField;
    Qr_BoletoBLT_ACEITE: TStringField;
    Qr_BoletoBLT_DT_PROCESSAMENTO: TDateField;
    Qr_BoletoCTR_NUMERO: TStringField;
    Qr_BoletoEMP_CNPJ: TStringField;
    Qr_BoletoEND_ENDER: TStringField;
    Qr_BoletoEND_NUMERO: TStringField;
    Qr_BoletoEND_BAIRRO: TStringField;
    Qr_BoletoCDD_DESCRICAO: TStringField;
    Qr_BoletoUFE_SIGLA: TStringField;
    Qr_BoletoEND_CEP: TStringField;
    Qr_BoletoBLE_LOCALPAG: TStringField;
    Qr_BoletoBLT_VALOR: TBCDField;
    Qr_BoletoBLT_VL_MORA: TBCDField;
    Qr_BoletoBLT_VL_DESCONTO: TBCDField;
    Qr_BoletoBLT_TX_MULTA: TBCDField;
    Qr_BoletoBLE_INSTR_1: TStringField;
    Qr_BoletoBLE_INSTR_2: TStringField;
    Qr_BoletoBLT_INSTRUCOES: TMemoField;
    Qr_BoletoBLT_DT_PROTESTO: TDateField;
    Qr_BuscaBoletoBLT_NUMERO: TStringField;
    SB_Bl_Add_Tudo: TSpeedButton;
    SB_Bl_Retirar_Tudo: TSpeedButton;
    Qr_BuscaBoletoBLT_REMESSA: TIntegerField;
    Sb_BoletoPDF: TSpeedButton;
    Qr_BoletoBLT_TX_DESCONTO: TBCDField;
    Qr_BoletoBLT_TX_JUROS: TBCDField;
    Qr_BoletoBLT_TX_MORA: TBCDField;
    Qr_BoletoBLT_VL_TARIFA: TBCDField;
    Qr_BoletoBLT_DT_DESC_VENC: TDateField;
    Qr_BoletoEMP_NOME: TStringField;
    Qr_BoletoBLE_VL_MORA_MIN: TBCDField;
    Qr_BoletoBLT_CODIGO: TIntegerField;
    Qr_BuscaBoletoBLT_CODIGO: TIntegerField;
    SB_Excluir: TSpeedButton;
    Qr_BuscaBoletoFIN_CODIGO: TIntegerField;
    OpenDialog1: TOpenDialog;
    Qr_BuscaBoletoBLT_MSG_RETORNO: TStringField;
    Qr_BoletoCTR_TIPO_EMISSAO: TStringField;
    DBLCB_CarteiraCobranca: TDBLookupComboBox;
    Sb_Pesq_Empresa: TSpeedButton;
    DBLCB_Msg_Retorno: TDBLookupComboBox;
    Label2: TLabel;
    Label8: TLabel;
    Sb_Envia: TSpeedButton;
    Sb_AlteraDataValor: TSpeedButton;
    SB_BaixaManual: TSpeedButton;
    Qr_BuscaBoletoEMP_EMAIL: TStringField;
    Qr_BuscaBoletoBLT_NOSSONUMERO: TStringField;
    Qr_BuscaBoletoBLT_CODQTC: TIntegerField;
    Qr_BoletoEND_CONTATO: TStringField;
    Qr_Msg_Retorno: TSTQuery;
    Ds_Msg_Retorno: TDataSource;
    Qr_BoletoBLT_DIAS_PROTESTO: TIntegerField;
    Qr_BoletoBLT_TIPO_DIA: TStringField;
    GroupBox5: TGroupBox;
    Rg_Data_CtaReceber: TRadioGroup;
    DBLCB_Nr_Remessa: TDBLookupComboBox;
    Label9: TLabel;
    Ds_Nr_Remessa: TDataSource;
    Qr_Nr_Remessa: TSTQuery;
    Qr_BoletoFIN_CODQTC: TIntegerField;
    Qr_BoletoBCO_NUMERO: TStringField;
    Qr_BuscaParcelaEMP_EMAIL: TStringField;
    Qr_BoletoBLT_DIAS_NEGATIVACAO: TIntegerField;
    Qr_BoletoBLE_NEGATIVACAO: TStringField;
    cds_comissao: TClientDataSet;
    cds_comissaoFIN_CODIGO: TIntegerField;
    cds_comissaoPED_CODIGO: TIntegerField;

    procedure SB_BuscaParcelaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure E_cd_EmpresaExit(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StrGrd_ParcelaClick(Sender: TObject);
    procedure StrGrd_ParcelaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SB_Cr_Add_TudoClick(Sender: TObject);
    procedure SB_Cr_Retirar_TudoClick(Sender: TObject);
    procedure SB_BoletoClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure Rg_DataClick(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure Sb_RemessaClick(Sender: TObject);
    procedure Sb_RetornoRemessaClick(Sender: TObject);
    procedure Sb_NegociarClick(Sender: TObject);
    procedure Sb_BuscaBoletoClick(Sender: TObject);
    procedure StrGrd_BoletoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGrd_BoletoClick(Sender: TObject);
    procedure SB_Bl_Retirar_TudoClick(Sender: TObject);
    procedure SB_Bl_Add_TudoClick(Sender: TObject);
    procedure DBLCB_BuscaContaCorrenteClick(Sender: TObject);
    procedure Sb_BoletoPDFClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure DBLCB_CarteiraCobrancaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_Pesq_EmpresaClick(Sender: TObject);
    procedure Sb_AlteraDataValorClick(Sender: TObject);
    procedure Sb_EnviaClick(Sender: TObject);
    procedure SB_BaixaManualClick(Sender: TObject);
    procedure DBLCB_Msg_RetornoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_Nr_RemessaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbs_BoletosShow(Sender: TObject);
  private
    { Private declarations }
    FPagaComissao : Boolean;
    procedure Pc_GravaNumeroRemessa(Pc_Nr_Remessa:Integer);
  public
    { Public declarations }
    it_cod_ContBanc,it_PlanoC, it_planoD, It_Qt_Rec, it_Cd_Qtc:Integer;
    it_baixa:Boolean;
    it_dt_pag:TDate;
    Procedure Pc_IniciaVariaveis;
    Procedure Pc_FormataTela;
    //Contas a Receber
    procedure Pc_BuscarParcela;
    procedure Pc_PreencherParcelas;
    procedure Pc_ativaTabelas;
    Procedure Pc_LancaCaixa;
    procedure Pc_LancaBanco;

    //Boletos
    procedure Pc_BuscarBoletos;
    procedure Pc_PreencherBoletos;


    //Totalizadores
    procedure Pc_SomaContasReceber;
    procedure Pc_SomaCreditosCeder;
    procedure Pc_SomaVencidos;
    procedure Pc_SomaAVencer;
    procedure Pc_SomaCrSelecionados;
    procedure Pc_SomaBlSelecionados;
    function Fc_VerificaMarcado(Fc_grid:TStringGrid):Boolean;
    function Fc_VerificaMarcadoMesmoCliente():Boolean;

    function Fc_ValidaGerarBoleto():Boolean;
    function Fc_VerificaRemessaGerada(Fc_grid:TStringGrid):Boolean;
    function Fc_ValidaRemessaBoleto():Boolean;
    function Pc_GeraRemessaBoleto:Integer;
    function Fc_GeraListaCodigoBoleto():TStringArray;

    function Fc_ValidaBaixaManual():Boolean;

    function Fc_ValidaImpressao():Boolean;
    procedure Pc_ImprimeBoleto;
    procedure Pc_ChamaGeraBoleto;
    procedure Pc_GeraPDFBoleto;

    function Fc_ValidaRetornoBoleto():Boolean;
    procedure Pc_TrataRetornoBoleto;
    procedure Pc_ProcessoBaixaAutomatica;
    procedure RegistraComissao(cd_financeiro,cd_pedido:Integer);
    procedure Baixar_Comissao;
    procedure Pc_ProcessoBaixaBoleto(Pc_Qry : TSTQuery; Pc_Cd_Boleto:Integer;Pc_NossoNumero, Pc_Cd_Liquidacao,PC_LiquidacaoDescricao:String);
    procedure Pc_ProcessoBaixaFinanceiro(Pc_Vl_Recebido:Real; Pc_Dt_Pagto:TDate; Pc_Cd_Quitacao:Integer);

    procedure Pc_ImagemBotao;
    function fc_ValidaExclusao():boolean;
    procedure Pc_ExcluiBoletos;
    function Fc_ValidaNegociacao():Boolean;
    Procedure Pc_Negociar;
    function GeraListaBoletoStrGrdBoleto:String;
    procedure Pc_CarregarComponenteBoletoRemessa(Pc_Lst_Boleto:String;Pc_Print:Boolean);
    procedure Pc_CarregarComponenteBoletoRetorno;
    function  Fc_ValidaAlteraVencimento():Boolean;
    procedure Pc_AlteraVencimentoValor;
    function ValidaEnvio():Boolean;
    procedure EnviaEmail(email:String;CodigoBoleto:String;CodigoQuitacao:Integer);
    procedure EnviaWhatsApp(CodigoCliente, CodigoBoleto: String);
    Function Fc_Anexo_boleto(Fc_Nr_Boleto:String):TStringList;

    function Fc_Gera_Email(Fc_Indice,CodigoQuitacao:Integer):String;

  end;

const   Checked: array[1..4] of boolean = (false, true, false, true);

var
  Fr_ContasReceberBoleto: TFr_ContasReceberBoleto;

implementation


uses     Un_DM, un_MSG, Un_Lanca_PlanoContas, Un_Principal, env, WhatsApp, un_info_baixa_lote, Un_Fc_Sored_Procedures, Un_Fc_Comissao, ControllerComissao, Un_Regra_Negocio, StdConvs, un_receber_baixa_lote, Un_GeraBoleto, Un_Negociar, Un_Funcoes, RN_FormaPagto, RN_Cliente, RN_Empresa, Un_Baixa_Boleto, Un_envia_email, RN_Mailing, Un_AlteraBoleto, RN_BoletoEletronico;
{$R *.dfm}



function TFr_ContasReceberBoleto.Fc_VerificaMarcado(Fc_grid:TStringGrid):Boolean;
Var
  Lc_I : Integer;
Begin
  with Fc_grid do
  Begin
    Result := False;
    For Lc_I := 1 to RowCount - 1 do
    Begin
      if Cells[2,Lc_I] = 'X' then
      Begin
        Result := true;
        break;
      end;
    end;
 end; 
  if not Result then
    Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nenhum registro foi selecionado.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    end;
end;

function TFr_ContasReceberBoleto.Fc_VerificaMarcadoMesmoCliente():Boolean;
Var
  Lc_I : Integer;
  Lc_Cd_Empesa : String;
Begin
  Result := True;
  Lc_Cd_Empesa := '';
  For Lc_I := 1 to StrGrd_Parcela.RowCount - 1 do
  Begin
    if StrGrd_Parcela.Cells[2,Lc_I] = 'X' then
    Begin
      if (Trim(Lc_Cd_Empesa) = '') then
      Begin
        Lc_Cd_Empesa := StrGrd_Parcela.Cells[8,Lc_I];
      end
      else
      Begin
        if (Lc_Cd_Empesa <> StrGrd_Parcela.Cells[8,Lc_I]) then
        Begin
          Result := False;
        end;
      end;
    end;
  end;
end;


function TFr_ContasReceberBoleto.Fc_validaGerarBoleto():Boolean;
Begin
  Result := true;
  if not Fc_VerificaMarcado(StrGrd_Parcela) then
  Begin
    Result := False;
    exit;
  end;
end;

function TFr_ContasReceberBoleto.Fc_VerificaRemessaGerada(Fc_grid:TStringGrid):Boolean;
Var
  Lc_I : Integer;
  Lc_Nr_Boleto : String;
Begin
  with Fc_grid do
  Begin
    Result := true;
    For Lc_I := 1 to RowCount - 1 do
    Begin
      if StrToIntDef(Cells[13,Lc_I],0) > 0 then
      Begin
        Lc_Nr_Boleto := Cells[12,Lc_I];
        Result := False;
        break;
      end;
    end;
 end;
  if not Result then
    Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Verificque o boleto Nº ' + Lc_Nr_Boleto + '.'+EOLN+
                   'Consta que pertence a outra remessa.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    end;
end;


function TFr_ContasReceberBoleto.Fc_ValidaRemessaBoleto():Boolean;
Begin
  Result := true;
  IF (Trim(DBLCB_CarteiraCobranca.text) = '') then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe a carteira utilizada.'+EOLN+
                   'Isso garante que todos os boletos selecionados '+EOLN+
                   ' estejam relacionados ao mesmo grupo de cobrança.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    DBLCB_CarteiraCobranca.setFocus;
    Result := False;
    exit;
  end;

  IF (Trim(DBLCB_Msg_Retorno.text) <> 'Em Aberto') then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe a situação do Documento.'+EOLN+
                   'Selecione apenas Documentos em aberto '+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    DBLCB_Msg_Retorno.setFocus;
    Result := False;
    exit;
  end;


  if not Fc_VerificaMarcado(StrGrd_Boleto) then
  Begin
    Result := False;
    exit;
  end;

  if not Fc_VerificaRemessaGerada(StrGrd_Boleto) then
  Begin
    Result := False;
    exit;
  end;

end;

function TFr_ContasReceberBoleto.Fc_GeraListaCodigoBoleto():TStringArray;
Var
  Lc_I : Integer;
  Lc_Nr_Boletos : Integer;
Begin
  with StrGrd_Boleto do
  begin
    Lc_Nr_Boletos := 0;
    for Lc_I := 1 to RowCount -1 do
    Begin
      IF Cells[2,Row]= 'X' then
        Inc(Lc_Nr_Boletos);
    End;
    if ( Lc_Nr_Boletos > 0 ) then
    Begin
      SetLength(Result,Lc_Nr_Boletos);
      Lc_Nr_Boletos := 0;
      for Lc_I := 1 to RowCount -1 do
      Begin
        IF Cells[2,Row]= 'X' then
        Begin
          Result[Lc_Nr_Boletos] := StrToIntDef( cells[3,Lc_I],0);
          Inc(Lc_Nr_Boletos);
        End;
      End;
    End;
  end;
End;

function TFr_ContasReceberBoleto.Pc_GeraRemessaBoleto:Integer;
Var
  Lc_Nr_Remessa : Integer;
  Lc_Lista_cd_Boleto : TStringArray;
Begin
  with Fr_Principal.Boleto do
  Begin
    try
      Lc_Nr_Remessa := Fc_GeraNumeroRemessa(DBLCB_CarteiraCobranca.KeyValue);
      GerarRemessa( Lc_Nr_Remessa );
      //Lc_Lista_cd_Boleto := Fc_GeraListaCodigoBoleto;
      Pc_GravaNumeroRemessa(Lc_Nr_Remessa);
      MensagemPadrao('Mensagem ','S U C E S S O!.'+EOLN+EOLN+
                     'Geração do arquivo gerado com sucesso.'+EOLN,
                    ['OK'],[bEscape],mpInformacao);
      Result := Lc_Nr_Remessa;
    except
      on E: Exception do
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Problemas ao gerar o arquivo remessa.'+EOLN+
                     E.Message + EOLN,
                    ['OK'],[bEscape],mpErro);
    end;
  end;
end;

procedure TFr_ContasReceberBoleto.Pc_GravaNumeroRemessa(Pc_Nr_Remessa:Integer);
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_I : Integer;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE TB_BOLETO_BANCARIO  SET '+
            'BLT_NR_REMESSA =:BLT_NR_REMESSA, '+
            'BLT_MSG_RETORNO =:BLT_MSG_RETORNO '+
            'WHERE (BLT_CODIGO =:BLT_CODIGO) ');

    for Lc_I := 1 to StrGrd_Boleto.RowCount - 1 do
    begin
      if (StrGrd_Boleto.Cells[2,Lc_I] = 'X') then
      begin
        if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
        Active := False;
        ParamByName('BLT_NR_REMESSA').AsInteger := Pc_Nr_Remessa;
        ParamByName('BLT_CODIGO').AsInteger := StrToIntDef(StrGrd_Boleto.cells[3,Lc_I],0);
        ParamByName('BLT_MSG_RETORNO').AsString := 'Remessa Gerada';
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      end;
    end;
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

function TFr_ContasReceberBoleto.Fc_ValidaBaixaManual():Boolean;
Begin
  Result := true;
  if not Fc_VerificaMarcado(StrGrd_Boleto) then
    Begin
    Result := False;
    exit;
    end;


end;


function TFr_ContasReceberBoleto.Fc_ValidaImpressao():Boolean;
Begin
  Result := true;
  IF (Trim(DBLCB_CarteiraCobranca.text) = '') then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe uma carteira utilizada.'+EOLN+
                   'Isso garante que todos os boletos selecionados '+EOLN+
                   ' estejam relacionados ao mesmo grupo de cobrança.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    DBLCB_CarteiraCobranca.setFocus;
    Result := False;
    exit;
  end;

  if DM.Qr_Carteiras.FieldByname('CTR_TIPO_EMISSAO').AsString = 'B' then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Esta carteira de cobrança a emissão é por conta do Banco.'+EOLN+
                   'Verifique os parãmetros no cadastro de cobrança.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;


  if not Fc_VerificaMarcado(StrGrd_Boleto) then
  Begin
    Result := False;
    exit;
  end;
end;

procedure TFr_ContasReceberBoleto.Pc_ImprimeBoleto;
Begin
  with Fr_Principal do
  Begin
    if not DirectoryExists(GbPathexe + 'imagem\') then
      CreateDir(GbPathexe + 'imagem\');
    BoletoFcFortes.DirLogo := GbPathexe + '\imagem\';
    if not FileExists(GbPathexe + 'imagem\'+StrZero(Boleto.Banco.Numero,3,0)+'.bmp') then
    Pc_BaixarLogoBanco(StrZero(Boleto.Banco.Numero,3,0));
    BoletoFcFortes.Filtro := fiNenhum;
    BoletoFcFortes.NomeArquivo := '';
    BoletoFcFortes.MostrarPreview := Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S'  ;
    Boleto.Imprimir;
  end;
end;

procedure TFr_ContasReceberBoleto.Pc_GeraPDFBoleto;
Begin
  with Fr_Principal do
  Begin
    Fr_Principal.SaveDialogo.Filter := 'Documento PDF|*.pdf';
    if SaveDialogo.Execute then
    Begin
      if not DirectoryExists(GbPathexe + 'imagem\') then
        CreateDir(GbPathexe + 'imagem\');
      Boleto.ACBrBoletoFC.DirLogo := GbPathexe + '\imagem\';
      if not FileExists(GbPathexe + 'imagem\'+StrZero(Fr_Principal.Boleto.Banco.Numero,3,0)+'.bmp') then
        Pc_BaixarLogoBanco(StrZero(Fr_Principal.Boleto.Banco.Numero,3,0));
      Boleto.ACBrBoletoFC.Filtro := fiPDF;
      Boleto.ACBrBoletoFC.NomeArquivo := Fr_Principal.SaveDialogo.FileName;
      Boleto.Imprimir;
      SaveDialogo.Filter := 'Pasta de Trabalho do Microsoft Excel (*.xls)|*.xls';
    end;
  end;
end;

procedure TFr_ContasReceberBoleto.Pc_ChamaGeraBoleto;
Var
  Lc_Form : TFr_GeraBoleto;
  Lc_StrGridDuplicata : TStringGrid;
  Lc_I,Lc_J : Integer;
  Lc_Nr_Parcela : integer;
  Lc_Valor : Real;
  Lc_Lst_Boleto:String;
  Lc_Escolha : Integer;
begin
  Try
    //Prepara uma grid para passar os valores
    Lc_StrGridDuplicata  := TStringGrid.Create(Fr_ContasReceberBoleto);
    Lc_StrGridDuplicata.RowCount := 2;
    Lc_StrGridDuplicata.ColCount := StrGrd_Parcela.ColCount;
    Lc_Nr_Parcela := 0;
    Lc_Valor := 0;
    For Lc_I := 1 to StrGrd_Parcela.RowCount - 1 do
    Begin
      if StrGrd_Parcela.Cells[2,Lc_I] = 'X' then
      Begin
        inc(Lc_Nr_Parcela);
        Lc_StrGridDuplicata.RowCount := 1 + Lc_Nr_Parcela;
        For Lc_J := 1  to StrGrd_Parcela.ColCount do
        Begin
          Lc_StrGridDuplicata.Cells[Lc_J,Lc_Nr_Parcela] := StrGrd_Parcela.Cells[Lc_J,Lc_I];
        end;
        Lc_Valor := Lc_Valor  + StrtoFloatDef(StrGrd_Parcela.Cells[11,Lc_I],0);
      end;
    end;

    Lc_Form := TFr_GeraBoleto.Create(nil);
    Lc_Form.It_StrGridDuplicata := Lc_StrGridDuplicata;
    //Verifica se é do mesmo cliente
    Lc_Form.Chbx_Agrupar.Checked := False;
    Lc_Form.Chbx_Agrupar.Enabled := Fc_VerificaMarcadoMesmoCliente;
    Lc_Form.ShowModal;
    if ( Fc_Tb_Geral('L','FIN_BOL_ENVIA_EMAIL','S') = 'S') then
    Begin
      if Lc_Form.Codigoquitacao >0 then
      Begin
        Lc_Lst_Boleto := concat(' and BLT_CODIGO = ',Lc_Form.BoletoBancario.Registro.Codigo.ToString);
        Pc_ConfiguraComponenteBoleto(DM.Qr_Carteiras.FieldByName('EMP_NUMBCO').AsString);

        Pc_CarregarComponenteBoletoRemessa(Lc_Lst_Boleto,True);

        EnviaEmail(
                StrGrd_Parcela.Cells[32,StrGrd_Parcela.row],
                Lc_Form.BoletoBancario.Registro.Codigo.ToString,
                Lc_Form.BoletoBancario.Registro.CodigoQuitacao
        );
      End;
    End;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;


function TFr_ContasReceberBoleto.Fc_ValidaRetornoBoleto():Boolean;
Begin
  Result := true;
  IF (Trim(DBLCB_CarteiraCobranca.text) = '') then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe a carteira utilizada.'+EOLN+
                   'Isso garante que todos os boletos do retorno '+EOLN+
                   ' estejam relacionados ao mesmo grupo de cobrança.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    DBLCB_CarteiraCobranca.setFocus;
    Result := False;
    exit;
  end;

  with Fr_Principal.Boleto,OpenDialog1 do
  Begin
    Title := 'Selecione o arquivo retorno';
    DefaultExt := '*.ret';
              //'Text files (*.txt)|*.TXT|Pascal files (*.pas)|*.PAS';
    Filter := 'Retorno geral (*.ret)|*.ret|Retorno Sicredi (*.crt)|*.crt';
    InitialDir := DirArqRetorno;
    if Execute then
    Begin
      DirArqRetorno := ExtractFilePath(FileName);
      NomeArqRetorno := ExtractFileName(FileName);
      Pc_ConfiguraComponenteBoleto(DM.Qr_Carteiras.FieldByName('EMP_NUMBCO').AsString);

    End
    else
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Arquivo de retorno não selecionado.'+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      REsult := False;
      exit;
    End;
  End;
end;

procedure TFr_ContasReceberBoleto.Pc_TrataRetornoBoleto;
Var
  Lc_I:Integer;
  Lc_J : Integer;
Begin
  with Fr_Principal.Boleto do
  Begin
    for Lc_I := 0 to  ListadeBoletos.Count-1 do
    begin
      if ListadeBoletos.Objects[Lc_I].ValorRecebido > 0 then
      begin
        ListadeBoletos.Objects[Lc_I].CodigoLiquidacao := '3';
        ListadeBoletos.Objects[Lc_I].CodigoLiquidacaoDescricao := 'Documento Baixado';
      end
      else
      Begin
        if (ListadeBoletos.Objects[Lc_I].MotivoRejeicaoComando.Count > 0) then
        Begin
          For Lc_J := 0 to ListadeBoletos.Objects[Lc_I].MotivoRejeicaoComando.Count -1 do
          Begin
            if (ListadeBoletos.Objects[Lc_I].MotivoRejeicaoComando[Lc_J] <> '00') then
            Begin
              case (DM.Qr_Carteiras.FieldByName('EMP_NUMBCO').AsInteger) of
                237:BEgin
                      //19/08/2024
                      if (ListadeBoletos.Objects[Lc_I].MotivoRejeicaoComando[Lc_J] = '76') then
                      Begin
                        ListadeBoletos.Objects[Lc_I].CodigoLiquidacao := '2';
                        ListadeBoletos.Objects[Lc_I].CodigoLiquidacaoDescricao := 'Documento Enviado';
                      End;
                    End
                else
                Begin
                  ListadeBoletos.Objects[Lc_I].CodigoLiquidacao := '4';
                  if Length(Trim(ListadeBoletos.Objects[Lc_I].MotivoRejeicaoComando.ValueFromIndex[Lc_J])) > 0 then
                    ListadeBoletos.Objects[Lc_I].CodigoLiquidacaoDescricao := ListadeBoletos.Objects[Lc_I].MotivoRejeicaoComando.ValueFromIndex[Lc_J]
                  else
                    ListadeBoletos.Objects[Lc_I].CodigoLiquidacaoDescricao := 'Erro codigo ' + ListadeBoletos.Objects[Lc_I].MotivoRejeicaoComando[Lc_J] + '. ' + 'Verificar';
                End;
              end;
            end
            else
            Begin
              ListadeBoletos.Objects[Lc_I].CodigoLiquidacao := '2';
              ListadeBoletos.Objects[Lc_I].CodigoLiquidacaoDescricao := 'Documento Enviado';
            end;
          end;
        end
        else
        Begin
          ListadeBoletos.Objects[Lc_I].CodigoLiquidacao := '2';
          ListadeBoletos.Objects[Lc_I].CodigoLiquidacaoDescricao := 'Documento Enviado';
        end;
      end;
    end;
  end;
end;

procedure TFr_ContasReceberBoleto.Pc_ProcessoBaixaAutomatica;
Var
  Lc_Qry : TSTQuery;
  Lc_Qry_Aux : TSTQuery;
  lC_i : Integer;
  Lc_NossoNumero : Integer;
  LcAux : String;
  LcDataBaixa : TDateTime;
Begin
  Lc_Qry_Aux := TSTQuery.Create(Fr_ContasReceberBoleto);
  Lc_Qry_Aux.Database := DM.IBD_Gestao;
  Lc_Qry_Aux.Transaction := DM.IB_Transacao;
  Lc_Qry_Aux.ForcedRefresh := True;

  Lc_Qry := TSTQuery.Create(Fr_ContasReceberBoleto);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    Active := False;
    SQL.Clear;
    SQL.Add(concat(
                'SELECT DISTINCT BLT_CODIGO, BLT_CODQTC, blt_dt_vencimento,FIN_CODIGO,FIN_CODPED '+
                'FROM TB_BOLETO_BANCARIO '+
                '  INNER JOIN TB_FINANCEIRO '+
                '  ON (FIN_CODQTC = BLT_CODQTC)'+
                'WHERE ( (BLT_NOSSONUMERO=:BLT_NOSSONUMERO) or (BLT_NUMERO=:BLT_NUMERO) ) ',
                'AND (FIN_BAIXA = ''N'') '
    ));

    with Fr_Principal.Boleto do
    Begin


      for Lc_I := 0 to  ListadeBoletos.Count-1 do
      begin
        LcAux := Datetostr( Fr_Principal.Boleto.ListadeBoletos.Objects[lc_I].DataDocumento);
        LcAux := Datetostr( Fr_Principal.Boleto.ListadeBoletos.Objects[lc_I].DataProcessamento);
        LcAux := Datetostr( Fr_Principal.Boleto.ListadeBoletos.Objects[lc_I].DataOcorrencia);
        LcAux := Datetostr( Fr_Principal.Boleto.ListadeBoletos.Objects[lc_I].DataBaixa);
        LcAux := Datetostr( Fr_Principal.Boleto.ListadeBoletos.Objects[lc_I].DataLimitePagto);
        Active := false;
        ParamByName('BLT_NOSSONUMERO').AsString := ListadeBoletos.Objects[lc_I].NossoNumero;
        ParamByName('BLT_NUMERO').AsString := ListadeBoletos.Objects[lc_I].NumeroDocumento;
        Active := True;
        FetchAll;
        if (recordCount > 0) then
        Begin
          Pc_ProcessoBaixaBoleto( Lc_Qry_Aux,
                                 FieldByName('BLT_CODIGO').AsInteger,
                                 ListadeBoletos.Objects[lc_I].NossoNumero,
                                 ListadeBoletos.Objects[lc_I].CodigoLiquidacao,
                                 ListadeBoletos.Objects[lc_I].CodigoLiquidacaoDescricao);

          if ListadeBoletos.Objects[lc_I].ValorRecebido > 0 then
          Begin
            //Baixa no Financeiro
            if ListadeBoletos.Objects[lc_I].DataBaixa > 0 then
              LcDataBaixa := ListadeBoletos.Objects[lc_I].DataBaixa
            else
            if ListadeBoletos.Objects[lc_I].DataOcorrencia > 0 then
              LcDataBaixa := ListadeBoletos.Objects[lc_I].DataOcorrencia
            else
              LcDataBaixa := FieldByNAme('blt_dt_vencimento').AsDateTime;
            Pc_ProcessoBaixaFinanceiro(ListadeBoletos.Objects[lc_I].ValorRecebido,
                                       LcDataBaixa,

                                       FieldByName('BLT_CODQTC').AsInteger);
            //Monta a lista do Financeiro para gerars as comissoes
            RegistraComissao(FieldByNAme('FIN_CODIGO').AsInteger,
                             FieldByNAme('FIN_CODPED').AsInteger);

            //Lanca valor Recebido na conta corrente
            Pc_Movim_Financeiro(DM.IB_Transacao,
                                'I',
                                0,
                                DM.Qr_Carteiras.FieldByName('CTB_CODIGO').AsInteger,
                                ListadeBoletos.Objects[lc_I].DataBaixa,
                                0, //Historico Bancaria
                                0,//Credito
                                0,//DEbito
                                ListadeBoletos.Objects[lc_I].ValorRecebido,
                                0,
                                'Recebimento boleto '  ,
                                'C',
                                FieldByName('BLT_CODQTC').AsInteger,
                                Gb_Cd_Usuario,
                                0,
                                ListadeBoletos.Objects[lc_I].DataProcessamento,
                                ListadeBoletos.Objects[lc_I].NossoNumero,
                                'N',
                                'S',
                                Gb_CodMha,
                                Fc_PegaFormaPgto('BOLETO'));


          end;
        end;
      end;
    end;
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure TFr_ContasReceberBoleto.Pc_ProcessoBaixaBoleto(Pc_Qry : TSTQuery;
                                                          Pc_Cd_Boleto:Integer;
                                                          Pc_NossoNumero,
                                                          Pc_Cd_Liquidacao,
                                                          PC_LiquidacaoDescricao:String);
Begin
  with Pc_Qry do
  Begin
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    Active := False;
    SQL.Clear;
    SQL.Add(concat(
              'UPDATE TB_BOLETO_BANCARIO SET ',
              'BLT_STATUS = :BLT_STATUS, ',
              'BLT_MSG_RETORNO =:BLT_MSG_RETORNO, ',
              'BLT_NOSSONUMERO =:BLT_NOSSONUMERO ',
              'WHERE BLT_CODIGO=:BLT_CODIGO '
    ));
    ParamByName('BLT_STATUS').AsString := Pc_Cd_Liquidacao;
    ParamByName('BLT_NOSSONUMERO').AsString := Pc_NossoNumero;
    ParamByName('BLT_MSG_RETORNO').AsString := PC_LiquidacaoDescricao;
    ParamByName('BLT_CODIGO').AsInteger := Pc_Cd_Boleto;
    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
  end;
end;

procedure TFr_ContasReceberBoleto.Pc_ProcessoBaixaFinanceiro(Pc_Vl_Recebido:Real; Pc_Dt_Pagto:TDate; Pc_Cd_Quitacao:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE TB_FINANCEIRO SET '+
              'FIN_VL_PAGO =:FIN_VL_PAGO, '+
              'FIN_DT_PAGTO =:FIN_DT_PAGTO, '+
              'FIN_DT_BAIXA =:FIN_DT_BAIXA, '+
              'FIN_BAIXA =:FIN_BAIXA '+
              'WHERE FIN_CODQTC =:FIN_CODQTC ');

      ParamByName('FIN_VL_PAGO').AsCurrency := Pc_Vl_Recebido;
      ParamByName('FIN_DT_PAGTO').AsDate := Pc_Dt_Pagto;
      ParamByName('FIN_DT_BAIXA').AsDate := Date;
      ParamByName('FIN_BAIXA').AsString := 'S';
      ParamByName('FIN_CODQTC').AsInteger := Pc_Cd_Quitacao;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


Procedure TFr_ContasReceberBoleto.Pc_IniciaVariaveis;
Begin
  Lb_Vl_Receber.Caption := '0,00';
  Lb_Vl_Credito.Caption := '0,00';
  Lb_Vl_Vencer.Caption := '0,00';
  Lb_Vl_Vencida.Caption := '0,00';
  Lb_Vl_Cr_selecionado.Caption := '0,00';
  Lb_Vl_Bl_selecionado.Caption := '0,00';
  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
  FPagaComissao := (Fc_Tb_Geral('L','TP_COMISSAO','')='R');
end;

Procedure TFr_ContasReceberBoleto.Pc_FormataTela;
Var
  Lc_I:Integer;
Begin
  Pg_ContasReceberBoleto.ActivePage := tbs_ContasReceber;
  //Colunas Fixas
  with StrGrd_Parcela,Qr_BuscaParcela do
  Begin
    ColCount := FieldCount + 3;
    ColWidths[0]:=17;
    ColWidths[1]:=54;
    ColWidths[2]:=-1;
    Cols[1].Add('Selecionar');
    For Lc_I:= 0 to FieldCount -1 do
    Begin
      ColWidths[Lc_I + 3]:= Fields[Lc_I].Tag;
      Cols[Lc_I + 3].Add(Fields[Lc_I].DisplayLabel);
    end;
  end;

  //Colunas Fixas
  with StrGrd_Boleto,Qr_BuscaBoleto do
  Begin
    ColCount := FieldCount + 3;
    ColWidths[0]:=17;
    ColWidths[1]:=54;
    ColWidths[2]:=-1;
    Cols[1].Add('Selecionar');
    For Lc_I:= 0 to FieldCount -1 do
    Begin
      ColWidths[Lc_I + 3]:= Fields[Lc_I].Tag;
      Cols[Lc_I + 3].Add(Fields[Lc_I].DisplayLabel);
    end;
  end;

end;



//Totalizadores
procedure TFr_ContasReceberBoleto.Pc_SomaContasReceber;
Var
  Lc_I : Integer;
  Lc_Valor : Real;
Begin
  Lc_Valor := 0;
  For Lc_I:= 1 to StrGrd_Parcela.RowCount - 1 do
    Begin
    if (StrGrd_Parcela.Cells[20,Lc_I] = 'C') then
      Begin
      Lc_Valor := Lc_Valor +
                  StrtoFloatDef(StrGrd_Parcela.Cells[11,Lc_I],0) + //Parcela
                  StrtoFloatDef(StrGrd_Parcela.Cells[29,Lc_I],0) + //Juros
                  StrtoFloatDef(StrGrd_Parcela.Cells[30,Lc_I],0) - //Mora
                  StrtoFloatDef(StrGrd_Parcela.Cells[28,Lc_I],0) - //Pago
                  StrtoFloatDef(StrGrd_Parcela.Cells[29,Lc_I],0) ; //Desconto
      end;
    end;
    Lb_Vl_Receber.Caption := FloatToStrF(Lc_Valor,ffNumber,10,2);
end;

procedure TFr_ContasReceberBoleto.Pc_SomaCreditosCeder;
Var
  Lc_I : Integer;
  Lc_Valor : Real;
Begin
  Lc_Valor := 0;
  For Lc_I:= 1 to StrGrd_Parcela.RowCount - 1 do
    Begin
    if (StrGrd_Parcela.Cells[20,Lc_I] = 'D') then
      Begin
      Lc_Valor := Lc_Valor +
                  StrtoFloatDef(StrGrd_Parcela.Cells[11,Lc_I],0) + //Parcela
                  StrtoFloatDef(StrGrd_Parcela.Cells[29,Lc_I],0) + //Juros
                  StrtoFloatDef(StrGrd_Parcela.Cells[30,Lc_I],0) - //Mora
                  StrtoFloatDef(StrGrd_Parcela.Cells[28,Lc_I],0) - //Pago
                  StrtoFloatDef(StrGrd_Parcela.Cells[29,Lc_I],0) ; //Desconto
      end;
    end;
    Lb_Vl_Credito.Caption := FloatToStrF(Lc_Valor,ffNumber,10,2);
end;

procedure TFr_ContasReceberBoleto.Pc_SomaVencidos;
Var
  Lc_I : Integer;
  Lc_Valor : Real;
Begin
  Lc_Valor := 0;
  For Lc_I:= 1 to StrGrd_Parcela.RowCount - 1 do
    Begin
    if (StrtoDateDef(StrGrd_Parcela.Cells[7,Lc_I],Date)< Date) and (StrGrd_Parcela.Cells[20,Lc_I] = 'C') then
      Begin
      Lc_Valor := Lc_Valor +
                  StrtoFloatDef(StrGrd_Parcela.Cells[11,Lc_I],0) + //Parcela
                  StrtoFloatDef(StrGrd_Parcela.Cells[29,Lc_I],0) + //Juros
                  StrtoFloatDef(StrGrd_Parcela.Cells[30,Lc_I],0) - //Mora
                  StrtoFloatDef(StrGrd_Parcela.Cells[28,Lc_I],0) - //Pago
                  StrtoFloatDef(StrGrd_Parcela.Cells[29,Lc_I],0) ; //Desconto
      end;
    end;
    Lb_Vl_Vencida.Caption := FloatToStrF(Lc_Valor,ffNumber,10,2);
end;

procedure TFr_ContasReceberBoleto.Pc_SomaAVencer;
Var
  Lc_I : Integer;
  Lc_Valor : Real;
Begin
  Lc_Valor := 0;
  For Lc_I:= 1 to StrGrd_Parcela.RowCount - 1 do
    Begin
    if (StrtoDateDef(StrGrd_Parcela.Cells[7,Lc_I],Date)>= Date) and (StrGrd_Parcela.Cells[20,Lc_I] = 'C') then
      Begin
      Lc_Valor := Lc_Valor +
                  StrtoFloatDef(StrGrd_Parcela.Cells[11,Lc_I],0) + //Parcela
                  StrtoFloatDef(StrGrd_Parcela.Cells[29,Lc_I],0) + //Juros
                  StrtoFloatDef(StrGrd_Parcela.Cells[30,Lc_I],0) - //Mora
                  StrtoFloatDef(StrGrd_Parcela.Cells[28,Lc_I],0) - //Pago
                  StrtoFloatDef(StrGrd_Parcela.Cells[29,Lc_I],0) ; //Desconto
      end;
    end;
    Lb_Vl_Vencer.Caption := FloatToStrF(Lc_Valor,ffNumber,10,2);
end;

procedure TFr_ContasReceberBoleto.Pc_SomaCrSelecionados;
Var
  Lc_I : Integer;
  Lc_Valor : Real;
Begin
  with StrGrd_Parcela do
  Begin
    Lc_Valor := 0;
    For Lc_I:= 1 to RowCount - 1 do
    Begin
      if (StrGrd_Parcela.Cells[2,Lc_I] = 'X') then
      Begin
        if (StrGrd_Parcela.Cells[20,Lc_I] = 'C') then
        Begin
          Lc_Valor := Lc_Valor +
                      StrtoFloatDef(Cells[11,Lc_I],0) + //Parcela
                      StrtoFloatDef(Cells[29,Lc_I],0) + //Juros
                      StrtoFloatDef(Cells[30,Lc_I],0) - //Mora
                      StrtoFloatDef(Cells[28,Lc_I],0) - //Pago
                      StrtoFloatDef(Cells[29,Lc_I],0) ; //Desconto
        end
        else
        Begin
          Lc_Valor := Lc_Valor -
                      StrtoFloatDef(Cells[11,Lc_I],0) + //Parcela
                      StrtoFloatDef(Cells[29,Lc_I],0) + //Juros
                      StrtoFloatDef(Cells[30,Lc_I],0) - //Mora
                      StrtoFloatDef(Cells[28,Lc_I],0) - //Pago
                      StrtoFloatDef(Cells[29,Lc_I],0) ; //Desconto
        end;
      end;
    end;
  end;
  Lb_Vl_Cr_selecionado.Caption := FloatToStrF(Lc_Valor,ffNumber,10,2);
end;

procedure TFr_ContasReceberBoleto.Pc_SomaBlSelecionados;
Var
  Lc_I : Integer;
  Lc_Valor : Real;
Begin
  with StrGrd_Boleto do
  Begin
    Lc_Valor := 0;
    For Lc_I:= 1 to RowCount - 1 do
    Begin
      if (Cells[2,Lc_I] = 'X') then
      Begin
        Lc_Valor := Lc_Valor + StrtoFloatDef(Cells[13,Lc_I],0);
      end;
    end;
  end;
  Lb_Vl_Bl_selecionado.Caption := FloatToStrF(Lc_Valor,ffNumber,10,2);
end;

procedure TFr_ContasReceberBoleto.SB_BuscaParcelaClick(Sender: TObject);
begin
  Pc_BuscarParcela;
  Pc_LimpaStringGrid(StrGrd_Parcela);
  Pc_PreencherParcelas;
  Pc_SomaContasReceber;
  Pc_SomaCreditosCeder;
  Pc_SomaVencidos;
  Pc_SomaAVencer;
end;

procedure TFr_ContasReceberBoleto.Pc_BuscarParcela;
var
  Lc_sqltxt : string;
  Lc_Pedido, Lc_NotaFiscal,Lc_Financeiro, Lc_Cd_Cliente, Lc_Cliente,  Lc_Conta : boolean;
begin
  Lc_sqltxt := '';
  Screen.Cursor:=crHourGlass;
  with Qr_BuscaParcela do
  Begin
    Close;
    Sql.Clear;
    Lc_sqltxt :='SELECT DISTINCT '+
                'FIN_CODIGO, '+
                'NFL_NUMERO, '+
                'PED_NUMERO, '+
                'FIN_NUMERO, '+
                'FIN_DT_VENCIMENTO, '+
                'FIN_CODEMP, '+
                'tb_cliente.EMP_FANTASIA, '+
                'tb_cliente.EMP_NOME, '+
                'FIN_VL_PARCELA, '+
                'FIN_BAIXA, '+
                'FIN_SITUACAO, '+
                'FIN_CODQTC, '+
                'FIN_CODFPG, '+
                'PED_CODIGO, '+
                'NFL_CODIGO, '+
                'FIN_TIPO, '+
                'FIN_DT_PAGTO, '+
                'FIN_VL_PAGO, '+
                'FIN_OPERACAO, '+
                'FIN_ETAPA, '+
                'FIN_CODMHA, '+
                'FIN_CODCHQ, '+
                'FIN_NR_PARCELA, '+
                'FIN_DATA, '+
                'FIN_CODPED, '+
                'FIN_VL_JUROS, '+
                'FIN_VL_MORA, '+
                'FIN_VL_DESCONTO, '+
                'EMP_EMAIL '+
                'FROM TB_FINANCEIRO tb_financeiro '+
                '  INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal '+
                '  ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '+
                '  LEFT OUTER JOIN TB_PEDIDO tb_pedido '+
                '  ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '+
                '  INNER JOIN TB_EMPRESA tb_cliente '+
                '  ON (tb_cliente.EMP_CODIGO = tb_financeiro.FIN_CODEMP) '+
             ' WHERE ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) '+
             '   AND (FIN_CODMHA=:FIN_CODMHA) '+
             '   AND (FIN_SITUACAO = ''N'') '+
             '   AND (FIN_BAIXA = ''N'') ';

    if E_BuscaPedido.Text = ''          then Lc_Pedido       := False else Lc_Pedido      := True;
    if E_BuscaNota.Text = ''            then Lc_NotaFiscal   := False else Lc_NotaFiscal  := True;
    if E_BuscaFinanceiro.Text = ''      then Lc_Financeiro   := False else Lc_Financeiro  := True;
    if E_Busca_Empresa.Text = ''         then Lc_Cliente      := False else Lc_Cliente     := True;
    if E_cd_Empresa.Text = ''           then Lc_Cd_Cliente   := False else Lc_Cd_Cliente  := True;

    if Lc_Pedido      then Lc_sqltxt := Lc_sqltxt + ' AND (PED_NUMERO = :PED_NUMERO) ';
    if Lc_NotaFiscal  then Lc_sqltxt := Lc_sqltxt + ' AND (NFL_NUMERO like :NFL_NUMERO) ';
    if Lc_Conta       then Lc_sqltxt := Lc_sqltxt + ' AND (CTB_CODIGO =:CTB_CODIGO) ';
    if Lc_Cd_Cliente  then Lc_sqltxt := Lc_sqltxt + ' AND (FIN_CODEMP =:FIN_CODEMP) ';
    if Lc_Cliente     then Lc_sqltxt := Lc_sqltxt + ' AND ((tb_cliente.EMP_FANTASIA LIKE :EMP_FANTASIA) OR (tb_cliente.EMP_NOME LIKE :EMP_FANTASIA)) ';

    if ChBx_Periodo.Checked then
    Begin
      if (Rg_Data_CtaReceber.ItemIndex = 0) then
        Lc_sqltxt := Lc_sqltxt + 'AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '
      else
        Lc_sqltxt := Lc_sqltxt + 'AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM) '
    end;

    SQL.Add(Lc_sqltxt+ 'ORDER BY FIN_DT_VENCIMENTO, EMP_NOME, PED_NUMERO, FIN_NUMERO ');

    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDate      := E_Data_Ini.date;
      ParamByName('DATAFIM').Asdate      := E_Data_Fim.Date;
    end;

    if Lc_Pedido      then ParamByName('PED_NUMERO').AsString    := E_BuscaPedido.Text;
    if Lc_NotaFiscal  then ParamByName('NFL_NUMERO').AsString    := '%' + E_BuscaNota.Text;
    if Lc_Cliente     then ParamByName('EMP_FANTASIA').AsString  := '%'+ E_Busca_Empresa.Text +'%';
    if Lc_Cd_Cliente  then ParamByName('FIN_CODEMP').AsString    := E_cd_Empresa.Text;


    ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
    Open;
    FetchAll;
    SB_Cr_Add_Tudo.Enabled:= (RecordCount > 0);
    SB_Cr_Retirar_Tudo.Enabled:= (RecordCount > 0);
    Screen.Cursor:=crDefault;
  end;   
end;

procedure TFr_ContasReceberBoleto.Pc_PreencherParcelas;
Var
  Lc_I,Lc_J : Integer;
  Lc_registro : Integer;

Begin
  with Qr_BuscaParcela,StrGrd_Parcela do
  Begin
    First;
    Lc_registro := 0;
    while not Eof do
    Begin
      Lc_registro := Lc_registro + 1;
      RowCount := Lc_registro + 1;
      For Lc_I:= 0 to FieldCount -1 do
        if (Fields.Fields[Lc_I].DataType = ftFloat) OR (Fields.Fields[Lc_I].DataType = ftBCD) then
          Cells[Lc_I + 3,Lc_registro] := FloatToStrF(Fields[Lc_I].AsFloat,ffFixed,10,2)
        else
          Cells[Lc_I + 3,Lc_registro] := Fields[Lc_I].AsString;
      Next;
    end;
    Repaint;
  end;
end;


procedure TFr_ContasReceberBoleto.Baixar_Comissao;
Var
  Lc_I : Integer;
  Lc_cd_Financeiro : Integer;
  Lc_cd_Pedido : Integer;
  Lc_Comissao : TControllerComissao;
Begin
  if FPagaComissao then
  Begin
    Try
      Pc_Construtor_Comissao(DM.IB_Transacao);
      Lc_Comissao := TControllerComissao.create(Self);
      if not cds_comissao.Active then cds_comissao.CreateDataSet;
      cds_comissao.First;
      while not cds_comissao.Eof do
      Begin
        Lc_cd_Financeiro := cds_comissaoFIN_CODIGO.AsInteger;
        Lc_Cd_Pedido     := cds_comissaoPED_CODIGO.AsInteger;

        Lc_Comissao.Parametros.FieldName.Pedido := Lc_Cd_Pedido;
        Lc_Comissao.Parametros.FieldName.Financeiro := Lc_Cd_Financeiro;
        Lc_Comissao.deleteByFinanceiro;

        Pc_Registra_Vdo_Pedido(DM.IB_Transacao, Lc_cd_Pedido);
        Pc_Gerar_Comissao_Vda_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
        Pc_Gerar_Comissao_Srv_Rec(DM.IB_Transacao, Lc_cd_Financeiro);
        Pc_Gerar_Comissao_Srv_Vdo_Rec(DM.IB_Transacao, Lc_cd_Financeiro);

        cds_comissao.Next;
      end;
    Finally
      Pc_Destrutor_Comissao;
      FreeAndNil(Lc_Comissao);
    End;
  end;
end;

//Boletos
procedure TFr_ContasReceberBoleto.Pc_BuscarBoletos;
var
  Lc_sqltxt : string;
  Lc_Pedido, Lc_NotaFiscal,Lc_Financeiro, Lc_Cd_Cliente, Lc_Cliente, Lc_Boleto, Lc_Carteira, Lc_situacao, Lc_Nr_Remessa : boolean;
begin
  Lc_sqltxt := '';
  Screen.Cursor:=crHourGlass;
  with Qr_BuscaBoleto do
  Begin
    Close;
    Sql.Clear;
    Lc_sqltxt :='SELECT DISTINCT '+
                '  BLT_CODIGO, '+
                '  FIN_CODIGO, '+
                '  BLT_NUMERO, '+
                '  NFL_NUMERO, '+
                '  PED_NUMERO, '+
                '  FIN_NUMERO, '+
                '  FIN_DT_VENCIMENTO, '+
                '  FIN_CODEMP, '+
                '  tb_cliente.EMP_FANTASIA, '+
                '  tb_cliente.EMP_NOME, '+
                '  FIN_VL_PARCELA, '+
                '  FIN_DT_PAGTO, '+
                '  FIN_VL_PAGO, '+
                '  BLT_NUMERO, '+
                '  (tb_banco.EMP_NUMBCO || '' - '' || tb_banco.EMP_FANTASIA || '' | AG: '' || CTB_AGENCIA || ''-'' || CTB_AG_DV || '' | CC: '' || CTB_CONTA || ''-'' || CTB_CC_DV ) CTB_COMPLETO, '+
                '  BLT_REMESSA, '+
                '  BLT_CODQTC, '+
                '  BLT_MSG_RETORNO, '+
                '  tb_cliente.EMP_EMAIL, '+
                '  BLT_NOSSONUMERO '+
                'FROM TB_FINANCEIRO tb_financeiro '+
                '  INNER JOIN TB_NOTA_FISCAL tb_nota_Fiscal '+
                '  ON (tb_nota_Fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) '+
                '  LEFT OUTER JOIN TB_PEDIDO tb_pedido '+
                '  ON (tb_pedido.PED_CODIGO = tb_financeiro.FIN_CODPED) '+
                ' INNER JOIN TB_EMPRESA tb_cliente '+
                '  ON (tb_cliente.EMP_CODIGO = tb_financeiro.FIN_CODEMP) '+
                '  INNER JOIN  tb_boleto_bancario '+
                '  ON (tb_boleto_bancario.BLT_CODQTC = tb_financeiro.FIN_CODQTC) '+
                '  INNER JOIN  tb_contabancaria '+
                '  ON (tb_contabancaria.CTB_CODIGO = tb_boleto_bancario.BLT_CODCTB) '+
                '  INNER JOIN  tb_boleto_eletronico '+
                '  ON (tb_boleto_eletronico.BLE_CODIGO = tb_boleto_bancario.BLT_CODBLE) '+
                '  INNER JOIN  TB_EMPRESA tb_banco '+
                '  ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO )'+
                '  INNER JOIN tb_formapagto '+
                '  ON (tb_formapagto.fpt_codigo = tb_financeiro.fin_codfpg) '+
                ' WHERE ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) '+
                '   AND (FIN_CODMHA=:FIN_CODMHA) ' +
                '   AND (FIN_SITUACAO = ''D'') ';

    if E_BuscaPedido.Text = ''            then Lc_Pedido       := False else Lc_Pedido      := True;
    if E_BuscaNota.Text = ''              then Lc_NotaFiscal   := False else Lc_NotaFiscal  := True;
    if E_BuscaFinanceiro.Text = ''        then Lc_Financeiro   := False else Lc_Financeiro  := True;
    if E_Busca_Empresa.Text = ''          then Lc_Cliente      := False else Lc_Cliente     := True;
    if E_cd_Empresa.Text = ''             then Lc_Cd_Cliente   := False else Lc_Cd_Cliente  := True;
    if E_Busca_Boleto.Text = ''           then Lc_Boleto       := False else Lc_Boleto      := True;
    if DBLCB_CarteiraCobranca.Text = ''   then Lc_Carteira     := False else Lc_Carteira    := True;
    if DBLCB_Msg_Retorno.Text = ''        then Lc_situacao     := False else Lc_Situacao    := True;
    if DBLCB_Nr_Remessa.Text = ''         then Lc_Nr_Remessa   := False else Lc_Nr_Remessa  := True;

    if Lc_Pedido      then Lc_sqltxt := Lc_sqltxt + ' AND (PED_NUMERO = :PED_NUMERO) ';
    if Lc_NotaFiscal  then Lc_sqltxt := Lc_sqltxt + ' AND (NFL_NUMERO like :NFL_NUMERO) ';
    if Lc_Cd_Cliente  then Lc_sqltxt := Lc_sqltxt + ' AND (FIN_CODEMP =:FIN_CODEMP) ';
    if Lc_Cliente     then Lc_sqltxt := Lc_sqltxt + ' AND ((tb_cliente.EMP_FANTASIA LIKE :EMP_FANTASIA) OR (tb_cliente.EMP_NOME LIKE :EMP_FANTASIA)) ';
    if Lc_Boleto      then Lc_sqltxt := Lc_sqltxt + ' AND (BLT_NUMERO LIKE:BLT_NUMERO) ';
    if Lc_Carteira    then Lc_sqltxt := Lc_sqltxt + ' AND (BLE_CODCTR=:CTR_CODIGO) ';
    if Lc_situacao    then Lc_sqltxt := Lc_sqltxt + ' AND (BLT_MSG_RETORNO = :BLT_MSG_RETORNO) ';
    if Lc_Nr_Remessa  then Lc_sqltxt := Lc_sqltxt + ' AND (BLT_NR_REMESSA =:BLT_NR_REMESSA) ';

    if ChBx_Periodo.Checked then
    Begin
      case Rg_Data_Boleto.ItemIndex of
        0: Lc_sqltxt := Lc_sqltxt + 'AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ';
        1: Lc_sqltxt := Lc_sqltxt + 'AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM) ';
        2: Lc_sqltxt := Lc_sqltxt + 'AND (FIN_DT_PAGTO BETWEEN :DATAINI AND :DATAFIM) ';
      end;
    end;

    SQL.Add(Lc_sqltxt+ 'ORDER BY FIN_DT_VENCIMENTO, tb_cliente.EMP_NOME, PED_NUMERO, FIN_NUMERO ');

    if ChBx_Periodo.Checked then
    Begin
      ParamByName('DATAINI').AsDate      := E_Data_Ini.date;
      ParamByName('DATAFIM').Asdate      := E_Data_Fim.Date;
    end;

    if Lc_Pedido      then ParamByName('PED_NUMERO').AsString    := E_BuscaPedido.Text;
    if Lc_NotaFiscal  then ParamByName('NFL_NUMERO').AsString    := '%'+ E_BuscaNota.Text;
    if Lc_Cliente     then ParamByName('EMP_FANTASIA').AsString  := '%'+ E_Busca_Empresa.Text +'%';
    if Lc_Cd_Cliente  then ParamByName('FIN_CODEMP').AsString    := E_cd_Empresa.Text;
    if Lc_Boleto      then ParamByName('BLT_NUMERO').AsString  := '%' + E_Busca_Boleto.Text +'%';
    if Lc_Carteira    then ParamByName('CTR_CODIGO').AsInteger  := DBLCB_CarteiraCobranca.KeyValue;
    if Lc_situacao    then ParamByName('BLT_MSG_RETORNO').Value := DBLCB_Msg_Retorno.KeyValue;
    if Lc_Nr_Remessa  then ParamByName('BLT_NR_REMESSA').Value := DBLCB_Nr_Remessa.KeyValue;

    ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
    Open;
    FetchAll;
    SB_Bl_Add_Tudo.Enabled:= (RecordCount > 0);
    SB_Bl_Retirar_Tudo.Enabled:= (RecordCount > 0);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFr_ContasReceberBoleto.Pc_PreencherBoletos;
Var
  Lc_I,Lc_J : Integer;
  Lc_registro : Integer;

Begin
  with Qr_BuscaBoleto,StrGrd_Boleto do
  Begin
    First;
    Lc_registro := 0;
    while not Eof do
    Begin
      Lc_registro := Lc_registro + 1;
      RowCount := Lc_registro + 1;
      For Lc_I:= 0 to FieldCount -1 do
      Begin
        if (Fields.Fields[Lc_I].DataType = ftFloat) OR (Fields.Fields[Lc_I].DataType = ftBCD) then
          Cells[Lc_I + 3,Lc_registro] := FloatToStrF(Fields[Lc_I].AsFloat,ffFixed,10,2)
        else
          Cells[Lc_I + 3,Lc_registro] := Fields[Lc_I].AsString;
      end;
      Next;
    end;
  Repaint;
  end;
end;

procedure TFr_ContasReceberBoleto.Pc_ativaTabelas;
begin
  with DM do
  Begin
    Qr_Carteiras.Active := False;
    Qr_Carteiras.ParamByName('CTB_CODMHA').AsInteger := Gb_CodMha;
    Qr_Carteiras.Active := True;
  end;
  Qr_Msg_Retorno.Active := False;
  Qr_Msg_Retorno.Active := True;
  Qr_Msg_Retorno.FetchAll;

  Qr_Nr_Remessa.Active := False;
  Qr_Nr_Remessa.Active := True;
  Qr_Nr_Remessa.FetchAll;
end;

procedure TFr_ContasReceberBoleto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  Fr_ContasReceberBoleto:=NIL;
end;

procedure TFr_ContasReceberBoleto.EnviaWhatsApp(CodigoCliente, CodigoBoleto: String);
Var
  LcW : TWhatsApp;
  Lc_Anexo : TStringList;
  Lc_Endereco : TControllerEndereco;
begin
  Try
    Lc_Endereco := TControllerEndereco.create(nil);
    Lc_Endereco.Registro.CodigoEmpresa := StrToIntDef(CodigoCliente,0);
    Lc_Endereco.getByEmpresa;
    LcW := TWhatsApp.create(nil);
    LcW.Mensagem := 'Ola, Seu pedido foi faturado , Segue anexo o Boleto';
    LcW.ReceiverNumber := Lc_Endereco.Registro.Celular;
    //Agora Envia o Anexo
    Lc_Anexo   := Fc_Anexo_boleto(CodigoBoleto);
    if not (Lc_Anexo.Strings[0] = 'Sem anexo') then
    Begin
      LcW.Arquivo := Lc_Anexo.Strings[0];
      LcW.RegisterMessage;
      LcW.Send;
    End;
  finally
    FreeAndNil(LcW);
    FreeAndNil(Lc_Endereco);
    FreeAndNil(Lc_Anexo);
  end;
end;

procedure TFr_ContasReceberBoleto.E_cd_EmpresaExit(Sender: TObject);
begin
  if ChBx_Nome.checked then
    E_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_NOME',E_CD_Empresa.Text)
  else
    E_Busca_Empresa.Text := Fc_BuscaNomeCliente('EMP_FANTASIA',E_CD_Empresa.Text);
end;

procedure TFr_ContasReceberBoleto.ChBx_FantasiaClick(Sender: TObject);
begin
  if ChBx_Fantasia.Checked then
  Begin
    ChBx_Nome.Checked := False;
    Pc_BuscarParcela;
    Pc_PreencherParcelas;
  end;
end;

procedure TFr_ContasReceberBoleto.ChBx_NomeClick(Sender: TObject);
begin
  if ChBx_Nome.Checked then
  Begin
    ChBx_Fantasia.Checked := False;
    Pc_BuscarParcela;
    Pc_PreencherParcelas;
  end;
end;

procedure TFr_ContasReceberBoleto.Pc_LancaBanco;
Var
  Lc_I : Integer;
begin
  with Qr_BuscaParcela,StrGrd_Parcela do
  Begin
    First;
    For Lc_I := 1 to RowCount - 1 do
    begin
      if StrGrd_Parcela.Cells[11,Lc_I] = 'X' then
      Begin
        It_Qt_Rec := Fc_GeraCod_BAixa;
        Locate('FIN_CODIGO',Cells[1,Lc_I],[] );
        It_Qt_Rec := Fc_GeraCod_BAixa;
        Pc_Movim_Financeiro(dm.IB_Transacao,
                            'I',
                            0,
                            it_cod_ContBanc,
                            Now,
                            1,
                            it_PlanoC,
                            it_planoD,
                            FieldByName('FIN_vl_parcela').AsCurrency,//valor CREDITO
                            0, //valor debito
                            'Baixa Lote Pedido Nº' + FieldByName('PED_NUMERO').AsString,
                            'C',
                            It_Qt_Rec,
                            Gb_Cd_Usuario,
                            0,
                            FieldByName('FIN_DATA').AsDateTime,
                            FieldByName('FIN_NUMERO').AsString,
                            'S',
                            'N',
                            Gb_CodMha,
                            FieldByName('FIN_CODFPG').AsInteger  );
      Pc_Financeiro(dm.IB_Transacao, 'B', FieldByName('FIN_CODIGO').AsInteger, FieldByName('FIN_CODEMP').AsInteger, FieldByName('FIN_DT_VENCIMENTO').AsDateTime, FieldByName('PED_CODIGO').AsInteger, FieldByName('NFL_CODIGO').AsInteger,
                    FieldByName('FIN_CODFPG').AsInteger, '000 - é vista', FieldByName('FIN_DT_VENCIMENTO').AsDateTime, FieldByName('FIN_NUMERO').AsString, FieldByName('FIN_VL_PARCELA').AsCurrency,0,0,0,FieldByName('FIN_VL_PARCELA').AsCurrency,
                    it_dt_pag, Now,'S', FieldByName('FIN_NR_PARCELA').asinteger,FieldByName('FIN_TIPO').asstring,FieldByName('FIN_SITUACAO').asstring, It_Qt_Rec,'C','N',0);
      end;
    end;
  end;
end;


procedure TFr_ContasReceberBoleto.Pc_LancaCaixa;
var
  Lc_I:Integer;
begin
  with Qr_BuscaParcela,StrGrd_Parcela do
  Begin
    First;
    For Lc_I := 1 to RowCount - 1 do
    begin
      if Cells[11,Lc_I] = 'X' then
      Begin
        It_Qt_Rec := Fc_GeraCod_BAixa;
        Locate('FIN_CODIGO',Cells[1,Lc_I],[] );
        Pc_Movim_Financeiro(dm.IB_Transacao,
                            'I',
                            0,
                            it_cod_ContBanc,
                            Now,
                            1,
                            it_PlanoC,
                            it_planoD,
                            FieldByName('FIN_VL_PARCELA').AsCurrency,
                            0, //valor debito
                            'Baixa Lote Pedido Nº' + FieldByName('PED_NUMERO').AsString,
                            'C',
                            It_Qt_Rec,
                            Gb_Cd_Usuario,
                            0,
                            FieldByName('FIN_DATA').AsDateTime,
                            FieldByName('FIN_NUMERO').AsString,
                            'S',
                            'N',
                            Gb_CodMha,
                            FieldByName('FIN_CODFPG').AsInteger);

        Pc_Financeiro(dm.IB_Transacao,'B',FieldByName('FIN_CODIGO').AsInteger, FieldByName('FIN_CODEMP').AsInteger, FieldByName('FIN_DT_VENCIMENTO').AsDateTime, FieldByName('PED_CODIGO').AsInteger, FieldByName('NFL_CODIGO').AsInteger,
                      FieldByName('FIN_CODFPG').AsInteger, '000 - é vista', FieldByName('FIN_DT_VENCIMENTO').AsDateTime, FieldByName('FIN_NUMERO').AsString, FieldByName('FIN_VL_PARCELA').AsCurrency,0,0,0,FieldByName('FIN_VL_PARCELA').AsCurrency,
                      it_dt_pag, Now,'S', FieldByName('FIN_NR_PARCELA').asinteger,FieldByName('FIN_TIPO').asstring,FieldByName('FIN_SITUACAO').asstring, It_Qt_Rec,'C','N',0);
      end;
    end;
  end;
end;



procedure TFr_ContasReceberBoleto.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if shift = [] then
  begin
    if Pg_ContasReceberBoleto.ActivePage = tbs_ContasReceber then
    Begin
      case Key of
        VK_F5  : if SB_Boleto.Enabled then SB_BoletoClick(Sender);
        VK_F6  : If Sb_Negociar.Enabled then Sb_NegociarClick(Sender);
        VK_F7  : If SB_BuscaParcela.Enabled then SB_BuscaParcelaClick(Sender);
        VK_Escape: if SB_Sair_0.Enabled then   SB_Sair_0Click(Sender);
      end;
    end
    else
    Begin
      case Key of
        VK_F3     : if Sb_AlteraDataValor.Enabled then Sb_AlteraDataValorClick(Sender);
        VK_F4     : if Sb_Remessa.Enabled         then Sb_RemessaClick(Sender);
        VK_F5     : if Sb_RetornoRemessa.Enabled  then Sb_RetornoRemessaClick(Sender);
        VK_F6     : If SB_Excluir.Enabled         then SB_ExcluirClick(Sender);
        VK_F7     : if Sb_BuscaBoleto.Enabled     then Sb_BuscaBoletoClick(Sender);
        VK_F8     : if Sb_Envia.Enabled      then Sb_EnviaClick(Sender);
        VK_F9     : if Sb_BoletoPDF.Enabled       then Sb_BoletoPDFClick(Sender);
        VK_F10    : if SB_BaixaManual.Enabled     then SB_BaixaManualClick(Sender);
        VK_F11    : If SB_Imprimir.Enabled        then SB_ImprimirClick(Sender);
        VK_Escape : if Sb_Sair_1.Enabled          then SB_Sair_0Click(Sender);
      end;
    end;
  end;
end;

procedure TFr_ContasReceberBoleto.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
  Pc_AtivaTabelas;
  Pc_ImagemBotao;
end;


function TFr_ContasReceberBoleto.GeraListaBoletoStrGrdBoleto: String;
Var
  LcContador : Integer;
  Lc_I : Integer;
begin
  with StrGrd_Boleto do
  Begin
    LcContador := 0;
    Result := '';
    for Lc_I := 1 to RowCount - 1 do
    begin
      if (Cells[2,Lc_I] = 'X') then
      begin
        inc(LcContador);
        if (Result = '') then
          Result := Result + cells[3,Lc_I]
        else
          Result := Result + ',' + cells[3,Lc_I];
      end;
    end;
  End;
  if LcContador > 0 then
    Result := concat('and BLT_CODIGO in (',Result,')')
  else
    Result := '';
end;

procedure TFr_ContasReceberBoleto.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Contas a Receber
    SB_Boleto.Glyph.Assign(Fc_CarregaImagemBotao('BOLETO'));
    Sb_Negociar.Glyph.Assign(Fc_CarregaImagemBotao('NEGOCIAR'));
    SB_BuscaParcela.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    //Boleto
    Sb_Remessa.Glyph.Assign(Fc_CarregaImagemBotao('PUBLICAR'));
    Sb_RetornoRemessa.Glyph.Assign(Fc_CarregaImagemBotao('DESPUBLICAR'));
    SB_Excluir.Glyph.Assign(Fc_CarregaImagemBotao('EXCLUIR'));
    Sb_BuscaBoleto.Glyph.Assign(Fc_CarregaImagemBotao('BUSCAR'));
    SB_Imprimir.Glyph.Assign(Fc_CarregaImagemBotao('IMPRIMIR'));
    Sb_Sair_1.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_ContasReceberBoleto.StrGrd_ParcelaClick(Sender: TObject);
begin
  with StrGrd_Parcela do
  Begin
    IF Cells[2,Row]= 'X' then
      Cells[2,Row] := ''
    else
      Cells[2,Row] := 'X';
    Repaint;
  end;
  Pc_SomaCrSelecionados;
end;



procedure TFr_ContasReceberBoleto.StrGrd_ParcelaDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with Qr_BuscaParcela, StrGrd_Parcela do
  Begin
    if (ACol = 1)and(ARow>0) Then
    begin
      if (Cells[3,ARow] <> '') then
      Begin
        if (Cells[2,ARow] = 'X') then
          DrawFrameControl(Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
        else
          DrawFrameControl(Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
      end;
    end
    else
    Begin
      If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
      Begin
        if (Cells[2,ARow] = '') then
        Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clCream;
        end
        else
        Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clMoneyGreen;
        end;
        Canvas.FillRect(Rect); // redesenha a celula
        Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
        // Pega o texto da célula
        Texto := Cells[acol, ARow];
        //{ Calcura largura e altura (em pontos) do texto
        LarguraTexto := Canvas.TextWidth(Texto);
        AlturaTexto := Canvas.TextHeight(Texto);
        // Calcula a posição horizontal do início do texto
        if (Acol > 2) then
        Begin
          if (Fields[ACol-3].Alignment = taLeftJustify) then   // esquerda
            X := Rect.Left + 2
          else
          if (Fields[ACol-3].Alignment = taCenter) then // Centro
            X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
          else // Direita
            X := Rect.Right - LarguraTexto - 2;
        end;
        // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
        Canvas.TextRect(Rect, X, Y, Texto);
      end;
    end;
  end;
end;

procedure TFr_ContasReceberBoleto.tbs_BoletosShow(Sender: TObject);
begin
  Pc_ativaTabelas;
end;

procedure TFr_ContasReceberBoleto.SB_Cr_Add_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with StrGrd_Parcela do
  Begin
    For LC_I := 1 to RowCount -1 do
    Begin
      Cells[2,Lc_I] := 'X';
    end;
    Repaint;
  end;
  Pc_SomaCrSelecionados;
end;

procedure TFr_ContasReceberBoleto.SB_Cr_Retirar_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with StrGrd_Parcela do
  Begin
    For LC_I := 1 to RowCount -1 do
    Begin
      Cells[2,Lc_I] := '';
    end;
    Repaint;
  end;
  Lb_Vl_Cr_selecionado.Caption := '0,00';
end;

procedure TFr_ContasReceberBoleto.Sb_EnviaClick(Sender: TObject);
Var
  Lc_Escolha : Integer;
begin
  try
    Pc_ProcesoAguarde(Self,'I');
    Application.ProcessMessages;
    Self.Enabled := False;
    if ValidaEnvio then
    Begin
      Pc_ConfiguraComponenteBoleto(DM.Qr_Carteiras.FieldByName('EMP_NUMBCO').AsString);
      Pc_CarregarComponenteBoletoRemessa(GeraListaBoletoStrGrdBoleto,True);
      EnviaEmail(
                StrGrd_Boleto.Cells[20,StrGrd_Boleto.row],
                StrGrd_Boleto.Cells[3,StrGrd_Boleto.row],
                StrToIntDef(StrGrd_Boleto.Cells[21,StrGrd_Boleto.row],0)
      );
    End;
  finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
    Self.BringToFront;
  end;
end;

procedure TFr_ContasReceberBoleto.SB_BoletoClick(Sender: TObject);
begin
  if Fc_ValidaGerarBoleto then
  Begin
    Pc_ChamaGeraBoleto;
    SB_BuscaParcelaClick(Sender);
  end;
end;

procedure TFr_ContasReceberBoleto.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_ContasReceberBoleto.Sb_AlteraDataValorClick(Sender: TObject);
begin
  if Fc_ValidaAlteraVencimento then
  Begin
    Pc_AlteraVencimentoValor;
    Pc_BuscarBoletos;
    Pc_LimpaStringGrid(StrGrd_Boleto);
    Pc_PreencherBoletos;
  end;
end;

procedure TFr_ContasReceberBoleto.RegistraComissao(cd_financeiro,cd_pedido:Integer);
begin
  if FPagaComissao then
  Begin
    if not cds_comissao.Active then cds_comissao.CreateDataSet;
    if not ( cds_comissao.Locate('FIN_CODIGO',cd_financeiro,[]) ) then
    Begin
      cds_comissao.Append;
      cds_comissaoFIN_CODIGO.AsInteger := cd_financeiro;
      cds_comissaoPED_CODIGO.AsInteger := cd_pedido;
      cds_comissao.Post;
    End;
  End;
end;

procedure TFr_ContasReceberBoleto.Rg_DataClick(Sender: TObject);
begin
  Pc_BuscarParcela;
  Pc_PreencherParcelas;
  Pc_SomaContasReceber;
  Pc_SomaCreditosCeder;
  Pc_SomaVencidos;
  Pc_SomaAVencer;
end;


procedure TFr_ContasReceberBoleto.SB_ImprimirClick(Sender: TObject);
begin
  if Fc_ValidaImpressao then
  Begin
    Pc_ConfiguraComponenteBoleto(DM.Qr_Carteiras.FieldByName('EMP_NUMBCO').AsString);
    Pc_CarregarComponenteBoletoRemessa(GeraListaBoletoStrGrdBoleto,TRue);
    Pc_ImprimeBoleto;
  end;
end;


procedure TFr_ContasReceberBoleto.Sb_RemessaClick(Sender: TObject);
Var
  Lc_nr_remessa : Integer;
begin
  if Fc_ValidaRemessaBoleto then
  Begin
    Pc_ConfiguraComponenteBoleto(DM.Qr_Carteiras.FieldByName('EMP_NUMBCO').AsString);
    Pc_CarregarComponenteBoletoRemessa(GeraListaBoletoStrGrdBoleto,False);
    Lc_nr_remessa := Pc_GeraRemessaBoleto;
    //refaz a busca para
    Pc_ativaTabelas;
    Pc_BuscarBoletos;
    Pc_LimpaStringGrid(StrGrd_Boleto);
    Pc_PreencherBoletos;
  end;
end;

procedure TFr_ContasReceberBoleto.Sb_RetornoRemessaClick(Sender: TObject);
begin
  if Fc_ValidaRetornoBoleto then
  Begin
    Pc_CarregarComponenteBoletoRetorno;
    Pc_TrataRetornoBoleto;
    Pc_ProcessoBaixaAutomatica;
    Baixar_Comissao;
    MensagemPadrao('Mensagem ','S U C E S S O!.'+EOLN+EOLN+
                   'Retorno executado com sucesso.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  end;
end;

function TFr_ContasReceberBoleto.Fc_ValidaNegociacao():Boolean;
Begin
  Result := true;
  if not Fc_VerificaMarcado(StrGrd_Parcela) then
  Begin
    Result := False;
    exit;
  end;

  if not Fc_VerificaMarcadoMesmoCliente then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Para negociar marque apenas valores do mesmo cliente.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;  
end;

Procedure TFr_ContasReceberBoleto.Pc_Negociar;
Var
  Lc_Form : TFr_Negociar;
  Lc_StrGridDuplicata : TStringGrid;
  Lc_I,Lc_J : Integer;
  Lc_Nr_Parcela : Integer;
  Lc_Valor : Real;
begin
  //Prepara uma grid para passar os valores
  Lc_StrGridDuplicata  := TStringGrid.Create(Fr_ContasReceberBoleto);
  Lc_StrGridDuplicata.RowCount := 2;
  Lc_StrGridDuplicata.ColCount := StrGrd_Parcela.ColCount;
  Lc_Nr_Parcela := 0;
  Lc_Valor := 0;
  For Lc_I := 1 to StrGrd_Parcela.RowCount - 1 do
  Begin
    if StrGrd_Parcela.Cells[2,Lc_I] = 'X' then
    Begin
      inc(Lc_Nr_Parcela);
      Lc_StrGridDuplicata.RowCount := 1 + Lc_Nr_Parcela;
      For Lc_J := 1  to StrGrd_Parcela.ColCount do
      Begin
        Lc_StrGridDuplicata.Cells[Lc_J,Lc_Nr_Parcela] := StrGrd_Parcela.Cells[Lc_J,Lc_I];
      end;
      Lc_Valor := Lc_Valor  + StrtoFloatDef(StrGrd_Parcela.Cells[11,Lc_I],0);
    end;
  end;
  Lc_Form := TFr_Negociar.Create(Self);
  Lc_Form.It_StrGridDuplicata := TStringGrid.Create(Lc_Form);
  Lc_Form.It_StrGridDuplicata := Lc_StrGridDuplicata;
  Lc_Form.It_Cd_Empresa := StrToIntDef(Lc_StrGridDuplicata.Cells[8,1],0);
  Lc_Form.It_Dt_Emissao := Date;
  Lc_Form.E_VL_Doc.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
  Lc_Form.It_Ctrl_Tela := 'Fr_ContasReceberBoleto';
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
end;



procedure TFr_ContasReceberBoleto.Pc_CarregarComponenteBoletoRemessa(Pc_Lst_Boleto:String;Pc_Print:Boolean);
var
  Lc_Titulo    : TACBrTitulo;
//  NrTitulos : Integer;
  NrTitulosStr :String;
  Convertido: Boolean;
  Lc_Instr_Venc : String;
  Lc_Lst_Boleto : String;
  Lc_Aceite : String;
  Lc_ValorDesconto : Real;
  Lc_DataAbatimento : String;
begin
  with Qr_Boleto do
  Begin
    Active := false;
    SQL.Clear;
    SQL.Add('select DISTINCT BLT_CODIGO,BLT_DT_VENCIMENTO,BLT_DATA,BLT_NUMERO,BLT_NOSSONUMERO,EPD_SIGLA,BLT_ACEITE, '+
            'BLT_DT_PROCESSAMENTO,CTR_NUMERO,ctr_tipo_emissao,cliente.EMP_NOME,cliente.EMP_CNPJ,END_ENDER,END_NUMERO,END_BAIRRO,CDD_DESCRICAO,UFE_SIGLA, '+
            'END_CEP,BLE_LOCALPAG,BLT_VALOR,BLT_VL_MORA,BLT_VL_DESCONTO,BLT_DT_DESC_VENC,BLT_TX_MULTA,BLE_INSTR_1,BLE_INSTR_2, '+
            'BLT_INSTRUCOES,BLT_DT_PROTESTO,BLT_TX_DESCONTO,BLT_TX_JUROS,BLT_TX_MORA,BLE_VL_MORA_MIN,BLT_VL_TARIFA, '+
            ' END_CONTATO, BLT_DIAS_PROTESTO,BLT_TIPO_DIA,fin_codqtc,banco.EMP_NUMBCO BCO_NUMERO,BLT_DIAS_NEGATIVACAO,BLE_NEGATIVACAO  '+
            'from tb_boleto_bancario '+
            '  INNER JOIN TB_FINANCEIRO '+
            '  ON (tb_financeiro.fin_codqtc = Tb_boleto_bancario.blt_codqtc) '+
            '  INNER JOIN tb_boleto_eletronico '+
            '  ON (tb_boleto_eletronico.ble_codigo = tb_boleto_bancario.blt_codble) '+
            '  INNER JOIN tb_carteira_cobranca '+
            '  ON (tb_carteira_cobranca.ctr_codigo = tb_boleto_eletronico.ble_codctr) '+

            '  INNER JOIN tb_empresa banco '+
            '  ON (banco.EMP_codigo = tb_carteira_cobranca.CTR_CODBCO) '+


            '  INNER JOIN tb_especie_doc '+
            '  ON (tb_especie_doc.epd_codigo = tb_boleto_eletronico.ble_codepd) '+
            '  INNER JOIN tb_empresa cliente '+
            '  ON (cliente.EMP_CODIGO = TB_BOLETO_bancario.BLT_CODEMP) '+
            '  INNER JOIN tb_endereco '+
            '  ON (tb_endereco.end_codemp = cliente.EMP_CODIGO) '+
            '  INNER JOIN TB_CIDADE tb_cidade '+
            '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '+
            '  INNER JOIN TB_UF tb_uf '+
            '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
            'WHERE ( END_PRINCIPAL = ''S'')' + Pc_Lst_Boleto );
    Active := True;
    first;
    Fr_Principal.Boleto.ListadeBoletos.Clear;
    while not eof do
    begin
      IF (FieldByName('BLT_ACEITE').AsString = 'S') then
        Lc_Aceite            := 'S'
      else
        Lc_Aceite           := 'N';
      Pc_IncluirBoleto(FieldByName('BCO_NUMERO').asString,
                       FieldByName('BLT_DT_VENCIMENTO').AsDateTime,
                       FieldByName('BLT_DATA').AsDateTime,
                       FieldByName('BLT_NUMERO').AsString,
                       FieldByName('EPD_SIGLA').AsString,
                       Lc_Aceite,
                       Now,
                       FieldByName('BLT_NOSSONUMERO').AsString,
                       FieldByName('CTR_NUMERO').AsString,
                       FieldByName('BLT_VALOR').AsCurrency,
                       FieldByName('EMP_NOME').AsString,
                       FieldByName('EMP_CNPJ').AsString,
                       FieldByName('END_ENDER').AsString,
                       FieldByName('END_NUMERO').AsString,
                       FieldByName('END_BAIRRO').AsString,
                       FieldByName('CDD_DESCRICAO').AsString,
                       FieldByName('UFE_SIGLA').AsString,
                       FieldByName('END_CEP').AsString,
                       FieldByName('BLE_LOCALPAG').AsString,
                       FieldByName('BLT_DT_DESC_VENC').AsString,
                       FieldByName('BLT_VL_DESCONTO').AsCurrency,
                       FieldByName('BLT_TX_MULTA').AsCurrency,
                       FieldByName('BLT_TX_JUROS').AsFloat,
                       FieldByName('BLT_TX_MORA').AsCurrency,
                       FieldByName('BLE_VL_MORA_MIN').AsCurrency,
                       FieldByName('BLT_DIAS_PROTESTO').asInteger,
                       FieldByName('BLT_TIPO_DIA').asString,
                       FieldByName('BLT_DT_PROTESTO').asString,
                       FieldByName('BLT_DIAS_NEGATIVACAO').asInteger,
                       FieldByName('BLE_NEGATIVACAO').asString,
                       FieldByName('BLT_INSTRUCOES').AsString,
                       FieldByName('BLE_INSTR_1').AsString,
                       FieldByName('BLE_INSTR_2').AsString,
                       FieldByName('fin_codqtc').asInteger,
                       Pc_Print);
      next;
    end;
  end;
end;

procedure TFr_ContasReceberBoleto.Pc_CarregarComponenteBoletoRetorno;
Begin
  with Fr_Principal.Boleto do
  Begin
    LerRetorno;
  end;
end;

function  TFr_ContasReceberBoleto.Fc_ValidaAlteraVencimento():Boolean;
Var
  Lc_I : Integer;
Begin
  Result := True;
  IF (Trim(DBLCB_CarteiraCobranca.text) = '') then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe a carteira utilizada.'+EOLN+
                   'Isso garante que todos os boletos selecionados '+EOLN+
                   ' estejam relacionados ao mesmo grupo de cobrança.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    DBLCB_CarteiraCobranca.setFocus;
    Result := False;
    exit;
  end;

  if not Fc_VerificaMarcado(StrGrd_Boleto) then
  Begin
    Result := False;
    exit;
  end;

  with StrGrd_Boleto do
  Begin
    For Lc_I := 1 to RowCount - 1 do
    Begin
      if Cells[2,Lc_I] = 'X' then
      Begin
        if (Cells[18,Lc_I] = 'Documento Baixado') then
        Begin
          MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                         'O Documento '+ Cells[5,Lc_I] + ' já esta baixado' + EOLN+
                         'Esta operação não é permitida.'+EOLN,
                        ['OK'],[bEscape],mpAlerta);
          result := False;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TFr_ContasReceberBoleto.Pc_AlteraVencimentoValor;
Var
  Lc_I : Integer;
  Lc_Qry:TSTQuery;
  Lc_Dt_Vencimento : TDate;
  Lc_Data:String;
Begin
  if not(InputQuery('Informe a Data de Vencimento ', 'Data de Vencimento',Lc_Data)) then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe uma data de Vencimento'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    exit;
  end;
  try
    Lc_Dt_Vencimento := StrToDate(Lc_Data);
  except
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Data Inválida, por favor Verifique!!'+EOLN+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    exit;
  end;
  Lc_Qry := TSTQuery.Create(Fr_ContasReceberBoleto);
  with StrGrd_Boleto,Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := True;
    //ALTERAR O VENCIMENTO DO BOLETO
    sql.Clear;
    sql.Add('UPDATE TB_BOLETO_BANCARIO SET '+
            'BLT_DT_VENCIMENTO =:BLT_DT_VENCIMENTO,'+
            'BLT_REMESSA =:BLT_REMESSA '+
            'WHERE BLT_CODIGO=:BLT_CODIGO');
    For Lc_I := 1 to RowCount - 1 do
    Begin
      if Cells[2,Lc_I] = 'X' then
      Begin
        Active := False;
        ParamByName('BLT_DT_VENCIMENTO').AsDate := Lc_Dt_Vencimento;
        if (Cells[18,Lc_I] = 'Documento Enviado') then
          ParamByName('BLT_REMESSA').AsInteger := 6
        else
          ParamByName('BLT_REMESSA').AsInteger := 1;
        ParamByName('BLT_CODIGO').AsString := Cells[3,Lc_I];
        ExecSQL;
         if Transaction.InTransaction then Transaction.CommitRetaining;
      end;
    end;
    //ALTERAR O VENCIMENTO DO FINANCIERO
    sql.Clear;
    sql.Add('UPDATE TB_FINANCEIRO SET '+
            'FIN_DT_VENCIMENTO =:FIN_DT_VENCIMENTO '+
            'WHERE FIN_CODIGO=:FIN_CODIGO');
    For Lc_I := 1 to RowCount - 1 do
    Begin
      if Cells[2,Lc_I] = 'X' then
      Begin
        Active := False;
        ParamByName('FIN_DT_VENCIMENTO').AsDate := Lc_Dt_Vencimento;
        ParamByName('FIN_CODIGO').AsString := Cells[4,Lc_I];
        ExecSQL;
         if Transaction.InTransaction then Transaction.CommitRetaining;
      end;
    end;

  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;
{
Var
  Lc_Form : TFr_AlteraBoleto;
Begin
  Lc_Form := TFr_AlteraBoleto.Create(Self);
  //Financeiro
  Lc_Form.Financeiro.Registro.Codigo := StrToIntDef(StrGrd_Boleto.Cells[4,StrGrd_Boleto.RowCount],0);
  Lc_Form.Financeiro.getById;
  //Boleto
  Lc_Form.Boleto.Registro.Codigo := StrToIntDef(StrGrd_Boleto.Cells[3,StrGrd_Boleto.RowCount],0);
  Lc_Form.Boleto.getById;
end;
 }
function TFr_ContasReceberBoleto.ValidaEnvio():Boolean;
Begin
  Result := true;
  IF (Trim(DBLCB_CarteiraCobranca.text) = '') then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe uma carteira utilizada.'+EOLN+
                   'Isso garante que todos os boletos selecionados '+EOLN+
                   ' estejam relacionados ao mesmo grupo de cobrança.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    DBLCB_CarteiraCobranca.setFocus;
    Result := False;
    exit;
  end;

  if DM.Qr_Carteiras.FieldByName('CTR_TIPO_EMISSAO').AsString = 'B' then
  Begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Esta carteira de cobrança a emissão é por conta do Banco.'+EOLN+
                   'Verifique os parãmetros no cadastro de cobrança.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
    Result := False;
    exit;
  end;


  if not Fc_VerificaMarcado(StrGrd_Boleto) then
  Begin
    Result := False;
    exit;
  end;
end;

procedure TFr_ContasReceberBoleto.EnviaEmail(email:String;CodigoBoleto:String;CodigoQuitacao:Integer);
var
  Lc_Mail : String;
  Lc_Assunto : String;
  //Email automatico
  Lc_Escolha : Integer;
  Lc_Email: string;
  Lc_Destinatario : TStringList;
  Lc_AssuntoEmail : string;
  Lc_Obs : TMemo;
  Lc_Texto: TMemoryStream;
  LcEnviaemail : TFr_envia_email;
begin
  Try
    Lc_Destinatario := TStringList.Create;
    Lc_AssuntoEmail :=  'Envio de Boleto - ' + DM.Qr_Estabelecimento.FieldByName('EMP_FANTASIA').AsString;
    LcEnviaemail := TFr_envia_email.create(nil);
    with LcEnviaemail do
    Begin
      It_Tipo_Envio := 'S';
      It_Assunto := Lc_AssuntoEmail;
      Pc_Define_RemententeAtivo;
      Lc_Destinatario.Clear;
      Lc_Destinatario.Add(' ' + email );
      Pc_ListaEmailParaEnvio(DM.Qr_Estabelecimento.FieldByName('EMP_CODIGO').AsString,['FINANCEIRO'],Lc_Destinatario) ;
      It_Anexo   := Fc_Anexo_boleto(CodigoBoleto);
      It_Destino := Lc_Destinatario;
      It_Corpo   := Fc_Gera_Email(StrGrd_Boleto.row, CodigoQuitacao);
      ShowModal;
    End;
  Finally
    FReeAndNil(Lc_Destinatario);
    FreeAndNil(LcEnviaemail);
  End;
end;

Function TFr_ContasReceberBoleto.Fc_Anexo_boleto(Fc_Nr_Boleto:String):TStringList;
Var
  Lc_Arquivo : String;
Begin
  Result := TStringList.Create;
  Result.Clear;
  Lc_Arquivo := GbPathexe + 'temp\' + Fc_Nr_Boleto + '.pdf';
  with Fr_Principal do
  Begin
    if not DirectoryExists(GbPathexe + 'imagem\') then
      CreateDir(GbPathexe + 'imagem\');
    BoletoFcFortes.DirLogo := GbPathexe + '\imagem\';
    if not FileExists(GbPathexe + 'imagem\'+StrZero(Boleto.Banco.Numero,3,0)+'.bmp') then
      Pc_BaixarLogoBanco(StrZero(Boleto.Banco.Numero,3,0));
    BoletoFcFortes.Filtro := fiPDF;
    BoletoFcFortes.MostrarPreview := False;
    BoletoFcFortes.MostrarSetup := False;
    BoletoFcFortes.MostrarPreview := False;
    BoletoFcFortes.NomeArquivo := Lc_Arquivo;
    Boleto.GerarPDF;
  end;

  Result.Add(Lc_Arquivo);
end;

function TFr_ContasReceberBoleto.Fc_Gera_Email(Fc_Indice,CodigoQuitacao:Integer):String;
Var
  Lc_Qry : TSTQuery;
  Lc_Referencia : String;
Begin
  if (CodigoQuitacao > 0 ) then
  Begin
    Lc_Referencia := NotasReferenciadas(CodigoQuitacao);
    Lc_Qry := TSTQuery.Create(nil);
    with Lc_Qry  do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := True;
      sql.Clear;
      sql.Add('SELECT DISTINCT NFL_NUMERO '+
              'FROM tb_nota_fiscal n '+
              '  INNER JOIN TB_FINANCEIRO f '+
              '  ON (f.fin_codnfl = n.nfl_codigo) '+
              'where ( n.nfl_numero is not null) '+
              ' and  ( n.nfl_numero <> '''') '+
              ' and  ( f.fin_codqtc > 0) '+
              ' and  ( f.fin_codqtc = :FIN_CODQTC) ');
      ParamByName('FIN_CODQTC').AsInteger := CodigoQuitacao;
      Active := True;
      First;
      Lc_Referencia := '';
      while not eof do
      Begin
        if bof then
          Lc_Referencia := 'Referente a(s) nota(s): ' + FieldByName('NFL_NUMERO').AsString
        else
          Lc_Referencia := Lc_Referencia + ' / ' + FieldByName('NFL_NUMERO').AsString;
        next;
      End;
    End;
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
  End;
  Screen.Cursor:=crHourGlass;
  //Criar o Html
  Result := '<html> '+
            '<head> '+
            '  <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type"> '+
            '</head> '+
            '<body> ';
  //Cabeçalho do Email
  Result := Result +
            '<table width="100%" border="0" cellpadding="0" cellspacing="0"> '+
            '   <tr> '+
            '     <td>Olá ' + Qr_Boletoend_Contato.AsString + '</td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td>&nbsp;</td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td> Segue em anexo o boleto bancário para pagamento. </td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td> Favor retornar este e-mail com a confirmação de recebimento do boleto. </td> '+
            '   </tr> ';
  if Trim(Lc_Referencia) <> '' then
  Begin
    Result := Result +
              '   <tr> '+
              '     <td>&nbsp;</td> '+
              '   </tr> '+
              '   <tr> '+
              '     <td> ' + Lc_Referencia + '</td> '+
              '   </tr> ';
  End;
  Result := Result +
            '   <tr> '+
            '     <td>&nbsp;</td> '+
            '   </tr> ';
  //Rodape
  Result := Result +
            '</tbody> '+
            '</table> '+
            '<BR> '+
            '<BR> '+
            '<BR> '+
            Fc_GeraAssinaturaEmail +
            '</body> '+
            '</html> ';
  Screen.Cursor:=crDefault;
end;


procedure TFr_ContasReceberBoleto.Sb_NegociarClick(Sender: TObject);
begin
  if Fc_ValidaNegociacao then
    Begin
    Pc_Negociar;
    end;
end;

procedure TFr_ContasReceberBoleto.Sb_BuscaBoletoClick(Sender: TObject);
begin
  Pc_BuscarBoletos;
  Pc_LimpaStringGrid(StrGrd_Boleto);
  Pc_PreencherBoletos;
end;

procedure TFr_ContasReceberBoleto.StrGrd_BoletoDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with Qr_BuscaBoleto, StrGrd_Boleto do
  Begin
    if (ACol = 1)and(ARow>0) Then
    begin
      if (Cells[3,ARow] <> '') then
      Begin
      if (Cells[2,ARow] = 'X') then
        DrawFrameControl(Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
      else
        DrawFrameControl(Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
      end;
    end
    else
    Begin
      If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
      Begin
        if (Cells[2,ARow] = '') then
        Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clCream;
        end
        else
        Begin
          Canvas.Font.Color:= clBlack;
          Canvas.Brush.Color:= clMoneyGreen;
        end;
        Canvas.FillRect(Rect); // redesenha a celula
        Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
        // Pega o texto da célula
        Texto := Cells[acol, ARow];
        //{ Calcura largura e altura (em pontos) do texto
        LarguraTexto := Canvas.TextWidth(Texto);
        AlturaTexto := Canvas.TextHeight(Texto);
        // Calcula a posição horizontal do início do texto
        if (Acol > 2) then
        Begin
          if (Fields[ACol-3].Alignment = taLeftJustify) then   // esquerda
            X := Rect.Left + 2
          else
          if (Fields[ACol-3].Alignment = taCenter) then // Centro
            X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
          else // Direita
            X := Rect.Right - LarguraTexto - 2;
        end;
        // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
        Canvas.TextRect(Rect, X, Y, Texto);
      end;
    end;
  end;

end;

procedure TFr_ContasReceberBoleto.StrGrd_BoletoClick(Sender: TObject);
begin
  with StrGrd_Boleto do
  Begin
    IF Cells[2,Row]= 'X' then
      Cells[2,Row] := ''
    else
      Cells[2,Row] := 'X';
    Repaint;
  end;
  Pc_SomaBlSelecionados;
end;

procedure TFr_ContasReceberBoleto.SB_Bl_Retirar_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with StrGrd_Boleto do
  Begin
    For LC_I := 1 to RowCount -1 do
      Begin
      Cells[2,Lc_I] := '';
      end;
    Repaint;
  end;
  Lb_Vl_Bl_selecionado.Caption := '0,00';
end;

procedure TFr_ContasReceberBoleto.SB_Bl_Add_TudoClick(Sender: TObject);
Var
  Lc_I : Integer;
begin
  with StrGrd_Boleto do
  Begin
    For LC_I := 1 to RowCount -1 do
      Begin
      Cells[2,Lc_I] := 'X';
      end;
    Repaint;
  end;
  Pc_SomaBlSelecionados;  
end;

procedure TFr_ContasReceberBoleto.DBLCB_BuscaContaCorrenteClick(
  Sender: TObject);
begin
  Sb_BuscaBoletoClick(Self);
end;

procedure TFr_ContasReceberBoleto.Sb_BoletoPDFClick(Sender: TObject);
begin
  if Fc_ValidaImpressao then
    Begin
    Pc_ConfiguraComponenteBoleto(DM.Qr_Carteiras.FieldByName('EMP_NUMBCO').AsString);
    Pc_CarregarComponenteBoletoRemessa(GeraListaBoletoStrGrdBoleto,True);
    Pc_GeraPDFBoleto;
    end;
end;

function TFr_ContasReceberBoleto.fc_ValidaExclusao():boolean;
Begin
  Result := True;
  if not Fc_VerificaMarcado(StrGrd_Boleto) then
  Begin
    Result := False;
    exit;
  end;
end;
procedure TFr_ContasReceberBoleto.Pc_ExcluiBoletos;
Var
  Lc_I:Integer;
  Lc_Qry_delete:TSTQuery;
  Lc_Qry_Update:TSTQuery;
Begin
  //Atualiza Financeiro
  Lc_Qry_Update := TSTQuery.Create(Fr_ContasReceberBoleto);
  Lc_Qry_Update.Database := DM.IBD_Gestao;
  Lc_Qry_Update.Transaction := DM.IB_Transacao;
  Lc_Qry_Update.ForcedRefresh := True;
  Lc_Qry_Update.SQL.Clear;
  Lc_Qry_Update.SQL.Add('UPDATE TB_FINANCEIRO SET '+
                        'FIN_SITUACAO =:FIN_SITUACAO, '+
                        'FIN_CODQTC =:FIN_CODQTC '+
                        'WHERE FIN_CODIGO=:FIN_CODIGO ');
  //Deleta o Boleto
  Lc_Qry_delete := TSTQuery.Create(Fr_ContasReceberBoleto);
  Lc_Qry_delete.Database := DM.IBD_Gestao;
  Lc_Qry_delete.Transaction := DM.IB_Transacao;
  Lc_Qry_delete.ForcedRefresh := True;
  Lc_Qry_delete.SQL.Clear;
  Lc_Qry_delete.sql.Add('delete from TB_BOLETO_BANCARIO where blt_codigo=:BLT_CODIGO');
  if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
  For Lc_I := 1 to StrGrd_Boleto.RowCount - 1 do
  Begin
    if StrGrd_Boleto.Cells[2,Lc_I] = 'X' then
    Begin
      //Atualiza Financeiro
      Lc_Qry_Update.Active := False;
      Lc_Qry_Update.ParamByName('FIN_SITUACAO').AsString := 'N';
      Lc_Qry_Update.ParamByName('FIN_CODQTC').AsInteger := 0;
      Lc_Qry_Update.ParamByName('FIN_CODIGO').AsString := StrGrd_Boleto.Cells[4,Lc_I];
      Lc_Qry_Update.ExecSQL;
      //Delete o Boleto
      Lc_Qry_delete.Active := False;
      Lc_Qry_delete.ParamByName('BLT_CODIGO').AsString := StrGrd_Boleto.Cells[3,Lc_I];
      Lc_Qry_delete.ExecSQL;
    end;
  end;
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
end;

procedure TFr_ContasReceberBoleto.SB_ExcluirClick(Sender: TObject);
begin
  if fc_ValidaExclusao then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir os boletos selecionados?' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
    begin
      Pc_ExcluiBoletos;
      Pc_Log_Sistema(Gb_CodMha,
                     GB_Cd_Usuario,
                     now,
                     'Controle de Boletos',
                     StrtoIntDef(StrGrd_Parcela.Cells[1,StrGrd_Parcela.row],0),
                     'Exclusão Boleto',
                     'Boleto: ' + StrGrd_Boleto.Cells[5,StrGrd_Boleto.row] + ' | VALOR: ' + StrGrd_Boleto.Cells[13,StrGrd_Boleto.row]);
      Pc_BuscarBoletos;
      Pc_LimpaStringGrid(StrGrd_Boleto);
      Pc_PreencherBoletos;
    end;
  end;
end;

procedure TFr_ContasReceberBoleto.SB_BaixaManualClick(Sender: TObject);
Var
  Lc_form: TFr_Baixa_Boleto;
begin
  Lc_form := TFr_Baixa_Boleto.Create(Self);
  Lc_form.It_NossoNumero := StrGrd_Boleto.Cells[19,StrGrd_Boleto.row];
  Lc_form.E_Valor_Pago.Text := StrGrd_Boleto.Cells[13,StrGrd_Boleto.row];
  Lc_form.show;

end;

procedure TFr_ContasReceberBoleto.DBLCB_CarteiraCobrancaKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
    DBLCB_CarteiraCobranca.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_ContasReceberBoleto.DBLCB_Msg_RetornoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
          DBLCB_Msg_Retorno.KeyValue := Null;
        end;
      end;
end;

procedure TFr_ContasReceberBoleto.DBLCB_Nr_RemessaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
        begin
          DBLCB_Nr_Remessa.KeyValue := Null;
        end;
      end;
end;

procedure TFr_ContasReceberBoleto.Sb_Pesq_EmpresaClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    E_Busca_Empresa.text := Lc_Retorno.It_Dados[1,1];
  end;
end;

end.
      