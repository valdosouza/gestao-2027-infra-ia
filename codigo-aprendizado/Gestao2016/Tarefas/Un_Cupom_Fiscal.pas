unit Un_Cupom_Fiscal;

interface

uses
      Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Forms, ControllerPedido, Vcl.ActnList, QEdit_Setes, Vcl.Buttons, Actions, ControllerRestaurante, tributacao, itemVenda, SetesTEF, ControllerPedidoVda, ControllerBase, ControllerCartaoEletronico, Vcl.Touch.Keyboard, ControllerCtrlLote, ControllerItensNFL, Un_Fm_MetodoPagamento, SysUtils, Vcl.DBCtrls, STQuery, Vcl.Graphics, ACBrGAV, ACBrDevice, Winapi.Windows, Winapi.Messages, ControllerPrePaidCard, ControllerPayBack;



type


  TFr_Cupom_Fiscal = class(TForm)
    pnl_Geral: TPanel;
    Pnl_Caixa: TLabel;
    Lb_FormaPagto: TLabel;
    Pnl_Botao: TPanel;
    Sb_Confirma: TSpeedButton;
    Sb_Cancelar: TSpeedButton;
    Grp_Pagamento: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    LB_TL_RECEBIDO: TLabel;
    Label1: TLabel;
    E_Vl_Pagar: TEdit_Setes;
    E_VL_Troco: TEdit_Setes;
    e_vl_recebido: TEdit_Setes;
    E_VL_Total: TEdit_Setes;
    E_M_Fisco: TMemo;
    E_M_Nota: TMemo;
    Ac_Funcoes: TActionList;
    Ac_Gaveta: TAction;
    Ac_Log: TAction;
    GroupBox1: TGroupBox;
    Sb_NovaFormaPagto: TSpeedButton;
    Sb_ResetaFormaPagto: TSpeedButton;
    Scx_Parcela: TScrollBox;
    Sb_Dividir: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_CancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sb_ConfirmaClick(Sender: TObject);
    procedure Sb_NovaFormaPagtoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure Sb_ResetaFormaPagtoClick(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sb_DividirClick(Sender: TObject);

  private
    CArtao : TControllerCartaoEletronico;
    Frame :TFm_MetodoPagamento;
    FObservacaoNFCE: String;
    procedure setFObservacaoNFCE(const Value: String);
    procedure GeraMensagemPayPack;
    procedure GeraMensagemCartaoPrePAgo;
  protected

    Bloqueio : Boolean;
    Tributacao :TTributacao;
    PedidoItems : TControllerItensNFL;
    PrePaid : TControllerPrePaidCard;
    PayBack : TControllerPayBack;
    procedure ValorExit(Sender: TObject);
    procedure OnClickFormaPagto(Sender: TObject);
    procedure Pc_Totalizar;
    procedure DividirVAlores;
    procedure RedividirValores(pIndice:Integer);
    Function ValidaPagamentoCarteira:Boolean;
  public
    It_Cd_Cliente : Integer;
    It_Usa_Imp_Checkout : Boolean;
    It_Gera_Financeiro : Boolean;
    It_Fatura_Ok : Boolean;
    It_Nr_Cupom: Integer;
    It_Cd_Pedido: Integer;
    It_Nr_Pedido: Integer;
    It_NFCe : boolean;

    It_Pizzaria : Boolean;
    //Calculo do Caixa e Financeiro
    PEdido:TControllerPedido;
    It_Cd_Quitacao : Integer;


    It_Usa_Gaveta : boolean;
    //Comissão
    It_Comissao : Boolean;
    //Impressão
    It_Linha : Integer;
    It_Traco : String;
    It_Nr_Colunas : Integer;

    It_CodigoFPagto : TStringList;
    It_Cd_Consumidor : Integer;
    //permissão para fechar tela
    Fechar : Boolean;

    ListaPedidoItem : TListaItemVenda;

    It_Ctrl_Estoque : Boolean;
    Procedure Pc_Formata_Tela;
    Procedure Pc_Inicia_Variaveis;Virtual;
    //Metodos para o Faturamento
    function ValidaPreenchimentoParcelamento:Boolean;Virtual;
    function ValidaCartaoPrePago:Boolean;
    function ValidaPayBack:Boolean;
    Function  Valida():Boolean;Virtual;
    procedure Pc_GeraItensPedido;
    Function  Fc_Faturar():Boolean;
    procedure Pc_Gera_Comissao;
    procedure GeraCreditoPayBAck;
    //Metodos para emissãoo da nota



    procedure Pc_EmiteCupomNaoFiscal;
    procedure Pc_FechaCupomNaoFiscal;//Para a opção em que cada item impresso conforme passagem no checkout
    //Metodos para o Financeiro
    Function   Fc_ValorRecebido:Real;
    procedure Pc_Gera_Financeiro;

    Function Fc_ValidaAberturaGaveta():Boolean;

    function chamarTEF:Boolean;Virtual;

    Function EfetuaPagamentoTEF(Valor:Real; Parcela:Integer;Pagto:String;NrNFCE:String):Boolean;
    procedure Pc_Executar;Virtual;
    procedure Pc_DefineObservacao;
    procedure Pc_CarregaComponenteTributacao;
    procedure Pc_CriarFrame(Pc_Metodo:String;Pc_Valor: Real;altura:integer);
    procedure GravaRestaurante;

    procedure Pc_LimpaParcelamento;

    property ObservacaoNFCE : String read FObservacaoNFCE write setFObservacaoNFCE;
  end;

var
  Fr_Cupom_Fiscal: TFr_Cupom_Fiscal;

implementation

uses     UN_Sistema, UN_Principal, env, UN_MSG, Un_DM, rn_cliente, Un_Fc_Sored_Procedures, Un_Fc_Comissao, Un_FrenteCaixa, Un_Regra_Negocio, un_Padrao, Un_Imp_Mod_Impressao, RN_Estoque, RN_NotaFiscal, RN_NotaFiscalEletronica3X, RN_Pedido, RN_Pizzaria, RI_MovimentoFinanceiro, RN_FormaPagto, RN_Financeiro, RN_PlanoContas, ControllerFinanceiro, Un_Fm_FormaPagto, Un_Funcoes, Un_TEF_ExibeMenu, Un_TEF_ObtemCampo, ControllerTefMovimento, RN_Itens_Vda_Avulso, tas_processamento, un_obtem_campo, tas_gera_nfce_autorizacao;
{$R *.dfm}


procedure TFr_Cupom_Fiscal.Pc_CriarFrame(Pc_Metodo:String;Pc_Valor: Real;altura:integer);
Var
  Lc_Indice : Integer;
begin
  Lc_Indice := It_CodigoFPagto.Count;
  Frame := TFm_MetodoPagamento.Create(Self);//Não alterar esse Self por que ele determina o owner para localizar depois
  with Frame do
  begin
    Parent := Scx_Parcela;
    Name := 'Fm_' + It_CodigoFPagto[Lc_Indice - 1];
    Tag := Lc_Indice;

    Fm_FormaPagto.Lb_FormaPagamento.Caption := It_CodigoFPagto[Lc_Indice - 1] + 'º -  Forma de Pagamento';
    //Grava esta tag para que em outro momento possa saber qual parcela estou usando.
    Fm_FormaPagto.DBLCB_FormaPagto.Tag := Lc_Indice;
    Top := 4 + (74 * (It_CodigoFPagto.Count - 1));
    Left := 3;
    Height := 75;
    Width := 526;
    Fm_FormaPagto.Pc_Listar(3,Bloqueio,It_Cd_Cliente);
    if Trim(Pc_Metodo) <> '' then
    Begin
      Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := Fc_PegaParteFormaPgto(Pc_Metodo);
      Pc_MontaListaParcelas;
    End;
    if Fm_FormaPagto.DBLCB_FormaPagto.CanFocus then
      Fm_FormaPagto.DBLCB_FormaPagto.SetFocus;
    Fm_FormaPagto.DBLCB_FormaPagto.OnClick := OnClickFormaPagto;
    E_valor.Text := FloatToStrF(Pc_Valor,ffFixed,10,2);
    E_valor.OnExit := ValorExit;
    if Lc_Indice >= 1 then
    Begin
      RedividirValores(Lc_Indice);
    End;
  end;

  Height := (74 * (It_CodigoFPagto.Count )) + Grp_Pagamento.Height + Pnl_Botao.Height + altura;//,90
  if top > 74 then
    top := top - 74;
//  repaint;
end;

Function   TFr_Cupom_Fiscal.Fc_ValorRecebido:Real;
var
  I : Integer;
  Lc_Edit: TEdit;
  variavel : TComponent;
  Lc_Valor : Real;
begin
  Try
    Result := 0;
    for I := 0 to It_CodigoFPagto.Count - 1 do
    begin
      //Encontrar os campos para pegar os valores
      variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
      //Encontra o valor a receber
      Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
      Lc_Valor := (StrToFloatDef(Lc_Edit.Text,0));
      if Lc_Valor >= 100000 then Lc_Valor := 0;
      Lc_Edit.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
      Result := Result + Lc_Valor;
    end;
  Finally

  End;

End;


procedure  TFr_Cupom_Fiscal.Pc_Gera_Financeiro;
var
  I : Integer;
  Lc_Baixa,Lc_Situacao,Lc_Etapa : String;
  Lc_LancaCaixa : boolean;
  //Novos
  Lc_Edit: TEdit;
  Lc_Valor, Lc_Vl_Troco :real;

  Lc_Dblookup : TDBLookupComboBox;
  Lc_cd_Forma_Pagto : Integer;
  Lc_Combo : TComboBox;
  Lc_Parcelas : Integer;

  variavel : TComponent;
  Lc_ContaResultado : Integer;
  Lc_CentroCusto : Integer;
  Lc_Cd_Financeiro : Integer;
  Lc_Financeiro : TControllerFinanceiro;
  MetodoPagamento : TFm_FormaPagto;
begin
  try
    Lc_Financeiro := TControllerFinanceiro.Create(nil);
    Lc_Vl_Troco := StrToFloatDef(E_VL_Troco.Text,0);
    for I := 0 to It_CodigoFPagto.Count - 1 do
    begin
      //Encontrar os campos para pegar os valores
      variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
      //Encontra o valor a receber
      Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
      Lc_Valor := (StrToFloatDef(Lc_Edit.Text,0));
      if (Lc_Valor > 0) then
      Begin
        variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
        //Encontra a forma de pagamento
        MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
        Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));
        Lc_cd_Forma_Pagto := Lc_Dblookup.KeyValue;
        if (I = 0) then
        Begin
          Tributacao.NotaFiscal.Pedido.Registro.codigo     := Tributacao.NotaFiscal.Registro.CodigoPedido;
          Tributacao.NotaFiscal.Pedido.Registro.FormaPagto := Lc_cd_Forma_Pagto;
          Tributacao.NotaFiscal.Pedido.UpdateFormaPagto;
        End;

        //Encontra o parcelamento
        Lc_Combo := TComboBox(Fc_LocalizaComponente(variavel,TComboBox));
        Lc_Parcelas := StrToIntDef( Lc_Combo.Text , 1);

        with Tributacao do
        Begin
          //trata formas de pagamento que não seráo lancados em caixa.
          Lc_LancaCaixa := False;
          Lc_Baixa := 'N';
          Lc_Situacao := 'N';
          It_Cd_Quitacao := 0;
          Lc_Etapa := 'N';
          if (Pos('DINHEIRO',Trim(Lc_Dblookup.text))>0) or
             (Pos('CHEQUE',Trim(Lc_Dblookup.text))>0) then
          Begin
            Lc_LancaCaixa := True;
            Lc_Baixa := 'N';
            Lc_Situacao := 'D';
            Lc_Etapa := 'P';
            It_Cd_Quitacao := Fc_GeraCod_BAixa;
            if (Pos('DINHEIRO',Trim(Lc_Dblookup.text))>0) then
            Begin
              Lc_Baixa := 'S';
              if (Lc_Vl_Troco > 0) then
              Begin
                if (Lc_Valor > Lc_Vl_Troco ) then
                Begin
                  Lc_Valor := Lc_Valor - Lc_Vl_Troco;
                  Lc_Vl_Troco := 0;
                End
                else
                Begin
                  Lc_Valor := Lc_Valor - (Lc_Vl_Troco/2);
                  Lc_Vl_Troco := (Lc_Vl_Troco/2)
                End;
              End;
            End;
          end
          else
          Begin
            CArtao.Registro.FormaPagamento := Lc_cd_Forma_Pagto;
            CArtao.getbyFormaPagto;
            if ( CArtao.exist ) then
            Begin
              Lc_LancaCaixa := False;
              It_Cd_Quitacao := Fc_GeraCod_BAixa;
              Lc_Baixa := 'S';
              Lc_Situacao := 'D';
              Lc_Etapa := 'P';
              Pc_LancaValorCartao(CArtao.Registro.Codigo,Lc_Valor,Lc_Parcelas,It_Cd_Quitacao,NotaFiscal.Pedido.Registro.Numero.ToString);
            end;
            if (Pos('CARTÃO PRÉ-PAGO',Lc_Dblookup.text)>0)then
            Begin
              PrePaid.Registro.Codigo           := 0;
              PrePaid.Registro.Estabelecimento  := Gb_CodMha;
              PrePaid.Registro.Terminal         := Gb_Terminal;
              //PrePaid.Registro.Numero           := 0; é digitado pelo usuario
              PrePaid.Registro.Data             := Date;
              PrePaid.Registro.ValorCredito     := 0;
              PrePaid.Registro.ValorDebito      := Lc_Valor;
              PrePaid.Registro.Historico        := Concat('Pagamento Pedido: ',NotaFiscal.Pedido.Registro.Numero.ToString);
              PrePaid.Registro.Ordem            := NotaFiscal.Pedido.Registro.Codigo;
              PrePaid.insert;
            End;

            if (Pos('PAYBACK',Lc_Dblookup.text)>0)then
            Begin
              //Lc_LancaCaixa := False; - Pensando
              {
              Retirado em 20-06/2024 por que no faturamento identificado que o pagamento é payback e não é gerado o credito - Testando
              //EXTORNO DO VALOR DESTE PAGAMENTO PARA NÃO GERAR CRÉDIO SOBRE CREDITO
              PayBack.Registro.Codigo           := 0;
              PayBack.Registro.Estabelecimento  := Gb_CodMha;
              PayBack.Registro.Terminal         := Gb_Terminal;
              PayBack.Registro.Cliente          := NotaFiscal.Pedido.Registro.Empresa;
              PayBack.Registro.Data             := Date;
              PayBack.Registro.ValorDebito      := 0;
              PayBack.Registro.ValorCredito     := (Lc_Valor * StrToFloatDef( Fc_Tb_Geral('L','PAYBACK_TAXA','0'),0))/100;
              PayBack.Registro.ValorCredito     := PayBack.Registro.ValorDebito * -1;
              PayBack.Registro.Historico        := Concat('Estorno Crédito Cedido - Pedido: ',NotaFiscal.Pedido.Registro.Numero.ToString);
              PayBack.Registro.Situacao         := 'Estornado';
              PayBack.Registro.Ordem            := NotaFiscal.Pedido.Registro.Codigo;
              PayBack.insert;
              }
              //UTILIZAÇÃO DO CRÉDITO
              PayBack.Registro.Codigo           := 0;
              PayBack.Registro.Estabelecimento  := Gb_CodMha;
              PayBack.Registro.Terminal         := Gb_Terminal;
              PayBack.Registro.Cliente          := NotaFiscal.Pedido.Registro.Empresa;
              PayBack.Registro.Data             := Date;
              PayBack.Registro.ValorCredito     := 0;
              PayBack.Registro.ValorDebito      := Lc_Valor;
              PayBack.Registro.Historico        := Concat('Utilização Crédito - Pedido: ',NotaFiscal.Pedido.Registro.Numero.ToString);
              PayBack.Registro.Ordem            := NotaFiscal.Pedido.Registro.Codigo;
              PayBack.Registro.Situacao         := 'Compensado';
              PayBack.insert;

              //Registra crédito utilizado nos registros anteriores a esta data
              PayBack.Parametros.Estabelecimento := Gb_Codmha;
              PayBack.Parametros.PayBack.Data := PayBack.Registro.Data;
              PayBack.Parametros.PayBack.Cliente := PayBack.Registro.Cliente;
              PayBack.Parametros.PayBack.ValorDebito := PayBack.Registro.ValorDebito;
              PayBack.UtilizaCredito;
            End;
          End;
          //Centro de Custo observando a forma de pagamento
          Lc_CentroCusto := Fc_PegaCentroCustoFormaPagto( Lc_cd_Forma_Pagto );
          //Conta de resultado para o Financeiro não é necessario
          Lc_ContaResultado :=  0;
          //Lanca o valor no financeiro
          with Lc_Financeiro.Registro do
          Begin
            Lc_Financeiro.Clear;
            CodigoEmpresa := NotaFiscal.Pedido.Registro.Empresa;
            DataFinanceiro := Date;
            CodigoPedido := It_Cd_Pedido;
            CodigoNota   := NotaFiscal.Registro.Codigo;
            FormaPagamento := Lc_cd_Forma_Pagto;
            PrazoPagamento := '000 - A PRAZO';
            DataVencimento := Date;
            NumeroDuplicata := IntToStr(It_Nr_Pedido) + '/' + IntToStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1);
            ValorParcela := Lc_Valor;
            NumeroParcela := 1;
            ValorJuros := 0;
            ValorMora := 0;
            ValorDesconto := 0;
            ValorPago := Lc_Valor;
            DataPagamento := Date;
            DataBaixa := DAte;
            DocumentoBaixado := Lc_Baixa;
            ContaResultado := Lc_ContaResultado;
            CentroCusto := Lc_CentroCusto;
            TipoFinanceiro := 'RA';
            SituacaoFinanceiro := Lc_Situacao;
            CodigoQuitacao := It_Cd_Quitacao;
            OperacaoFinanceiro := 'C';
            EtapaFinaceiro := Lc_Etapa;
            Estabelecimento := Gb_CodMha;
            CodigoCheque := 0;
          End;
          Lc_Financeiro.insere;
          //Lanca o valor no Caixa
          if Lc_LancaCaixa then
          Begin
            //Conta de resultado para o Financeiro não é necessario
            Lc_ContaResultado :=  Fc_PegaContaResultadoFormaPagto( Lc_cd_Forma_Pagto );

            Pc_Movim_Financeiro(DM.IB_Transacao,
                                'I',
                                0,
                                0,
                                Gb_DataCaixa,
                                0,
                                Lc_ContaResultado,
                                Lc_CentroCusto,
                                Lc_Valor,
                                0,
                                'PEDIDO Nº ' + IntToStr(It_Nr_Pedido),
                                'C',
                                It_Cd_Quitacao,
                                GB_Cd_Usuario,
                                0,
                                Gb_DataCaixa,
                                '',
                                'N',
                                'S',
                                Gb_CodMha,
                                Lc_cd_Forma_Pagto);
          End;
        end;
      end;
    end;
  finally
    FreeAndNil(Lc_Financeiro);
  end;
end;


procedure TFr_Cupom_Fiscal.Pc_EmiteCupomNaoFiscal;
Var
  Lc_Vl_Pagar,Lc_Vl_Recebido,Lc_Vl_Troco:Real;
  Lc_Tp_Impressao : Integer;
  Lc_Imp: TimpModImpressao;
Begin
  if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_FRENTE','S') = 'S') then
  Begin
    Try
      Lc_Imp := TimpModImpressao.create(Nil);
      Lc_Vl_Pagar := StrToFloatDef(E_Vl_Pagar.Text,0);
      Lc_Vl_Recebido := StrToFloatDef(e_vl_recebido.Text,0);
      Lc_Vl_Troco := StrToFloatDef(E_VL_Troco.Text,0);

      Lc_Tp_Impressao := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_IMPRESSORA','1'),1);
      case Lc_Tp_Impressao of
        0:Lc_Imp.Pc_Imp_Frt_Matricial(It_Cd_Pedido,Lc_Vl_Pagar,Lc_Vl_Recebido,Lc_Vl_Troco);
        1:Lc_Imp.Pc_Imp_Frt_Termica(It_Cd_Pedido,Lc_Vl_Pagar,Lc_Vl_Recebido,Lc_Vl_Troco);
      end;
    Finally
      FreeAndNil(Lc_Imp);
    end;
  end;
end;

procedure TFr_Cupom_Fiscal.Pc_FechaCupomNaoFiscal;
Var
  Lc_I : Integer;
  Lc_Finaliza: TextFile;
  Lc_Salto : Integer;
  Lc_Valor : Real;
  Lc_Imp: TimpModImpressao;
  //Novos
  Lc_Edit: TEdit;
  Lc_Dblookup : TDBLookupComboBox;
  Lc_cd_Forma_Pagto : Integer;
  Lc_Combo : TComboBox;
  Lc_Parcelas : Integer;

  variavel : TComponent;
  MetodoPagamento : TFm_FormaPagto;
Begin
  Try
    Lc_Imp := TimpModImpressao.create(Nil);
    Lc_Imp.It_Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', '');
    if Trim(Lc_Imp.It_Porta) = '' then Lc_Imp.It_Porta := 'LPT1';
    Lc_Imp.IT_FRow:=1;
    Lc_Imp.It_FCol:=1;
    It_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)


    AssignFile(Lc_Imp.It_Arquivo,Lc_Imp.It_Porta);
    Rewrite(Lc_Imp.It_Arquivo);
    Lc_Imp.It_FRow:=1;
    Lc_Imp.It_FCol:=1;
    It_Linha := 1;
    Lc_Imp.Pc_TextOutLC(It_Linha,1,'');
    Inc(It_Linha);

    For Lc_I:= 1 to It_Nr_Colunas do
      It_Traco := It_Traco + '-';

     // Total...
    Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(It_traco,It_Nr_Colunas));
    Inc(It_Linha);
    Lc_Imp.Pc_TextOutLC(IT_Linha,1,Lc_Imp.Pc_AlinhaE('Total Geral do Cupom',22));
    Lc_Imp.Pc_TextOutLC(It_Linha,35,Lc_Imp.Pc_AlinhaD(FormatFloat('###,###,##0.00', tributacao.NotaFiscal.Pedido.Registro.ValorPedido ),14));

    // Desconto Global
    if tributacao.NotaFiscal.Pedido.Registro.ValorDesconto > 0 then
    begin
      Inc(It_Linha);
      Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE('(-) Desconto Global',22));
      Lc_Imp.Pc_TextOutLC(It_Linha,35,Lc_Imp.Pc_AlinhaD(FormatFloat('-##,###,##0.00', tributacao.NotaFiscal.Pedido.Registro.ValorDesconto ),14));
      // Total Liquido...
      Inc(It_Linha);
      Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE('VALOR A PAGAR R$',22));
      Lc_Imp.Pc_TextOutLC(It_Linha,35,Lc_Imp.Pc_AlinhaD(FormatFloat('###,###,##0.00', tributacao.NotaFiscal.Pedido.Registro.ValorPedido ),14));
    end;

    For Lc_I := 0 to (It_CodigoFPagto.Count - 1) do
    Begin
      //Encontrar os campos para pegar os valores
      variavel := findcomponent('Fm_' + It_CodigoFPagto[Lc_I]);

      //Encontra o valor a receber
      Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
      Lc_Valor := (StrToFloatDef(Lc_Edit.Text,0));
      if (Lc_Valor > 0) then
      Begin
        variavel := findcomponent('Fm_' + It_CodigoFPagto[Lc_I]);
        //Encontra a forma de pagamento
        MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
        Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));

        Lc_cd_Forma_Pagto := Lc_Dblookup.KeyValue;
        if (UpperCase(Lc_Dblookup.Text) = 'CARTEIRA') then
        Begin
          Inc(It_Linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE('A RECEBER : ' + UpperCase(Lc_Dblookup.Text),22))
        End
        else
        Begin
          Inc(It_Linha);
          Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE('RECEBIDO EM ' + UpperCase(Lc_Dblookup.Text),22));
        End;
        Lc_Imp.Pc_TextOutLC(It_Linha,35,Lc_Imp.Pc_AlinhaD(FormatFloat('###,###,##0.00', Lc_Valor),14));
      end;
    end;


    if (StrToFloatDef(E_VL_Troco.Text,0) > 0) then
    begin
      Inc(It_Linha);
      Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE('VALOR DO TROCO R$ ',22));
      Lc_Imp.Pc_TextOutLC(It_Linha,35,Lc_Imp.Pc_AlinhaD(FormatFloat('###,###,##0.00', StrToFloatDef(E_VL_Troco.Text,0)),14));
    end;
    //Imprime dados do cliente
    if (It_Cd_Consumidor <> tributacao.NotaFiscal.Pedido.Registro.Empresa) then
    Begin
      Inc(It_Linha);
      Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(It_traco,It_Nr_Colunas));
      Inc(It_Linha);
      Lc_Imp.Pc_TextOutLC(It_Linha,1,'CLIENTE: ');
      Lc_Imp.Pc_TextOutLC(It_Linha,10,Copy(tributacao.NotaFiscal.Pedido.Empresa.Registro.NomeRazaoSocial,1,(It_Nr_Colunas-10)));
    End;
    Inc(It_Linha);
    Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaE(It_traco,It_Nr_Colunas));
    It_LInha := It_LInha + 3;
    Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC('***  SEM VALOR FISCAL  ***',It_Nr_Colunas));
    Inc(It_Linha);
    Lc_Imp.Pc_TextOutLC(It_Linha,1,Lc_Imp.Pc_AlinhaC('***  CAIXA: '+ GB_Nm_Usuario +' ***',It_Nr_Colunas));
    CloseFile(Lc_Imp.It_Arquivo);
    //Salto do Cupon
    Lc_Salto := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRETE','FRT_P_SALTO','0'), 0);
    Lc_Imp.Pc_FinalizaCupom(Lc_Salto);
    //Aciona Guilhotina
    Pc_AcionaGuilhotina(Lc_Imp.It_Porta);

  Finally
    FreeAndNil(Lc_Imp);
  end;
end;

Procedure TFr_Cupom_Fiscal.Pc_Formata_Tela;
Begin
  Pnl_Caixa.ParentColor := False;
  Pnl_Caixa.Color := clGreen;
  Pnl_Caixa.Transparent := False;
  Lb_FormaPagto.ParentColor := False;
  Lb_FormaPagto.Color := clNavy;
  Lb_FormaPagto.Transparent := False;
end;

Procedure TFr_Cupom_Fiscal.Pc_Inicia_Variaveis;
Var
  Lc_Gvta : Integer;
Begin
  It_Fatura_Ok := False;
  It_NFCe := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_VDA_NFCE', 'S') = 'S');
  //Comissao
  It_Comissao  := (Fc_Tb_Geral('L','COM_G_GERA_COM_FRT','N') = 'S');
  //Codigo do consumidors - Devera ser repassado por outra tela
  It_Cd_Consumidor := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
  //Verifica como a impressao vai acontecer (no final ou um a um)
  It_Usa_Imp_Checkout := (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_ITEM_CHECKOUT', 'N') = 'S');
  //Calculo do Caixa e Financeiro
  It_Gera_Financeiro := (Fc_Tb_Geral('L','FIN_G_ATIVAR','S') = 'S');

  It_Cd_Quitacao := 0;
  //Ativa a Gaveta de dinheiro
  Lc_Gvta := (StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_MODELO', ''),0)-1);
  It_Usa_Gaveta := False;
  if (Lc_Gvta <> 2) then
  Begin
    It_Usa_Gaveta := True;
    case Lc_Gvta of
      0:Fr_Principal.Acb_Gaveta.Modelo := gavImpressoraComum;
      1:Fr_Principal.Acb_Gaveta.Modelo := gavImpressoraECF;
      3:Fr_Principal.Acb_Gaveta.Modelo := gavSerialGerbo;
      4:Fr_Principal.Acb_Gaveta.Modelo := gavSerialMenno;
    end;
    Fr_Principal.Acb_Gaveta.Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_PORTA', '');
    Fr_Principal.Acb_Gaveta.StrComando := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_STR_ABERT', '');
    Lc_Gvta :=StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_ACA_ANTEC', ''),0)-1;
    case Lc_Gvta of
      0:Fr_Principal.Acb_Gaveta.AberturaAntecipada := aaAguardar;
      1:Fr_Principal.Acb_Gaveta.AberturaAntecipada := aaException;
      2:Fr_Principal.Acb_Gaveta.AberturaAntecipada := aaIgnorar;
    end;
  end;

  It_CodigoFPagto.Add( '1' );
  if It_Cd_Consumidor <> It_Cd_Cliente then
    Bloqueio := Fc_VerIficaBloqueioCliente(It_Cd_Cliente);
  Pc_CriarFrame('DINHEIRO',0,90);
  //Abre os dados
  Pc_CarregaComponenteTributacao;
  PEdido.Registro.Codigo := It_Cd_Pedido;
  PEdido.getbyId;

  PrePaid.clear;
  PayBack.clear;
end;

Function TFr_Cupom_Fiscal.Fc_ValidaAberturaGaveta():Boolean;
Begin
  Result := true;
  if not It_Usa_Gaveta then
  Begin
    Result := False;
    exit;
  end;
end;

procedure TFr_Cupom_Fiscal.Pc_Gera_Comissao;
Begin
  Pc_Construtor_Comissao(DM.IBT_Faturamento);
  Pc_Registra_Vdo_Pedido(DM.IBT_Faturamento, It_Cd_Pedido);
  if Fc_Tb_Geral('L','TP_COMISSAO','') ='F' then
    Begin
    Pc_Gerar_Comissao_Vda_Fat(DM.IBT_Faturamento, It_Cd_Pedido);
    Pc_Gerar_Comissao_Srv_Fat(DM.IBT_Faturamento, It_Cd_Pedido);
    Pc_Gerar_Comissao_Srv_Vdo_Fat(DM.IBT_Faturamento, It_Cd_Pedido);
    end;
  Pc_Destrutor_Comissao;
end;

procedure TFr_Cupom_Fiscal.Pc_GeraItensPedido;
var
  Lc_I: Integer;
  Lc_Estoque : String;
begin
  if ListaPedidoItem.Count  > 0 then
  Begin
    //Deleta os itens do pedio para reinseri-los
    Pedido.Itens.Registro.CodigoPedido := It_Cd_Pedido;
    Pedido.Itens.deleteByPedido;
    //Insere os itens de produto
    for Lc_I := 0 to ListaPedidoItem.Count - 1 do
    begin
      Pedido.Itens.clear;
      with Pedido.Itens.Registro do
      Begin
        CodigoPedido  := It_Cd_Pedido;
        CodigoProduto := ListaPedidoItem[Lc_I].Produto;
        Quantidade    := ListaPedidoItem[Lc_I].Quantidade;
        ValorCusto    := ListaPedidoItem[Lc_I].ValorCusto;
        ValorUnitario := ListaPedidoItem[Lc_I].ValorVenda;
        AliqDesconto  := 0;
        ValorDesconto := 0;
        AliqComissao  := 0;
        Operacao      := 'V';
        Estoque       := 'S';
        Despachar     := 'S';
        AliqIPI       := 0;
        AliqICMS      := 0;
        CodigoEstoque := Gb_Estoque;
        CodigoTabela  := 1;
        Largura       := 0;
        Altura        := 0;
        NumeroPecas   := 0;
      End;
      Pedido.Itens.insere;
      //Insere na tabela de Itens Avuldos usado na emissãoo do NFC-e
      Fc_InsereItenVdaAvulso(IntToStr(Pedido.Itens.Registro.Codigo),
                               ListaPedidoItem[Lc_I].Abreviatura,
                               ListaPedidoItem[Lc_I].Descricao);

      if It_Ctrl_Estoque then
      Begin
        Pedido.CtrlEstoque.Clear;
        with Pedido.CtrlEstoque.Registro do
        Begin
          Codigo      := 0;
          Terminal    := Gb_Terminal;
          Vinculo     := 'P';
          Ordem       := It_Cd_Pedido;
          Item        := Pedido.Itens.Registro.Codigo;
          Estoque     := Gb_Estoque;
          operacao    := 'S';
          Produto     := ListaPedidoItem[Lc_I].Produto;
          Quantidade  := ListaPedidoItem[Lc_I].Quantidade;
          Data        := Gb_DataCaixa;
          Tipo        := 'Venda';
          UpdateAt    := Now;
        End;
        Pedido.CtrlEstoque.Registra;
      end;
    end;
  End;
end;

Function  TFr_Cupom_Fiscal.Fc_Faturar():Boolean;
Var
  CtrlLote : TControllerCtrlLote;

Begin
  Try
    Result := True;
    //Calcula os impostos
    Pnl_Caixa.Caption := 'Verificando tributação...';
    Pnl_Caixa.Update;

    Tributacao.Pc_PreencheDadosDanfe;
    Pnl_Caixa.Caption := 'Gravando a venda..';
    Pnl_Caixa.Update;
    Tributacao.Pc_Pedido;
    Pnl_Caixa.Caption := 'Faturando a venda...';
    Pnl_Caixa.Update;
    Tributacao.Pc_Gera_NotaFiscal;
    //
    GeraCreditoPayBAck;
    //Mensagem para a NFC-e
    GeraMensagemPayPack;
    GeraMensagemCartaoPrePAgo;
    Tributacao.Pc_Obs_NFC_E(FObservacaoNFCE);

    Pnl_Caixa.Caption := 'Atualizando itens da venda...';
    Pnl_Caixa.Update;
    Tributacao.Pc_AtualizarItens;
    Pnl_Caixa.Caption := 'Finalizando Faturamento...';
    Pnl_Caixa.Update;

    tributacao.NotaFiscal.Pedido.Registro.Codigo := It_Cd_Pedido;
    tributacao.NotaFiscal.Pedido.Registro.Faturado := 'S';
    tributacao.NotaFiscal.Pedido.alteraStatus;

    if (Fc_Tb_Geral('L','VDA_G_LANCALOTEAUTO','S') = 'S') then
    Begin
      try
        CtrlLote := TControllerCtrlLote.Create(nil);
        CtrlLote.AplicaLotePedido(It_Cd_Pedido);
      finally
        FreeAndNil(CtrlLote);
      end;
    End;
  except
    Result := False;
  end;
end;

function TFr_Cupom_Fiscal.ValidaPagamentoCarteira: Boolean;
var
  I : Integer;
  Lc_Dblookup : TDBLookupComboBox;
  Lc_Edit : TEdit;
  Lc_Valor : Real;
  variavel : TComponent;
  MetodoPagamento : TFm_FormaPagto;
begin
  Result := True;
  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    //Encontra a forma de pagamento
    MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
    Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));
    Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
    Lc_Valor := (StrToFloatDef(Lc_Edit.Text,0));
    if (Pos('CARTEIRA',Trim(Lc_Dblookup.text))>0) then
    Begin
      if not Cliente_Valida_Limite(pedido.Registro.Empresa,pedido.Registro.FormaPagto ,Lc_Valor) then
      Begin
        Result:=FALSE;
        exit;
      end;
    End;
  end;
end;

function TFr_Cupom_Fiscal.ValidaPayBack: Boolean;
var
  I : Integer;
  Lc_Edit: TEdit;
  Lc_Valor :real;
  Lc_Dblookup : TDBLookupComboBox;
  variavel : TComponent;
  MetodoPagamento : TFm_FormaPagto;
  MR    : TModalResult ;
  Lc_Saldo : Real;
  Lc_ValorMinimo : REal;
begin
  Result := True;
  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    //Encontra a forma de pagamento
    MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
    Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));
    if (Trim(Lc_Dblookup.text) = 'PAYBACK') then
    Begin
      //Encontra o valor a receber
      Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
      Lc_Valor := StrToFloatDef(Lc_Edit.Text,0);
      PayBack.Parametros.PayBack.Estabelecimento := Gb_CodMha;
      PayBack.Parametros.PayBack.Cliente  := Tributacao.NotaFiscal.Pedido.Registro.Empresa;
      Lc_Saldo := PayBack.getSaldo;
      Lc_ValorMinimo := StrToFloatDef(Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0);
      if (Lc_ValorMinimo > Lc_Saldo  ) then
      Begin
        MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                       'Cliente não atingiu o valor Mínimo de R$ '+ FloatToStrF(Lc_ValorMinimo,ffNumber,10,2) +'.' + EOLN +
                       'O saldo atual acumulado atual é de R$ '+ FloatToStrF(Lc_Saldo,ffNumber,10,2) +'.' + EOLN +
                       'Não será possivel utilizar esta forma de pagamento.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        Result := False;
        Break;
      End;


      if (Lc_Valor > Lc_Saldo  ) then
      Begin
        MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                       'O saldo acumulado do PAYBACKE é de R$ '+ FloatToStrF(Lc_Saldo,ffNumber,10,2) +'.' + EOLN +
                       'Utilize mais de uma forma de pagamento.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        Result := False;
        Break;
      End;
    End;
  end;
end;

function TFr_Cupom_Fiscal.ValidaPreenchimentoParcelamento:Boolean;
var
  I : Integer;

  Lc_Baixa,Lc_Situacao,Lc_Etapa : String;
  Lc_LancaCaixa : boolean;
  //Novos
  Lc_Edit: TEdit;
  Lc_Valor, Lc_Vl_Troco :real;

  Lc_Dblookup : TDBLookupComboBox;
  Lc_cd_Forma_Pagto : Integer;
  Lc_Combo : TComboBox;
  Lc_Parcelas : Integer;

  variavel : TComponent;
  Lc_ContaResultado : Integer;
  Lc_CentroCusto : Integer;
  Lc_Cd_Financeiro : Integer;

  MetodoPagamento : TFm_FormaPagto;
  SemFormaPagto : Boolean;
  TemDinheiro : boolean;
  ValorDinheiro : Real;
  LcValorCalculado : Real;
begin
  Result := True;
  SemFormaPagto := True;
  TemDinheiro := False;
  ValorDinheiro := 0;
  Lc_Vl_Troco := StrToFloatDef(E_VL_Troco.Text,0);
  TRy
    for I := 0 to It_CodigoFPagto.Count - 1 do
    begin
      variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
      //Encontra a forma de pagamento
      MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
      Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));
      if (Trim(Lc_Dblookup.text) <> '') then
      Begin
        SemFormaPagto := false;
        //Encontra o valor a receber
        Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
        //VErifica o caixa aberto

        if (Pos('DINHEIRO',Trim(Lc_Dblookup.text))>0) or (Pos('CHEQUE',Trim(Lc_Dblookup.text))>0) then
        Begin
          if not Fc_VErificaCaixaAberto(True) then
          Begin
            Result := False;
            exit;
          End;
        End;
        if (Pos('DINHEIRO',Trim(Lc_Dblookup.text))>0)  then
        Begin
          TemDinheiro := True;
          ValorDinheiro := ValorDinheiro + StrToFloatDef(Lc_Edit.Text,0);
        End;
      End
      else
      Begin
        SemFormaPagto := True;
      End;
    end;
  Finally

  End;

  if SemFormaPagto then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'A forma de pagamento é campo obrigatório' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End;

  if (not TemDinheiro) and (Lc_Vl_Troco > 0 ) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'O valor do troco não pode ser maior que zero' + EOLN +
                   'quando não há DINHEIRO na forma de pagamento.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End;
  if ( Lc_Vl_Troco > ValorDinheiro ) then
  Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'O valor do troco não pode ser maior que' + EOLN +
                   'o valor do forma de pagamento em DINHEIRO.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  End;

//  LcValorCalculado := 0;
//  for I := 0 to It_CodigoFPagto.Count - 1 do
//  begin
//    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
//    //Encontra o valor a receber
//    Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
//    LcValorCalculado := LcValorCalculado  + StrToFloatDef(Lc_Edit.text,0);
//  end;

end;

Function  TFr_Cupom_Fiscal.Valida():Boolean;
Var
  Lc_Valor : Real;
  Lc_Est : String ;
Begin
  Result := True;
  Pc_Totalizar;
  Pnl_Caixa.Caption := 'Validando informações...';
  Pnl_Caixa.Update;
  if not ValidaPreenchimentoParcelamento then
  Begin
    Result := False;
    exit;
  End;

  if (It_Cd_Consumidor <> tributacao.NotaFiscal.Pedido.Registro.Empresa) then
  Begin
    if not ValidaPagamentoCarteira then
    Begin
      Result := False;
      exit;
    End;
  End;

  if PEdido.Registro.Faturado = 'N' then
  Begin
    if not ValidaCartaoPrePago then
    Begin
      Result := False;
      exit;
    End;
  End;

  Lc_Valor := StrToFloatDef(e_vl_recebido.Text,0);
  if (Lc_Valor = 0) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'O valor recebido não pode ser igual a Zero.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  Lc_Valor := StrToFloatDef(E_Vl_Pagar.Text,0);
  if (Lc_Valor > 0) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'O campo falta pagar não pode ser maior do que Zero.' + EOLN +
                   'Verifique os valores recebidos e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  Pnl_Caixa.Caption := 'Gravando os itens da Venda...';
  Pnl_Caixa.Update;

  Pc_GeraItensPedido;

  pedido.AplicarValorDescontoItens(It_Cd_Pedido,PEdido.Registro.ValorDesconto);

  //Força a gravação dos itens
  if It_NFCe then
  Begin
    IF NOT Tributacao.Fc_Valida then
    Begin
      Result := False;
      exit;
    end;    
  end
  else
  Begin
    Tributacao.Pc_Pedido;
  End;

  if (It_Cd_Consumidor <> tributacao.NotaFiscal.Pedido.Registro.Empresa) then
  Begin
    if PEdido.Registro.Faturado = 'N' then
    Begin
      if not ValidaPayBack then
      Begin
        Result := False;
        exit;
      End;
    End;
  End;

end;

function TFr_Cupom_Fiscal.ValidaCartaoPrePago: Boolean;
var
  I : Integer;
  Lc_Edit: TEdit;
  Lc_Valor :real;
  Lc_Dblookup : TDBLookupComboBox;
  variavel : TComponent;
  MetodoPagamento : TFm_FormaPagto;
  Form : TFr_ObtemCampo;
  MR    : TModalResult ;
  Lc_Saldo : Real;
begin
  Result := True;
  TRy
    Form := TFr_ObtemCampo.create(nil);

    for I := 0 to It_CodigoFPagto.Count - 1 do
    begin
      variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
      //Encontra a forma de pagamento
      MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
      Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));
      if (Pos('CARTÃO PRÉ-PAGO',Lc_Dblookup.text)>0)then
      Begin
        //Encontra o valor a receber
        try
          Self.FormStyle := fsNormal;
          Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
          Lc_Valor := StrToFloatDef(Lc_Edit.Text,0);
          form.FormStyle := fsStayOnTop;
          form.ShowModal;
          if ( form.E_Numero.Text <> '' ) then
          Begin
            PrePaid.Parametros.PrePago.Estabelecimento := Gb_CodMha;
            PrePaid.Parametros.PrePago.Numero := form.E_Numero.Text;
            PrePaid.getbyNumber;
            Lc_Saldo := PrePaid.getSaldo;
            if (Lc_Valor > Lc_Saldo  ) then
            Begin
              MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                             'Este cartão tem o Saldo de R$ '+ FloatToStrF(Lc_Saldo,ffNumber,10,2) +'.' + EOLN +
                             'Utilize mais de uma forma de pagamento.' + EOLN,
                             ['OK'], [bEscape], mpErro);
              Result := False;
              Break;
            End;
          End
          else
          BEgin
            Result := False;
            Break;
          End;
        finally
          form.FormStyle := fsNormal;
          self.FormStyle := fsStayOnTop;
        end;

      End;
    end;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TFr_Cupom_Fiscal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2 : if Self.Enabled then Sb_NovaFormaPagtoClick(Sender);
      VK_F3 : if Self.Enabled then Sb_ResetaFormaPagtoClick(Sender);
      VK_ESCAPE : if Self.Enabled then Sb_CancelarClick(Sender);
      VK_F10 : if Self.Enabled then Sb_ConfirmaClick(Sender);
    end;
  end;
end;



procedure TFr_Cupom_Fiscal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_Cupom_Fiscal.Sb_CancelarClick(Sender: TObject);
begin
  It_Fatura_Ok := False;
  Self.Close;
end;

procedure TFr_Cupom_Fiscal.GeraCreditoPayBAck;
Var
  LcTxPayBack : REal;
  variavel : TComponent;
  MetodoPagamento : TFm_FormaPagto;
  Lc_Dblookup : TDBLookupComboBox;
  Lc_Edit: TEdit;
  Lc_Valor, Lc_Vl_Troco :real;

  I:Integer;
begin
  //gerar o Credito do PayBack para poder gerar a mensagem na sequencia
  if (It_Cd_Consumidor <> tributacao.NotaFiscal.Pedido.Registro.Empresa) then
  Begin
    LcTxPayBack := StrToFloatDef(Fc_Tb_Geral('L','PAYBACK_TAXA','0'),0);
    if ( LcTxPayBack > 0 ) then
    Begin
      Lc_Vl_Troco := StrToFloatDef(E_VL_Troco.Text,0);
      for I := 0 to It_CodigoFPagto.Count - 1 do
      begin
        variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
        //Encontra a forma de pagamento
        MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
        Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));
        //Diferente de Pre-Pago
        if (Pos('PAYBACK',Lc_Dblookup.text)=0)then
        Begin
          variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
          //Encontra o valor a receber
          Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
          Lc_Valor := StrToFloatDef(Lc_Edit.Text,0);
          if (Pos('DINHEIRO',Trim(Lc_Dblookup.text))>0) then
          Begin
            if Lc_Vl_Troco > 0 then
            Begin
              {para casos em que é informado com 2 ou mais parcelas em dinheiro e que tem troco
              Então precisamos tirar o valor do troco e zera-lo para que seja feito apenas uma vez}
              Lc_Valor := Lc_Valor - Lc_Vl_Troco;
              Lc_Vl_Troco := 0;
            End;
          End;
          Lc_Valor := (Lc_Valor * LcTxPayBack) / 100;
          if Lc_Valor > 0 then
          Begin
            PayBack.Registro.Codigo           := 0;
            PayBack.Registro.Estabelecimento  := Gb_CodMha;
            PayBack.Registro.Terminal        := Gb_Terminal;
            PayBack.Registro.Cliente         :=  Tributacao.NotaFiscal.Pedido.Registro.Empresa;
            PayBack.Registro.Data             := Date;
            PayBack.Registro.ValorCredito     := Lc_Valor;
            PayBack.Registro.ValorDebito      := 0;
            PayBack.Registro.Historico        := Concat('Crédito Pedido: ',Tributacao.NotaFiscal.Pedido.Registro.Numero.ToString );
            PayBack.Registro.Ordem            := Tributacao.NotaFiscal.Pedido.Registro.Codigo ;
            PayBack.insert;
          End;
        End;
      end;
    End;
  End;
end;

procedure TFr_Cupom_Fiscal.GeraMensagemCartaoPrePAgo;
Var
  lCPrepago : TControllerPrePaidCard;
  Lc_SaldoPrePago : Real;
  Lc_ObsPrePago : String;
begin
  if (It_Cd_Consumidor <> It_Cd_Cliente) then
  Begin
    Pedido.Empresa.Registro.Codigo := It_Cd_Cliente;
    Pedido.Empresa.getById;
    //PROGRAMA CARTÃO PRE-PAGO
    try
      lCPrepago := TControllerPrePaidCard.Create(nil);
      lCPrepago.Parametros.PrePago.Estabelecimento := Gb_CodMha;
      lCPrepago.Parametros.PrePago.Numero := Pedido.Empresa.Registro.CpfCNPJ;
      Lc_SaldoPrePago := lCPrepago.getSaldo;
      Lc_ObsPrePago := '';
      if (Lc_SaldoPrePago > 0  ) then
      Begin
        Lc_ObsPrePago := concat('Cartão pre-pago',#13,
                                'Saldo de R$ '+ FloatToStrF(Lc_SaldoPrePago,ffFixed,10,2) );

        if trim(Lc_ObsPrePago)<> '' then
        Begin
          Self.ObservacaoNFCE := concat(Self.ObservacaoNFCE,#13,Lc_ObsPrePago);
        End;
      End;
    finally
      FreeAndNil(lCPrepago);
    end;
  End;
end;

procedure TFr_Cupom_Fiscal.GeraMensagemPayPack;
Var
  LcPayBackTaxa: REal;
  LcPayBackMinimo : REal;
  LcPayBackAcumul : REal;
  LcPayBack : TControllerPayBack;
  LcUsouPayPack : Boolean;
  lcValorPayBAck : Real;
  LcObsPayBack : String;
begin
  if (It_Cd_Consumidor <> It_Cd_Cliente) then
  Begin
    Pedido.Empresa.Registro.Codigo := It_Cd_Cliente;
    Pedido.Empresa.getById;
    //PROGRAMA PAYBACK
    if ( Fc_Tb_Geral('L','PAYBACK_IMP_CREDIT','S') = 'S') then
    Begin
      LcObsPayBack := '';
      LcPayBackTaxa   := StrToFloatDef(Fc_Tb_Geral('L','PAYBACK_TAXA','0'),0);
      if (  LcPayBackTaxa > 0 ) then
      Begin
        Try
          LcPayBack := TControllerPayBack.Create(nil);
          LcPayBackMinimo := StrToFloatDef( Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0);
          LcPayBack.Parametros.Periodo := False;
          LcPayBack.Parametros.PayBack.Cliente := Pedido.Empresa.Registro.Codigo;
          LcPayBack.Parametros.PayBack.estabelecimento := Gb_CodMha;
          LcPayBack.Parametros.PayBack.Ordem := 0;
          LcPayBackAcumul := LcPayBack.getSaldo;
          LcObsPayBack := concat(Fc_Tb_Geral('L','PAYBACK_TITTLE','0'),#13,
                                 concat('A cada compra voce pode ganhar ', FloatToStrF(LcPayBackTaxa,ffFixed,10,1) ,'% de retorno'),#13,
                                 concat('Juntando um valor minimo de R$ ', FloatToStrF(LcPayBackMinimo,ffFixed,10,2)),#13,
                                 'Voce pode utilizar como desconto da sua ',#13,
                                 'proxima compra com a gente',#13,
                                 concat('Saldo de R$ '+ FloatToStrF(LcPayBackAcumul,ffFixed,10,2))
          );

          if trim(LcObsPayBack)<> '' then
          Begin
            Self.ObservacaoNFCE := concat(Self.ObservacaoNFCE,#13,LcObsPayBack);
          End;
        Finally
          FreeAndNil(LcPayBack);
        End;
      End;
    End;
  End;
end;

procedure TFr_Cupom_Fiscal.GravaRestaurante;
Var
  Lc_Restaurante : TControllerRestaurante;
Begin
  Try
    Lc_Restaurante := TControllerRestaurante.Create(nil);
    with Lc_Restaurante.Registro do
    Begin
      CodigoPedido := Self.It_Cd_Pedido;
      CodigoEstabelecimento := Gb_CodMha;
      Lc_Restaurante.getbyId;
      ValorRecebido := StrToFloatDef(e_vl_recebido.Text,0);
      ValorTroco  := StrToFloatDef(E_VL_Troco.Text,0);
      Lc_Restaurante.Salva;
    End;
  Finally
    FreeAndNil(Lc_Restaurante);
  End;
End;

procedure TFr_Cupom_Fiscal.OnClickFormaPagto(Sender: TObject);
Var
  variavel : TComponent;
  LcFormaPagto : TFm_FormaPagto;
  Lc_Edit: TEdit;
  LcNameParent : String;
  Lc_Vl_total : Real;
  I : integer;
  Lc_SaldoPaybak : REal;
  Lc_Indice : Integer;
begin
  Lc_Indice := TDBLookupComboBox(Sender).Tag;

  if ( pos('CARTAO',TDBLookupComboBox(Sender).Text) > 0 ) OR
     ( pos('CARTÃO',TDBLookupComboBox(Sender).Text) > 0 )then
  Begin
    if Lc_Indice = 1 then
    Begin
      Lc_Vl_total := StrToFloatDef(E_VL_Total.Text,0);
      variavel := findcomponent(concat('fm_',InttoStr( Lc_Indice )));
      Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
      Lc_Edit.Text := FloatToStrF(Lc_Vl_total,ffFixed,10,2);
      Self.Pc_Totalizar;
    End;
  End;

  if ( pos('PAYBACK',TDBLookupComboBox(Sender).Text) > 0 ) then
  Begin
    PayBack.Parametros.Estabelecimento := Gb_CodMha;
    PayBack.Parametros.PayBack.Cliente  := Tributacao.NotaFiscal.Pedido.Registro.Empresa;

    variavel := findcomponent(concat('fm_',InttoStr( Lc_Indice )));
    Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
    Lc_Edit.Text := '0,00';
    Lc_SaldoPaybak := PayBack.getSaldo;
    if (Lc_SaldoPaybak > 0)then
    Begin
      Lc_Edit.Text := FloatToStrF(Lc_SaldoPaybak,ffFixed,10,2);
      Self.Pc_Totalizar;
    End;
  End;
end;

function TFr_Cupom_Fiscal.chamarTEF:Boolean;
var
  I : Integer;
  //Novos
  Lc_Edit: TEdit;
  Lc_Valor :real;
  Lc_Dblookup : TDBLookupComboBox;
  Lc_cd_Forma_Pagto : Integer;
  Lc_Combo : TComboBox;
  variavel : TComponent;
  MetodoPagamento : TFm_FormaPagto;
  Lc_PagtoNFCe : String;
  Lc_TEF : Boolean;
begin
  Result := True;
  if Assigned(Fr_FrenteCaixa) then
  BEgin
    Fr_FrenteCaixa.mm_Tef.Clear;
    if Fr_FrenteCaixa.TEF_Ativo  then
    Begin
      Fr_FrenteCaixa.IndiceTransacaoTef     := -1;
      Fr_FrenteCaixa.estadoSimuladoEcf := tpsVenda;
      for I := 0 to It_CodigoFPagto.Count - 1 do
      begin
       //Encontrar os campos para pegar os valores
        variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
        //Encontra a forma de pagamento
        MetodoPagamento := TFm_FormaPagto(Fc_LocalizaComponente(variavel,TFm_FormaPagto));
        Lc_Dblookup := TDBLookupComboBox(Fc_LocalizaComponente(MetodoPagamento,TDBLookupComboBox));
        Lc_PagtoNFCe := Lc_Dblookup.ListSource.DataSet.FieldByName('FPT_TIPO_NFCE').AsString;
        Lc_TEF := (Lc_Dblookup.ListSource.DataSet.FieldByName('FPT_TEF').AsString = 'S');
        //Verifica
        if Lc_TEF then
        Begin
          //Encontra o valor a receber
          Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
          Lc_Valor := (StrToFloatDef(Lc_Edit.Text,0));
          Fr_FrenteCaixa.TEFformapagto := UpperCase(Lc_Dblookup.Text);
          Result := EfetuaPagamentoTEF(Lc_Valor,I, Lc_PagtoNFCe, IntToStr( It_Cd_Pedido ));
          if Not Result then
          Begin
            Fr_FrenteCaixa.mm_Tef.Lines.Add('Operação abortada');
            break;
          End;
        End;

      end;
      Fr_FrenteCaixa.Tef.ImprimirTransacoesPendentes;
      Fr_FrenteCaixa.estadoSimuladoEcf := tpsLivre;
    End;
  End;
End;

procedure TFr_Cupom_Fiscal.DividirVAlores;
var
  I : Integer;
  Lc_Edit: TEdit;
  variavel : TComponent;
  Lc_Valor : Real;
  Lc_Vl_total : Real;
  Lc_VL_Parcela : Real;
  Lc_St_Parcela : String;
  Lc_Nr_Parcelas : Integer;

begin
  Lc_Nr_Parcelas := It_CodigoFPagto.Count;
  if ( It_CodigoFPagto.Count > 1) then
  Begin
    Lc_Vl_total := StrToFloatDef(E_VL_Total.Text,0);
    Lc_Vl_Parcela := ( Lc_Vl_total / Lc_Nr_Parcelas );
    Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela, ffFixed, 10, 2);
    Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
    for I := 1 to Lc_Nr_Parcelas do
    Begin
      IF ( I = Lc_Nr_Parcelas ) THEN
      Begin
        Lc_Vl_Parcela := Lc_Vl_total -  (Lc_Vl_Parcela * (Lc_Nr_Parcelas - 1));
        Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
      end
      else
      Begin
        Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
      end;
      variavel := findcomponent(concat('fm_',InttoStr(I)));
      Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
      Lc_Edit.Text := Lc_St_Parcela;
    End;
    Pc_Totalizar;
  End;
end;

function TFr_Cupom_Fiscal.EfetuaPagamentoTEF(Valor: Real;Parcela:Integer;Pagto:String;  NrNFCE: String): Boolean;var StatusTransacao : Boolean;
  CtrlTEF : TControllerTefMovimento;
begin
  Result := True;
  if Assigned(Fr_FrenteCaixa) then
  BEgin
    try
      //Inicia a Gravação da operação
      CtrlTEF := TControllerTefMovimento.Create(nil);
      CtrlTEF.Clear;
      CtrlTEF.Registro.CodigoPedido := It_Cd_Pedido ;
      CtrlTEF.Registro.Estabelecimento := Gb_CodMha;
      CtrlTEF.Registro.Parcela := Parcela;
      CtrlTEF.Registro.Usuario := GB_Cd_Usuario;
      CtrlTEF.Registro.status := 'I';
      CtrlTEF.insert;
      //Efetua a operação
      StatusTransacao := Fr_FrenteCaixa.TEF.tef.CRT( Valor , Pagto, trim(NrNFCE));

      if StatusTransacao then
      begin
        Inc(Fr_FrenteCaixa.IndiceTransacaoTef);
        if not(Fr_FrenteCaixa.TEF.AutoFinalizarCupom) then
        Begin
          CtrlTEF.Registro.CRT := Fr_FrenteCaixa.TEF.RespostasPendentes[Fr_FrenteCaixa.IndiceTransacaoTef].ID;
          CtrlTEF.Registro.DocumentoVinculado := Fr_FrenteCaixa.TEF.RespostasPendentes[Fr_FrenteCaixa.IndiceTransacaoTef].DocumentoVinculado;
          CtrlTEF.Registro.ValorTotal := Fr_FrenteCaixa.TEF.RespostasPendentes[Fr_FrenteCaixa.IndiceTransacaoTef].ValorTotal ;
          CtrlTEF.Registro.Rede := Fr_FrenteCaixa.TEF.RespostasPendentes[Fr_FrenteCaixa.IndiceTransacaoTef].Rede;
          CtrlTEF.Registro.NSU := Fr_FrenteCaixa.TEF.RespostasPendentes[Fr_FrenteCaixa.IndiceTransacaoTef].NSU;
          CtrlTEF.Registro.DataHora := Fr_FrenteCaixa.TEF.RespostasPendentes[Fr_FrenteCaixa.IndiceTransacaoTef].DataHoraTransacaoHost;
          CtrlTEF.Registro.Instituicao := StrToIntDef( Fr_FrenteCaixa.TEF.RespostasPendentes[Fr_FrenteCaixa.IndiceTransacaoTef].Instituicao,0);
          CtrlTEF.Registro.Campo11 := Copy(Fr_FrenteCaixa.TEF.RespostasPendentes[Fr_FrenteCaixa.IndiceTransacaoTef].LeInformacao(11,0).AsString,1,100) ;
        End;
        //Application.MessageBox('Transação aprovada, Favor Travar o dados do comprovante', 'Informação', MB_OK + MB_ICONINFORMATION);
      end
      else
      begin
        Fr_FrenteCaixa.mm_Tef.Lines.Add('Transação Negada');
        Application.MessageBox('Transação Negada', 'Informação', MB_OK + MB_ICONWARNING);
        Result := False;
        Exit;
      end;
      //TErmina da gravação da Operação
      CtrlTEF.Registro.status := 'T';
      CtrlTEF.update;
    finally
      FreeAndNil(CtrlTEF);
    end;
  End;
end;

procedure TFr_Cupom_Fiscal.ValorExit(Sender: TObject);
begin
  Pc_Totalizar;
  //Recalcula as Parclas
  // e_Valor -> Pnl_Valor -> Panel1 -> fm_
  if ( TForm(Sender).Name <> Self.Name) then
    if It_CodigoFPagto.Count > 1 then
    BEgin
      RedividirValores(TEdit(Sender).Parent.Parent.parent.Tag);
      Pc_Totalizar;
    End;
end;

procedure TFr_Cupom_Fiscal.Pc_executar;
Var
  Lc_ResTEF : Boolean;
  Lc_Pedido : TControllerPedidoVda;
  Lc_Form : TTasGeraNfceautorizacao;
Begin
  Lc_ResTEF := chamarTEF;
  if not Lc_ResTEF then
  Begin
    exit;
  End;
  It_Fatura_Ok := Fc_Faturar;
  if It_Fatura_Ok then
  Begin
    //Geração do Financeiro
    Pc_Gera_Financeiro;
    //Caso seja pizzaria gravar o registro de controle de entrega
    if It_Pizzaria then
    Begin
      try
        Lc_Pedido := TControllerPedidoVda.create(nil);
        Lc_Pedido.Registro.Codigo := self.It_Cd_Pedido;
        Lc_Pedido.SaveAddressDelivery;
      finally
        FreeAndNil(Lc_Pedido);
      end;
    End;
    //Esta sendo usado para todos os tipo de de venda para registrar valor recebido e troco
    GravaRestaurante;
    //Geração de Comissão no faturamento
    if It_Comissao then Pc_Gera_Comissao;
    Pnl_Caixa.Caption := 'Iniciando Impressão...';
    Pnl_Caixa.Update;
    Lc_Form := TTasGeraNfceautorizacao.Create(Self);
    try
      Self.FormStyle := fsNormal;
      Self.Update;
      TRy
        Lc_Form.It_Cd_Pedido      := It_Cd_Pedido;
        Lc_Form.It_cd_Cliente     := Tributacao.NotaFiscal.Pedido.Registro.Empresa;
        Lc_Form.It_cd_Consumidor  := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
        Lc_Form.It_Cd_Nota        := Tributacao.NotaFiscal.Registro.Codigo;
        Lc_Form.It_Nr_Nota        := 0;
        Lc_Form.It_Nf_Terceiro    := FAlse;
        Lc_Form.ValorRecebido     := StrToFloatDef(e_vl_recebido.Text,0);
        Lc_Form.ValorTroco        := StrToFloatDef(E_VL_Troco.Text,0);

        //Operação Normal
        Pc_CarregaDadosEmitente(true);
        Lc_Form.TipoOperacao := 'NFC-e';
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
    if Fc_ValidaAberturaGaveta then
    BEgin
      Pc_AbreGaveta;
    End;
    Fechar := True;
  end;
end;

procedure TFr_Cupom_Fiscal.Pc_Totalizar;
Var
  Lc_VL_total:Real;
  Lc_Vl_Recebido :Real;
  Lc_Vl_Pagar : Real;
  Lc_VL_Troco : Real;
Begin
  Lc_Vl_Recebido := Fc_ValorRecebido;
  E_vl_recebido.Text := FloatToStrF( Lc_Vl_Recebido,ffFixed,10,2);
  Lc_VL_total := StrToFloatDef(E_VL_Total.Text,0);
  //Verifica Valor a Pagar
  Lc_Vl_Pagar := Lc_VL_total - Lc_Vl_Recebido;
  if Lc_Vl_Pagar > 0 then
    E_Vl_Pagar.Text := FloatToStrF( Lc_Vl_Pagar,ffFixed,10,2)
  else
    E_Vl_Pagar.Text := '0,00';
  //Verifica TRoco
  Lc_VL_Troco := Lc_Vl_Recebido - Lc_VL_total;
  if Lc_VL_Troco > 0 then
    E_VL_Troco.Text := FloatToStrF( Lc_VL_Troco,ffFixed,10,2)
  else
    E_VL_Troco.Text := '0,00';
end;

procedure TFr_Cupom_Fiscal.RedividirValores(pIndice: Integer);
var
  I : Integer;
  Lc_Edit: TEdit;
  variavel : TComponent;
  Lc_VL_Parcela_Anterior:Real;
  Lc_Valor : Real;
  Lc_Vl_total : Real;
  Lc_VL_Parcela : Real;
  Lc_St_Parcela : String;
  Lc_Nr_Parcelas : Integer;

begin
  //PEga PArcela Anterior;
  Lc_VL_Parcela_Anterior := 0;
  for I := 1 to pIndice do
  Begin
    variavel := findcomponent(concat('fm_',InttoStr(I)));
    Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
    Lc_VL_Parcela_Anterior := Lc_VL_Parcela_Anterior + StrToFloatDef(Lc_Edit.Text,0);

  End;
  Lc_Vl_total := StrToFloatDef(E_VL_Total.Text,0) - Lc_VL_Parcela_Anterior;
  if (Lc_Vl_total > 0) and (Lc_VL_Parcela_Anterior > 0) then
  Begin
    //Inicio a partir do proximo indice
    Lc_Nr_Parcelas := It_CodigoFPagto.Count - pIndice;
    pIndice := pIndice + 1;
    if Lc_Nr_Parcelas >= 1  then
    Begin
      Lc_Vl_Parcela := Lc_Vl_total / Lc_Nr_Parcelas;
      Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela, ffFixed, 10, 2);
      Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
      for I := pIndice to It_CodigoFPagto.Count do
      Begin
        IF ( I = Lc_Nr_Parcelas ) THEN
        Begin
          Lc_Vl_Parcela := Lc_Vl_total -  (Lc_Vl_Parcela * (Lc_Nr_Parcelas - 1));
          Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
        end
        else
        Begin
          Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
        end;
        variavel := findcomponent(concat('fm_',InttoStr(I)));
        Lc_Edit := TEdit(Fc_LocalizaComponente(variavel,TEdit));
        Lc_Edit.Text := Lc_St_Parcela;
      End;
    End;
  End;
end;

procedure TFr_Cupom_Fiscal.Pc_DefineObservacao;
Var
  Lc_Observacao : TMemo;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  I  : Integer;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_Observacao:= TMemo.Create(Self);
      Lc_Observacao.Parent:= Self;
      Lc_Observacao.Visible:=FALSE;
      Lc_Observacao.Width := 640;
      Lc_Observacao.Height := 90;
      Lc_Observacao.Top := 0;
      Lc_Observacao.Left := 0;
      Lc_Observacao.Lines.Clear;
      //Observação do Cadastro de observações
      SQL.Add(concat(
                   'SELECT DISTINCT OBS_CODIGO, OBS_DETALHES ',
                   'FROM TB_OBSERVACAO tb_observacao         ',
                   'WHERE (OBS_GERAL = ''4'')                ',
                   ' AND (OBS_CODMHA =:OBS_CODMHA)           '
          ));
      ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      First;
      while not Eof do
      begin
        //Registra a Observação
        Lc_Observacao.Lines.Add(FieldByname('OBS_DETALHES').AsString);
        Next;
      end;
    end;
    E_M_Nota.clear;
    if Lc_Observacao.Lines.Count > 0 then
    Begin
      for I := 0 to Lc_Observacao.Lines.Count -1 do
        E_M_Nota.Lines.Add(Lc_Observacao.Lines[I] );
    End;
  finally
    FreeAndNil(Lc_Observacao);
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  end;
end;


procedure TFr_Cupom_Fiscal.FormShow(Sender: TObject);
begin
  Pc_Formata_Tela;
  Pc_Totalizar;
  Pc_Inicia_Variaveis;
end;



procedure TFr_Cupom_Fiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(ListaPedidoItem); //- É PASSADO POR REFERENCIA E DEVE SER LIBERADO NO FORM ANTERIOR
  FreeAndNil(It_CodigoFPagto);
  FreeAndNil(Tributacao);
  FreeAndNil(PrePaid);
  FreeAndNil(PayBack);
  FreeAndNil(PEdido);
  FreeAndNil(CArtao);
end;

procedure TFr_Cupom_Fiscal.FormCreate(Sender: TObject);
begin
  Tributacao      := ttributacao.create(Self);

  It_CodigoFPagto := TStringList.Create;
  ListaPedidoItem := TListaItemVenda.Create;
  PrePaid         := TControllerPrePaidCard.Create(Self);
  PayBack         := TControllerPayBack.Create(Self);
  PEdido          := TControllerPedido.create(Self);
  CArtao          := TControllerCartaoEletronico.create(Self);
end;

procedure TFr_Cupom_Fiscal.Pc_CarregaComponenteTributacao;
Begin
  with Tributacao do
  Begin
    estabelecimento.Registro.Codigo := Gb_CodMha;
    NotaFiscal.Pedido.Registro.Codigo := Self.It_Cd_Pedido;
    NotaFiscal.Clear;
    with NotaFiscal.Registro do
    Begin
      CodigoEstabelecimento := Gb_CodMha;
      CodigoPedido :=  Self.It_Cd_Pedido;
      if Fc_VerificaFormularioDisponivel('Fr_Pizzaria') then
      Begin
        DataEmissao := Gb_DataCaixa;
        DataSaida   := Gb_DataCaixa
      End
      else
      Begin
        DataEmissao := Date;
        DataSaida := Date;
      End;
      Finalidade := '1';
      CodigoTransportadora := 0;
      ContaFrete := 1;
     End;

    it_ECF := True;
    It_AutorizacaoNFE := It_NFCe;
    It_AutorizacaoNFCE := It_NFCe;
    It_AutorizacaoNFSE := False;
    it_SomaIPI_Bs_ICMS := False;
    It_SomaIPI_Bs_ICMS_St := False;
    It_RevendaCarro := False;
    It_Sentido := 'S';
    It_Tipo_OPer := 'V';
    It_Aq_Cred_Icms := StrtoFloatDef(Fc_Tb_Geral('L','GRL_G_AQ_CRED_ICMS','0'),0);
    It_Decreto108352014 :=(Fc_Tb_Geral('L','GRL_G_DECRETO108352014','N') = 'S');
    Tributacao.Pc_CriaConsultas;
    Tributacao.Pc_Pedido;
    with It_Nfe.NotasFiscais[0].NFe do
    Begin
      //Valor do Frete
      Total.ICMSTot.vFrete := Tributacao.NotaFiscal.Pedido.Registro.ValorFrete;
      //Valor do Seguro
      Total.ICMSTot.vSeg := 0;
      //Valor das outras despesas
      Total.ICMSTot.vOutro := Tributacao.NotaFiscal.Pedido.Registro.ValorOutrasDEspesas;
    end;
    It_Qt_Produto := 0;
    It_Especie := 'VOLUME';
    It_PesoBruto := '';
    It_PesoLiquido := '';
    It_PlacaVeiculo := '';
    It_Uf_Veiculo := '';
    It_RNTC := '';
    It_Marca := '';
    It_Volume := '';
    It_Despachar := Fc_Tb_Geral('L','DSP_G_CTRL_DESPACHO','N');
  end;
end;



procedure TFr_Cupom_Fiscal.Sb_ConfirmaClick(Sender: TObject);
begin
  Fechar := False;
  if Valida then
  Begin
    try
      Self.Enabled := False;
      Pc_ProcesoAguarde(Self,'I');
      Self.FormStyle := fsNormal;
      Self.Update;
      Pc_Executar;
    finally
      Pc_ProcesoAguarde(Self,'F');
      Self.Enabled := True;
      Self.FormStyle := fsStayOnTop;
      Self.Update;
      if Fechar then Self.Close;
    end;
  end;
end;

procedure TFr_Cupom_Fiscal.Sb_DividirClick(Sender: TObject);
begin
  DividirVAlores;
end;

procedure TFr_Cupom_Fiscal.Sb_NovaFormaPagtoClick(Sender: TObject);
begin
  if ( It_CodigoFPagto.Count < 6 ) then
  Begin
    It_CodigoFPagto.Add( IntToStr( It_CodigoFPagto.Count + 1 ) );
    Pc_CriarFrame('',0,90);
    Sb_Dividir.Visible := (It_CodigoFPagto.Count > 1);
  End
  else
  Begin
    MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                   'O número máximo de Formas de pagamento foi atingido.' + EOLN +
                   'Não é possivel continuar.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  End;
end;

procedure TFr_Cupom_Fiscal.Pc_LimpaParcelamento;
var
  I : Integer;
  variavel : TComponent;
begin
  for I := 0 to It_CodigoFPagto.Count - 1 do
  begin
    //Encontrar o frame
    variavel := findcomponent('Fm_' + It_CodigoFPagto[I]);
    //Limpa o Frame
    FreeAndNil(variavel);
  end;
  //Limpa o controlador de quantidade de parcelas
  It_CodigoFPagto.Clear;
end;

procedure TFr_Cupom_Fiscal.Sb_ResetaFormaPagtoClick(Sender: TObject);
begin
  Pc_LimpaParcelamento;
  It_CodigoFPagto.Add( '1' );
  Pc_CriarFrame('DINHEIRO',0,90);
end;

procedure TFr_Cupom_Fiscal.setFObservacaoNFCE(const Value: String);
begin
  FObservacaoNFCE := Value;
end;

end.


