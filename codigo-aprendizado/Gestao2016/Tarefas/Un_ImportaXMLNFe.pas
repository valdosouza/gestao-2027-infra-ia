unit Un_ImportaXMLNFe;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, ControllerCtrlLote, OleCtrls, SHDocVw, ACBrUtil, XMLIntf, XMLDoc, pcnAuxiliar, pcnConversao, ACBrValidador, pcnConversaoNfe, Un_Fm_CentroCusto, Un_Fm_FormaPagto, ControllerParcelamento, ControllerEndereco, ControllerCtrlIcmsST, Vcl.ComCtrls, Vcl.DBCtrls, QEdit_Setes, System.Math, ControllerCtrlEstoque, ControllerNotaFiscal, ControllerFornecedor, ControllerTransportadora, Datasnap.DBClient, un_base, Vcl.Menus, base_frame_list, un_fm_lista_eventos_nfe;

type
  TFr_ImportaXMLNFe = class(TFr_Base)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    E_Chave: TEdit_Setes;
    GroupBox4: TGroupBox;
    Panel2: TPanel;
    Pg_Notas: TPageControl;
    tbs_nota: TTabSheet;
    Pnl_Cliente: TPanel;
    Label1: TLabel;
    Label3: TLabel;
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
    E_RazaoSocial: TEdit;
    E_Cnpj_CPf: TEdit;
    E_Endereco: TEdit;
    E_Bairro: TEdit;
    E_Cep: TEdit;
    E_Cidade: TEdit;
    E_Fone: TEdit;
    E_Estado: TEdit;
    E_Insc_Est: TEdit;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    E_Nr_Nota: TEdit;
    E_Natureza: TEdit;
    E_Vl_Total: TEdit_Setes;
    TabSheet6: TTabSheet;
    Panel4: TPanel;
    Sb_Produto: TBitBtn;
    tbs_financeiro: TTabSheet;
    Pnl_Financeiro: TPanel;
    tbs_processo: TTabSheet;
    TabSheet3: TTabSheet;
    Panel5: TPanel;
    StrGrd_CFOP: TStringGrid;
    Sb_CFOP: TBitBtn;
    SB_Processo: TSpeedButton;
    SB_Confirmar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    tbs_adicional: TTabSheet;
    Panel6: TPanel;
    GroupBox5: TGroupBox;
    Lb_Controle: TLabel;
    E_DocVinculado: TEdit_Setes;
    Chbx_CreditoFinanceiro: TCheckBox;
    Label5: TLabel;
    Label34: TLabel;
    ChBx_FinManual: TCheckBox;
    GroupBox6: TGroupBox;
    Label36: TLabel;
    E_VL_Frete_Extra: TEdit_Setes;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel3: TPanel;
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
    Label2: TLabel;
    E_Bs_Icms: TEdit_Setes;
    E_Vl_Icms: TEdit_Setes;
    E_Bs_Icms_St: TEdit_Setes;
    E_Vl_Icms_St: TEdit_Setes;
    E_Vl_frete: TEdit_Setes;
    E_Vl_Seguro: TEdit_Setes;
    E_Vl_Outras: TEdit_Setes;
    E_Vl_IPI: TEdit_Setes;
    E_VL_Produto: TEdit_Setes;
    E_VL_Nota: TEdit_Setes;
    E_Qtde: TEdit_Setes;
    E_Especie: TEdit;
    E_MArca: TEdit;
    E_Numero: TEdit;
    E_PesoBruto: TEdit_Setes;
    E_PesoLiquido: TEdit_Setes;
    E_Vl_Desconto: TEdit_Setes;
    E_Obs: TMemo;
    OpenDialogo: TOpenDialog;
    Label37: TLabel;
    GroupBox7: TGroupBox;
    Label38: TLabel;
    E_Vl_Outras_Extra: TEdit_Setes;
    Sb_Estoque: TBitBtn;
    ChBx_XML_Terceiro: TCheckBox;
    ChBx_Cad_Produto_Auto: TCheckBox;
    E_Dt_Emissao: TMaskEdit;
    E_Dt_Saida: TMaskEdit;
    Chbx_Financeiro: TCheckBox;
    Label4: TLabel;
    Lb_Nr_Caracteres: TLabel;
    ChBx_Manifestacao: TCheckBox;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    MemoResp: TMemo;
    MM_REceita: TMemo;
    ChBx_AtualizarEstoque: TCheckBox;
    Chbx_ForcaCusto: TCheckBox;
    Label35: TLabel;
    ChBx_CalculoCustoMedioBonificacao: TCheckBox;
    TabSheet7: TTabSheet;
    Scx_Parcela: TScrollBox;
    Dbg_items: TDBGrid;
    ds_itens_nota: TDataSource;
    sb_RecarregaLista: TBitBtn;
    Panel7: TPanel;
    Sb_Replicar_item: TBitBtn;
    cds_itens_nota: TClientDataSet;
    cds_itens_notaitem: TStringField;
    cds_itens_notacodigo: TIntegerField;
    cds_itens_notadescricao: TStringField;
    cds_itens_notaunidade: TStringField;
    cds_itens_notaqtde: TFloatField;
    cds_itens_notavalorUnitario: TFloatField;
    cds_itens_notavalorDesconto: TFloatField;
    cds_itens_notavalorTotal: TFloatField;
    cds_itens_notacodigoNota: TStringField;
    cds_itens_notacodigoInterno: TIntegerField;
    cds_itens_notacodigoFabrica: TStringField;
    cds_itens_notadescricaoInterna: TStringField;
    cds_itens_notacodigoEstoque: TIntegerField;
    cds_itens_notadescricaoEstoque: TStringField;
    cds_itens_notancmNota: TStringField;
    cds_itens_notaorigemNota: TStringField;
    cds_itens_notastNota: TStringField;
    cds_itens_notaduplicate: TStringField;
    cds_itens_notabarras: TStringField;
    cds_itens_notaloteNumero: TStringField;
    cds_itens_notaloteVencimento: TDateField;
    cds_itens_notafrete: TFloatField;
    cds_itens_notaseguro: TFloatField;
    cds_itens_notaoutras: TFloatField;
    Panel8: TPanel;
    Lb_Total_Itens_Nota: TLabel;
    Lb_Total_Itens_Calculado: TLabel;
    cds_itens_notavalortotalFixo: TFloatField;
    Label40: TLabel;
    Label41: TLabel;
    FmListaEventosNfe: TFmListaEventosNfe;


    procedure FormShow(Sender: TObject);
    procedure Sb_ProdutoClick(Sender: TObject);
    procedure Sb_CFOPClick(Sender: TObject);
    procedure StrGrd_CFOPDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure Pg_NotasChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure E_ChaveKeyPress(Sender: TObject; var Key: Char);
    procedure E_ChaveEnter(Sender: TObject);
    procedure SB_ProcessoClick(Sender: TObject);
    procedure Sb_EstoqueClick(Sender: TObject);
    procedure E_ChaveChange(Sender: TObject);
    procedure sb_RecarregaListaClick(Sender: TObject);
    procedure Sb_Replicar_itemClick(Sender: TObject);
    procedure Dbg_itemsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    // Permissão
    It_Processo: Boolean;
    It_Confirma: Boolean;
    It_CodigoFPagto: TStringList;
    It_FileXML: String;
    // Controles para a importação
    It_Cd_Pedido: Integer;
    It_Nr_Pedido: Integer;
    It_cd_Empresa: Integer;
    It_cd_Endereco: Integer;
    It_Cd_Transporte: Integer;
    It_cd_Vendedor: Integer;
    It_Nr_Nota: String;
    CtrlcmsST : TControllerCtrlIcmsST;
    Parcelamento : TControllerParcelamento;
    procedure FinalizaProcesso;
    function  validaDuplicaitem:Boolean;
    procedure duplicaItem;
    procedure ChangeSubTotalByQtde(Sender: TField);
    procedure ChangeSubTotalbyValor(Sender: TField);
    procedure CalculoCustoExtrasDataset;

  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure setPerfil;Override;
    procedure FormataTela;Override;
    procedure AtivaTabelas;Override;
    procedure ClearFields(T: TComponent);

  public
    { Public declarations }
    NotaFiscal : TControllerNotaFiscal;
    CtrlLote : TControllerCtrlLote;
    procedure Pc_AtivarTabelas;

    procedure Pc_MontaGradeCFOP;
    procedure Pc_LimpaGrandeCFOP;

    procedure Pc_IniciaVariaveis;
    // Mostra da Tela
    procedure Pc_MostraEmitenteXML_Nfe;
    procedure Pc_MostraDadosNotaXML_Nfe;
    procedure Pc_MostraItensNotaXML_Nfe;

    procedure calculatotalItens;
    procedure Pc_MostraItensNotaXML_Nfe_Novo;

    procedure Pc_MostraDadosCFOP_Nfe;
    function Fc_ManifestacaoDestinatario(Fc_Chave: String;
      Fc_CNPJ: String): Boolean;
    function Fc_ValidaManifestacao(): Boolean;

    // Gerar a Gravação dos dados no Sistema
    Function Fc_ValidaFaturamento(): Boolean;
    Function Fc_ValidaValoresProdutos(): Boolean;
    Function Fc_ValidaReferenciaItens(): Boolean;
    Function Fc_ValidaReferenciaCFOP(): Boolean;
    Function Fc_ValidaValoresFinanceiros(): Boolean;
    procedure Pc_GravaEmitente;
    procedure Pc_GravaTransportadora;
    procedure Pc_CadastrarProdutosAuto;
    procedure Pc_GravaPedido;
    procedure Pc_GravaNotaFiscal;
    procedure Pc_GravaItensNota;
    procedure Pc_GravaLote;
    procedure Pc_GravaItensICMS(Pc_Sequencia: Integer);
    procedure Pc_GravaCtrlIcmsRet(Pc_Sequencia,Pc_Cd_Produto: Integer);
    procedure Pc_GravaItensIPI(Pc_Sequencia: Integer);
    procedure Pc_GravaItensPIS(Pc_Sequencia: Integer);
    procedure Pc_GravaItensCOFINS(Pc_Sequencia: Integer);
    procedure Pc_GravaItensII(Pc_Sequencia: Integer);
    procedure Pc_Gera_Financeiro;
    procedure Pc_GravaArquivoXML;
    procedure Pc_AtualizaCusto;
    procedure Pc_Atualiza_Preco_Venda;

    function Fc_ValidaLeituraManual(): Boolean;
    procedure Pc_LeituraOnLineNFe;
    procedure Pc_LeituraManualNFe;
    procedure Pc_DefineParcelamentoXML_Nfe;
    procedure Pc_CriaParcelamento;


  end;

var
  Fr_ImportaXMLNFe: TFr_ImportaXMLNFe;

implementation

uses     UN_Principal, env, RN_NotaFiscalEletronica3x, Un_Regra_Negocio, ACBrNFe, Un_DM, UN_Sistema, RN_Empresa, Un_Funcoes, Un_Fc_Sored_Procedures, Un_Pesq_Produto, RN_Produto, UN_MSG, sea_cfop, RN_Pedido, RN_Estoque, RN_NotaFiscal, RN_Lotes, RN_FormaPagto, sea_stocks, RN_PlanoContas, RN_Compras, UN_TabelasEmListas, RN_Estados, ControllerFinanceiro, Un_Fatura_Fin, ControllerEmpresa, ControllerPedido, ControllerProduto, ControllerItensNFL;

{$R *.dfm}


procedure TFr_ImportaXMLNFe.Pc_DefineParcelamentoXML_Nfe;
Var
  LC_I : Integer;
  Lc_Cd_FormaPagto:Integer;
  Lc_VL_Total : Real;
  Lc_Linha : Integer;
Begin
  WITH Fr_Principal.Nfe.NotasFiscais.Items[0].NFe DO
  Begin

    if (Cobr.Dup.Count > 0) or (Cobr.Fat.vLiq > 0) then //or (pag.Count > 0) foi retirado pois a Winkert informou que o Mercadora utiliza esse campo para questões de troca
    Begin
      Chbx_Financeiro.Checked := True;
      Chbx_Financeiro.enabled := False;
      ChBx_FinManual.Checked := False;
      ChBx_FinManual.enabled := False;
      Chbx_CreditoFinanceiro.Checked := False;
      Chbx_CreditoFinanceiro.enabled := False;
    end
    else
    BEgin
      Chbx_Financeiro.Checked := False;
      Chbx_Financeiro.enabled := False;
      ChBx_FinManual.Checked := False;
      ChBx_FinManual.enabled := True;
      Chbx_CreditoFinanceiro.Checked := False;
      Chbx_CreditoFinanceiro.enabled := True;
    End;
  End;
end;

procedure TFr_ImportaXMLNFe.Pc_CriaParcelamento;
Var
  I : Integer;
  Lc_Cd_FormaPagamento : Integer;
  Lc_Soma : Real;
  Lc_VL_Nota : Real;
Begin
  Lc_Cd_FormaPagamento := Fc_PegaFormaPgto('CARTEIRA');
  WITH Fr_Principal.Nfe.NotasFiscais.Items[0].NFe DO
  Begin
    if (Cobr.Dup.Count > 0) then
    Begin
      for I := 0 to (Cobr.Dup.Count - 1) do
      Begin
        with Parcelamento.Registro do
        Begin
          CodigoPedido := It_Cd_Pedido;
          NumeroParcela := I + 1;
          Vencimento := Cobr.Dup.Items[I].dVenc;
          Valor := Cobr.Dup.Items[I].vDup;
          CodigoFormaPagamento := Lc_Cd_FormaPagamento;
        End;
        Parcelamento.salva;
      End;
    End
    else
    Begin
      if (Cobr.Fat.vLiq > 0) then
      Begin
        with Parcelamento.Registro do
        Begin
          CodigoPedido := It_Cd_Pedido;
          NumeroParcela := 1;
          Vencimento := Ide.dEmi;
          Valor := Cobr.Fat.vLiq;
          CodigoFormaPagamento := Lc_Cd_FormaPagamento;
        End;
        Parcelamento.salva;
      End;
    End;
  End;
  Parcelamento.Registro.CodigoPedido := It_Cd_Pedido;
  Parcelamento.getList;
  Lc_Soma := 0;
  for I := 0 to Parcelamento.Lista.count - 1 do
    Lc_Soma := Lc_Soma + Parcelamento.Lista[I].Valor;
  Lc_VL_Nota := Fr_Principal.Nfe.NotasFiscais.Items[0].NFe.Total.ICMSTot.vNF;
  if Lc_Soma <> Lc_VL_Nota then
  Begin
    Parcelamento.Registro.CodigoPedido := It_Cd_Pedido;
    Parcelamento.deletebyPedido;
    with Parcelamento.Registro do
    Begin
      CodigoPedido := It_Cd_Pedido;
      NumeroParcela := I + 1;
      Vencimento := Date;
      Valor := Lc_VL_Nota;
      CodigoFormaPagamento := Lc_Cd_FormaPagamento;
    End;
    Parcelamento.salva;
  End;

end;




procedure TFr_ImportaXMLNFe.Pc_AtivarTabelas;
Begin
  FmListaEventosNfe.Autor := 'Destinatário';
  FmListaEventosNfe.Dblcb_Lista.KeyValue := 210200;
end;




procedure TFr_ImportaXMLNFe.Pc_MontaGradeCFOP;
Begin
  with StrGrd_CFOP do
  Begin
    Cells[1, 0] := 'Cód Nat Orig';
    Cells[2, 0] := 'CFOP Origem';
    Cells[3, 0] := 'Descrição Origem';
    Cells[4, 0] := 'Cód Nat Dest';
    Cells[5, 0] := 'CFOP Destino';
    Cells[6, 0] := 'Descrição Destino';

    ColWidths[0] := 17;
    ColWidths[1] := -1;
    ColWidths[2] := 80;
    ColWidths[3] := 300;
    ColWidths[4] := -1;
    ColWidths[5] := 80;
    ColWidths[6] := 300;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_LimpaGrandeCFOP;
Var
  Lc_I, Lc_J: Integer;
  CanSelect: Boolean;
Begin
  with StrGrd_CFOP do
  Begin
    For Lc_I := 1 to RowCount - 1 do
      For Lc_J := 0 to ColCount - 1 do
        Cells[Lc_J, Lc_I] := '';
    RowCount := 2;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_IniciaVariaveis;
Var
  CanSelect: Boolean;
begin
  // Acerta o campo data
  Pg_Notas.ActivePage := tbs_financeiro;
  // Controladores
  Pg_Notas.ActivePage := tbs_nota;

  SB_Processo.Enabled := It_Processo;
  SB_Confirmar.Enabled := It_Confirma;
end;


function TFr_ImportaXMLNFe.Fc_ValidaManifestacao(): Boolean;
var
  Lc_Chave: String;
  Lc_Uf: String;
Begin
  Result := True;
  Pc_AtivaEstabelecimento;
  Lc_Chave := E_Chave.Text;
  if (Trim(Lc_Chave) = '') then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Campo chave não informado.' + EOLN + 'Verifique antes de continuar.' +
      EOLN, ['OK'], [bEscape], mpAlerta);
    IF E_Chave.CanFocus then
      E_Chave.setFocus;
    Result := False;
    exit;
  end;

  if (Length(Trim(Lc_Chave)) <> 44) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Campo chave não está no padrão de 44 números.' + EOLN +
      'Verifique antes de continuar.' + EOLN, ['OK'], [bEscape], mpAlerta);
    IF E_Chave.CanFocus then
      E_Chave.setFocus;
    Result := False;
    exit;
  end;

  if (Trim(FmListaEventosNfe.Dblcb_Lista.Text) = '') then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Campo tipo de evento não informado.' + EOLN +
      'Verifique antes de continuar.' + EOLN, ['OK'], [bEscape], mpAlerta);
    IF FmListaEventosNfe.Dblcb_Lista.CanFocus then
      FmListaEventosNfe.Dblcb_Lista.setFocus;
    Result := False;
    exit;
  end;
  // Efetua a Consulta da nota antes de continuar
  with fr_principal.Nfe do
  Begin
    WebServices.Consulta.NFeChave := Lc_Chave;
    Lc_Uf := Copy(Lc_Chave, 1, 2);
    Lc_Uf := Fc_BuscaSiglaEstado(StrtoInt(Lc_Uf));
    Configuracoes.WebServices.UF := Lc_Uf;
    Configuracoes.WebServices.Ambiente   := taProducao;
    Configuracoes.WebServices.Visualizar := FAlse;
    WebServices.Consulta.Executar;
    if (WebServices.Consulta.cStat <> 100) then
    Begin
      MemoResp.Lines.Add('Retorno : ' + WebServices.Consulta.XMotivo);
      Result := False;
      exit;
    end;
  end;

end;

function TFr_ImportaXMLNFe.Fc_ManifestacaoDestinatario(Fc_Chave: String;
  Fc_CNPJ: String): Boolean;
Var
  Lc_NumeroLote: Int64;
  Lc_Aux:String;
  Lc_Justificativa: String;
Begin
  Result := True;
  MemoResp.Lines.Add('Iniciando processo de manifestação do destinatário');
  with fr_principal.Nfe do
  Begin
    EventoNFe.Evento.Clear;
    with EventoNFe.Evento.Add do
    begin
      Lc_Aux := FormatDateTime('yymmddhhmmss', NOW);
      Lc_Aux := copy(Lc_Aux,2,10);
      Lc_NumeroLote := StrToInt64(Lc_Aux);
      infEvento.chNFe := Fc_Chave;
      infEvento.cOrgao := 91;
      infEvento.CNPJ := Fc_CNPJ;
      infEvento.dhEvento := NOW; // - StrtoTime('01:00');

      case FmListaEventosNfe.Dblcb_Lista.KeyValue of
        210200: infEvento.tpEvento := teManifDestConfirmacao;
        210210: infEvento.tpEvento := teManifDestCiencia;
        210220: infEvento.tpEvento := teManifDestDesconhecimento;
        210240: infEvento.tpEvento := teManifDestOperNaoRealizada;
      end;
      if (infEvento.tpEvento = teManifDestOperNaoRealizada) then
      Begin
        if not(InputQuery('WebServices Manifestação Destinatário',
          'Justificativa', Lc_Justificativa)) then
        Begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                          'Para este tipo de manifestação a justificativa é obrigatria.' +EOLN +
                          'Verifique antes de continuar.' + EOLN, ['OK'], [bEscape],
                          mpAlerta);
          exit;
        end;
      end;
    end;

    EnviarEvento( Lc_NumeroLote );
    with WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento do
    begin
      {
        128 Lote de Evento Processado
        135 Evento registrado e vinculado a NF-e
        136 Evento registrado, mas não vinculado a NF-e
        137 Nenhum documento localizado para o Destinatário
        138 Documento localizado para o Destinatário
        139 Pedido de Download processado
        140 Download disponibilizado
        573 Duplicidade de evento
      }
      if (cStat = 573) then
      Begin
        Pg_Notas.ActivePage := tbs_processo;
        MemoResp.Lines.Add('Código: ' + IntToStr(cStat));
        MemoResp.Lines.Add('Retorno: ' + XMotivo);
      end
      else
      Begin
        IF (cStat = 128) or (cStat = 135) then
        Begin
          MemoResp.Lines.Add('Gravando o registro do Evento');
          Lc_Justificativa := XMotivo;
          Pc_GravaEvento(0, Lc_NumeroLote, Fc_Chave, FmListaEventosNfe.Dblcb_Lista.KeyValue, NOW,
            '1', '', '', '1', Lc_Justificativa, IntToStr(cStat));
        end
        else
        Begin
          Pg_Notas.ActivePage := tbs_processo;
          MemoResp.Lines.Add('Código: ' + IntToStr(cStat));
          MemoResp.Lines.Add('Retorno: ' + XMotivo);
          Result := False;
        end;
      end;
    end;
  end;

end;

procedure TFr_ImportaXMLNFe.Pc_MostraEmitenteXML_Nfe;
Var
  Lc_Aux: Integer;
  Lc_Aux_Text: String;
  Lc_cd_Endereco: Integer;
begin
  { ========================== E - Identificação do Destinatário da Nota Fiscal eletrônica ========================== }
  // dados da tb_empresa
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    Self.It_cd_Empresa := Fc_BuscaCodigoEmpresa(DM.IBD_Gestao, DM.IB_Transacao,
      Emit.CNPJCPF);
    E_RazaoSocial.Text := UpperCase(UTF8Decode(Emit.xNome));
    IF Length(Emit.CNPJCPF) > 11 then
      E_Cnpj_CPf.Text := fc_MascaraCNPJ(Emit.CNPJCPF)
    else
      E_Cnpj_CPf.Text := fc_MascaraCPF(Emit.CNPJCPF);
    E_Insc_Est.Text := Emit.IE;
    E_Endereco.Text := UpperCase(UTF8Decode(Emit.EnderEmit.xLgr) + ', ' +
      Emit.EnderEmit.nro);
    E_Bairro.Text := UpperCase(UTF8Decode(Emit.EnderEmit.xBairro));
    E_Cep.Text := Fc_MascaraCep(IntToStr(Emit.EnderEmit.CEP));
    E_Cidade.Text := Emit.EnderEmit.xMun;
    E_Estado.Text := Emit.EnderEmit.UF;
    E_Fone.Text := fc_MascaraFone(Emit.EnderEmit.Fone);
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_MostraDadosNotaXML_Nfe;
begin
  // dados da tb_empresa
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    E_Natureza.Text := UTF8Decode(Ide.natOp);
    E_Nr_Nota.Text := StrZero(Ide.nNF, 6, 0);
    E_Vl_Total.Text := FloatToStrF(Total.ICMSTot.vNF, ffFixed, 10, 2);
    E_Dt_Emissao.Text := DateToStr(Ide.dEmi);
    if (Ide.dSaiEnt > 0) then
      E_Dt_Saida.Text := DateToStr(Ide.dSaiEnt)
    else
      E_Dt_Saida.Text := DateToStr(Ide.dEmi);
    // Totais
    E_Bs_Icms.Text := FloatToStrF(Total.ICMSTot.vBC, ffFixed, 10, 2);
    E_Vl_Icms.Text := FloatToStrF(Total.ICMSTot.vICMS, ffFixed, 10, 2);
    E_Bs_Icms_St.Text := FloatToStrF(Total.ICMSTot.vBCST, ffFixed, 10, 2);
    E_Vl_Icms_St.Text := FloatToStrF(Total.ICMSTot.vST, ffFixed, 10, 2);
    E_VL_Produto.Text := FloatToStrF(Total.ICMSTot.vProd, ffFixed, 10, 2);
    E_Vl_frete.Text := FloatToStrF(Total.ICMSTot.vFrete, ffFixed, 10, 2);
    E_Vl_Seguro.Text := FloatToStrF(Total.ICMSTot.vSeg, ffFixed, 10, 2);
    E_Vl_Outras.Text := FloatToStrF(Total.ICMSTot.vOutro, ffFixed, 10, 2);
    E_Vl_IPI.Text := FloatToStrF(Total.ICMSTot.vIPI, ffFixed, 10, 2);
    E_Vl_Desconto.Text := FloatToStrF(Total.ICMSTot.vDesc, ffFixed, 10, 2);
    E_VL_Nota.Text := FloatToStrF(Total.ICMSTot.vNF, ffFixed, 10, 2);
    // Informações de Transportes
    if Transp.Vol.Count > 0 then
    Begin
      with Transp.Vol.Items[0] do
      Begin
        E_Qtde.Text := floatToStr(qVol);
        E_Especie.Text := esp;
        E_MArca.Text := marca;
        E_Numero.Text := nVol;
        E_PesoBruto.Text := FloatToStrF(pesoB, ffFixed, 10, 4);
        E_PesoLiquido.Text := FloatToStrF(pesoL, ffFixed, 10, 4);
      end;
    end;

    E_Obs.Lines.Clear;
    E_Obs.Lines.Text := InfAdic.infCpl;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_MostraItensNotaXML_Nfe;
Var
  Lc_I: Integer;
  Lc_ValidaEANGTIN : TACBrValidador;
  Lc_ValorProdutos : Real;
  Lc_Aux : Real;
Begin
  Try
    Lc_ValidaEANGTIN := TACBrValidador.Create(Self);
    Lc_ValidaEANGTIN.TipoDocto := docGTIN;
    DM.Qr_Estoques.Active := False;
    DM.Qr_Estoques.ParamByName('ETS_CODMHA').AsInteger := Gb_CodMha;
    DM.Qr_Estoques.Active := True;
    DM.Qr_Estoques.First;
    DM.Qr_Estoques.Locate('ETS_CODIGO', Gb_Estoque, []);

    if not cds_itens_nota.Active then cds_itens_nota.CreateDataSet;
    if cds_itens_nota.Active then cds_itens_nota.EmptyDataSet;

    cds_itens_notaqtde.OnChange := nil;
    cds_itens_notavalorUnitario.OnChange := nil;

    WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
    Begin
      Lc_ValorProdutos := 0;
      For Lc_I := 0 to (Det.Count - 1) do
      Begin
        cds_itens_nota.Append;
        cds_itens_notacodigo.AsInteger            := 0;
        cds_itens_notaitem.AsString               := StrZero(Det.Items[Lc_I].Prod.nItem, 3, 0);
        cds_itens_notadescricao.AsString          := Copy(Det.Items[Lc_I].Prod.xProd,1,99);
        cds_itens_notaunidade.AsString            := Det.Items[Lc_I].Prod.uCom;
        cds_itens_notaqtde.AsFloat                := Det.Items[Lc_I].Prod.qCom;
        cds_itens_notavalorUnitario.AsCurrency       := Det.Items[Lc_I].Prod.vUnCom;
        cds_itens_notavalorDesconto.AsCurrency       := Det.Items[Lc_I].Prod.vDesc;
        cds_itens_notavalorTotal.AsCurrency          := Det.Items[Lc_I].Prod.vProd;
        cds_itens_notavalortotalFixo.AsCurrency      := Det.Items[Lc_I].Prod.vProd;

        cds_itens_notaCodigoNota.asString         := Det.Items[Lc_I].Prod.cProd;
        //Valida o Codigo de Barras
        Lc_ValidaEANGTIN.Documento := TRIM(Det.Items[Lc_I].Prod.cEAN);
        if Lc_ValidaEANGTIN.Validar then
          cds_itens_notaBarras.AsString     := Det.Items[Lc_I].Prod.cEAN
        else
          cds_itens_notaBarras.AsString := '';
        //Verifica se o produto já existe no cadastro
        NotaFiscal.pedido.Itens.Produto.getFromXML(IntToStr(Self.It_cd_Empresa),
                                                   cds_itens_notaCodigoNota.asString,
                                                   cds_itens_notaBarras.AsString);
        if NotaFiscal.pedido.Itens.Produto.exist then
        Begin
          cds_itens_notacodigoInterno.AsInteger     := NotaFiscal.pedido.Itens.Produto.Registro.Codigo;
          cds_itens_notacodigoFabrica.AsString      := NotaFiscal.pedido.Itens.Produto.Registro.CodigoFabrica;
          cds_itens_notadescricaoInterna.AsString   := NotaFiscal.pedido.Itens.Produto.Registro.Descricao;
        End
        else
        Begin
          cds_itens_notacodigoInterno.AsInteger     := 0;
          cds_itens_notacodigoFabrica.AsString      := '';
          cds_itens_notadescricaoInterna.AsString   := '';
        End;

        cds_itens_notacodigoEstoque.AsInteger     := DM.Qr_Estoques.FieldByName('ETS_CODIGO').AsInteger;
        cds_itens_notadescricaoEstoque.AsString  := DM.Qr_Estoques.FieldByName('ETS_DESCRICAO').AsString;
        cds_itens_notancmNota.AsString            := Det.Items[Lc_I].Prod.NCM;
        cds_itens_notaorigemNota.AsString         := OrigToStr(Det.Items[Lc_I].Imposto.ICMS.orig);
        if (CSTICMSToStr(Det.Items[Lc_I].Imposto.ICMS.CST) = '10') or
          (CSTICMSToStr(Det.Items[Lc_I].Imposto.ICMS.CST) = '60') or
          (CSTICMSToStr(Det.Items[Lc_I].Imposto.ICMS.CST) = '201') or
          (CSTICMSToStr(Det.Items[Lc_I].Imposto.ICMS.CST) = '202') or
          (CSTICMSToStr(Det.Items[Lc_I].Imposto.ICMS.CST) = '500') then
          cds_itens_notastNota.AsString := 'S'
        else
          cds_itens_notastNota.AsString := 'N';
        cds_itens_notaduplicate.AsString := 'N';
        cds_itens_notafrete.AsCurrency := Det.Items[Lc_I].Prod.vFrete;
        cds_itens_notaoutras.AsFloat := Det.Items[Lc_I].Prod.vOutro;
        cds_itens_notaseguro.AsFloat := Det.Items[Lc_I].Prod.vSeg;
        cds_itens_nota.post;
        Lc_Aux := (cds_itens_nota.FieldByName('valorUnitario').AsCurrency * cds_itens_nota.FieldByName('qtde').AsFloat );
        Lc_Aux := RoundTo( Lc_Aux, -2);
        Lc_Aux := Lc_Aux - cds_itens_nota.FieldByName('valorDesconto').AsCurrency;
        Lc_ValorProdutos :=  Lc_ValorProdutos +  Lc_Aux ;
        //Lc_ValorProdutos :=  Lc_ValorProdutos + cds_itens_nota.FieldByName('valortotal').AsFloat ; cuidado ao usar este pois daré problema no desconto
      end;
    end;
  Finally
    Lc_ValorProdutos :=  RoundTo( Lc_ValorProdutos, -2);
    Lb_Total_Itens_Nota.Caption := FloatToStrF( Lc_ValorProdutos, ffFixed, 10, 2);
    Lb_Total_Itens_Calculado.Caption := FloatToStrF( Lc_ValorProdutos, ffFixed, 10, 2);

    FreeAndNil(Lc_ValidaEANGTIN);
    cds_itens_notaqtde.OnChange := ChangeSubTotalByQtde;
    cds_itens_notavalorUnitario.OnChange := ChangeSubTotalbyValor;
  End;
end;


procedure TFr_ImportaXMLNFe.Pc_MostraItensNotaXML_Nfe_Novo;
Var
  Lc_I: Integer;
  Lc_ValidaEANGTIN : TACBrValidador;
Begin
  Try
    Lc_ValidaEANGTIN := TACBrValidador.Create(nil);
    Lc_ValidaEANGTIN.TipoDocto := docGTIN;
    DM.Qr_Estoques.Active := False;
    DM.Qr_Estoques.ParamByName('ETS_CODMHA').AsInteger := Gb_CodMha;
    DM.Qr_Estoques.Active := True;
    DM.Qr_Estoques.First;
    DM.Qr_Estoques.Locate('ETS_CODIGO', Gb_Estoque, []);
    WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
    Begin
      For Lc_I := 0 to (Det.Count - 1) do
      Begin
        //Pc_CriarFrame(Lc_I);
      end;
    end;
  Finally
    FreeAndNil(Lc_ValidaEANGTIN);
  End;

end;

procedure TFr_ImportaXMLNFe.Pc_MostraDadosCFOP_Nfe;
Var
  Lc_I: Integer;
  Lc_ListarResult: TStringList;
  Lc_ListarCFOP: TStringList;
  Lc_Cfop: String;
  Lc_Linha: Integer;
Begin
  Try
    Lc_ListarResult := TStringList.Create;
    Lc_ListarCFOP := TStringList.Create;
    // Pega todos os CFOPs da Nota
    WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
    Begin
      For Lc_I := 0 to (Det.Count - 1) do
        Lc_ListarCFOP.Add(Det.Items[Lc_I].Prod.CFOP)
    end;
    // Preenche a Grade de CFOP sem as duplicidades
    Lc_ListarCFOP.Sorted := True;
    Lc_Cfop := '';
    Lc_Linha := 0;
    For Lc_I := 0 to (Lc_ListarCFOP.Count - 1) do
    BEgin
      if (Lc_Cfop <> Lc_ListarCFOP.Strings[Lc_I]) then
      Begin
        with StrGrd_CFOP do
        Begin
          inc(Lc_Linha);
          RowCount := Lc_Linha + 1;
          Lc_ListarResult := Fc_BuscaCodigoDescricaoCFOP(Lc_ListarCFOP.Strings[Lc_I]);
          Cells[1, Lc_Linha] := Lc_ListarResult.Strings[0];
          Cells[2, Lc_Linha] := Lc_ListarResult.Strings[1];
          Cells[3, Lc_Linha] := Lc_ListarResult.Strings[2];
          Lc_ListarResult := Fc_BuscaCodigoReferenciaCFOP( Lc_ListarResult.Strings[0]);
          Cells[4, Lc_Linha] := Lc_ListarResult.Strings[0];
          Cells[5, Lc_Linha] := Lc_ListarResult.Strings[1];
          Cells[6, Lc_Linha] := Lc_ListarResult.Strings[2];
        end;
      end;
      Lc_Cfop := Lc_ListarCFOP.Strings[Lc_I];
    end;
  Finally
    FreeAndNil(Lc_ListarResult);
    FreeAndNil(Lc_ListarCFOP);
  End;
end;

procedure TFr_ImportaXMLNFe.FormShow(Sender: TObject);
begin
  pfMenu := 'Importar XML da NF-e';
  inherited;
end;

procedure TFr_ImportaXMLNFe.ImagemBotao;
begin
  CarregaImagemBotao(SB_Processo,'PROCESSO');
  CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
end;

procedure TFr_ImportaXMLNFe.IniciaVariaveis;
begin
  inherited;
  Pc_LimpaGrandeCFOP;
  Pc_MontaGradeCFOP;
  Pc_AtivarTabelas;
end;

procedure TFr_ImportaXMLNFe.Sb_ProdutoClick(Sender: TObject);
Var
  Lc_Form: TFr_Pesq_Produto;
  Lc_cd_Fornece : String;
begin
  try
    Lc_Form := TFr_Pesq_Produto.Create(nil);
    with Lc_Form do
    Begin
      Pc_Tabelas_Disponiveis;
      it_Modalidade_preco := 'A';
      ShowModal;
      // Depois que Fecha o Relatorio
      if lc_Form.It_Visualizar then
      Begin
        IF (Qr_Pesquisa.FieldByName('PRO_CODIGO').AsInteger > 0) then
        Begin
          Lc_cd_Fornece := IntToStr(Self.It_cd_Empresa);

          Pc_VincularCodigoProdutoFornecedor(Qr_Pesquisa.FieldByName('PRO_CODIGO').AsString,
                                             Lc_cd_Fornece,
                                             cds_itens_notaCodigoNota.AsString);
          cds_itens_nota.Edit;
          cds_itens_notacodigoInterno.asinteger   := Qr_Pesquisa.FieldByName('PRO_CODIGO').Asinteger;
          cds_itens_notacodigoFabrica.AsString    := Qr_Pesquisa.FieldByName('PRO_CODIGOFAB').AsString;
          cds_itens_notadescricaoInterna.AsString := Qr_Pesquisa.FieldByName('PRO_DESCRICAO').AsString;
          cds_itens_nota.post;
        end;
      end;
    End;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_ImportaXMLNFe.sb_RecarregaListaClick(Sender: TObject);
begin
  //Verifica se deseja abir a tela de nota fiscal
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja realmente recarregar os dados?' + EOLN +
                     'Dados atuais seráo descartados'+EOLN +
                     'Confirmar a operação ?',
                      [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBlue) = mrBotao1) then
  Begin
    Pc_MostraItensNotaXML_Nfe;
  End;
end;

procedure TFr_ImportaXMLNFe.Sb_CFOPClick(Sender: TObject);
Var
  Lc_Form: TSeaCFOp;
begin
  Lc_Form := TSeaCFOp.Create(Self);
  try
    Lc_Form.ShowModal;
    if (Lc_Form.cds_searchcodigo.AsInteger > 0) then
    Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO, 'Relacionar o CFOP ' +
        Lc_Form.cds_searchCfop.AsString + ' ao CFOP ' + StrGrd_CFOP.Cells[2,
        StrGrd_CFOP.Row] + '.' + EOLN + EOLN + 'Confirmar a operação ?',
        [SIM, NAO], [bNormal, bEscape], mpConfirmacao, clBtnFace) = mrBotao1)
      then
      Begin
        Pc_VincularCodigosCFOP(StrGrd_CFOP.Cells[1, StrGrd_CFOP.Row],
                               IntToStr(Lc_Form.cds_searchcodigo.AsInteger ));
        StrGrd_CFOP.Cells[4, StrGrd_CFOP.Row] := IntToStr(Lc_Form.cds_searchcodigo.AsInteger);
        StrGrd_CFOP.Cells[5, StrGrd_CFOP.Row] := Lc_Form.cds_searchCfop.AsString;
        StrGrd_CFOP.Cells[6, StrGrd_CFOP.Row] := Lc_Form.cds_searchdescricao.AsString
      end;
    end;
  finally
    FreeAndNil(Lc_Form);
    StrGrd_CFOP.Repaint;
  end;
end;

procedure TFr_ImportaXMLNFe.StrGrd_CFOPDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: Integer;
  Texto: string;
begin
  If (ARow > 0) and (ACol > 0) then // testa se não é a primeira linha (fixa)
  begin // verifica se a linha impar
    with StrGrd_CFOP do
    Begin
      if Trim(Cells[4, ARow]) = '' then
      begin
        Canvas.Font.Color := clRed;
        Canvas.Brush.Color := clMoneyGreen;
      end
      else
      begin
        Canvas.Font.Color := clBlack;
        Canvas.Brush.Color := clMoneyGreen;
      end;
      Canvas.FillRect(Rect); // redesenha a celula
      Canvas.TextOut(Rect.Left + 2, Rect.Top, Cells[ACol, ARow]);
      // reimprime o texto.
      { Pega o texto da célula }
      Texto := Cells[ACol, ARow];
      { Calcura largura e altura (em pontos) do texto }
      LarguraTexto := Canvas.TextWidth(Texto);
      AlturaTexto := Canvas.TextHeight(Texto);
      { Calcula a posição horizontal do início do texto }
      if (ACol = 3) or (ACol = 6) then { esquerda }
        X := Rect.Left + 2
      else if (ACol = 2) OR (ACol = 5) then { Centro }
        X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
      else { Direita }
        X := Rect.Right - LarguraTexto - 2;
      { Calcula a posição vertical do início do texto para
        que seja impresso no centro (verticalmente) da célula }
      Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;

      { Pinta o texto }
      Canvas.TextRect(Rect, X, Y, Texto);
    end;
  end;
end;

function TFr_ImportaXMLNFe.validaDuplicaitem: Boolean;
begin
  REsult := True;
  if (not cds_itens_nota.Active ) then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Não foi possivel abrir a lista de Items.'+EOLN+
                   'Recarregue a nota.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Result:=false;
    Exit;
  End;

  if (cds_itens_nota.RecordCount = 0 ) then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Nenhum item enontrado.'+EOLN+
                   'Recarregue a nota.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Result:=false;
    Exit;
  End;
end;

procedure TFr_ImportaXMLNFe.Pc_LeituraOnLineNFe;
var
  Lc_Chave: String;
  Lc_Cnpj: String;
  Lc_Path: String;

  Lc_Nome: String;
  Lc_Lote: Integer;
  Lc_Msg: string;
  Lc_Justificativa: String;
begin
  if Fc_ValidaManifestacao then
  Begin
    try
      Pc_ProcesoAguarde(Self, 'I');
      Self.Enabled := False;
      MemoResp.Lines.Clear;
      Lc_Chave := E_Chave.Text;
      Lc_Cnpj := DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;
      // Define o caminho e o arquivo da Nota Fiscal
      It_FileXML := Lc_Chave + '-nfe.xml';
      Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
      // Faz a manifestação
      Self.Update;
      if not Fc_BuscaEventoManifestacao(E_Chave.Text) then
      Begin
        if not Fc_ManifestacaoDestinatario(Lc_Chave, Lc_Cnpj) then
          exit;
      end;
      if not FilesExists(Lc_Path + '\' + It_FileXML) then
      Begin
        // Efetuar o Download
        MemoResp.Lines.Add('O sistema vai iniciar o processo de download...');
        if Fc_DownloadNFeXML(Lc_Path, Lc_Chave, Lc_Cnpj,MemoResp) then
          MemoResp.Lines.Add('Download Finalizado.')
        else
          MemoResp.Lines.Add('Arquivo para donwload não encontrado.');
        MemoResp.Lines.Add('Retorno da Consulta WebService');
        MemoResp.Lines.Add(fr_principal.Nfe.WebServices.Retorno.XMotivo);
        MM_REceita.Lines.Clear;
        MM_REceita.Lines.Text := fr_principal.NFe.WebServices.DistribuicaoDFe.RetornoWS;
      end;

      // Verifica se o XMl está no Diretorio
      if (FilesExists(Lc_Path + '\' + It_FileXML)) then
      Begin
        MemoResp.Lines.Add('Iniciando a Leitura do Arquivo para a importação.');
        // Carrega o componente
        MemoResp.Update;
        Pc_CarregaComponenteNFE(Lc_Path, It_FileXML);
        MemoResp.Update;
        Pc_MostraEmitenteXML_Nfe;
        MemoResp.Update;
        Pc_MostraDadosNotaXML_Nfe;
        MemoResp.Update;
        if cds_itens_nota.Active then cds_itens_nota.EmptyDataSet;

        MemoResp.Update;
        Pc_MostraItensNotaXML_Nfe;
        calculatotalItens;

        Pc_MostraItensNotaXML_Nfe_Novo;

        MemoResp.Update;
        Pc_DefineParcelamentoXML_Nfe;
        MemoResp.Update;
        Pc_LimpaGrandeCFOP;
        MemoResp.Update;
        Pc_MostraDadosCFOP_Nfe;
        MemoResp.Update;
        //grava os dados para garantir o vinculo dos produtos
        Pc_GravaEmitente;
        MemoResp.Update;
        Pc_GravaTransportadora;
        MemoResp.Update;
      end;
    finally
      Pg_Notas.ActivePage := tbs_processo;
      Pc_ProcesoAguarde(Self, 'F');
      Self.Enabled := True;
    end;
  end;

end;

procedure TFr_ImportaXMLNFe.SB_ConfirmarClick(Sender: TObject);
begin
  if ChBx_Cad_Produto_Auto.Checked then
  Begin
    Pc_CadastrarProdutosAuto;
    Self.Update;
  end;

  if Fc_ValidaFaturamento then
  Begin
    try
      Pc_ProcesoAguarde(Self, 'I');
      Self.Enabled := False;

      Self.Update;
      Pc_GravaPedido;
      Self.Update;
      Pc_GravaNotaFiscal;
      Self.Update;
      CalculoCustoExtrasDataset;
      Self.Update;
      Pc_GravaItensNota;
      Self.Update;

      Pc_GravaLote;
      Self.Update;


      NotaFiscal.Pedido.Registro.Codigo := It_Cd_Pedido;
      NotaFiscal.Pedido.Registro.Faturado := 'S';
      NotaFiscal.Pedido.alteraStatus;

      Self.Update;
      Pc_CriaParcelamento;
      Self.Update;
      Pc_Gera_Financeiro;
      Self.Update;

      Pc_AtualizaCusto;
      Self.Update;
      Pc_Atualiza_Preco_Venda;
      Self.Update;
      // Ativa produtos caso estejam inativos
      Pc_Ativa_Produtos_Saldo(It_Cd_Pedido);
      Self.Update;
      if Trim(E_DocVinculado.Text) <> '' then
      BEgin
        NotaFiscal.registro.NotaVinculada := E_DocVinculado.Text;
        NotaFiscal.BaixaRetorno;
        MensagemPadrao('Mensagem ','S U C E S S O!.'+EOLN+EOLN+
                       'A atualização de Retorno foi executada com sucesso.'+EOLN+
                       'O Documento '+ E_DocVinculado.Text + ' está baixado.'+EOLN,
                      ['OK'],[bEscape],mpInformacao);
      End;
      Self.Update;
      Pc_FormataModeloNFE;
      Pc_GravaArquivoXML;
      Self.Update;
      MensagemPadrao('Mensagem ', 'S U C E S S O!.' + EOLN + EOLN +
                     'A importação do XML da Nota Nº ' + E_Nr_Nota.Text +
                     ' foi executada com sucesso.' + EOLN, ['OK'], [bEscape], mpInformacao);
      //Verifica se deseja abir a tela de nota fiscal
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Deseja abrir a tela de Nota Fiscal' + EOLN +
                         'Caso tenha informações complementares'+EOLN +
                         'Confirmar a operação ?',
                          [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clBlue) = mrBotao1) then
      Begin
      if dm.IBT_Consulta.InTransaction then
        dm.IBT_Consulta.Commit;
        Pc_AbreTelaNotaFiscal( NotaFiscal.Registro.Codigo ,Self);
      End;
    finally
      Pc_ProcesoAguarde(Self, 'F');
      Self.Enabled := True;
      FinalizaProcesso;
      Pc_AtivarTabelas;
    end;
  end;
end;

// Gerar a Gravação dos dados no Sistema
Function TFr_ImportaXMLNFe.Fc_ValidaFaturamento(): Boolean;
Begin
  Result := True;
  if Fc_VerificaNumeroNota('T', Self.It_cd_Empresa, E_Nr_Nota.Text) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN + 'A nota ' +
      E_Nr_Nota.Text + ' já está registrada no sistema.' + EOLN +
      'Verifique antes de continuar.' + EOLN, ['OK'], [bEscape], mpAlerta);
    Result := False;
    exit;
  end;

  if not Fc_ValidaValoresProdutos() then
  Begin
    Result := False;
    exit;
  end;

  if not Fc_ValidaReferenciaItens() then
  Begin
    Result := False;
    exit;
  end;

  if not Fc_ValidaReferenciaCFOP() then
  Begin
    Result := False;
    exit;
  end;

  if not Fc_ValidaValoresFinanceiros() then
  Begin
    Result := False;
    exit;
  end;

end;

Function TFr_ImportaXMLNFe.Fc_ValidaValoresProdutos(): Boolean;
Var
  Lc_I: Integer;
  Lc_Str_Vl_Produto, Lc_Str_Vl_Soma: String;
  Lc_Vl_Soma: Real;
Begin
  Result := True;
  {
  Lc_Vl_Soma := 0;
  cds_itens_nota.First;
  while not cds_itens_nota.Eof do
  Begin
    Lc_Vl_Soma := Lc_Vl_Soma + cds_itens_notavalorTotal.AsCurrency;
    cds_itens_nota.Next;
  End;

  Lc_Str_Vl_Produto := E_VL_Produto.Text;
  Lc_Str_Vl_Soma := FloatToStrF(Lc_Vl_Soma, ffFixed, 10, 2);
  if (Lc_Str_Vl_Produto <> Lc_Str_Vl_Soma) then
  }
  if (Lb_Total_Itens_Nota.Caption <> Lb_Total_Itens_Calculado.Caption) then

  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
      'Os valores dos itens não confere com o valor total' + EOLN +
      'dos produtos da Nota Fiscal. Verifique' + EOLN, ['OK'], [bEscape],
      mpAlerta);
    Result := False;
  end;

end;

procedure TFr_ImportaXMLNFe.FinalizaProcesso;
begin
  if cds_itens_nota.Active then cds_itens_nota.EmptyDataSet;
  Pc_LimpaGrandeCFOP;
  Chbx_Financeiro.Checked := False;
  Chbx_Financeiro.enabled := False;
  ChBx_FinManual.Checked := False;
  ChBx_FinManual.enabled := True;
  Chbx_CreditoFinanceiro.Checked := False;
  Chbx_CreditoFinanceiro.enabled := True;
  ClearFields(Self);
end;

procedure TFr_ImportaXMLNFe.FinalizaVariaveis;
begin
  FreeAndNil(It_CodigoFPagto);
  FreeAndNil(CtrlcmsST);
  FreeAndNil(NotaFiscal);
  FreeAndNil(CtrlLote);
  FreeAndNil(Parcelamento);
end;

Function TFr_ImportaXMLNFe.Fc_ValidaReferenciaItens(): Boolean;
Var
  Lc_I: Integer;
Begin
  Result := True;
  cds_itens_nota.First;
  while not cds_itens_nota.Eof do
  Begin
    if not ( cds_itens_notacodigoInterno.AsInteger > 0 ) then
    Begin
      Result := False;
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Revise a lista de itens da nota.' + EOLN +
                     'Existe item não vinculado ao cadastro do produto.' + EOLN, ['OK'],
                     [bEscape], mpAlerta);
      break;
    End;
    cds_itens_nota.Next;
  End;
end;

Function TFr_ImportaXMLNFe.Fc_ValidaReferenciaCFOP(): Boolean;
Var
  Lc_I: Integer;
Begin
  Result := True;
  For Lc_I := 1 to (StrGrd_CFOP.RowCount - 1) do
  Begin
    if Trim(StrGrd_CFOP.Cells[4, Lc_I]) = '' then
    Begin
      Result := False;
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
        'Revise a lista de CFOP da nota.' + EOLN +
        'Existe CFOP sem referência vinculada ao sistema.' + EOLN, ['OK'],
        [bEscape], mpAlerta);
      break;
    end;
  end;

end;

Function TFr_ImportaXMLNFe.Fc_ValidaValoresFinanceiros(): Boolean;
Var
  Lc_I: Integer;
  Lc_VL_Parcelas: Real;
  Lc_VL_Nota: Real;
Begin
   Result := True;
   EXIT;
  if (fr_principal.Nfe.NotasFiscais.Items[0].Nfe.Cobr.Dup.Count > 0) then
  Begin
    Lc_VL_Nota := StrToFloatDef(E_VL_Nota.Text, 0);
    Lc_VL_Parcelas := 0;

    if not(floatToStr(Lc_VL_Nota) = floatToStr(Lc_VL_Parcelas)) then
    Begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
        'O valor da nota e do parcelamento não conferem.' + EOLN +
        'Revise o parcelamento na aba financeiro.' + EOLN, ['OK'], [bEscape],
        mpAlerta);
      Result := False;
    end;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaEmitente;
Var
  Lc_Aux: Integer;
  Lc_Aux_Text: String;
  Lc_Pessoa: String;
  Fornecedor : TControllerFornecedor;
begin
  { ========================== E - Identificação do Destinatário da Nota Fiscal eletrônica ========================== }
  try
    Fornecedor :=  TControllerFornecedor.Create(Self);
    WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe,Fornecedor DO
    Begin
      //Busca a empresa por CNPJ
      Empresa.Registro.CpfCNPJ := Emit.CNPJCPF;
      Empresa.getByDocumento;
      if ( (Empresa.Registro.Tipo <> 0) and Empresa.exist ) OR (NOT Empresa.exist) then
      Begin
        with Empresa.Registro do
        Begin
          //GRava a empresa
          if Length(Emit.CNPJCPF) = 11 then
            TipoPessoa := 'F'
          else
            TipoPessoa := 'J';
          Tipo:= 2;
          NomeRazaoSocial := UpperCase(UTF8Decode(Emit.xNome));
          if Length(Trim(ApelidoFantasia)) = 0  then
            if Length(Trim(Emit.xFant)) > 0  then
              ApelidoFantasia := UpperCase(UTF8Decode(Emit.xFant))
            else
              ApelidoFantasia := UpperCase(UTF8Decode(Emit.xNome));
          CpfCNPJ := Emit.CNPJCPF;
          InscricaoEstadual := Emit.IE;
          UtilizarMalaDireta := SIM;
          ConsumidorFinal := 'N';
          OptantePeloSimples := 'N';
          Multiplicador := 1;
          Ativa := 'S';
          Lojista := 'N';
          IgnorarCalculoST := 'N';
        End;
        Empresa.salva;
        Self.It_cd_Empresa := Empresa.Registro.Codigo;
        //Atualização do Fornecedor
        Registro.Codigo := Empresa.Registro.Codigo;
        Registro.Ativo := 'S';
        Fornecedor.salva;

        //Atualização do Endereco
        with Endereco.Registro do
        Begin
          //Procura endereço
          CodigoEmpresa := Self.It_cd_Empresa;
          Endereco.getByEmpresa;

          //Salva Endereco exisindo ou não
          Cnpj := Emit.CNPJCPF;
          Tipo := 'COMERCIAL';
          Logradouro := Emit.EnderEmit.xLgr;
          NumeroPredial := Emit.EnderEmit.nro;
          Complemento := Emit.EnderEmit.xCpl;
          EnderecoPrincipal := 'S';
          cep := IntToStr(Emit.EnderEmit.CEP);
          Bairro := Emit.EnderEmit.xBairro;
          Fone := Emit.EnderEmit.Fone;
          CodigoPais := Emit.EnderEmit.cPais;
          CodigoCidade := Fc_BuscaCodigoCidade(Emit.EnderEmit.cMun, '', '');
          CodigoEstado := Fc_BuscaCodigoEstado(Emit.EnderEmit.UF);
        End;
        Endereco.salva;
        Self.It_cd_Endereco := Endereco.Registro.Codigo;
      End
      Else
      Begin
        if Empresa.exist then
        Begin
          try
            Self.It_cd_Empresa := Empresa.Registro.Codigo;
            Endereco := TControllerEndereco.create(Self);
            with Endereco.Registro do
            Begin
              //Procura endereço
              CodigoEmpresa := Self.It_cd_Empresa;
              Endereco.getByEmpresa;
              Self.It_cd_Endereco := Endereco.Registro.Codigo;
            End;
          finally
            FreeAndNil(Endereco);
          end;
        End;
      End;
    end;
  finally
    FreeAndNil(Fornecedor);
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaTransportadora;
Var
  Lc_Aux: Integer;
  Lc_Aux_Text: String;
  Lc_Pessoa: String;
  Lc_cd_Endereco: Integer;
  Transportadora  : TControllerTransportadora;
begin
  Try
    Transportadora  := TControllerTransportadora.create(Self);
    WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe,Transportadora DO
    Begin
      if ( Transp.Transporta.CNPJCPF <> '' ) then
      Begin
        if ( Emit.CNPJCPF <> Transp.Transporta.CNPJCPF ) then
        Begin
          WITH Transp.Transporta, Fornecedor DO
          Begin
            //Busca a empresa por CNPJ
            Empresa.Registro.CpfCNPJ := CNPJCPF;
            Empresa.getByDocumento;
            if ( (Empresa.Registro.Tipo <> 0) and Empresa.exist ) OR (NOT Empresa.exist) then
            Begin
              It_Cd_Transporte := Empresa.Registro.Codigo;
              with Empresa.Registro do
              Begin
                //GRava a empresa
                if Length(CNPJCPF) = 11 then
                  TipoPessoa := 'F'
                else
                  TipoPessoa := 'J';
                Tipo := 3;
                NomeRazaoSocial := UpperCase(UTF8Decode(xNome));
                ApelidoFantasia := UpperCase(UTF8Decode(xNome));
                CpfCNPJ := CNPJCPF;
                InscricaoEstadual := IE;
                UtilizarMalaDireta := SIM;
                ConsumidorFinal := 'N';
                OptantePeloSimples := 'N';
                Multiplicador := 1;
                Ativa := 'S';
                Lojista := 'N';
                IgnorarCalculoST := 'N';
              End;
              Empresa.salva;
              It_Cd_Transporte := Empresa.Registro.Codigo;
              //Atualização Transportradora
              Transportadora.Registro.Codigo := Empresa.Registro.Codigo;
              Transportadora.Registro.Ativo := 'S';
              Transportadora.salva;
              //Atualiza Endereco

              with Endereco.Registro do
              Begin
                //Procura endereço
                CodigoEmpresa := It_Cd_Transporte;
                Endereco.getByEmpresa;
                //Salva Endereco exisindo ou não
                Cnpj := CNPJCPF;
                Tipo := 'COMERCIAL';
                Logradouro := xEnder;
                EnderecoPrincipal := 'S';
                CodigoPais   := DM.Qr_Estabelecimento.FieldByName('PAI_CODBACEN').AsInteger;
                CodigoCidade := DM.Qr_Estabelecimento.FieldByName('END_CODCDD').AsInteger;
                CodigoEstado := DM.Qr_Estabelecimento.FieldByName('END_CODUFE').AsInteger;
                Endereco.salva;
              End;
            End
            else
            Begin
            if Empresa.exist then
            Begin
              Self.It_Cd_Transporte := Empresa.Registro.Codigo;
            End;
            End;
          End;
        end
        else
        BEgin
          self.It_Cd_Transporte := self.It_cd_Empresa;
        End;
      End;
    end;
  Finally
    FreeAndNil(Transportadora);
  End;
end;

procedure TFr_ImportaXMLNFe.Pc_CadastrarProdutosAuto;
Var
  Lc_I: Integer;
  //Lc_Cd_Produto,
  Lc_Cd_Grupo, Lc_Cd_SubGrupo, Lc_cd_Medida, Lc_Cd_Embalagem,
    Lc_Cd_Marca: Integer;
  Lc_VL_Custo: Real;
  Lc_Produto : TControllerProduto;

Begin
  Try
    Lc_Produto := TControllerProduto.Create(self);
    Lc_Cd_Grupo := Lc_Produto.grupo.autocreate('IMPORTACAO XML');
    Self.Update;
    Lc_Cd_SubGrupo := Lc_Produto.grupo.SubGRupo.autocreate(Lc_Cd_Grupo,'GERAL');
    Self.Update;
    Lc_cd_Medida := Lc_Produto.Medida.autocreate('UNIDADE', 'UND');
    Self.Update;
    Lc_Produto.Embalagem.Registro.Descricao := 'NORMAL';
    Lc_Produto.Embalagem.Registro.Abreviatura := 'NRL';
    Lc_Produto.Embalagem.getIdAutoByDesc;
    Lc_Cd_Embalagem := Lc_Produto.Embalagem.Registro.Codigo;
    Self.Update;
    Lc_Produto.Marca.Registro.Descricao :='NÃO INFORMADA';
    Lc_Produto.Marca.getIdAutoByDesc;
    Lc_Cd_Marca := Lc_Produto.Marca.Registro.Codigo;
    Self.Update;

    cds_itens_nota.First;
    while not cds_itens_nota.Eof do
    Begin
      if not ( cds_itens_notacodigoInterno.AsInteger > 0 ) then
      Begin
        Lc_Produto.Clear;
        with Lc_Produto.Registro do
        Begin
          Codigo                := 0;
          CodigoEstabelecimento := Gb_CodMha;
          CodigoFabrica         := '';
          CodigoBarras          := cds_itens_notaBarras.AsString;
          CodigoNCM             := cds_itens_notancmNota.AsString;
          Descricao             := cds_itens_notadescricao.AsString;
          MedidaComercial       := Lc_cd_Medida;
          CodigoEmbalagem       := Lc_Cd_Embalagem;
          CodigoGrupo           := Lc_Cd_Grupo;
          CodigoSubgrupo        := Lc_Cd_SubGrupo;
          Divisor               := 1;
          Origem                := cds_itens_notaorigemNota.AsString;
          Tipo                  := 'P';
          ValorFabrica          :=  cds_itens_notavalorUnitario.AsCurrency;
          ValorCustoMedio       :=  cds_itens_notavalorUnitario.AsCurrency;
          ValorCustoMedioAnt    :=  cds_itens_notavalorUnitario.AsCurrency;
          ValorCusto            :=  cds_itens_notavalorUnitario.AsCurrency;
          ValorCustoAnt         :=  cds_itens_notavalorUnitario.AsCurrency;
          SubsTrib              := cds_itens_notastNota.AsString;
          Campanha              := 'N';
          Destaque              := 'N';
          Ativo                 := 'S';
          Imprime               := 'S';
          EstoqueNegativo       := 'S';
          Exclusivo             := 'N';
          Internet              := 'N';
          MaisVendido           := 'N';
          Composicao            := '1';
          CodigoMarca           := Lc_Cd_Marca;
          FinalidadeTributacao  := '1';
          UtilizaSerie          := 'N';
          Venda                 := 'S';
          ForaLinha             := 'N';
          CEST                  := '';
          IndicacaoEscala       := 'S';
        End;
        Lc_Produto.save;

        Pc_CriaRegistroTabelas(Lc_Produto.Registro.Codigo,
                               cds_itens_notavalorUnitario.AsCurrency,
                               0);

        Lc_Produto.Estoque.SaldoEstoque.CriaRegistroAutomatico(Lc_Produto.Registro.Codigo);



        // Preenche a Grade mostrando que o vinculo foi feito
        Pc_VincularCodigoProdutoFornecedor(IntToStr(Lc_Produto.Registro.Codigo),
                                           IntToStr(Self.It_cd_Empresa),
                                           Lc_Produto.Registro.Codigo.ToString());
        cds_itens_nota.edit;
        cds_itens_notacodigoInterno.AsInteger := Lc_Produto.Registro.Codigo;
        cds_itens_notacodigoFabrica.AsString :=  Lc_Produto.Registro.codigo.ToString();
        cds_itens_notadescricaoInterna.AsString :=  cds_itens_notadescricao.AsString;
        cds_itens_nota.post;
      end;
      cds_itens_nota.Next;
    end;
  Finally
    FreeAndNil(Lc_Produto);
  End;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaPedido;
Var
  Lc_Tp_Pedido: String;
  Lc_Qr_Vol: String;
  Pedido : TControllerPedido;
Begin
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    Try
      Pedido := TControllerPedido.create(nil);
      with Pedido.Registro do
      Begin
        Codigo := 0;
        if (Chbx_Financeiro.Checked) OR (ChBx_FinManual.Checked) then
         Tipo := 2
       else
          Tipo := 3;
        FormaPagto := Fc_PegaFormaPgto('CARTEIRA');
        Usuario := GB_Cd_Usuario;
        Data := Ide.dEmi;
        Empresa := Self.It_cd_Empresa;
        Prazo := '000 - A VISTA';
        Endereco := Self.It_cd_Endereco;
        if (Transp.Vol.Count > 0) then
          QtdeProdutos := Transp.Vol.Items[0].qVol;
        ValorProdutos := Total.ICMSTot.vProd;
        ValorIPI := Total.ICMSTot.vIPI;
        ValorFrete := Total.ICMSTot.vFrete;
        ValorPedido := Total.ICMSTot.vNF;
        Faturado := 'N';
        CodigoEstabelecimento := Gb_Codmha;
        Aprovado := 'S';
        ValorOutrasDEspesas := Total.ICMSTot.vOutro;
      End;
      Pedido.salva;
      Pedido.nextNumber('T');
      It_Cd_Pedido := Pedido.Registro.Codigo;
    Finally
      FreeAndNil(Pedido);
    End;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaNotaFiscal;
Var
  Lc_Qr_volume: Integer;
  Lc_Especie: String;
  Lc_Marca: String;
  Lc_PesoBruto: String;
  Lc_PesoLiquido: String;
  Lc_Nr_Volume: String;
  Lc_Veic_Placa: String;
  Lc_Veic_Uf: String;
  Lc_Veic_RNTC: String;
Begin
  // dados da tb_empresa
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    // Foi criado o SE para o caso em que o fornecedor fez a nota de devolução para ele mesmo, neste caso o produto deve sair do estoque do cliente, por isso fiz Saida Externa
    // Dados dos volumes
    Lc_Qr_volume := 0;
    Lc_Especie := '';
    Lc_Marca := '';
    Lc_PesoBruto := '';
    Lc_PesoLiquido := '';
    if (Transp.Vol.Count > 0) then
    Begin
      Lc_Qr_volume := Transp.Vol.Items[0].qVol;
      Lc_Especie := Copy(Transp.Vol.Items[0].esp,1,10);
      Lc_Marca := Copy(Transp.Vol.Items[0].marca,1,10);
      Lc_PesoBruto := FloatToStrF(Transp.Vol.Items[0].pesoB, ffFixed, 10, 4);
      Lc_PesoLiquido := FloatToStrF(Transp.Vol.Items[0].pesoL, ffFixed, 10, 4);
      Lc_Nr_Volume := Copy(Transp.Vol.Items[0].nVol,1,8);

      Lc_Veic_Placa := Transp.veicTransp.placa;
      Lc_Veic_Uf := Transp.veicTransp.UF;
      Lc_Veic_RNTC := Transp.veicTransp.RNTC;
    end;

    WITH NotaFiscal.Registro DO
    Begin
      Codigo := 0;
      CodigoEstabelecimento := Gb_CodMha;
      if (Ide.tpNF = tnSaida) then
        Tipo :=  'EE'
      else
        Tipo :=  'SE';

      Finalidade := FinNFeToStr(Ide.finNFe);
      Numero := StrZero(Ide.nNF, 6, 0);
      Serie :=  IntToStr( Ide.serie );
      CodigoCFOP := StrtoInt(StrGrd_CFOP.Cells[4, 1]);
      CodigoPedido := It_Cd_Pedido;
      CodigoEmpresa :=  Self.It_cd_Empresa;
      DataEmissao := StrToDateDEf(E_Dt_Emissao.Text, Ide.dEmi);
      DataSaida := StrToDateDEf(E_Dt_Saida.Text, Ide.dEmi);
      HoraSaida := Ide.dSaiEnt;
      ValorBaseICMS := Total.ICMSTot.vBC;
      ValorICMS :=   Total.ICMSTot.vICMS;
      ValorBaseICMSST := Total.ICMSTot.vBCST;
      ValorICMSST := Total.ICMSTot.vST;
      ValorProdutos := Total.ICMSTot.vProd;
      ValorFrete := Total.ICMSTot.vFrete;
      ValorSeguro := Total.ICMSTot.vSeg;
      ValorOutrasDespesas := Total.ICMSTot.vOutro;
      ValorIPI :=  Total.ICMSTot.vIPI;
      ValorNota := Total.ICMSTot.vNF;
      CodigoTransportadora := It_Cd_Transporte;
      ContaFrete := StrToIntDef(modFreteToStr(Transp.modFrete), 0);
      QtdeProdutos := Lc_Qr_volume;
      Especie :=  Lc_Especie;
      Marca := Lc_Marca;
      PesoBruto := Copy(Lc_PesoBruto,1,10);
      PesoLiquido := Copy(Lc_PesoLiquido,1,10);
      ControlaRetorno := 'N';
      Situacao := 'F';
      NumeroVolume := Lc_Nr_Volume;
      PlacaVeiculo := Lc_Veic_Placa;
      EstadoVeiculo := Lc_Veic_Uf;
      RNTC := Lc_Veic_RNTC;
      CFOP :=  StrGrd_CFOP.Cells[5, 1];
      Modelo := InttoStr( Ide.modelo );
      XMLImportado := 'S';
    End;
    NotaFiscal.salva;
    if Length(E_Obs.Text) > 0 then
    Begin
      Pc_Observacao(DM.IB_Transacao, 'I', 0, 0, NotaFiscal.Registro.Codigo, 'M', E_Obs.Text);
    end;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaItensNota;
Var
  Lc_I: Integer;
  Lc_Tp_Operacao: String;
  Lc_Lote: String;
  Lc_I_Lote: Integer;
  Lc_Lt_Controle: Integer;
  Lc_Op_Lote: String;
  Lc_Lst_Lote: TStringList;
  Lc_Sentido: String;
  Lc_Estoque : String;
  Lc_CtrlItens : TControllerItensNFL;
  LCCtrlEstoque : TControllerCtrlEstoque;
Begin
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    if Ide.tpNF = tnSaida then
    Begin
      Lc_Sentido := 'E'
    End
    else
    Begin
      Lc_Sentido := 'S'
    End;

    if (Chbx_Financeiro.Checked) OR (ChBx_FinManual.Checked) then
    Begin
      Lc_Tp_Operacao := 'C';
      Lc_Op_Lote := 'COMPRA';
    end
    else
    Begin
      Lc_Tp_Operacao := 'A';
      Lc_Op_Lote := 'AJUSTE';
    end;
    if ChBx_AtualizarEstoque.Checked then
      Lc_Estoque := 'N'
    else
      Lc_Estoque := 'S';

    LCCtrlEstoque := TControllerCtrlEstoque.Create( nil );
    Lc_CtrlItens := TControllerItensNFL.Create( nil );
    Try
      cds_itens_nota.first;
      //Começar com -1 para no acumulador iniciar em zero
      Lc_I := -1;
      while not cds_itens_nota.Eof do
      Begin

        with Lc_CtrlItens do
        begin
          Registro.Codigo            := 0;
          Registro.Sequencia         := cds_itens_notaitem.AsInteger;
          Registro.CodigoPedido      := It_Cd_Pedido;
          Registro.CodigoNota        := NotaFiscal.Registro.Codigo;
          Registro.CodigoProduto     := cds_itens_notacodigoInterno.AsInteger;
          Registro.Quantidade        := cds_itens_notaqtde.AsFloat;
          Registro.ValorCusto        := cds_itens_notavalorUnitario.AsCurrency;
          Registro.ValorUnitario     := cds_itens_notavalorUnitario.AsCurrency;
          Registro.Despachar         := 'N';
          Registro.Estoque           := 'S';
          Registro.AliqComissao      := 0;
          Registro.ValorDesconto     := cds_itens_notavalorDesconto.AsCurrency;
          Registro.AliqDesconto      := 0;//Det.Items[Lc_I].Prod.aDesc;
          Registro.AliqIPI           := 0;
          Registro.Operacao          := Lc_Tp_Operacao;
          Registro.AliqICMS          := 0;
          Registro.CodigoEstoque     := cds_itens_notacodigoEstoque.AsInteger;
          Registro.CodigoTabela      := 1;
          Registro.Altura            := 0;
          Registro.Largura           := 0;
          Registro.Sentido           := Lc_Sentido;
          Registro.PedidoCompra      := '0';
          Registro.ItemCompra        := '0';
          Registro.ImpostoAproximado := 0;
          Registro.NumeroPecas       := 0;
        End;
        Lc_CtrlItens.insere;
        cds_itens_nota.Edit;
        cds_itens_notacodigo.AsInteger := Lc_CtrlItens.Registro.Codigo;
        cds_itens_nota.Post;

        with LCCtrlEstoque.Registro do
        Begin
          Codigo      := 0;
          Terminal    := Gb_Terminal;
          Vinculo     := 'P';
          Ordem       := It_Cd_Pedido;
          Item        := cds_itens_notacodigo.AsInteger;
          Estoque     := cds_itens_notacodigoEstoque.AsInteger;
          operacao    := 'E';
          Produto     := cds_itens_notacodigoInterno.AsInteger;
          Quantidade  := cds_itens_notaqtde.AsFloat;
          Data        := Date;
          if (Chbx_Financeiro.Checked) OR (ChBx_FinManual.Checked) then
            Tipo        := 'Compra'
          else
            Tipo        := 'Ajuste';
          UpdateAt    := Now;
        End;
        LcCtrlEstoque.Registra;

        //Controla o indice dos dados da nota como era no loop pelo For
        //Se o item for duplicado não avança
        if ( cds_itens_notaduplicate.AsString = 'N' ) then
        Begin
          Lc_I := Lc_I + 1;
          // Grava os impostos
          Pc_GravaItensICMS(Lc_I);
          Pc_GravaCtrlIcmsRet(Lc_I,cds_itens_notacodigoInterno.AsInteger);
          Pc_GravaItensIPI(Lc_I);
          Pc_GravaItensPIS(Lc_I);
          Pc_GravaItensCOFINS(Lc_I);
          Pc_GravaItensII(Lc_I);
        End;
        cds_itens_nota.Next;
      end;
    Finally
      FreeAndNil(Lc_CtrlItens);
      FreeAndNil(LcCtrlEstoque);
    End;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaItensICMS(Pc_Sequencia: Integer);
vAR
  Lc_Cd_CFOP: Integer;
  Lc_Cd_CST: Integer;
  Lc_Cd_SCOSN: Integer;
  Lc_Nr_Itens: Integer;
  Lc_I : Integer;

Begin
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    with Det.Items[Pc_Sequencia].Imposto.ICMS do
    Begin
      // Trata as Variaveis do CFOP
      Lc_Cd_CFOP := Fc_BuscaCodigoCFOP(Det.Items[Pc_Sequencia].Prod.CFOP);
      for Lc_I := 1 to ( StrGrd_CFOP.RowCount -1 ) do
      Begin
        if Lc_Cd_CFOP = StrToIntDef(StrGrd_CFOP.cells[1,Lc_I],0) then
           Lc_Cd_CFOP := StrToIntDef(StrGrd_CFOP.cells[4,Lc_I],0)
      End;
      Lc_Cd_CST := Fc_BuscaCodigoReferenciaCST(CSTICMSToStr(CST));
      Lc_Cd_SCOSN := Fc_BuscaCodigoReferenciaCSOSN(CSOSNIcmsToStr(CSOSN));

      with NotaFiscal.Pedido.Itens do
      Begin
        ItensIcms.Registro.codigo             := 0;
        ItensIcms.Registro.Nota               := NotaFiscal.Registro.Codigo;
        ItensIcms.Registro.ItemNota           := cds_itens_notacodigo.AsInteger;
        ItensIcms.Registro.CST                := Lc_Cd_CST;
        ItensIcms.Registro.CSOSN              := Lc_Cd_SCOSN;
        ItensIcms.Registro.Origem             := OrigToStr(orig);
        ItensIcms.Registro.Determinacao       := modBCToStr(modBC);
        ItensIcms.Registro.AliqRedBase        := pRedBC;
        ItensIcms.Registro.ValorBase          := vBC;
        ItensIcms.Registro.Aliquota           := pICMS;
        ItensIcms.Registro.AliquotaReduzida   := 0;
        ItensIcms.Registro.Valor              := vICMS;
        ItensIcms.Registro.DeterminacaoBaseST := modBCSTToStr(modBCST);
        ItensIcms.Registro.AliqRedBaseST      := pRedBCST;
        ItensIcms.Registro.MVA                := pMVAST;
        ItensIcms.Registro.ValorBaseST        := vBCST;
        ItensIcms.Registro.AliquotaST         := pICMSST;
        ItensIcms.Registro.AliqRedST          := 0;
        ItensIcms.Registro.ValorST            := vICMSST;
        ItensIcms.Registro.Desoneracao        := StrtoIntDef(motDesICMSToStr(motDesICMS),0);
        ItensIcms.Registro.VAlorBaseSTRetido  := 0;
        ItensIcms.Registro.ValorSTRetido      := 0;
        ItensIcms.Registro.Partilha           := '';
        ItensIcms.Registro.Repasse            := '';
        ItensIcms.Registro.BaseICMSRetido     := 0;
        ItensIcms.Registro.ValorICMSRetido    := 0;
        ItensIcms.Registro.BaseFCPST          := vBCFCPST;
        ItensIcms.Registro.ValorFCPST         := vFCPST;
        ItensIcms.Registro.AliqFCPST          := pFCPST;
        ItensIcms.Registro.AliqCalcCred       := pCredSN;
        ItensIcms.Registro.CreditoAprox       := vCredICMSSN;
        ItensIcms.Registro.ValorFrete         := StrToFloatDef( cds_itens_notafrete.AsString,0);
        ItensIcms.Registro.Seguro             := StrToFloatDef( cds_itens_notaSeguro.AsString,0);
        ItensIcms.Registro.OutrasDespesas     := StrToFloatDef( cds_itens_notaOutras.AsString,0);
        ItensIcms.Registro.CFOP               := Lc_Cd_CFOP;
        ItensIcms.Registro.Destacar           := 'S';
        ItensIcms.Registro.Observacao         := 0;
        ItensIcms.insere;
      end;
    End;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaItensIPI(Pc_Sequencia: Integer);
Var
  LcBcIPi : Real;
Begin

  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe, NotaFiscal.Pedido.Itens DO
  Begin
    with Det.Items[Pc_Sequencia].Imposto.IPI do
    Begin
      IF (vBC > 0) then
        LcBcIPi := vBC
      else
      Begin
        if pIPI > 0 then
          LcBcIPi :=  ( vIPI / pIPI ) * 100
        else
         LcBcIPi := 0;
      End;
      if LcBcIPi > 0 then      
      Begin
        with NotaFiscal.Pedido.Itens do
        Begin
          ItensIpi.Registro.Codigo       := 0;
          ItensIpi.Registro.Nota         := NotaFiscal.Registro.Codigo;
          ItensIpi.Registro.ItemNota     := cds_itens_notacodigo.AsInteger;
          ItensIpi.Registro.CST          := StrtoIntDEf(CSTIPIToStr(CST),0);
          ItensIpi.Registro.ClassEnqu    := clEnq;
          ItensIpi.Registro.CNPJProdutor := CNPJProd;
          ItensIpi.Registro.CodigoSelo   := cSelo;
          ItensIpi.Registro.QtdeSelo     := qSelo;
          ItensIpi.Registro.CodigoEnqu   := cEnq;
          ItensIpi.Registro.ValorBase    := LcBcIPi;
          ItensIpi.Registro.Aliquota     := pIPI;
          ItensIpi.Registro.QtdeUnid     := qUnid;
          ItensIpi.Registro.ValorUnid    := vUnid;
          ItensIpi.insere;
        End;
      end;
    end;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaItensPIS(Pc_Sequencia: Integer);
Begin
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    with Det.Items[Pc_Sequencia].Imposto.PIS do
    Begin
      IF (vBC > 0) then
      Begin
        with NotaFiscal.Pedido.Itens do
        Begin
          ItensPis.Registro.Codigo        := 0;
          ItensPis.Registro.Nota          := NotaFiscal.Registro.Codigo;
          ItensPis.Registro.ItemNota      := cds_itens_notacodigo.AsInteger;
          ItensPis.Registro.CST           := StrtoIntDef(CSTPISToStr(CST),0);
          ItensPis.Registro.ValorBase     := vBC;
          ItensPis.Registro.Aliquota      := pPIS;
          ItensPis.Registro.Valor         := vPIS;
          ItensPis.Registro.QtdeVenda     := qBCProd;
          ItensPis.Registro.ValorAliquota := vAliqProd;
          ItensPis.insere;
        End;
      end;
    end;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaLote;
Var
  Lc_Sentido : String;
  Lc_Op_Lote : String;
  Lc_Data : TDAte;
  Lc_NumeroNota: String;
  Lc_NumeroLote : String;
  Lc_ItemLote : Integer;
begin
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    Lc_NumeroNota := StrZero(Ide.nNF, 6, 0);
    if Ide.tpNF = tnSaida then
    Begin
      Lc_Sentido := 'E'
    End
    else
    Begin
      Lc_Sentido := 'S'
    End;
    Lc_Data := StrToDateDEf(E_Dt_Emissao.Text, Ide.dEmi);

    if (Chbx_Financeiro.Checked) OR (ChBx_FinManual.Checked) then
    Begin
      Lc_Op_Lote := 'COMPRA';
    end
    else
    Begin
      Lc_Op_Lote := 'AJUSTE';
    end;
  end;


  cds_itens_nota.first;
  Lc_ItemLote := 0;
  while not cds_itens_nota.Eof do
  Begin
    //Verifica se foi informado o vencimento do lote
    if (Length(Trim(cds_itens_notaloteVencimento.AsString)) > 0) then
    Begin
      //Verifica e existe do lote e insere
      //Verifica se o numero foi informado, caso contrário registro o codigo de Entrada
      if (Length(Trim(cds_itens_notaloteNumero.AsString)) > 0) then
        Lc_NumeroLote  := cds_itens_notaloteNumero.AsString
      else
      Begin
        inc(Lc_ItemLote);
        Lc_NumeroLote := concat(Lc_NumeroNota,'/',IntToStr(Lc_ItemLote));
      End;

      CtrlLote.Registro.Numero := Lc_NumeroLote;
      CtrlLote.Registro.Empresa := It_cd_Empresa;
      CtrlLote.Registro.Codigo  := 0;
      CtrlLote.Registro.Produto := cds_itens_notacodigoInterno.AsInteger;
      CtrlLote.VerificaExistenciaNumeroLote;
      if not CtrlLote.exist then
      Begin
        CtrlLote.Registro.Codigo  := 0;
        CtrlLote.Registro.Estabelecimento := Gb_CodMha;
        CtrlLote.Registro.Empresa         := It_cd_Empresa;
        CtrlLote.Registro.Numero          := Lc_NumeroLote;
        CtrlLote.Registro.Certificado     := '';
        CtrlLote.Registro.Produto         := cds_itens_notacodigoInterno.AsInteger;
        CtrlLote.Registro.Vencimento      := StrToDateDef(cds_itens_notaloteVencimento.AsString,Date);
        CtrlLote.insere;
      End;

      CtrlLote.Movimento.Registro.Codigo  := 0;
      CtrlLote.Movimento.Registro.Lote    := CtrlLote.Registro.Codigo;
      CtrlLote.Movimento.Registro.Data    := Lc_Data;
      CtrlLote.Movimento.Registro.Tipo    := Lc_Op_Lote;
      CtrlLote.Movimento.Registro.Vinculo := cds_itens_notacodigo.AsInteger;
      CtrlLote.Movimento.Registro.Sentido := Lc_Sentido;
      CtrlLote.Movimento.Registro.Qtde    := cds_itens_notaqtde.AsFloat;
      CtrlLote.Movimento.insere;
      CtrlLote.Movimento.AtualizaSaldo;
    End;
    cds_itens_nota.Next;
  End;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaItensCOFINS(Pc_Sequencia: Integer);
Begin
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    with Det.Items[Pc_Sequencia].Imposto.COFINS do
    Begin
      IF (vBC > 0) then
      Begin
        with NotaFiscal.Pedido.Itens do
        Begin
          ItensCofins.Registro.Codigo        := 0;
          ItensCofins.Registro.Nota          := NotaFiscal.Registro.Codigo;
          ItensCofins.Registro.ItemNota      := cds_itens_notacodigo.AsInteger;
          ItensCofins.Registro.CST           := StrtoIntDef(CSTCOFINSToStr(CST),0);
          ItensCofins.Registro.ValorBase     := vBC;
          ItensCofins.Registro.Aliquota      := pCOFINS;
          ItensCofins.Registro.Valor         := vCOFINS;
          ItensCofins.Registro.QtdeVenda     := qBCProd;
          ItensCofins.Registro.ValorAliquota := vAliqProd;
          ItensCofins.insere;
        End;
      end;
    end;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaItensII(Pc_Sequencia: Integer);
Begin
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    with Det.Items[Pc_Sequencia].Imposto.II do
    Begin
      IF (vBC > 0) then
      Begin
        with NotaFiscal.Pedido.Itens do
        Begin
          ItensII.Registro.Codigo         := 0;
          ItensII.Registro.Nota           := NotaFiscal.Registro.Codigo;
          ItensII.Registro.ItemNota       := cds_itens_notacodigo.AsInteger;
          ItensII.Registro.ValorBase      := vBC;
          ItensII.Registro.ValorDespesaAd := vDespAdu;
          ItensII.Registro.Valor          := vII;
          ItensII.Registro.ValorIOF       := vIOF;
          ItensII.insere;
        End;
      end;
    end;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_Gera_Financeiro;
var
  Lc_I: Integer;
  Lc_Qt_Parcelas: Integer;
  Lc_Nr_Duplicata : String;
  Lc_Form : TFr_Fatura_fin;
begin
  if (Chbx_Financeiro.checked) or (ChBx_FinManual.checked) then
  Begin
    Try
      Lc_Form := TFr_Fatura_fin.Create(nil);
      Lc_Form.It_Confirma := False;
      Lc_Form.It_cd_Nota := NotaFiscal.Registro.Codigo;
      Lc_Form.TelaVenda := False;
      if Chbx_CreditoFinanceiro.checked  then
      Begin
        Lc_Form.It_Tipo_Finaceiro := 'RA';
      End
      else
      Begin
        Lc_Form.It_Tipo_Finaceiro := 'PA';
      End;
      Lc_Form.It_Oper_Financeiro := 'D';
      Lc_Form.PegaContaGerencialAuto := False;
      Lc_Form.It_Hist_Caixa := 'COMPRA NF Nº ' + It_Nr_Nota;
      Lc_Form.ShowModal;
    Finally
      FreeAndNil(Lc_Form);
    End;

  End;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaArquivoXML;
Var
  Lc_Path: String;
Begin
  with fr_principal do
  Begin
    Lc_Path := Fc_TrazRepositorio('NFE_REPOSITORIO');
    IF (Length(Trim(E_Chave.Text)) > 0) then
    Begin
      It_FileXML := E_Chave.Text + '-nfe.XML';
    end
    else
    Begin
      It_FileXML := Copy(It_FileXML, 1, 44);
      It_FileXML := It_FileXML + '-nfe.XML';
    end;
    Nfe.NotasFiscais.GravarXML(Lc_Path + '/' + It_FileXML);
    Pc_Insere_Arq_Banco(Lc_Path, It_FileXML, 3, 'XML', NotaFiscal.Registro.Codigo);
    //Força a Visualização no modelo 55
    Pc_FormataModeloNFE;
    Nfe.DANFE.Logo := '';
    Nfe.DANFE.MostraPreview := True;
    Nfe.NotasFiscais.Imprimir;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_GravaCtrlIcmsRet(Pc_Sequencia,
  Pc_Cd_Produto: Integer);
Var
  I : Integer;
  F : Integer;
begin
  //Registramos o ICMS Recolhidod por ST nesta operação ou anteiormente
//  fr_principal.Nfe.NotasFiscais.Items[0].Nfe.Det.Items[1].Imposto.ICMS.pICMSST
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    with Det.Items[Pc_Sequencia].Imposto.ICMS do
    Begin
      if vBCST > 0 then
      Begin
        F := Trunc(Det.Items[Pc_Sequencia].Prod.qCom);
        for I := 1 to F do
        Begin
          CtrlcmsST.Registro.Estabelecimento     := Gb_CodMha;
          CtrlcmsST.Registro.Codigo              := 0;
          CtrlcmsST.Registro.Origem              := cds_itens_notacodigo.AsInteger;
          CtrlcmsST.Registro.Produto             := Pc_Cd_Produto;
          CtrlcmsST.Registro.ValorBaseSTRetido   := Det.Items[Pc_Sequencia].Prod.vUnTrib / (1 + pMVAST);
          CtrlcmsST.Registro.AliqST              := pICMSST;
          //Caso não preencham corretamente o campo tentamos pegar pelo valor do icms recolhido
          if vICMSSubstituto > 0 then
            CtrlcmsST.Registro.ValorICMSSubstituto := vICMSSubstituto / F
          else
            CtrlcmsST.Registro.ValorICMSSubstituto := (CtrlcmsST.Registro.ValorBaseSTRetido * pICMSST) / F;
          CtrlcmsST.Registro.ValorICMSSTRetido   := vICMSST / F;
          CtrlcmsST.Registro.Destino             := 0;
          CtrlcmsST.insere;
        End;
      End
      else
      Begin
        if vBCSTRet > 0 then
        Begin
          F := Trunc(Det.Items[Pc_Sequencia].Prod.qCom);
          for I := 1 to F do
          Begin
            CtrlcmsST.Registro.Estabelecimento     := Gb_CodMha;
            CtrlcmsST.Registro.Codigo              := 0;
            CtrlcmsST.Registro.Origem              := cds_itens_notacodigo.AsInteger;
            CtrlcmsST.Registro.Produto             := Pc_Cd_Produto;
            CtrlcmsST.Registro.ValorBaseSTRetido   := vBCSTRet / F;
            CtrlcmsST.Registro.AliqST              := pST;
            //Caso não preencham corretamente o campo tentamos pegar pelo valor do icms recolhido
            if vICMSSubstituto > 0 then
              CtrlcmsST.Registro.ValorICMSSubstituto := vICMSSubstituto / F
            else
              CtrlcmsST.Registro.ValorICMSSubstituto := vICMS / F;
            CtrlcmsST.Registro.ValorICMSSTRetido   := vICMSSTRet / F;
            CtrlcmsST.Registro.Destino             := 0;
            CtrlcmsST.insere;
          End;
        End;
      End;
    End;
  End;

end;

procedure TFr_ImportaXMLNFe.Pc_AtualizaCusto;
Begin
  WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
  Begin
    if ChBx_CalculoCustoMedioBonificacao.checked then
    Begin
      Pc_AtualizaCustosProdutos(It_Cd_Pedido,'',True);
    End
    else
    Begin
      if (Chbx_Financeiro.Checked) OR (ChBx_FinManual.Checked) or (Chbx_ForcaCusto.Checked) then
        Pc_AtualizaCustosProdutos(It_Cd_Pedido,'',false);
    End;
  end;
end;

procedure TFr_ImportaXMLNFe.Pc_Atualiza_Preco_Venda;
Var
  Lc_Atualiza : String;
Begin
  Lc_Atualiza := FC_Tb_Geral('L', 'PRO_G_ATUAL_PRECO_COMPRA', '') ;
  if ( Lc_Atualiza = 'A') then
    Pc_AtualizarPreco(NotaFiscal.Registro.Codigo)
  else if ( Lc_Atualiza  = 'M') then
    Pc_AtualizarPrecoManual(It_Cd_Pedido);
end;

procedure TFr_ImportaXMLNFe.Sb_Sair_0Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_ImportaXMLNFe.setPerfil;
begin
  if Gb_Nivel = 1 then
  begin
    It_Processo := True;
    It_Confirma := True;
  end
  else
  begin
    It_Processo := Fc_HabilitaPermissao(pfMenu, 'PROCESSO', 'S');
    It_Confirma := Fc_HabilitaPermissao(pfMenu, 'CONFIRMAR', 'S');
  end;
end;

procedure TFr_ImportaXMLNFe.Pg_NotasChange(Sender: TObject);
begin
  if (Pg_Notas.ActivePageIndex <> 0) AND (Pg_Notas.ActivePageIndex < 5) then
  Begin
    if Trim(E_Nr_Nota.Text) = '' then
    Begin
      Pg_Notas.ActivePage := tbs_nota;
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
        'Não há dados a serem visualizados.' + EOLN +
        'Execute a leitura do XML.' + EOLN, ['OK'], [bEscape], mpAlerta);

    end;
  end;
end;

procedure TFr_ImportaXMLNFe.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not(ActiveControl is TDBMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_ImportaXMLNFe.FormataTela;
begin
  inherited;

end;

procedure TFr_ImportaXMLNFe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = []) then
  begin
    case Key of
      VK_F2:
        if SB_Processo.Enabled then
          SB_ProcessoClick(Sender);
      VK_F3:
        if SB_Confirmar.Enabled then
          SB_ConfirmarClick(Sender);
      VK_Escape:
        if Sb_Sair_0.Enabled then
          Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_ImportaXMLNFe.E_ChaveKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    IF SB_Processo.Enabled then
      SB_ProcessoClick(Sender);
end;

procedure TFr_ImportaXMLNFe.AtivaTabelas;
begin
  inherited;

end;

procedure TFr_ImportaXMLNFe.calculatotalItens;
Var
  LcClone : TClientdataSet;
  Lc_Valor : Real;
  Lc_Vl_Unit : Real;
begin
  Try
    LcClone := TClientdataSet.create(nil);
    LcClone.CloneCursor(cds_itens_nota,false);
    LcClone.First;
    Lc_Valor := 0;
    while not LcClone.Eof do
    Begin
      //Lc_Valor := Lc_Valor  +  LcClone.FieldByName('valorTotal').AsFloat;
      Lc_Vl_Unit :=  (LcClone.FieldByName('valorUnitario').AsCurrency * LcClone.FieldByName('qtde').AsFloat );
      Lc_Vl_Unit := RoundTo( Lc_Vl_Unit, -2) - LcClone.FieldByName('valorDesconto').AsCurrency;
      Lc_Valor := Lc_Valor  + Lc_Vl_Unit;
      LcClone.Next
    End;
  Finally
    Lb_Total_Itens_Calculado.Caption := FloatToStrF(Lc_Valor,ffFixed,10,2);
    FreeAndNil(LcClone);
  End;
end;

procedure TFr_ImportaXMLNFe.CalculoCustoExtrasDataset;
vAR
  Lc_VL_frete_Produto, Lc_VL_frete_Acumulado, Lc_VL_TL_Frete: Real;
  Lc_VL_outras_Produto, Lc_VL_outras_Acumulado, Lc_VL_TL_Outras: Real;
  Lc_Tx_Prop: Real;
  Lc_Sequencia : Integer;
  Lc_Nr_Itens: Integer;
  Lc_ValorTotaProdutos : Real;

Begin
  Lc_VL_outras_Produto := 0;
  Lc_Tx_Prop := 0;
  //O frete destacado na nota não precisa entrar no rateio por que ele já consta no item da nota
  Lc_ValorTotaProdutos :=   fr_principal.Nfe.NotasFiscais.Items[0].Nfe.Total.ICMSTot.vProd;

  Lc_VL_TL_Frete := StrToFloatDef(E_VL_Frete_Extra.Text, 0);
  Lc_VL_TL_Outras := StrToFloatDef(E_Vl_Outras_Extra.Text, 0);
  Lc_VL_frete_Produto := 0;
  Lc_VL_frete_Acumulado := 0;
  Lc_VL_outras_Acumulado := 0;
  cds_itens_nota.First;
  Lc_Nr_Itens := cds_itens_nota.RecordCount;
  Lc_Sequencia  := 1;
  while not cds_itens_nota.Eof do
  Begin
    Lc_Tx_Prop :=  ( cds_itens_notavalorTotal.AsCurrency /Lc_ValorTotaProdutos );
    Lc_Tx_Prop :=  RoundTo( Lc_Tx_Prop, -4);
    // Verifica se há valor de Frete que não consta na nota Fiscal para fins de calculo de custo
    if (Lc_VL_TL_Frete > 0) then
    Begin
      if (Lc_Nr_Itens > Lc_Sequencia) then
      Begin
        // Valor do Frete
        Lc_VL_frete_Produto := Fc_ArredondarParaBaixo(Lc_VL_TL_Frete * Lc_Tx_Prop, 2, False);
        // Acumula o valor em variavel local
        Lc_VL_frete_Acumulado := Lc_VL_frete_Acumulado + Lc_VL_frete_Produto;
      end
      else
      Begin
        Lc_VL_frete_Produto := Lc_VL_TL_Frete - Lc_VL_frete_Acumulado;
        IF (Lc_VL_frete_Produto < 0) then Lc_VL_frete_Produto := 0;
      end;
    end;
    // Verifica se há valor adicionais para fins de calculo de custo
    if (Lc_VL_TL_Outras > 0) then
    Begin
      if (Lc_Nr_Itens > Lc_Sequencia) then
      Begin
        // Valor do Frete
        Lc_VL_outras_Produto := Fc_ArredondarParaBaixo(Lc_VL_TL_Outras * Lc_Tx_Prop, 2, False);
        // Acumula o valor em variavel local
        Lc_VL_outras_Acumulado := Lc_VL_outras_Acumulado + Lc_VL_outras_Produto;
      end
      else
      Begin
        Lc_VL_outras_Produto := Lc_VL_TL_Outras - Lc_VL_outras_Acumulado;
        IF (Lc_VL_outras_Produto < 0) then Lc_VL_outras_Produto := 0;
      end;
    end;
    cds_itens_nota.Edit;
    cds_itens_notafrete.AsCurrency :=  cds_itens_notafrete.AsCurrency + Lc_VL_frete_Produto;
    cds_itens_notaoutras.AsFloat :=  cds_itens_notaoutras.AsFloat + Lc_VL_outras_Produto;
    cds_itens_nota.Post;

    cds_itens_nota.Next;
    Lc_Sequencia := Lc_Sequencia + 1;
  end;

end;

procedure TFr_ImportaXMLNFe.ChangeSubTotalByQtde(Sender: TField);
begin
  Try
    cds_itens_notavalorUnitario.OnChange := nil;
    cds_itens_notavalorUnitario.AsCurrency := cds_itens_notavalortotalFixo.AsCurrency / TField(Sender).AsFloat  ;
    cds_itens_notavalorTotal.AsCurrency :=  (cds_itens_notavalorUnitario.AsCurrency * TField(Sender).AsFloat ) ;
    cds_itens_notavalorTotal.AsCurrency := RoundTo( cds_itens_notavalorTotal.AsCurrency, -2) ;

    cds_itens_nota.Post;
  Finally
    calculatotalItens;
    cds_itens_notavalorUnitario.OnChange := ChangeSubTotalbyValor;
  End;
end;

procedure TFr_ImportaXMLNFe.ChangeSubTotalbyValor(Sender: TField);
begin
  Try
    cds_itens_notaqtde.OnChange := nil;
    cds_itens_notavalorTotal.AsCurrency :=  (cds_itens_notaqtde.AsFloat * TField(Sender).AsFloat ) ;
    cds_itens_notavalorTotal.AsCurrency := RoundTo( cds_itens_notavalorTotal.AsCurrency,-2) ;
    cds_itens_nota.Post;
  Finally
    calculatotalItens;
    cds_itens_notaqtde.OnChange := ChangeSubTotalByQtde;
  End;
end;

procedure TFr_ImportaXMLNFe.ClearFields(T: TComponent);
Var
  I:Integer;
begin
  with T do
  Begin
    for I := 0 to ((ComponentCount)-1) do
    begin
      if (Components[I].ClassName = 'TEdit') then
        TEdit (Components[I]).Clear;

      if (Components[I].ClassName = 'TEdit_Setes') then
        TEdit_Setes(Components[I]).Clear;

      if (Components[I].ClassName = 'TMaskEdit') then
        TMaskEdit(Components[I]).Clear;

      if (Components[I].ClassName = 'TMemo') then
        TMemo (Components[I]).Clear;
    end;
  End;
end;

procedure TFr_ImportaXMLNFe.CriarVariaveis;
begin
  inherited;
  It_CodigoFPagto := TStringList.Create;
  CtrlcmsST := TControllerCtrlIcmsST.create(Self);
  NotaFiscal := TControllerNotaFiscal.Create(Self);
  CtrlLote := TControllerCtrlLote.Create(Self);
  Parcelamento := TControllerParcelamento.Create(Self)
end;

procedure TFr_ImportaXMLNFe.Dbg_itemsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if NOT (ds_itens_nota.DataSet.FieldByName('codigoInterno').AsInteger >0 ) then
    Dbg_items.Canvas.Font.Color := clRed;
  Dbg_items.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TFr_ImportaXMLNFe.duplicaItem;
var
  Cds: TClientDataSet;
  LcItem : String;
  I,J : Integer;
  Lc_Resposta : String;
  Lc_Replica : Integer;

begin
  Lc_Resposta := '2';
  InputQuery('Replicação do Item ', 'Número da vezes', Lc_Resposta );
  Lc_Replica := StrToIntDef(Lc_Resposta,0);

  if (Lc_Replica < 2) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'O Número de replicação deve ser pelo menos 2.' + EOLN +
                   'Verifique e tente novamente!!' + EOLN, ['OK'], [bEscape], mpAlerta);
    Exit;
  End;

  LcItem := cds_itens_notaitem.AsString;
  //Marca o item como duplicado
  Cds := TClientDataSet.Create(self);
  try
    cds_itens_notavalorUnitario.OnChange := nil;
    cds_itens_notaqtde.OnChange := nil;
    //Quando Duplicar deve divir o valor total por 2 para depois calcular as quantidades
    cds_itens_nota.edit;
    cds_itens_notavalorTotal.AsCurrency := cds_itens_notavalorTotal.AsCurrency / Lc_Replica;
    cds_itens_notavalorUnitario.AsCurrency := cds_itens_notavalorUnitario.AsCurrency / Lc_Replica;
    cds_itens_notavalorDesconto.AsCurrency := cds_itens_notavalorDesconto.AsCurrency / Lc_Replica;
    cds_itens_notavalortotalFixo.AsCurrency := cds_itens_notavalortotalFixo.AsCurrency / Lc_Replica;
    cds_itens_nota.Post;

    Cds.Data := cds_itens_nota.data;
    Cds.Filter := concat('( item = ',LcItem,')');
    Cds.Filtered := True;

    for J := 1 to (Lc_Replica-1) do
    Begin
      cds_itens_nota.Insert;
      for I := 0 to cds_itens_nota.FieldCount - 1 do
      Begin
        if (cds_itens_nota.Fields[I].FieldName = 'duplicate')  then
          cds_itens_nota.FieldByName(cds_itens_nota.Fields[I].FieldName).Value := 'S'
        else
          cds_itens_nota.FieldByName(cds_itens_nota.Fields[I].FieldName).Value := cds.FieldByName(cds_itens_nota.Fields[I].FieldName).Value;
      End;
      cds_itens_nota.post;
    End;
  finally
    Cds.free;
    cds_itens_notavalorUnitario.OnChange := ChangeSubTotalbyValor;
    cds_itens_notaqtde.OnChange := ChangeSubTotalByQtde;

  end;

end;

procedure TFr_ImportaXMLNFe.E_ChaveChange(Sender: TObject);
begin
  Lb_Nr_Caracteres.Caption := 'Número de Caracteres : ' + IntToStr( Length(E_Chave.Text) )
end;

procedure TFr_ImportaXMLNFe.E_ChaveEnter(Sender: TObject);
begin
  E_Chave.SelectAll;
end;

function TFr_ImportaXMLNFe.Fc_ValidaLeituraManual(): Boolean;
Var
  Lc_Path: String;
  Lc_Cnpj: String;
  Lc_CNpj_Dest: String;
Begin
  Result := False;
  Pc_AtivaEstabelecimento;
  OpenDialogo.Title := 'Informe o Arquivo XML da Nota Fiscal Eletrônica';
  if OpenDialogo.Execute then
  Begin
    Result := True;
    TRY
      // Define o caminho e o arquivo da Nota Fiscal
      It_FileXML := OpenDialogo.FileName;
      Lc_Path := OpenDialogo.FileName;
      GetDir(0, Lc_Path);
      It_FileXML := Copy(It_FileXML, Length(Lc_Path) + 2,
        Length(It_FileXML) - Length(Lc_Path) + 2);
      // Carrega o componente
      Self.Update;
      Pc_CarregaComponenteNFE(Lc_Path, It_FileXML);
    except
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                      'Não foi possível carregar a nota Fiscal.' + EOLN +
                      'Verifique e tente novamente ou informe a chave da nota no campo específico.'
                      + EOLN, ['OK'], [bEscape], mpAlerta);
      Result := False;
      exit;
    end;

    if not ChBx_XML_Terceiro.Checked then
    Begin
      // Verifica se o XML É DO CLIENTE
      if fr_principal.Nfe.NotasFiscais.Count > 0 then
      Begin
        WITH fr_principal.Nfe.NotasFiscais.Items[0].Nfe DO
        Begin
          Lc_Cnpj := DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;
          Lc_CNpj_Dest := Dest.CNPJCPF;
          if (Lc_Cnpj <> Lc_CNpj_Dest) and
            (Fc_VerificaFormularioDisponivel('Fr_GeraNFe')) then
          Begin
            MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                            'Esta nota não foi emitida para a ' + GB_NM_Empresa + '.' + EOLN +
                            'Verifique antes de continuar.' +
                            EOLN, ['OK'], [bEscape], mpAlerta);
            Result := False;
            exit;
          end;
        end;
      End
      else
      Begin
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Não foi possivel carregar o arquivo XML.' + EOLN +
                       'Verifique se o arquivo é referente a uma NFe e/ou se é válido.' + EOLN,
                       ['OK'], [bEscape], mpAlerta);
        Result := False;
        exit;
      End;
    end;
  End;
end;

procedure TFr_ImportaXMLNFe.Pc_LeituraManualNFe;
Var
  Lc_Chave: String;
  Lc_Path: String;
  Lc_Nome: String;
  Lc_Lote: Integer;
  Lc_Msg: string;
  Lc_Justificativa: String;

begin
  if Fc_ValidaLeituraManual then
  Begin
    try
      // Define o caminho e o arquivo da Nota Fiscal
      It_FileXML := OpenDialogo.FileName;
      Lc_Path := OpenDialogo.FileName;
      GetDir(0, Lc_Path);
      It_FileXML := Copy(It_FileXML, Length(Lc_Path) + 2,
        Length(It_FileXML) - Length(Lc_Path) + 2);

      Pc_ProcesoAguarde(Self, 'I');
      Self.Update;
      Self.Enabled := False;
      MemoResp.Lines.Clear;
      Self.Update;
      Pc_CarregaComponenteNFE(Lc_Path, It_FileXML);
      Self.Update;
      Pc_MostraEmitenteXML_Nfe;
      Self.Update;
      Pc_MostraDadosNotaXML_Nfe;
      Self.Update;
      if cds_itens_nota.Active then cds_itens_nota.EmptyDataSet;
      Self.Update;
      Pc_MostraItensNotaXML_Nfe;

      Pc_MostraItensNotaXML_Nfe_Novo;

      Self.Update;
      Pc_LimpaGrandeCFOP;
      Self.Update;
      Pc_DefineParcelamentoXML_Nfe;
      Self.Update;
      Pc_MostraDadosCFOP_Nfe;
      Self.Update;
      //grava os dados para garantir o vinculo dos produtos
      Pc_GravaEmitente;
      Self.Update;
      Pc_GravaTransportadora;
      Self.Update;
    finally
      Pc_ProcesoAguarde(Self, 'F');
      Self.Enabled := True;
    end;
  end;
end;

procedure TFr_ImportaXMLNFe.SB_ProcessoClick(Sender: TObject);
begin
  if Trim(E_Chave.Text) <> '' then
  Begin
    Fr_Principal.Nfe.NotasFiscais.Clear;
    Pc_AtivaConfiguracaoNFe;
    Pc_CarregaDadosEmitente(False);
    //Pc_AtivaDadosUsuarios;
    Pc_FormataModeloNFE;
    Pc_LeituraOnLineNFe;
  end
  else
  Begin
    Pc_LeituraManualNFe;
  end;
end;

procedure TFr_ImportaXMLNFe.Sb_Replicar_itemClick(Sender: TObject);
begin
  if validaDuplicaitem then
  Begin
    duplicaItem;
    calculatotalItens;
  End;
end;

procedure TFr_ImportaXMLNFe.Sb_EstoqueClick(Sender: TObject);
Var
  Lc_Form: TSeaStocks;
begin
  Lc_Form := TSeaStocks.Create(nil);
  try
    Lc_Form.ShowModal;
  finally
    cds_itens_nota.Edit;
    cds_itens_notacodigoEstoque.AsInteger := Lc_Form.cds_searchcodigo.AsInteger;
    cds_itens_notadescricaoEstoque.AsString := Lc_Form.cds_searchdescricao.AsString;
    cds_itens_nota.Post;
    FreeAndNil(Lc_Form);
  end;
end;

end.
