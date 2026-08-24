unit Un_Imp_Mod_Impressao;

interface

uses
      UN_NF, Un_Msg, QuickRpt, QRPDFFilt, BematechPrint, System.Math, Classes, STQuery, Vcl.Dialogs, Vcl.Printers, Vcl.StdCtrls, AnsiStrings, SysUtils, UITypes, Vcl.Forms, Vcl.Graphics, Winapi.Windows, Winapi.WinSpool, Data.DB, prmComissao;

type

  TImpModImpressao = Class(TComponent)
  private
    Qr_Pedido : TSTQuery;
    Qr_Itens : TSTQuery;
    Qr_Lote : TSTQuery;
    Qr_Cotacao: TSTQuery;
    Qr_Parcelamento : TSTQuery;
    Qr_Financeiro : TSTQuery;
    Qr_Empresas : TSTQuery;
    QR_Ordem: TSTQuery;
    Qr_ItensSrv: TSTQuery;
    Qr_Tecnico: TSTQuery;
    Qr_Vendedor: TSTQuery;
    Qr_Conserto: TSTQuery;
    FCodigoConsumidor: Integer;
    FNomePDF: String;
    FSalvaPDF: Boolean;
    FCodigoPedido: Integer;
    procedure  Print(Qrpt: TQuickRep);
    procedure setFCodigoConsumidor(const Value: Integer);
    procedure setFNomePDF(const Value: String);
    procedure setFSalvaPDF(const Value: Boolean);
    procedure setFCodigoPedido(const Value: Integer);


  public
    It_data:string;
    it_Traco130, it_Traco115: String;
    it_cd_orc : Integer;
    NomeImpressora : String;
  //  it_texto:string;
    it_vl_credito:Currency;
    It_Tp_Doc:string;
    It_Vl_Devedor, It_Vl_Chq_DEv, It_Vl_Chq_Pre: Real;
    //Componentes de Consutla
    It_Linha: Integer;
    It_LcLinha: Integer;
    It_LcColuna: Integer;
    It_LcParcela: String;

    //Manipular a Impressora na caixa de Dialogo
    It_Arquivo: TextFile;
    It_Porta : String;
    It_FCol,
    It_FRow:LongInt;

    It_Imp_Atual : Integer;
    It_Dial_Imp : TPrintDialog;
    //Compoenente de Impressão
    It_Observacao : TMemo;
    it_Modelo_jatolaser, it_Modelo_matricial, it_Modelo_Termica:integer;
    it_Tp_Impressora:integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ImprimeProgramaPayBack(ColunaImpressao:Integer; CodigoCliente:Integer):TStringList;
    function ImprimeProgramaCartaoPrePago(ColunaImpressao:Integer; CodigoCliente:Integer):TStringList;

    Function Fc_ChamaImpressora:Boolean;
    Function Fc_Parcelamento(Fc_Tipo:String):String;
    Procedure Pc_TextOutLC(nRow,nCol:LongInt;Text:String);
    Procedure Pc_FinalizaCupom(Pc_Linhas:Integer);
    function Pc_AlinhaD(Texto : String; Tamanho : Integer) : String;
    function Pc_AlinhaC(Texto : String; Tamanho : integer) : String;
    function Pc_AlinhaE(Texto : String; Tamanho : Integer) : String;


    procedure Pc_AbreDadosPedido;
    procedure Pc_AbreDadosParcelamento;
    procedure Pc_AbreDadosFinanceiro;
    procedure Pc_AbreDadosOrdem(Tipo:String);

    procedure Pc_OrcamentoBobina;
    function Fc_VerificaOrdemServico:Boolean;
    function Fc_VerificaServico:Boolean;
    procedure Pc_DadosPedido(Pc_Tipo:integer);
    function Fc_VerificaConserto:Boolean;
    procedure Pc_Imp_Tipo(Pc_TipoPed:integer; Pc_cd_Pedido,Pc_cd_Nota:integer);
    procedure Pc_Save_Tipo(Pc_TipoPed:integer; Pc_cd_Pedido,Pc_cd_Nota:integer);
    procedure Pc_Coluna(Pc_Registro: Integer);
    procedure Pc_Historico;

    Procedure Pc_Rodape_RdPrint;
    Procedure Pc_Cabecalho_RdPrint;
  //  Procedure Ativa_Tabela_Pedido(Pc_Cd_Select:integer);
    ///////////////////////////
    procedure Pc_Imp_ContultaOrcamento;

    //Imprime Ajuste
    procedure Pc_Imp_Ajt(Fc_cd_Pedido,Fc_Cd_Nota:integer);

    procedure Pc_Imp_Ajt_Matricial;
    procedure Pc_Imp_Ajt_Matricial_1;

    procedure Pc_Imp_Ajt_JatoLaser;
    procedure Pc_Imp_Ajt_JatoLaser_1;

    //Imprime Compra
    procedure Pc_Imp_Cpa(Fc_cd_Pedido,Fc_Cd_Nota:integer);

    procedure Pc_Imp_Cpa_Matricial;
    procedure Pc_Imp_Cpa_Matricial_1;

    procedure Pc_Imp_Cpa_JatoLaser;
    procedure Pc_Imp_Cpa_JatoLaser_1;
    procedure Pc_Imp_Cpa_JatoLaser_2;
    procedure Pc_Imp_Cpa_JatoLaser_3;

    function Fc_BuscaLote(CodigoViculo : Integer):String;

    //Imprime Vendas
    procedure Pc_Imp_Vda(Fc_cd_Pedido,Fc_Cd_Nota:integer);

    procedure Pc_Imp_Cupom;
    procedure Pc_Imp_Cupom_Pedido_1;//Cupom para cliente - Matricial
    procedure Pc_Imp_Cupom_Pedido_2;//Cupom para cliente - Matricial
    procedure Pc_Imp_Cupom_Pedido_3;//Cupom para cliente - Matricial - KAroli
    procedure Pc_Imp_Cupom_Pedido_4;//Cupom para cliente - Matricial - GG
    procedure Pc_Imp_Cupom_Pedido_5;//Cupom para cliente - Matricial - DOCES PRINCESA
    procedure Pc_Imp_Cupom_Pedido_6;//Cupom para cliente - Termica - Mac Baterias - FastREport
    procedure Pc_Imp_Cupom_Financeiro_1;
    procedure Pc_Imp_Cupom_Financeiro_2;
    procedure Pc_Imp_Cupom_Financeiro_3;
    procedure Pc_Imp_Cupom_Financeiro_4;

    procedure Pc_Imp_Vda_Matricial;
    procedure Pc_Imp_Vda_Matricial_Vda_1;
    procedure Pc_Imp_Vda_Matricial_Vda_2;
    procedure Pc_Imp_Vda_Matricial_Vda_3;
    procedure Pc_Imp_Vda_Matricial_Vda_4;
    procedure Pc_Imp_Vda_Matricial_Vda_5;
    procedure Pc_Imp_Vda_Matricial_Vda_6;
    procedure Pc_Imp_Vda_Matricial_Vda_7;

    procedure Pc_Imp_Vda_Matricial_Srv_1;
    procedure Pc_Imp_Vda_Matricial_Srv_2;
    procedure Pc_Imp_Vda_Matricial_Srv_3;
    procedure Pc_Imp_Vda_Matricial_Srv_4;
    procedure Pc_Imp_Vda_Matricial_Srv_5;
    procedure Pc_Imp_Vda_Matricial_Srv_6;
    procedure Pc_Imp_Vda_Matricial_Srv_7;

    procedure Pc_Imp_Vda_JatoLaser;
    procedure Pc_Imp_Vda_JatoLaser_Vda_1;
    procedure Pc_Imp_Vda_JatoLaser_Srv_1;
    procedure Pc_Imp_Vda_JatoLaser_Vda_2;
    procedure Pc_Imp_Vda_JatoLaser_Srv_2;
    procedure Pc_Imp_Vda_JatoLaser_Vda_3;
    procedure Pc_Imp_Vda_JatoLaser_Srv_3;
    procedure Pc_Imp_Vda_JatoLaser_Vda_4;
    procedure Pc_Imp_Vda_JatoLaser_Srv_4;
    procedure Pc_Imp_Vda_JatoLaser_Vda_5;
    procedure Pc_Imp_Vda_JatoLaser_Srv_5;
    procedure Pc_Imp_Vda_JatoLaser_Vda_6;
    procedure Pc_Imp_Vda_JatoLaser_Srv_6;
    procedure Pc_Imp_Vda_JatoLaser_Vda_7;
    procedure Pc_Imp_Vda_JatoLaser_Srv_7;
    procedure Pc_Imp_Vda_JatoLaser_Vda_8;
    procedure Pc_Imp_Vda_JatoLaser_Srv_8;
    procedure Pc_Imp_Vda_JatoLaser_Vda_9;
    procedure Pc_Imp_Vda_JatoLaser_Srv_9;
    procedure Pc_Imp_Vda_JatoLaser_Vda_10;
    procedure Pc_Imp_Vda_JatoLaser_Srv_10;
    procedure Pc_Imp_Vda_JatoLaser_Vda_11;
    procedure Pc_Imp_Vda_JatoLaser_Srv_11;
    procedure Pc_Imp_Vda_JatoLaser_Vda_12;
    procedure Pc_Imp_Vda_JatoLaser_Srv_12;
    procedure Pc_Imp_Vda_JatoLaser_Vda_13;
    procedure Pc_Imp_Vda_JatoLaser_Srv_13;

  //FRENTE DE CAIXA
    procedure pc_ImprimeCupomNotaPromissoria;
    procedure Pc_Imp_Frt_Matricial(Pc_Cd_Pedido:Integer;Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real);

    procedure Pc_Imp_Frt_Matricial_Vda_1(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real);
    procedure Pc_Imp_Frt_Matricial_Vda_2(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real;ModeloBematech:Integer);//MP-4200
    //Pc_Imp_Frt_Matricial_Vda_3 - MP-4000
    //Pc_Imp_Frt_Matricial_Vda_4 - MP-100S
    procedure Pc_Imp_Frt_Matricial_Vda_5(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real;ModeloBematech:Integer);//DIEBOLD IM4X3T/TSP143

    procedure Pc_Imp_Frt_Termica(Pc_Cd_Pedido:Integer;Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real);
    procedure Pc_Imp_Frt_Termica_Vda_1(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real);
    procedure Pc_Imp_Frt_Termica_Vda_2(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real);

  //Conserto
    procedure Pc_Imp_Conserto;
    procedure Pc_Imp_ConsertoDataEntrega;
    procedure Pc_Imp_ConsertoSemDataEntrega;
    //////////////////////////////
    procedure Pc_Imp_ModuloEletronicos(OrderID:Integer);
    procedure ImpModuloOrdemEletronicos(OrderID:Integer);
    procedure ImpModuloGarantiaEletronicos(OrderID:Integer);
    ////////////////////////////
    procedure Pc_Imp_ModuloFurniture(OrderID:Integer);
    procedure ImpModuloOrdemFurniture(OrderID:Integer);
    ///
  //////////////////Orcamento
     Function  Fc_VerificaOrdemOrc:boolean;

     procedure Pc_Imp_Orc(it_cod_Pedido:integer);
     procedure Pc_Imp_Orc_Matricial;
     procedure Pc_Imp_Orc_Matricial_1;
     procedure Pc_Imp_Orc_Matricial_2;
     procedure Pc_Imp_Orc_Matricial_3;
     procedure Pc_Imp_Orc_JatoLaser;
     procedure Pc_Imp_Orc_JatoLaser_1;
     procedure Pc_Imp_Orc_JatoLaser_Srv_1;
     procedure Pc_Imp_Orc_JatoLaser_2;
     procedure Pc_Imp_Orc_JatoLaser_Srv_2;
     procedure Pc_Imp_Orc_JatoLaser_3;
     procedure Pc_Imp_Orc_JatoLaser_Srv_3;
     procedure Pc_Imp_Orc_JatoLaser_4;
     procedure Pc_Imp_Orc_JatoLaser_Srv_4;
     procedure Pc_Imp_Orc_JatoLaser_5;
     procedure Pc_Imp_Orc_JatoLaser_Srv_5;
     procedure Pc_Imp_Orc_JatoLaser_6;
     procedure Pc_Imp_Orc_JatoLaser_Srv_6;
     procedure Pc_Imp_Orc_JatoLaser_7;
     procedure Pc_Imp_Orc_JatoLaser_Srv_7;
     procedure Pc_Imp_Orc_JatoLaser_8;
     procedure Pc_Imp_Orc_JatoLaser_Srv_8;
     procedure Pc_Imp_Orc_JatoLaser_9;
     procedure Pc_Imp_Orc_JatoLaser_Srv_9;
     procedure Pc_Imp_Orc_JatoLaser_10;
     procedure Pc_Imp_Orc_JatoLaser_Srv_10;
     procedure Pc_Imp_Orc_JatoLaser_11;
     procedure Pc_Imp_Orc_JatoLaser_Srv_11;
     procedure Pc_Imp_Orc_JatoLaser_12;
     procedure Pc_Imp_Orc_JatoLaser_Srv_12;
     procedure Pc_Imp_Orc_JatoLaser_13;
     procedure Pc_Imp_Orc_JatoLaser_Srv_13;


     //Controle de Despacho e Separação
     procedure Pc_Imp_Cupom_Dsp_Despachados(Pc_SqlCriterio:String);
     procedure Pc_Imp_Cupom_Dsp_Separacao(pc_Cd_Pedido:Integer);
     procedure Pc_Imp_Cupom_Dsp_Devolucao(Pc_SqlCriterio:String);
     procedure Pc_Pc_Modelo_Inexistente(Pc_TipoPed:integer;Pc_NrModelo:integer);
     //Controle de Conferencia
    procedure Pc_Imp_Conferencia(Pc_Cd_Pedido:Integer);
    procedure Pc_Imp_Conf_Matricial_1;
    //Controle de Pizzaria
    procedure Pc_Imp_Pizzaria(Pc_cd_Pedido,Pc_cd_Nota:integer);
    procedure Pc_Imp_Piz_Matricial;
    procedure Pc_Imp_Piz_Matricial_1;
    procedure Pc_Imp_Piz_Termica;
    procedure Pc_Imp_Piz_Termica_1;
    //Comissão Motoboy
    function GeraDadosComissao(Parametros:TParamComissao):TSTQuery;
    procedure PrintComissaoMotoboy(Parametros:TParamComissao);



    //===============================================================================
    procedure ImprimeCupom(c:TStringList);
    function TextoCentralizado(Fc_Texto:String; fc_Coluna:Integer;Fc_Extra:String):String;

    property CodigoPedido : Integer read FCodigoPedido write setFCodigoPedido;
    property CodigoConsumidor : Integer read FCodigoConsumidor write setFCodigoConsumidor;
    property SalvaPDF : Boolean read FSalvaPDF write setFSalvaPDF;
    property NomePDF : String read FNomePDF write setFNomePDF;
  end;

  //Impressao de Cupom
implementation

uses     UN_Sistema, Un_Funcoes, un_DM, un_RL_PedidoVenda_1, un_RL_PedidoVenda_2, un_RL_PedidoVenda_3, un_RL_Servico, UN_Principal, env, un_RL_PedidoCompra_1, un_RL_PedidoCompra_2, un_RL_PedidoCompra_3, un_Fatura_Ajt, un_pedido_vda, un_RL_PedidoAjuste, un_pedido_cpa, un_pedido_ajt, un_RL_OrcaCst_Entg, Un_RL_OrcaConserto, uN_RL_Orcamento_1, UN_RL_Orcamento_2, Un_RL_Orcamento_3, UN_RL_Orcamento_4, Un_RL_Orcamento_6, Un_RL_Orcamento_7, Un_RL_Orcamento_8, Un_Nota_Fiscal, Un_Regra_Negocio, Un_RL_PedidoVenda_4, Un_RL_PedidoVenda_5, Un_RL_PedidoVenda_6, RN_Financeiro, Un_RL_PedidoVenda_7, Un_RL_PedidoVenda_8, Un_Rl_Servico_Orc, Un_RL_Orcamento_9, UN_TabelasEmListas, Un_RL_ReportOrder_10, Un_RL_ReportBudget_10, Un_RL_ReportOrder_11, Un_RL_ReportBudget_11, ControllerVehicleOs, Un_TPrin, Un_RL_ReportOrder_12, Un_RL_ReportBudget_12, UN_RL_Orcamento_13, UN_RL_PedidoVenda_9, Rn_Transportadora, un_frx_imp_cupom_pedido_6, un_frx_order_service_eletc_equip, un_frx_order_service_furniture, ControllerPrePaidCard, Un_RL_PedidoVenda_10, Un_RL_PedidoVenda_11, un_frx_warranty_term_eletc_equip, GeneralPrint, ControllerPayBack, ControllerBase, prmCaixa;
constructor TImpModImpressao.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  NomeImpressora := Printer.Printers[Printer.PrinterIndex];
  Pc_AtivaEstabelecimento;
  FSalvaPDF := False;
  Qr_Pedido       := TSTQuery.Create(self);
  Qr_Pedido.Database:=DM.IBD_Gestao;
  Qr_Pedido.Transaction := DM.IB_Transacao;

  Qr_Conserto:= TSTQuery.Create(self);
  Qr_Conserto.Database:=DM.IBD_Gestao;
  Qr_Conserto.Transaction := DM.IB_Transacao;

  Qr_Itens        := TSTQuery.Create(self);
  Qr_Itens.Database:=DM.IBD_Gestao;
  Qr_Itens.Transaction := DM.IB_Transacao;

  Qr_Lote             :=  TSTQuery.Create(self);
  Qr_Lote.Database    :=  DM.IBD_Gestao;
  Qr_Lote.Transaction :=  DM.IB_Transacao;

  Qr_Cotacao        := TSTQuery.Create(self);
  Qr_Cotacao.Database:=DM.IBD_Gestao;
  Qr_Cotacao.Transaction := DM.IB_Transacao;

  Qr_ItensSrv        := TSTQuery.Create(self);
  Qr_ItensSrv.Database:=DM.IBD_Gestao;
  Qr_ItensSrv.Transaction := DM.IB_Transacao;

  Qr_Parcelamento := TSTQuery.Create(self);
  Qr_Parcelamento.Database:=DM.IBD_Gestao;
  Qr_Parcelamento.Transaction := DM.IB_Transacao;

  Qr_Financeiro := TSTQuery.Create(self);
  Qr_Financeiro.Database  :=  DM.IBD_Gestao;
  Qr_Financeiro.Transaction :=  DM.IB_Transacao;

  Qr_Empresas := TSTQuery.Create(self);
  Qr_Empresas.Database:=DM.IBD_Gestao;
  Qr_Empresas.Transaction := DM.IB_Transacao;

  QR_Ordem := TSTQuery.Create(self);
  QR_Ordem.Database:=DM.IBD_Gestao;
  QR_Ordem.Transaction := DM.IB_Transacao;

  Qr_Tecnico := TSTQuery.Create(self);
  Qr_Tecnico.Database:=DM.IBD_Gestao;
  Qr_Tecnico.Transaction := DM.IB_Transacao;

  Qr_Vendedor       := TSTQuery.Create(self);
  Qr_Vendedor.Database:=DM.IBD_Gestao;
  Qr_Vendedor.Transaction := DM.IB_Transacao;

  //Campo Observação
  It_Observacao:= TMemo.Create(Fr_Principal);
  It_Observacao.Parent:= Fr_Principal;
  It_Observacao.Visible:=FALSE;
  It_Observacao.Width := 640;
  It_Observacao.Height := 90;
  It_Observacao.Top := 0;
  It_Observacao.Left := 0;
  It_Observacao.Font.Name := 'Courier';
  It_Observacao.Lines.Clear;
end;


destructor TimpModImpressao.Destroy;
Begin
  Printer.Printers[Printer.PrinterIndex] := NomeImpressora;
  Qr_Pedido.Close;
  Qr_Conserto.Close;
  Qr_Itens.Close;
  Qr_Lote.Close;
  Qr_Cotacao.Close;
  Qr_ItensSrv.Close;
  Qr_Empresas.Close;
  QR_Ordem.Close;
  Qr_Tecnico.Close;
  Qr_Vendedor.close;
  Qr_Financeiro.Close;


  Inherited;
end;

Procedure TimpModImpressao.Pc_FinalizaCupom(Pc_Linhas:Integer);
Var
  Lc_I : Integer;
  Lc_Finaliza: TextFile;
Begin
    //Finaliza o Cupom
    AssignFile(Lc_Finaliza,It_Porta);
    Rewrite(Lc_Finaliza);
    if Pc_Linhas > 0 then
      Begin
      For Lc_I := 1 to Pc_Linhas do
        Writeln(Lc_Finaliza);
      Rewrite(Lc_Finaliza);
      end;
    CloseFile(Lc_Finaliza);
end;

Procedure TimpModImpressao.Pc_TextOutLC(nRow,nCol:LongInt;Text:String);
  Var xRow,xCol:LongInt;
Begin
  {Teste de próxima página}
  If nRow=It_FRow Then
    Begin
    For xCol:=1 To nCol-It_FCol Do
      Begin
      Write(It_Arquivo,' ');
      Inc(It_FCol);
      End
    End
  Else
    Begin
    It_FCol:=1;
    For xRow:=1 To nRow-It_FRow Do
      Begin
      WriteLn(It_Arquivo,'');
      Inc(It_FRow);
      End;
    For xCol:=1 To nCol Do
      Begin
      If xCol>It_FCol Then
        Begin
        Write(It_Arquivo,' ');
        Inc(It_FCol);
        End;
      End
    End;
  Inc(It_FCol,Length(Text));
  Write(It_Arquivo,Text);
End;

// para texto a esquerda
function TimpModImpressao.Pc_AlinhaE(Texto : String; Tamanho : Integer) : String;
 begin
   Texto := Trim(Texto);
   while length(Texto) < Tamanho do
   begin
     Texto := Texto + ' ';
   end;
   Result := Texto;
 end;

// para texto centralizado

function TimpModImpressao.Pc_AlinhaC(Texto : String; Tamanho : integer) : String;
 var
   metade: integer;
 begin
   Texto := Trim(Texto);
   metade := ((Tamanho-Length(Texto)) div 2);
   while Length(Texto)+metade < Tamanho do
     Texto := ' ' + Texto;
   result := Texto;
 end;

 // para texto a direita
function TimpModImpressao.Pc_AlinhaD(Texto : String; Tamanho : Integer) : String;
 begin
   Texto := Trim(Texto);
   while length(Texto) < Tamanho do
   begin
     Texto := ' ' + Texto;
   end;
   Result := Texto;
 end;

Function TimpModImpressao.Fc_ChamaImpressora():boolean;
Var
  Lc_Device : PChar;
  Lc_Driver : Pchar;
  Lc_Porta : Pchar;
  Lc_HdeviceMode: Thandle;

begin
  if not Assigned(It_Dial_Imp) then
    It_Dial_Imp := TPrintDialog.Create(self);
    Printer.Printers[Printer.PrinterIndex];

  if (It_Dial_Imp.Execute) then
  begin
    getmem(Lc_Device, 255);
    getmem(Lc_Driver, 255);
    getmem(lc_Porta, 255);
    Try
      NomeImpressora := Printer.Printers[Printer.PrinterIndex];
      Printer.getprinter(Lc_device, Lc_driver, Lc_porta, Lc_HdeviceMode);
      It_Porta:= Lc_Porta ;
      Result := True;
    finally
      FreeMem(Lc_Device);
      FreeMem(Lc_Driver);
      FreeMem(Lc_Porta);
    end;
  end
  else
    Result := False;
end;

function TimpModImpressao.Fc_Parcelamento(Fc_Tipo:String):String;
Var
  Lc_Nr_Parcelas : Integer;
  lc_Mtz_Prazo : Array of array of string;
  Lc_St_Parcela : String;
  Lc_Vl_Parcela : Real;
  Lc_I, Lc_J : Integer;
  Lc_Prazo : String;
Begin
  Qr_Parcelamento.Active := False;
  Qr_Parcelamento.SQL.Clear;
  Qr_Parcelamento.SQL.Add(' SELECT PAR_VALOR,PAR_DATA     ');
  Qr_Parcelamento.SQL.Add(' FROM TB_PARCELAMENTO          ');
  Qr_Parcelamento.SQL.Add(' WHERE PAR_CODPED=:PAR_CODPED  ');
  Qr_Parcelamento.SQL.Add(' ORDER BY PAR_PARCELA          ');
  Qr_Parcelamento.ParamByName('PAR_CODPED').AsInteger := FCodigoPedido;
  Qr_Parcelamento.Active := True;
  Qr_Parcelamento.FetchAll;

  if Qr_Parcelamento.RecordCount = 0 then
    Begin
    Lc_Nr_Parcelas := StrToIntDef(Copy(Qr_Pedido.FieldByname('PED_PRAZO').AsString,1,3),0);
    if Lc_Nr_Parcelas = 0 then
      Begin
      SetLength(lc_Mtz_Prazo,2,1);
      lc_Mtz_Prazo[0,0] := Qr_Pedido.FieldByname('DATA').AsString;
      lc_Mtz_Prazo[1,0] := FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2);
      end
    else
      Begin
      SetLength(lc_Mtz_Prazo,2,Lc_Nr_Parcelas);
      For Lc_I := 0 to Lc_Nr_Parcelas - 1 do
        For Lc_J := 0 to 1 do
          lc_Mtz_Prazo[Lc_J, Lc_I] := '';

      //Resolvemos o problema da Divisão e dizima periodica
      Lc_St_Parcela := FloatToStrF((Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency / Lc_Nr_Parcelas),ffFixed,10,2);
      Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,1);

      For Lc_I := 0 to (Lc_Nr_Parcelas -1) do
        begin
        Lc_Prazo := Copy(Qr_Pedido.FieldByname('PED_PRAZO').AsString,7,(Length(Qr_Pedido.FieldByname('PED_PRAZO').AsString)-6));
        Lc_Prazo :=  Copy(Lc_Prazo,(((Lc_I) * 4)+1),3);
        if not (Lc_I = Lc_Nr_Parcelas) then
          lc_Mtz_Prazo[1,Lc_I] := Lc_St_Parcela
        else
          lc_Mtz_Prazo[1,Lc_I] := FloatToStrF((Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency -(Lc_Vl_Parcela * (Lc_Nr_Parcelas - 1))),ffFixed,10,2);
        lc_Mtz_Prazo[0,Lc_I] := copy(DateToStr(Qr_Pedido.FieldByname('DATA').AsDateTime + StrToIntDef(Lc_Prazo,0)),1,5);
        end;
      end;
    end
  else
    Begin
    Lc_Nr_Parcelas := Qr_Parcelamento.RecordCount;
    SetLength(lc_Mtz_Prazo,2,Lc_Nr_Parcelas);
    For Lc_I := 0 to Lc_Nr_Parcelas - 1 do
      For Lc_J := 0 to 1 do
        lc_Mtz_Prazo[Lc_J, Lc_I] := '';
    Lc_I := 0;
    while not Qr_Parcelamento.Eof do
      begin
      lc_Mtz_Prazo[0,Lc_I] := FloatToStrF(Qr_Parcelamento.FieldByname('PAR_VALOR').AsCurrency,ffFixed,10,2);
      lc_Mtz_Prazo[1,Lc_I] := copy(Qr_Parcelamento.FieldByname('PAR_DATA').AsString,1,5);
      inc(Lc_I);
      Qr_Parcelamento.Next;
      end;
    end;

  if (Fc_Tipo = 'O') then
    Begin
    if Lc_Nr_Parcelas = 0 then
      Begin
      It_Observacao.Lines.Add('A VISTA');
      Lc_Prazo := 'A VISTA';
      end
    else
      Begin
      For Lc_I := 0 to Lc_Nr_Parcelas - 1 do
        Begin
        if lc_Mtz_Prazo[1,Lc_I] <> '' then
          Begin
          if Lc_I = 0 then
            Begin
            It_Observacao.Lines.Add(Qr_Pedido.FieldByname('FPT_DESCRICAO').AsString);
            It_Observacao.Lines.Add(lc_Mtz_Prazo[0,Lc_I] + ' - ' + lc_Mtz_Prazo[1,Lc_I]);
            end
          else
            It_Observacao.Lines.Add(lc_Mtz_Prazo[0,Lc_I] + ' - ' + lc_Mtz_Prazo[1,Lc_I]);
          end;
        end;
      end;
    end
  else
    Begin
    Lc_Prazo := 'A VISTA';
    For Lc_I := 0 to Lc_Nr_Parcelas - 1 do
      Begin
      if lc_Mtz_Prazo[0,Lc_I] <> '' then
        Begin
        if Lc_I = 0 then
          Lc_Prazo := lc_Mtz_Prazo[0,Lc_I] + '-' + lc_Mtz_Prazo[1,Lc_I]
        else
          Lc_Prazo := Lc_Prazo + ' | ' +lc_Mtz_Prazo[0,Lc_I] + '-' + lc_Mtz_Prazo[1,Lc_I];
        end;
      end;
    Result := Lc_Prazo + ' |' ;
    end;
end;

procedure  TimpModImpressao. Pc_Imp_Vda(Fc_cd_Pedido,Fc_Cd_Nota:integer);
var
  Lc_Escolha : Integer;
  Lc_tipo:integer;
  LcModulo : String;
begin
  Pc_LimpaQrPreviweMemoria;
  FCodigoPedido:=Fc_cd_Pedido;
  Pc_DadosPedido(1);
  if Fc_VerificaConserto then
  Begin
    LcModulo := Fc_Tb_Geral('L','OSR_G_TIPO_MODULO','AUTO CENTER');
    case AnsiIndexStr(LcModulo, ['AUTO CENTER','EXTINTORES','EQUIPAMENTOS ELETRÔNICOS','PET SHOP']) of
      0:Pc_Imp_Conserto;
      1:Pc_Imp_Conserto;
      2:Pc_Imp_ModuloEletronicos(Fc_cd_Pedido);
      3:Pc_Imp_Conserto;
      else
      Begin
        Pc_Imp_Conserto;
      End;
    end;
  End
  else
  begin
    //Mostra esta opção somente se for estiver com a tela de nota fiscal
    Lc_Tipo:= MensagemPadrao(TITULO_INFORMACAO,
                             'Deseja enviar para?',
                             ['CUPOM','NORMAL','CANCELA'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace);
    Case Lc_tipo of
      0:Pc_Imp_Cupom;
      1:begin
        it_Tp_Impressora :=  StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_IMPRESSORA',''),0);
        case it_Tp_Impressora of
        0:Begin
            Pc_Imp_Vda_Matricial;
          end;
        1:Begin
            Pc_Imp_Vda_JatoLaser;
          end;
        2:Begin
            Lc_escolha:=0;
            Lc_Escolha := (MensagemPadrao(TITULO_INFORMACAO,
                                          'Deseja enviar para?',
                                          ['MATRICIAL', 'LASER/JATO', 'CANCELA'], [bNormal, bNormal, bEscape], mpConfirmacao, clBtnFace));
              case Lc_Escolha of
                0:Pc_Imp_Vda_Matricial;
                1:Pc_Imp_Vda_JatoLaser;
              end;
          end;
        end;
      end;
    end;
  end;
end;

function  TimpModImpressao.Fc_VerificaServico:Boolean;
begin
  Result:=false;
  with Qr_Itens do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add(' SELECT ITF_CODPED '+
            ' FROM TB_ITENS_NFL Tb_itens_nfl '+
            '    INNER JOIN TB_PEDIDO Tb_pedido '+
            '    ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO) '+
            '    INNER JOIN TB_PRODUTO Tb_produto '+
            '    ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO) '+
            '  INNER JOIN tb_medida tb_medida  '+
            '    ON  (tb_medida.med_codigo = tb_produto.pro_codmed) '+
            '    left join tb_embalagem tb_embalagem '+
            '      on tb_embalagem.emb_codigo = tb_produto.pro_codemb '+
            ' WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO = ''S'') AND (ITF_OPER = ''V'')  ');
    ParamByName('PED_CODIGO').AsInteger:= FCodigoPedido;
    Active := True;
    FetchAll;
    if RecordCount > 0 then
      Result:=true;
  End;
END;

function  TimpModImpressao.Fc_VerificaOrdemServico:Boolean;
Var
  OrdemServico : TControllerVehicleOs;
begin
  Result := False;
  with QR_Ordem do
  Begin
    //Verifica se tem item de serviço no orçamento
    Active:=false;
    SQL.Clear;
    SQL.Add('select ITF_CODIGO '+
            'FROM TB_ITENS_NFL '+
            '  INNER JOIN TB_PRODUTO '+
            '  ON (PRO_CODIGO = ITF_CODPRO) '+
            'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO = ''S'')');
    ParamByName('PED_CODIGO').AsInteger:=FCodigoPedido;
    Active:=true;
    FetchAll;
    if RecordCount > 0 then
    Begin
      Result:=true;
      exit;
    End;
    //Verifica se tem dados do veiculo
    try
      OrdemServico := TControllerVehicleOs.Create(nil);
      with OrdemServico do
      Begin
        Registro.CodigoEstabelecimento := gb_codmha;
        Registro.CodigoPedido := FCodigoPedido;
        getByPedido;
        if exist then
        Begin
          Result := true;
          exit;
        End;
      end;
      OrdemServico.Clear;
    finally
      FreeAndNil(OrdemServico);
    end;
  end;

end;


procedure  TimpModImpressao.Pc_Imp_ContultaOrcamento;
Begin
  with Qr_Cotacao do
  Begin
    Active:=false;
    Sql.clear;
    Sql.Add(' SELECT CTC_NUMERO,CTC_CODEMP,CTC_DATA DATA ,CTC_VL_COTACAO,CTC_VL_DESCONTO,CTC_ALIQ_DESCONTO, '+
            ' CTC_VL_FRETE,CTC_VL_PRODUTO,CTC_OBS,CTC_CODIGO,clb_nome,CTC_FANTASIA, CTC_PRAZO, '+
            ' CTC_VL_SERVICO,FPT_DESCRICAO '+
            ' FROM TB_COTACAO tb_cotacao '+
            '  inner join tb_colaborador tb_colaborador  ON (tb_colaborador.clb_codigo = tb_cotacao.ctc_codvdo) '+
            '  inner join TB_FORMAPAGTO on (FPT_CODIGO = CTC_CODFPG )'+
            ' LEFT OUTER JOIN TB_EMPRESA tb_empresa  ON (tb_empresa.EMP_CODIGO = tb_cotacao.CTC_CODEMP) '+

            ' WHERE(CTC_CODPED =:CTC_CODPED) ');
    ParamByName('CTC_CODPED').AsInteger:=FCodigoPedido;
    Active:=True;
    it_cd_orc:=fieldbyname('CTC_CODIGO').AsInteger;
  end;

  with Qr_Pedido do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add(' SELECT END_ENDER,END_NUMERO,END_COMPLEM,END_BAIRRO,CDD_DESCRICAO,UFE_SIGLA,END_CEP, '+
            ' END_FONE,END_FAX,UFE_DESCRICAO,END_CONTATO,EMP_PESSOA,EMP_CNPJ,EMP_INSC_EST '+
            ' FROM TB_ENDERECO '+
            ' INNER JOIN TB_CIDADE tb_cidade ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '+
            ' INNER JOIN TB_UF tb_uf ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)  '+
            ' left JOIN tb_empresa tb_empresa ON tb_empresa.emp_codigo = tb_endereco.end_codemp '+
            ' WHERE (END_CODEMP =:EMP_CODIGO) '+
            ' ORDER BY END_ENDER ');
    ParamByName('EMP_CODIGO').AsInteger := Qr_Cotacao.fieldbyname('CTC_CODEMP').asinteger;
    Active := True;
    FetchAll;
    First;
  end;

  with Qr_Itens do
  Begin
    Active:=false;
    Sql.clear;
    Sql.Add(' SELECT PRO_CODIGOFAB, PRO_VL_CUSTO,PRO_DIVISOR,ICT_CODIGO,ICT_CODCTC, '+
            ' ICT_TIPO,ICT_CODVCL,ICT_DESCRICAO,ICT_QTDE,ICT_VL_UNIT,ICT_AQ_COM, '+
            ' ICT_VL_DESC,ICT_AQ_DESC,ICT_AQ_IPI,ICT_AQ_ICMS,ICT_CODEST,ICT_CODTPR, '+
            ' PRO_CODIGO, (ICT_QTDE * ICT_VL_UNIT) AS ICT_VL_SUBTOTAL '+
            ' FROM TB_ITENS_CTC tb_itens_ctc '+
            ' left JOIN TB_PRODUTO tb_produto on (tb_produto.PRO_CODIGO = tb_itens_ctc.ICT_CODVCL) '+
            ' WHERE (ICT_CODCTC =:CTC_CODIGO) AND (ICT_TIPO <> ''S'') '+
            ' ORDER BY ICT_CODIGO ');
    ParamByName('CTC_CODIGO').asinteger:= it_cd_orc;
    Active:=true;
  end;

  with Qr_ItensSrv do
  Begin
    Active:=false;
    Sql.clear;
    SQL.Add(' SELECT PRO_CODIGOFAB,PRO_VL_CUSTO,PRO_DIVISOR,ICT_CODIGO,ICT_CODCTC,ICT_TIPO, '+
            ' ICT_CODVCL,ICT_DESCRICAO,ICT_QTDE,ICT_VL_UNIT,ICT_AQ_COM,ICT_VL_DESC,ICT_AQ_DESC, '+
            ' ICT_AQ_IPI,ICT_AQ_ICMS,ICT_CODEST,ICT_CODTPR,PRO_CODIGO, '+
            ' (ICT_QTDE * ICT_VL_UNIT) AS ICT_VL_SUBTOTAL '+
            ' FROM TB_ITENS_CTC tb_itens_ctc '+
            ' left JOIN TB_PRODUTO tb_produto on (tb_produto.PRO_CODIGO = tb_itens_ctc.ICT_CODVCL) '+
            ' WHERE  (ICT_CODCTC =:CTC_CODIGO) AND (ICT_TIPO = ''S'') '+
            ' ORDER BY ICT_CODIGO ');
    ParamByName('CTC_CODIGO').AsInteger:=it_cd_orc;
    active:=true;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_Matricial;
begin
  if not fc_ChamaImpressora then exit;
  it_Modelo_matricial:= StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_MOD_MATRICIAL', ''),1);
  IF not Fc_VerificaOrdemServico then
    begin
     case it_Modelo_matricial of
        1:Pc_Imp_Vda_Matricial_Vda_1;
        2:Pc_Imp_Vda_Matricial_Vda_2;
        3:Pc_Imp_Vda_Matricial_Vda_3;
        4:Pc_Imp_Vda_Matricial_Vda_4;
        5:Pc_Imp_Vda_Matricial_Vda_5;
        6:Pc_Imp_Vda_Matricial_Vda_6;
        7:Pc_Imp_Vda_Matricial_Vda_7;
     end;
    end
  else
    begin
     case it_Modelo_matricial of
       1:Pc_Imp_Vda_Matricial_Srv_1;
       2:Pc_Imp_Vda_Matricial_Srv_2;
       3:Pc_Imp_Vda_Matricial_Srv_3;
       4:Pc_Imp_Vda_Matricial_Srv_4;
       5:Pc_Imp_Vda_Matricial_Srv_5;
       6:Pc_Imp_Vda_Matricial_Srv_6;
       7:Pc_Imp_Vda_Matricial_Srv_7;
      end;
    end;
  Printer.PrinterIndex := It_Imp_Atual ;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser;
begin
  it_Modelo_jatolaser:= StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_MOD_JATOLASER', ''),1);
  IF not Fc_VerificaOrdemServico then
  begin
    case it_Modelo_jatolaser of
    1:Pc_Imp_Vda_JatoLaser_Vda_1;
    2:Pc_Imp_Vda_JatoLaser_Vda_2;  //Extforma
    3:Pc_Imp_Vda_JatoLaser_Vda_3;  //Extimplas
    4:Pc_Imp_Vda_JatoLaser_Vda_4;  //Genio Ferramentas
    5:Pc_Imp_Vda_JatoLaser_Vda_5;  //São Luiz
    6:Pc_Imp_Vda_JatoLaser_Vda_6;  //Genio Ferramentas - 2
    7:Pc_Imp_Vda_JatoLaser_Vda_7;  //Choconix
    8:Pc_Imp_Vda_JatoLaser_Vda_8;  //Face a Face
    9:Pc_Imp_Vda_JatoLaser_Vda_9;  //YUMI
    10:Pc_Imp_Vda_JatoLaser_Vda_10;  //ExterminaChama
    11:Pc_Imp_Vda_JatoLaser_Vda_11;  //Brasil Sacolas/GraficaImperial
    12:Pc_Imp_Vda_JatoLaser_Vda_12;  //Mac Baterais
    13:Pc_Imp_Vda_JatoLaser_Vda_13;  //Brasil Sacolas/GraficaImperial
    end;
  end
  else
  begin
    case it_Modelo_jatolaser of
      1:Pc_Imp_Vda_JatoLaser_Srv_1;
      2:Pc_Imp_Vda_JatoLaser_Srv_2;//Extforma
      3:Pc_Imp_Vda_JatoLaser_Srv_3;//Extimplas
      4:Pc_Imp_Vda_JatoLaser_Srv_4;  //Genio Ferramentas
      5:Pc_Imp_Vda_JatoLaser_Srv_5;  //São Luiz
      6:Pc_Imp_Vda_JatoLaser_Srv_6;  //Genio Ferramentas - 2
      7:Pc_Imp_Vda_JatoLaser_Srv_7;  //Choconix
      8:Pc_Imp_Vda_JatoLaser_Srv_8;  //Choconix
      9:Pc_Imp_Vda_JatoLaser_Vda_9;  //YUMI
      10:Pc_Imp_Vda_JatoLaser_Vda_10;  //ExterminaChama
      11:Pc_Imp_Vda_JatoLaser_Vda_11;  //Brasil Sacolas
      12:Pc_Imp_Vda_JatoLaser_Vda_12;  //Mac Baterais
      13:Pc_Imp_Vda_JatoLaser_Srv_13;  //Brasil Sacolas/GraficaImperial
    end;
  end;
end;

procedure  TimpModImpressao.Pc_DadosPedido(Pc_Tipo:integer);
begin
  with Qr_Pedido do
    Begin
    Database:=DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    Active:=false;
    SQL.Clear;
    SQL.Add(' SELECT ped_numero, ped_qt_produto, PED_VL_PRODUTO FROM tb_pedido '+
            ' where ped_codigo = :ped_codigo '+
            ' and ped_codmha =:ped_codmha '+
            ' and ped_tipo =:ped_tipo ');
    ParamByName('ped_codigo').AsInteger:= FCodigoPedido;
    ParamByName('ped_codmha').AsInteger:=Gb_CodMha;
    ParamByName('ped_tipo').AsInteger:= Pc_Tipo;
    Active:=true;
    end;
end;

function TimpModImpressao.Fc_BuscaLote(CodigoViculo : Integer):String;
Var
  SqlTxt : String;
  Lc_I : Integer;
  LcCodigoVinculo : String;
Begin
  Screen.Cursor := crHourGlass;
  with Qr_Lote do
  Begin
    Active := False;
    SQL.Clear;
    sqltxt := concat(
                'SELECT DISTINCT CLT_NUMERO ',
                'FROM TB_CTRL_LOTE L ',
                '  INNER JOIN TB_MOVIMENTO_LOTE M ',
                '  ON (M.mlt_codclt = L.clt_codigo) ',
                ' WHERE (M.MLT_CODVCL =:ITF_CODIGO ) '
              );
    SQL.Add(SqlTxt);
    ParamByName('ITF_CODIGO').AsInteger := CodigoViculo;
    Active := TRUE;
    first;
    Result := '';
    while not eof do
    Begin
      if bof then
        Result := Result + FieldByName('CLT_NUMERO').AsString
      else
        Result := Result + ' / ' + FieldByName('CLT_NUMERO').AsString;
      Next;
    End;
  End;
  Screen.Cursor := crDefault;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_Vda_1;
Var
  Lc_TExto : String;
  Lc_ItensPP : Integer;
  lc_contador : Integer;
  lc_I, Lc_II, lc_J : Integer;
  Lc_Prin : TPrin;
  LcLote : String;
  LcDescricao:String;
  Lc_ObsTexto: TMemoryStream;
  Lc_Observacao : TMemo;
Begin
  try
    Lc_Observacao:= TMemo.Create(nil);
    Lc_Observacao.Parent:= Fr_principal;
    Lc_Observacao.Visible:=FALSE;
    Lc_Observacao.WordWrap := True;
    Lc_Observacao.Width := 640;
    Lc_Observacao.Height := 90;
    Lc_Observacao.Top := 0;
    Lc_Observacao.Left := 0;
    Lc_Observacao.Font.Name := 'Courier';
    Lc_Observacao.Lines.Clear;

    //Monta o pedido
    Pc_AbreDadosPedido;


    Lc_ItensPP := StrToIntDEF(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_ITENS_FOLHA','16'),16);
    lc_contador := Lc_ItensPP + 4;
    Lc_Prin:=TPrin.Create(nil);
    With Lc_Prin Do
    begin
      Porta := It_Porta;
      Initialize(It_Porta);
      lc_I := 1;
      TextOutLC(lc_I,1,StrZero(Gb_CodMha,3,0) + '|' + 'PEDIDO: ');
      textoutLc(lc_I,13,Padr(Qr_Pedido.FieldByname('PED_NUMERO').AsString,8));
      TextOutLC(lc_I,57,'DATA :');

      Lc_TExto := Qr_Pedido.FieldByname('DATA').AsString + ' ' + TimeToStr(Now);
      textoutLc(lc_I,64,Padr(Lc_TExto ,16));
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
      Condensa(True);
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'NOME DO CLIENTE: ');
      TextOutLC(lc_I,18,Qr_Pedido.FieldByname('EMP_CODIGO').AsString + ' -  '+ Qr_Pedido.FieldByname('EMP_FANTASIA').AsString + ' - ' + Qr_Pedido.FieldByname('EMP_NOME').AsString);

      IF Qr_Pedido.FieldByname('EMP_PESSOA').AsString = 'F' then
        Begin
        TextOutLC(lc_I,106,'C.P.F: ');
        TextOutLC(lc_I,110,Padr(fc_MascaraCPF(Qr_Pedido.FieldByname('EMP_CNPJ').AsString),18));
        end
      else
        Begin
        TextOutLC(lc_I,106,'C.N.P.J: ');
        TextOutLC(lc_I,110,Padr(fc_MascaraCNPJ(Qr_Pedido.FieldByname('EMP_CNPJ').AsString),18));
        end;
      lc_I := lc_I +1;
      TextOutLC(lc_I,1,'ENDERECO: ' + Qr_Pedido.FieldByname('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByname('END_NUMERO').AsString +'  -  '+
                     ' BAIRRO: ' + Qr_Pedido.FieldByname('END_BAIRRO').AsString +'  -  '+
                     ' CEP: '    + Qr_Pedido.FieldByname('END_CEP').AsString    +'  -  '+
                     'CIDADE: '+Qr_Pedido.FieldByname('CDD_DESCRICAO').AsString +'  -  '+
                     'UF: ' + Qr_Pedido.FieldByname('UFE_SIGLA').AsString);

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'FONE: '+fc_MascaraFone(Qr_Pedido.FieldByname('END_FONE').AsString)+'  -  ');
      TextOutLC(lc_I,22,'CONTATO: '+Qr_Pedido.FieldByname('END_CONTATO').AsString);

       IF Qr_Pedido.FieldByname('EMP_PESSOA').AsString = 'F' then
        Begin
        TextOutLC(lc_I,106,'R.G: ');
        TextOutLC(lc_I,110,Padr(Qr_Pedido.FieldByname('EMP_INSC_EST').AsString,18));
        end
      else
        Begin
        TextOutLC(lc_I,106,'INSC. E: ');
        TextOutLC(lc_I,110,Padr(Qr_Pedido.FieldByname('EMP_INSC_EST').AsString,18));
        end;

      Condensa(FAlse);
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'DESCRICAO DOS PRODUTOS');
      LcLote := Fc_BuscaLote(Qr_Itens.FieldByName('ITF_CODIGO').AsInteger);
      TextOutLC(lc_I,46,'LOTE');
      TextOutLC(lc_I,53,'QTDE');
      TextOutLC(lc_I,62,'PRECO');
      TextOutLC(lc_I,71,'SUBTOTAL');
      Qr_Itens.First;
      While not Qr_Itens.EOF do
      BEGIN
        if (lc_contador > 0) then
        Begin
          lc_I := lc_I + 1;
          lc_contador := lc_contador - 1;
          LcLote := Fc_BuscaLote(Qr_Itens.FieldByName('ITF_CODIGO').AsInteger);
          if ( Length(LcLote) >0 ) then
          Begin
            LcDescricao := Copy(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString + '-' + Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,1,42);
            TextOutLC(lc_I,1,LcDescricao);
            TextOutLC(lc_I,44,LcLote);
            TextOutLC(lc_I,50,Padr(Qr_Itens.FieldByname('ITF_QTDE').AsString,6));
            TextOutLC(lc_I,57,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),9));
            TextOutLC(lc_I,67,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));

          End
          else
          Begin
            LcDescricao := Copy(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString + '-' + Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,1,50);
            TextOutLC(lc_I,1,LcDescricao);
            TextOutLC(lc_I,52,Padr(Qr_Itens.FieldByname('ITF_QTDE').AsString,6));
            TextOutLC(lc_I,59,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),9));
            TextOutLC(lc_I,69,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
          End;
          Qr_Itens.Next;
        end
        else
        Begin
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'                                                                    CONTINUA...');
          lc_I := lc_I + 2;
          lc_contador := Lc_ItensPP + 4;
        end;
      END;

      if (lc_contador < 4) then
        Begin
          for lc_J:=0 to lc_contador do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
        TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'                                                                    CONTINUA...');
        lc_I := lc_I + 2;
        end
      else
        Begin
        if (lc_contador >= 6) then
          for Lc_J:=1 to (lc_contador - 4) do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
        end;
      //Imprimi o Rodape
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'COND. PAGTO: ');
      TextOutLC(lc_I,14,Qr_Pedido.FieldByname('FPT_DESCRICAO').AsString  + ' | ' + Fc_Parcelamento('I'));

      //====================== MONTAR Observação==================================================
      LC_Observacao.Lines.Clear;
      if Length(Trim(Qr_Pedido.FieldByname('PED_OBS').AsString))>0 then
      Begin
        try
          Lc_ObsTexto := TMemoryStream.Create;
          Lc_ObsTexto.LoadFromStream(Qr_Pedido.CreateBlobStream(Qr_Pedido.FieldByName('PED_OBS'), bmRead));
          LC_Observacao.Lines.LoadFromStream(Lc_ObsTexto);
        finally
          FreeAndNil(Lc_ObsTexto);
        end;
      End;

      //Cheque Devolvido
      if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_DEV','') = 'S') then
      Begin
        LC_Observacao.Lines.Add(Fc_HistoricoFinanceiro(1,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger));
      end;

      //Cheque Pre-Datado
      if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_PRE','') = 'S') then
      Begin
        LC_Observacao.Lines.Add(Fc_HistoricoFinanceiro(2,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger));
      end;

      //Saldo Devedor
      if (Fc_Tb_Geral('L','FIN_G_INF_SALDO_DEV','') = 'S') then
      Begin
        LC_Observacao.Lines.Add(Fc_HistoricoFinanceiro(3,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger));
      end;

      //=========================================================================================

      TextOutLC(lc_I,49,'TOTAL DOS PRODUTOS:');
      TextOutLC(lc_I,69, Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),11));

      if (Fc_Tb_Geral('L','VDA_G_MOSTRA_VENDEDOR','S') ='S') then
      begin
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,concat('NOME DO VENDEDOR:',
                                Copy(Qr_Pedido.FieldByname('CLB_NOME').AsString,1,24)
        ));
      end;

      TextOutLC(lc_I,49,'QTD. PRODUTOS:');
      TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_QT_PRODUTO').AsFloat,ffFixed,10,2),11));

      lc_I := lc_I + 1;
      if Lc_Observacao.Lines.Count > 0 then
      Begin
        TextOutLC(lc_I,1,'OBSERVACOES:');
      End;

      TextOutLC(lc_I,49,'VALOR DO FRETE    :');
      TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_FRETE').AsCurrency,ffFixed,10,2),11));

      lc_I := lc_I + 1;
      if Lc_Observacao.Lines.Count >= 0 then
      Begin
        TextOutLC(lc_I,1,copy( Lc_Observacao.Lines[0],1,47));
      End;

      TextOutLC(lc_I,49,'DESCONTO          :');
      TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2),11));

      lc_I := lc_I + 1;
      if Lc_Observacao.Lines.Count >= 1 then
      Begin
        TextOutLC(lc_I,1,copy( Lc_Observacao.Lines[1],1,47));
      End;

      TextOutLC(lc_I,49,'TOTAL DO PEDIDO   :');
      TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),11));

      For lc_J := 2 to Lc_Observacao.Lines.Count - 1 do
      Begin
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,copy( Lc_Observacao.Lines[lc_J],1,47));
      End;
    end;

    If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
    begin
      Lc_Prin.Eject;
    end
    else
    begin
      For Lc_II := 1 to (StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),2)+1) do
      Begin
        Inc(Lc_I);
        Lc_Prin.TextOutLC(Lc_I,1,'');
      end;
    end;
    Lc_Prin.Finalize;
    FreeAndNil(Lc_Prin);
    FreeAndNil(Lc_Observacao);
  except
    If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
      Lc_Prin.Eject;
    Lc_Prin.Finalize;
    FreeAndNil(Lc_Prin);
    FreeAndNil(Lc_Observacao);
    Exit;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_Srv_1;
Var
  F: TextFile;
  Lc_I:Integer;
  Lc_Linha : Integer;
  Lc_Mecanicos : String;
  Lc_Prin : TPrin;
Begin
  //Monta o pedido
  Pc_AbreDadosPedido;
  Pc_AbreDadosOrdem('PEDIDO');
    Lc_Linha := 1;
    Lc_Prin:=TPrin.Create(nil);
    With Lc_Prin Do
    begin
      Initialize(It_Porta);

      Negrito(False);
      Condensa(True);
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'ORDEM DE SERVICO: ');

      textoutLc(Lc_Linha,19,Padr(StrZero(StrToIntDef(Qr_Pedido.fieldbyname('ped_numero').Value,0),5,0),8));
      TextOutLC(Lc_Linha,117,'DATA  : ' + Qr_Ordem.FieldByName('DATA').AsString  );

      Lc_Linha := Lc_Linha + 1;

      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Pc_AtivaEstabelecimento;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'EMPRESA: ' + Copy(DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString,1,70));
      TextOutLC(Lc_Linha,72,'ENDERECO: ' + Copy(DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ', ' +DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString ,1,37));


      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'BAIRRO: ' + Copy(DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString,1,50));
      TextOutLC(Lc_Linha,47,'CIDADE: ' + Copy(DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString,1,30));
      TextOutLC(Lc_Linha,87,'UF: ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString);
      TextOutLC(Lc_Linha,9,'CEP: ' + Fc_MascaraCep(DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString));
      TextOutLC(Lc_Linha,115,'FONE: ' + fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'CNPJ: ' + fc_MascaraCNPJ(DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString));
      TextOutLC(Lc_Linha,57,'INSCRICAO : ' + DM.Qr_Estabelecimento.FieldByname('EMP_INSC_EST').AsString);
      TextOutLC(Lc_Linha,115,'FAX : ' + fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FAX').AsString));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'CLIENTE: ' + Copy(Qr_Pedido.FieldByName('EMP_NOME').AsString,1,70));
      TextOutLC(Lc_Linha,72,'ENDERECO: ' + Copy(Qr_Pedido.FieldByName('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByName('END_NUMERO').AsString + ' ' + Qr_Pedido.FieldByName('END_COMPLEM').AsString,1,50));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'BAIRRO: ' + Copy(Qr_Pedido.FieldByName('END_BAIRRO').AsString,1,37));
      TextOutLC(Lc_Linha,47,'CIDADE: ' + Copy(Qr_Pedido.FieldByName('CDD_DESCRICAO').AsString,1,30));
      TextOutLC(Lc_Linha,87,'UF: ' + Qr_Pedido.FieldByName('UFE_SIGLA').AsString);
      TextOutLC(Lc_Linha,9,'CEP: ' + Fc_MascaraCep(Qr_Pedido.FieldByName('END_CEP').AsString));
      TextOutLC(Lc_Linha,115,'FONE: ' + fc_MascaraFone(Qr_Pedido.FieldByName('END_FONE').AsString));

      Lc_Linha := Lc_Linha + 1;
      if Length(Qr_Pedido.FieldByName('EMP_CNPJ').AsString)>11 then
        TextOutLC(Lc_Linha,1,'CNPJ: ' + fc_MascaraCNPJ(Qr_Pedido.FieldByName('EMP_CNPJ').AsString))
      else
        TextOutLC(Lc_Linha,1,'CPF: ' + fc_MascaraCPF(Qr_Pedido.FieldByName('EMP_CNPJ').AsString));
      TextOutLC(Lc_Linha,57,'I.E.RG : ' + Qr_Pedido.FieldByName('EMP_INSC_EST').AsString);
      TextOutLC(Lc_Linha,115,'FAX : ' + fc_MascaraFone(Qr_Pedido.FieldByName('END_FAX').AsString));

      Lc_Linha := Lc_Linha + 1;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,Copy('MARCA: ' + Qr_Ordem.FieldByName('TPV_DESCRICAO').AsString + ' ' +Qr_Ordem.FieldByName('MRC_DESCRICAO').AsString ,1,27));
      TextOutLC(Lc_Linha,29,Copy('MODELO: ' + Qr_Ordem.FieldByName('MOD_DESCRICAO').AsString,1,32));
      TextOutLC(Lc_Linha,62,'PLACA : ' + Copy(Qr_Ordem.FieldByName('VEI_PLACA').AsString,1,3) + '-' + Copy(Qr_Ordem.FieldByName('VEI_PLACA').AsString,4,4));
      TextOutLC(Lc_Linha,81,'KM/HR : '+  Qr_Ordem.FieldByName('VEI_KM').AsString);
      TextOutLC(Lc_Linha,99,'FROTA : ' + Qr_Ordem.FieldByName('VEI_FROTA').AsString);
      TextOutLC(Lc_Linha,116,'COR: ' + Copy(Qr_Ordem.FieldByName('COR_DESCRICAO').AsString,1,13));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');
      It_Observacao.Clear;
      It_Observacao.Lines.Add(Qr_Ordem.FieldByName('OBS').AsString);
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'SERVICO SOLICITADO/IDENTIFICADO E OBSERVACOES');
      For Lc_I := 0 to (It_Observacao.Lines.Count - 1) do
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,It_Observacao.Lines[Lc_I]);
      end;

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'MECANICO              DESCRICAO DOS SERVICOS                                                         QTDE/HORAS              SUBTOTAL');

      Qr_ItensSrv.Active := false;
      Qr_ItensSrv.sql.clear;
      Qr_ItensSrv.sql.add(' SELECT PRO_CODIGO,ITF_CODIGO,ITF_CODPED,ITF_CODNFL, ITF_CODPRO, PRO_DESCRICAO,          ');
      Qr_ItensSrv.sql.add(' ITF_QTDE, ITF_VL_CUSTO, ITF_VL_UNIT, ITF_AQ_COM, MED_ABREVIATURA,PRO_CODIGOFAB,         ');
      Qr_ItensSrv.sql.add('(ITF_QTDE * ITF_VL_UNIT) ITF_VL_SUBTOTAL                                                 ');
      Qr_ItensSrv.sql.add(' FROM TB_ITENS_NFL Tb_itens_nfl                                                          ');
      Qr_ItensSrv.sql.add(' INNER JOIN TB_PEDIDO Tb_pedido ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO)     ');
      Qr_ItensSrv.sql.add(' INNER JOIN TB_PRODUTO Tb_produto ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)  ');
      Qr_ItensSrv.sql.add(' INNER JOIN TB_MEDIDA tb_medida  ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)      ');
      Qr_ItensSrv.sql.add(' wHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO = ''S'')                                  ');
      Qr_ItensSrv.sql.add('ORDER BY PRO_DESCRICAO                                                                   ');
      Qr_ItensSrv.ParamByName('PED_CODIGO').asinteger:=FCodigoPedido;
      Qr_ItensSrv.active:=true;
      Qr_ItensSrv.FetchAll;
      Qr_ItensSrv.First;
      while not Qr_ItensSrv.Eof do
      Begin
        Qr_Tecnico.Active := False;
        Qr_Tecnico.SQL.Clear;
        Qr_Tecnico.SQL.Add(' SELECT TEC_CODCLB             ');
        Qr_Tecnico.SQL.Add(' FROM TB_TECNICO tb_tecnico    ');
        Qr_Tecnico.SQL.Add(' WHERE                         ');
        Qr_Tecnico.SQL.Add(' TEC_CODITF =:ITF_CODIGO       ');
        Qr_Tecnico.ParamByName('ITF_CODIGO').AsInteger := Qr_ItensSrv.FieldByName('ITF_CODIGO').AsInteger;
        Qr_Tecnico.Active := True;
        Qr_Tecnico.First;
        Lc_Mecanicos := '';
        while not Qr_Tecnico.eof do
        Begin
          if Qr_Tecnico.Bof then
            Lc_Mecanicos := Qr_Tecnico.FieldByName('TEC_CODCLB').AsString
          else
            Lc_Mecanicos := Lc_Mecanicos + '/' +Qr_Tecnico.FieldByName('TEC_CODCLB').AsString;
          Qr_Tecnico.Next;
        end;

        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,Copy(Lc_Mecanicos,1,20));
        TextOutLC(Lc_Linha,23,Copy(Qr_ItensSrv.FieldByName('PRO_DESCRICAO').AsString,1,77));

        TextOutLC(Lc_Linha,100,Padr(FormatFloat('#0.###', Qr_ItensSrv.FieldByname('ITF_QTDE').Value),11));
        TextOutLC(Lc_Linha,123,Padr((floattostrf((Qr_ItensSrv.FieldByName('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,10,2)),11));
        Qr_ItensSrv.Next;
      end;

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'CODIGO      DESCRICAO DOS PRODUTOS                                                           QTDE         VL.UNIT.           SUBTOTAL');

      Qr_Itens.Active := True;
      Qr_Itens.First;

      while not Qr_Itens.Eof do
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,Padr(Qr_Itens.FieldByName('PRO_CODIGOFAB').AsString,6));
        TextOutLC(Lc_Linha,13,copy(Qr_Itens.FieldByName('PRO_DESCRICAO').AsString,1,77));
        TextOutLC(Lc_Linha,93,Padr(FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value),6));
        TextOutLC(Lc_Linha,109,Padr((floattostrf((Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
        TextOutLC(Lc_Linha,123,Padr((floattostrf((Qr_Itens.FieldByName('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
        Qr_Itens.Next;
      end;

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'COND. PAGTO: ' + Copy(Qr_Pedido.FieldByName('FPT_DESCRICAO').AsString +' / ' + Copy(Qr_Pedido.FieldByName('PED_PRAZO').AsString,5,length(Qr_Pedido.FieldByName('PED_PRAZO').AsString)-4),1,40));
      TextOutLC(Lc_Linha,108,'VALOR SERVICO :');

      TextOutLC(Lc_Linha,123,Padr(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_SERVICO').AsCurrency, ffFixed, 10,2),11));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'GARANTIA   :' );
      TextOutLC(Lc_Linha,108,'VALOR PECAS   :');
      TextOutLC(Lc_Linha,123,Padr(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_PRODUTO').AsCurrency, ffFixed, 10,2),11));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,108,'SUBTOTAL      :');
      TextOutLC(Lc_Linha,123,Padr(FloatTostrF(Qr_Pedido.FieldByName('PED_VL_SERVICO').AsCurrency + Qr_Pedido.FieldByName('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),11));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'DATA SAIDA :' + Qr_Ordem.FieldByName('EXIT_DATE').AsString  );
      TextOutLC(Lc_Linha,108,'DESCONTOS     :');
      TextOutLC(Lc_Linha,123,Padr(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_DESCONTO').AsCurrency, ffFixed, 10,2),11));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'KM/HR SAIDA:' );
      TextOutLC(Lc_Linha,108,'TOTAL GERAL   :');
      TextOutLC(Lc_Linha,123,Padr(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_PEDIDO').AsCurrency, ffFixed, 10,2),11));

      Lc_Linha := Lc_Linha + 3;
      TextOutLC(Lc_Linha,1,DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString +  '  ____/____/_______       _____________________________________________');
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'                                          NOME E ASSINATURA DO CLIENTE');
    end;
    Lc_Prin.Eject;
    Lc_Prin.Finalize;
    FreeAndNil(Lc_Prin);
    Exit;
end;



procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_1;
Var
  Lc_Form : TRL_PedidoVenda_1;
begin
  try
    Lc_Form := TRL_PedidoVenda_1.create(nil);
    Lc_Form.It_Codigo := FCodigoPedido;
    Lc_Form.It_Vl_Credito := it_vl_credito;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Print(Qrpt: TQuickRep);
Begin
  //Qrpt.Prepare;
  if FSalvaPDF then
  Begin
    Qrpt.Prepare;
    Qrpt.ExportToFilter(TQRPDFDocumentFilter.Create(GbPathExe + FNomePDF));
  End
  else
  Begin
    if Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S' then
      Qrpt.Preview
    else
      Qrpt.Print;
  End;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_1;
Var
  Lc_Form : TRL_Servico;
begin
  try
    Lc_Form := TRL_Servico.create(nil);
    Lc_Form.It_Codigo := FCodigoPedido;
    Print(Lc_Form.Qrpt)
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Pc_Modelo_Inexistente(Pc_TipoPed:integer;Pc_NrModelo:integer);
var
lc_msg:string;
begin
  if Pc_TipoPed = 0 then
  lc_msg:= ' de Orçamento'
  ELSE
  if Pc_TipoPed = 1 then
  lc_msg:= ' do Pedido de Venda'
  else
  if Pc_TipoPed = 2 then
  lc_msg:= 'do Pedido de Compra'
  else
  if Pc_TipoPed = 3 then
  lc_msg:= 'do Pedido de Ajuste';

 MensagemPadrao(' Mensagem', 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                ' O Modelo ' + IntToStr(Pc_NrModelo) +  lc_msg + ' inexistente!' + EOLN  +
                ' Verifique a Configuração.',
                 ['OK'], [bEscape], mpInformacao);

{  MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                ' O Modelo ' + IntToStr(Pc_NrModelo) +  lc_msg + ' não está Disponivel!' + EOLN , +
                ' Contate o administrado do Sistema.',
  ['OK'], [bEscape], mpInformacao);}

end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_2;
Var
  Lc_Form : TRL_PedidoVenda_2;
BEGIN
  try
    Lc_Form := TRL_PedidoVenda_2.Create(nil);
    Lc_Form.It_Nr_Pedido := Qr_Pedido.fieldbyname('ped_numero').AsString;
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  Finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
END;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_2;
begin
  Pc_Imp_Vda_JatoLaser_Vda_2;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_3;
Var
  Lc_Form : TRL_PedidoVenda_3;
begin
  try
    Lc_Form := TRL_PedidoVenda_3.Create(nil);
    Lc_Form.It_Nr_Pedido := Qr_Pedido.fieldbyname('ped_numero').AsString;
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_3;
begin
//Extimplas
  Pc_Imp_Vda_JatoLaser_Vda_3;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_4;
Var
  Lc_Form: TRL_PedidoVenda_4;
begin
//Extimplas
//  if not(Fc_HabilitaPermissao('RL_Vendas_3','VISUALIZAR','S')) then exit;
  try
    Lc_Form := TRL_PedidoVenda_4.create(nil);
    Lc_Form.It_Nr_Pedido := Qr_Pedido.fieldbyname('ped_numero').AsInteger;
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_4;
begin
//Extimplas
  Pc_Imp_Vda_JatoLaser_Vda_4;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_5;
Var
  Lc_Form : TRL_PedidoVenda_5;
begin
  //São Luiz
  Try
    Lc_Form := TRL_PedidoVenda_5.Create(nil);
    Lc_Form.It_Codigo := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_5;
begin
  //São Luiz
  Pc_Imp_Vda_JatoLaser_Vda_5;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_6;
Var
  Lc_Form : TRL_PedidoVenda_6;
begin
  //São Luiz
  Try
    Lc_Form := TRL_PedidoVenda_6.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_6;
Begin
  Pc_Imp_Vda_JatoLaser_Vda_6;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_7;
Var
  Lc_Form: TRL_PedidoVenda_7;
begin
  try
    Lc_Form := TRL_PedidoVenda_7.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_7;
Begin
  Pc_Imp_Vda_JatoLaser_Vda_7;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_8;
Var
  Lc_Form : TRL_ReportOrder_11;
begin
  try
    Lc_Form := TRL_ReportOrder_11.create(nil);
    Lc_Form.CodigoPedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
 end;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_8;
Begin
  Pc_Imp_Vda_JatoLaser_Vda_8;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_9;
Var
  Lc_Form : TRL_ReportOrder_12;
begin
  try
    Lc_Form := TRL_ReportOrder_12.create(nil);
    Lc_Form.CodigoPedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_9;
Begin
  Pc_Imp_Vda_JatoLaser_Vda_9;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_10;
Var
  Lc_Form : TRL_PedidoVenda_8;
begin
  //São Luiz
  Try
    Lc_Form := TRL_PedidoVenda_8.Create(nil);
    Lc_Form.It_Codigo := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TImpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_11;
Var
  Lc_Form : TRL_PedidoVenda_9;
begin
  //Brasil SAcolas
  Try
    Lc_Form := TRL_PedidoVenda_9.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TImpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_12;
Var
  Lc_Form : TRL_PedidoVenda_10;
begin
  //São Luiz
  Try
    Lc_Form := TRL_PedidoVenda_10.Create(nil);
    Lc_Form.It_Codigo := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TImpModImpressao.Pc_Imp_Vda_JatoLaser_Vda_13;
Var
  Lc_Form : TRL_PedidoVenda_11;
begin
  //Brasil SAcolas
  Try
    Lc_Form := TRL_PedidoVenda_11.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_10;
Begin
  Pc_Imp_Vda_JatoLaser_Vda_10;
end;

procedure TImpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_11;
begin
  Pc_Imp_Vda_JatoLaser_Vda_11;
end;


procedure TImpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_12;
begin
  Pc_Imp_Vda_JatoLaser_Vda_12;
end;

procedure TImpModImpressao.Pc_Imp_Vda_JatoLaser_Srv_13;
begin
  Pc_Imp_Vda_JatoLaser_Vda_13;
end;

//Frente de Caixa
procedure  TimpModImpressao.Pc_Imp_Frt_Matricial(Pc_Cd_Pedido:Integer;Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real);
Begin
  it_Modelo_matricial := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_MOD_MATRICIAL', '1'),0);
  FCodigoPedido := Pc_Cd_Pedido;
  case it_Modelo_matricial of
    1:Pc_Imp_Frt_Matricial_Vda_1(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco);   //MODELO 1 - EPSON
    2:Pc_Imp_Frt_Matricial_Vda_2(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco,7); //MODELO 2 - BEMATECH MP4200
    3:Pc_Imp_Frt_Matricial_Vda_2(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco,5); //MODELO 3 - BEMATECH MP4000
    4:Pc_Imp_Frt_Matricial_Vda_2(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco,5); //MODELO 4 - BEMATECH MP100S
    5:Pc_Imp_Frt_Matricial_Vda_5(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco,5); //GERENCIADOR WINDOWS
    6:Pc_Imp_Frt_Matricial_Vda_2(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco,8); //MODELO 6 - BEMATECH MP2500
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Frt_Matricial_Vda_1(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real);
var
  subtotal, total: currency;
  traco: string;
  Lc_I,Lc_Salto : Integer;
  Lc_Linha : Integer;
  Lc_Nr_Colunas : Integer;
  Lc_Finaliza: TextFile;
  Lc_Aux_List : TStringList;
begin

  //Cria a Consulta
  Pc_AbreDadosPedido;

  total := 0;
  It_Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', '');
  if Trim(It_Porta) = '' then
  BEgin
    MensagemPadrao(' Mensagem', 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                  ' Por favor defina uma porta de comunicação com a impressora.' + EOLN  +
                  ' Verifique a Configuração.',
                   ['OK'], [bEscape], mpInformacao);
    exit;
  End;

  It_FRow:=1;
  It_FCol:=1;
  AssignFile(It_Arquivo,It_Porta);
  Rewrite(It_Arquivo);
  Lc_Linha := 1;
  Lc_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)

  //Define o tamanhho do Traço
  Traco := '';
  For Lc_I:= 1 to Lc_Nr_Colunas do
    Traco := Traco + '-';


  Pc_AtivaEstabelecimento;
  DM.Qr_Estabelecimento.First;

  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString,Lc_Nr_Colunas));
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('END_Numero').AsString,Lc_Nr_Colunas));
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString,Lc_Nr_Colunas));
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaC(fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString),Lc_Nr_Colunas));
  //Verifica se o cupom foi registrado em um cliente diferente do consumidor
  if Qr_Pedido.FieldByName('PED_CODEMP').AsInteger <> StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0) then
  Begin
    Inc(Lc_linha);
    Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas));
    Inc(Lc_linha);
    Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE('CLIENTE: ' + Qr_Pedido.FieldByname('EMP_FANTASIA').AsString ,Lc_Nr_Colunas));
    Inc(Lc_linha);
    if (Qr_Pedido.FieldByname('END_FONE').AsString <> '') then
      Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE('FONE   : ' + fc_MascaraFone( Qr_Pedido.FieldByname('END_FONE').AsString ) ,Lc_Nr_Colunas))
    else
    if (Qr_Pedido.FieldByname('END_CELULAR').AsString <> '') then
      Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE('FONE   : ' + fc_MascaraFone( Qr_Pedido.FieldByname('END_CELULAR').AsString ) ,Lc_Nr_Colunas))
  end;
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas));
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE('Nº ' + Qr_Pedido.FieldByname('PED_NUMERO').AsString + '   ' + Qr_Pedido.FieldByname('DATA').AsString +' - ' + TimeToStr(time)  ,Lc_Nr_Colunas));
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas));
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE('Descriçao dos Produtos  ',Lc_Nr_Colunas));
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE('Qte    VL. Unitário            Sub-Total',Lc_Nr_Colunas));
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas));
  Inc(Lc_linha);
  // Imprime itens do pedido...
  while not Qr_Itens.eof do
  begin
    if Length(Trim(Qr_Itens.FieldByname('IAV_DESCRICAO').AsString)) > 0 then
      Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(Copy(Qr_Itens.FieldByname('IAV_DESCRICAO').Value,1,Lc_Nr_Colunas),Lc_Nr_Colunas))
    else
      Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(Copy(Qr_Itens.FieldByname('PRO_DESCRICAO').Value,1,Lc_Nr_Colunas),Lc_Nr_Colunas));
    Inc(Lc_Linha);
    Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value),6));
    Pc_TextOutLC(Lc_Linha,7,Pc_AlinhaE( ' X ',3));
    Pc_TextOutLC(Lc_Linha,11,Pc_AlinhaD(FormatFloat('###,##0.00', Qr_Itens.FieldByname('ITF_VL_UNIT').Value),10));
    subtotal := Qr_Itens.FieldByname('ITF_QTDE').Value * Qr_Itens.FieldByname('ITF_VL_UNIT').Value;
    subtotal := RoundTo(subtotal,-2);
    total := total + subtotal;
    Pc_TextOutLC(Lc_Linha,22,Pc_AlinhaD(FormatFloat('###,###,##0.00', subtotal),19));
    Qr_Itens.Next;
    Inc(Lc_linha);
  end;

  // Frete
  if Qr_Pedido.FieldByname('PED_VL_FRETE').AsCurrency > 0 then
  Begin
    Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas));
    Inc(Lc_Linha);
    Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE('Valor total do Frete',22));
    Pc_TextOutLC(Lc_Linha,22,Pc_AlinhaD(FormatFloat('###,###,##0.00', Qr_Pedido.FieldByname('PED_VL_FRETE').AsCurrency ),17));
    Inc(Lc_Linha);
  End;

  // Total...
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas));
  Inc(Lc_Linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE('Total Geral do Cupom',22));
  Pc_TextOutLC(Lc_Linha,22,Pc_AlinhaD(FormatFloat('###,###,##0.00', total),17));

  // Desconto Global
  if Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency > 0 then
  begin
    Inc(Lc_Linha);
    Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE('(-) Desconto Global',22));
    Pc_TextOutLC(Lc_Linha,22,Pc_AlinhaD(FormatFloat('-##,###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_DESCONTO').Text, 0)),17));
    // Total Liquido...
    Inc(Lc_Linha);
    Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE('VALOR A PAGAR R$',22));
    Pc_TextOutLC(Lc_Linha,22,Pc_AlinhaD(FormatFloat('###,###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_PEDIDO').Text, 0)),17));
  end;


  Pc_AbreDadosFinanceiro;
  if Qr_Financeiro.RecordCount > 0 then
  Begin
    Inc(Lc_Linha);
    Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas));
    Inc(Lc_Linha);
    Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE('VALOR RECEBIDO',22));
    Pc_TextOutLC(Lc_Linha,22,Pc_AlinhaD(FloatToStrF(Qr_Pedido.FieldByname('VALUE_RECIVED').AsFloat,ffFixed,10,2) ,17));
    while not Qr_Financeiro.Eof do
    Begin
      inc(Lc_linha);
      Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString,22));
      if (Pos('DINHEIRO',Trim(Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString))>0) then
        Pc_TextOutLC(Lc_Linha,22,Pc_AlinhaD(FloatToStrF(Qr_Financeiro.FieldByname('FIN_VL_PARCELA').AsCurrency + Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat,ffFixed,10,2) ,17))
      else
        Pc_TextOutLC(Lc_Linha,22,Pc_AlinhaD(FloatToStrF(Qr_Financeiro.FieldByname('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2) ,17));
      Qr_Financeiro.Next;
    End;
  End;


  if Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat > 0 then
  begin
    Inc(Lc_Linha);
    Pc_TextOutLC( Lc_Linha,1,Pc_AlinhaE('VALOR DO TROCO R$ ',22));
    Pc_TextOutLC( Lc_Linha,22,Pc_AlinhaD(FloatToStrF(Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat,ffFixed,10,2) ,17));
  end;


  if ( Qr_Pedido.FieldByName('PED_INDPRES').AsInteger  = 4 ) then
  Begin
    Inc(Lc_Linha);
    Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas));
    Inc(Lc_Linha);
    Pc_TextOutLC( Lc_Linha,1,Pc_AlinhaC(Qr_Pedido.FieldByName('END_BAIRRO').AsString,Lc_Nr_Colunas ) );
    Inc(Lc_Linha);
    Pc_TextOutLC( Lc_Linha,1,Copy(Qr_Pedido.FieldByName('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByName('END_NUMERO').AsString,1,Lc_Nr_Colunas ));
    if Length(Qr_Pedido.FieldByName('END_COMPLEM').AsString) > 0 then
    Begin
      Inc(Lc_Linha);
      Pc_TextOutLC(Lc_Linha,1,copy(Qr_Pedido.FieldByName('END_COMPLEM').AsString,1,Lc_Nr_Colunas ));
    end;
    Inc(Lc_Linha);
    Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas));
  End;

  IF trim(Qr_Pedido.FieldByname('PED_OBS').AsString) <> '' then
  Begin
    Lc_LInha := Lc_LInha + 2;
    Pc_TextOutLC(Lc_Linha,1,'Observacao:' );
    It_Observacao.Lines.Add('');
    It_Observacao.Text := Qr_Pedido.FieldByname('PED_OBS').AsString;
    For lc_I := 0 to It_Observacao.Lines.Count - 1 do
    Begin
      Inc(Lc_Linha);
      Pc_TextOutLC(Lc_Linha,1,copy(It_Observacao.Lines[Lc_I],1,Lc_Nr_Colunas ));
    End;
  end;

  //PROGRAMA PAYBACK
  Lc_LInha := Lc_LInha + 2;
  Lc_Aux_List := ImprimeProgramaPayBack(Lc_Nr_Colunas,Qr_Pedido.FieldByName('EMP_CODIGO').AsInteger);
  if Lc_Aux_List.Count > 0 then
  Begin
    for Lc_I := 0 to Lc_Aux_List.Count-1 do
    Begin
      Lc_LInha := Lc_LInha + 1;
      Pc_TextOutLC(Lc_Linha,1,Lc_Aux_List[Lc_I]);
    End;
  End;

  //PROGRAMA CARTÃO PRE-PAGO
  Lc_LInha := Lc_LInha + 2;
  Lc_Aux_List := ImprimeProgramaCartaoPrePago(Lc_Nr_Colunas,Qr_Pedido.FieldByName('EMP_CODIGO').AsInteger);
  if Lc_Aux_List.Count > 0 then
  Begin
    for Lc_I := 0 to Lc_Aux_List.Count-1 do
    Begin
      Lc_LInha := Lc_LInha + 1;
      Pc_TextOutLC(Lc_Linha,1,Lc_Aux_List[Lc_I]);
    End;
  End;

  Lc_LInha := Lc_LInha + 3;

  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaC('***  SEM VALOR FISCAL  ***',Lc_Nr_Colunas));
  Inc(Lc_Linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaC('***  CAIXA: '+ GB_Nm_Usuario +' ***',Lc_Nr_Colunas));
  Writeln(It_Arquivo);
  CloseFile(It_Arquivo);

  //Finaliza o Cupom
  AssignFile(Lc_Finaliza,It_Porta);
  Rewrite(Lc_Finaliza);
  Lc_Salto := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRETE','FRT_P_SALTO','0'), 0);
  For Lc_I := 1 to Lc_Salto do
    Writeln(Lc_Finaliza);
  CloseFile(Lc_Finaliza);

  //Aciona Guilhotina
  Pc_AcionaGuilhotina(It_Porta);

end;

procedure  TimpModImpressao.Pc_Imp_Frt_Matricial_Vda_2(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real;ModeloBematech:Integer);
var
  subtotal, total: currency;
  traco: string;
  Lc_I,Lc_Salto : Integer;
  Lc_Linha : Integer;
  Lc_Nr_Colunas : Integer;
  Lc_Finaliza: TextFile;
  Print : TGeneralPrint;
  TextToPrint : String;
  Lc_Aux_List : TSTringList;
begin
  //Cria a Consulta
  Pc_AbreDadosPedido;
  Print := TPrintGeneralFactory.criarPrint('BEMATECH - MP4200');
  with Print do
  Begin
    ModeloImpressora := ModeloBematech;
    total := 0;
    Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', '');
    Lc_Linha := 1;
    Lc_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)

    Pc_AtivaEstabelecimento;
    DM.Qr_Estabelecimento.First;

    Iniciar;
    //Define o tamanhho do Traço
    Traco := '';
    For Lc_I:= 1 to Lc_Nr_Colunas do
      Traco := Traco + '-';

    TextOutLC(Lc_Linha,1,Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString,Lc_Nr_Colunas,''));
    Inc(Lc_linha);
    TextOutLC(Lc_Linha,1,Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('END_Numero').AsString,Lc_Nr_Colunas,''));
    Inc(Lc_linha);
    TextOutLC(Lc_Linha,1,Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString,Lc_Nr_Colunas,''));
    Inc(Lc_linha);
    TextOutLC(Lc_Linha,1,Pc_AlinhaC(fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString),Lc_Nr_Colunas,''));
    //Verifica se o cupom foi registrado em um cliente diferente do consumidor
    if Qr_Pedido.FieldByName('PED_CODEMP').AsInteger <> StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0) then
    Begin
      Inc(Lc_linha);
      TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas,''));
      Inc(Lc_linha);
      TextOutLC(Lc_Linha,1,Pc_AlinhaE('CLIENTE: ' + Qr_Pedido.FieldByname('EMP_FANTASIA').AsString ,Lc_Nr_Colunas,''));

      Inc(Lc_linha);
      if (Qr_Pedido.FieldByname('END_FONE').AsString <> '') then
        TextOutLC(Lc_Linha,1,Pc_AlinhaE ('FONE   : ' + Qr_Pedido.FieldByname('END_FONE').AsString ,Lc_Nr_Colunas,''))
      else
      if (Qr_Pedido.FieldByname('END_CELULAR').AsString <> '') then
        TextOutLC(Lc_Linha,1,Pc_AlinhaE('FONE   : ' + Qr_Pedido.FieldByname('END_CELULAR').AsString ,Lc_Nr_Colunas,''))

    end;
    Inc(Lc_linha);
    TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas,''));
    Inc(Lc_linha);
    TextOutLC(Lc_Linha,1,Pc_AlinhaE('Nº ' + Qr_Pedido.FieldByname('PED_NUMERO').AsString + '   ' + Qr_Pedido.FieldByname('DATA').AsString +' - ' + TimeToStr(time)   ,Lc_Nr_Colunas,''));
    Inc(Lc_linha);
    TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas,''));
    Inc(Lc_linha);
    TextOutLC(Lc_Linha,1,Pc_AlinhaE('Descriçao dos Produtos  ',Lc_Nr_Colunas,''));
    Inc(Lc_linha);
    TextOutLC(Lc_Linha,1,Pc_AlinhaE('Qte    VL. Unitário            Sub-Total',Lc_Nr_Colunas,''));
    Inc(Lc_linha);
    TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas,''));
    Inc(Lc_linha);
    // Imprime itens do pedido...
    while not Qr_Itens.eof do
    begin

      subtotal := Qr_Itens.FieldByname('ITF_QTDE').Value * Qr_Itens.FieldByname('ITF_VL_UNIT').Value;
      subtotal := RoundTo(subtotal,-2);
      total := total + subtotal;
      //1º Linha dos Itens
      if Length(Trim(Qr_Itens.FieldByname('IAV_DESCRICAO').AsString)) > 0 then
        TextToPrint := Pc_AlinhaE(Copy(Qr_Itens.FieldByname('IAV_DESCRICAO').Value,1,Lc_Nr_Colunas),Lc_Nr_Colunas,'')
      else
        TextToPrint := Pc_AlinhaE(Copy(Qr_Itens.FieldByname('PRO_DESCRICAO').Value,1,Lc_Nr_Colunas),Lc_Nr_Colunas,'');


      TextOutLC(Lc_Linha,1,TextToPrint);
      Inc(Lc_Linha);
      //º Linha dos Itens
      TextToPrint := Concat(Pc_AlinhaE(FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value),6,''),
                            Pc_AlinhaE( ' X ',3,''),
                            Pc_AlinhaD(FormatFloat('###,##0.00', Qr_Itens.FieldByname('ITF_VL_UNIT').Value),10,''),
                            Pc_AlinhaD(FormatFloat('###,###,##0.00', subtotal),19,'')
                           );
      TextOutLC(Lc_Linha,1,TextToPrint);
      Qr_Itens.Next;
      Inc(Lc_linha);
    end;

    // Total...
    TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas,''));
    Inc(Lc_Linha);
    TextToPrint := Concat(Pc_AlinhaE('Total Geral do Cupom',22,''),
                          Pc_AlinhaD(FormatFloat('###,###,##0.00', total),17,'')
                          );
    TextOutLC(Lc_Linha,1,TextToPrint);
    // Desconto Global
    if Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency > 0 then
    begin
      Inc(Lc_Linha);
      TextToPrint := Concat(Pc_AlinhaE('(-) Desconto Global',22,''),
                            Pc_AlinhaD(FormatFloat('-##,###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_DESCONTO').Text, 0)),17,'')
                            );
      TextOutLC(Lc_Linha,1,TextToPrint);
      // Total Liquido...
      Inc(Lc_Linha);
      TextToPrint := Concat(Pc_AlinhaE('VALOR A PAGAR R$',22,''),
                            Pc_AlinhaD(FormatFloat('###,###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_PEDIDO').Text, 0)),17,'')
                            );
      TextOutLC(Lc_Linha,1,TextToPrint);
    end;

    Pc_AbreDadosFinanceiro;
    if Qr_Financeiro.RecordCount > 0 then
    Begin

      Inc(Lc_linha);
      TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas,''));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1, Pc_AlinhaE('VALOR RECEBIDO',22,''));
      TextOutLC(Lc_Linha,22,Pc_AlinhaD(FloatToStrF(Qr_Pedido.FieldByname('VALUE_RECIVED').AsFloat,ffFixed,10,2) ,17,''));
      while not Qr_Financeiro.Eof do
      Begin
        inc(Lc_linha);
        if (Pos('DINHEIRO',Trim(Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString))>0) then
        Begin
          TextToPrint := Concat(Pc_AlinhaE(Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString,22,''),
                                Pc_AlinhaD(FloatToStrF(Qr_Financeiro.FieldByname('FIN_VL_PARCELA').AsCurrency + Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat,ffFixed,10,2) ,17,'')
                                )
        End
        else
        Begin
          TextToPrint := Concat(Pc_AlinhaE(Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString,22,''),
                                Pc_AlinhaD(FloatToStrF(Qr_Financeiro.FieldByname('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2) ,17,'')
                                );
        End;
        TextOutLC(Lc_Linha,1,TextToPrint);
        Qr_Financeiro.Next;
      End;
    End;

    if Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat > 0 then
    begin
      Inc(Lc_Linha);
      TextToPrint := Concat(Pc_AlinhaE('VALOR DO TROCO R$ ',22,''),
                            Pc_AlinhaD(FloatToStrF(Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat,ffFixed,10,2) ,17,'')
                            );
      TextOutLC(Lc_Linha,1,TextToPrint);
    end;

    if ( Qr_Pedido.FieldByName('PED_INDPRES').AsInteger  = 4 ) then
    Begin
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas,''));
      Inc(Lc_Linha);
      //bAIRRO
      Lc_Linha := Lc_Linha + 2;
      TextOutLC( Lc_Linha,1,Pc_AlinhaC(Qr_Pedido.FieldByName('END_BAIRRO').AsString,Lc_Nr_Colunas,'-' ) );
      Lc_Linha := Lc_Linha + 1;
      TextOutLC( Lc_Linha,1,Copy(Qr_Pedido.FieldByName('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByName('END_NUMERO').AsString,1,Lc_Nr_Colunas ));
      if Length(Qr_Pedido.FieldByName('END_COMPLEM').AsString) > 0 then
      Begin
        Lc_Linha := Lc_Linha + 1;
        Pc_TextOutLC(Lc_Linha,1,copy(Qr_Pedido.FieldByName('END_COMPLEM').AsString,1,Lc_Nr_Colunas ));
      end;
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,Pc_AlinhaE(traco,Lc_Nr_Colunas,''));
    End;

    IF trim(Qr_Pedido.FieldByname('PED_OBS').AsString) <> '' then
    Begin
      Lc_LInha := Lc_LInha + 2;
      Pc_TextOutLC(Lc_Linha,1,'Observacao:' );
      It_Observacao.Lines.Add('');
      It_Observacao.Text := Qr_Pedido.FieldByname('PED_OBS').AsString;
      For lc_I := 0 to It_Observacao.Lines.Count - 1 do
      Begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,copy(It_Observacao.Lines[Lc_I],1,Lc_Nr_Colunas ));
      End;
    end;

    //PROGRAMA PAYBACK
    Lc_LInha := Lc_LInha + 2;
    Lc_Aux_List := ImprimeProgramaPayBack(Lc_Nr_Colunas,Qr_Pedido.FieldByName('EMP_CODIGO').AsInteger);
    if Lc_Aux_List.Count > 0 then
    Begin
      for Lc_I := 0 to Lc_Aux_List.Count-1 do
      Begin
        Lc_LInha := Lc_LInha + 1;
        TextOutLC(Lc_Linha,1,Lc_Aux_List[Lc_I]);
      End;
    End;

    //PROGRAMA CARTÃO PRE-PAGO
    Lc_LInha := Lc_LInha + 2;
    Lc_Aux_List := ImprimeProgramaCartaoPrePago(Lc_Nr_Colunas,Qr_Pedido.FieldByName('EMP_CODIGO').AsInteger);
    if Lc_Aux_List.Count > 0 then
    Begin
      for Lc_I := 0 to Lc_Aux_List.Count-1 do
      Begin
        Lc_LInha := Lc_LInha + 1;
        TextOutLC(Lc_Linha,1,Lc_Aux_List[Lc_I]);
      End;
    End;

    Lc_LInha := Lc_LInha + 3;

    TextOutLC(Lc_Linha,1,Pc_AlinhaC('***  SEM VALOR FISCAL  ***',Lc_Nr_Colunas,''));
    Inc(Lc_Linha);
    TextOutLC(Lc_Linha,1,Pc_AlinhaC('***  CAIXA: '+ GB_Nm_Usuario +' ***',Lc_Nr_Colunas,''));

    //Finaliza o Cupom
     saltar(StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRETE','FRT_P_SALTO','0'), 2));
    //Retirado em 18/07/2017 - corte duplo acontecendo na Mercado Bonfim
    //Recolocado em 02/08/2017 - Impressão especifica da Bematech
    CortarPapel(0);
    Fechar;
  End;
end;

procedure TimpModImpressao.Pc_Imp_Frt_Matricial_Vda_5(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real;ModeloBematech:Integer);
var
  Handle: THandle;
  CaracteresImpressos: DWORD;
  Documento: TDocInfo1;
  TextoAnsiString : AnsiString;
  TextoUnicode: string;
  //-------
  subtotal, total: currency;
  traco: string;
  Lc_I,Lc_Salto : Integer;
  Lc_Linha : Integer;
  Lc_Nr_Colunas : Integer;
  Lc_Finaliza: TextFile;
  TextToPrint : String;
  Lc_Aux_List : TStringList;
begin
  //Cria a Consulta
  Pc_AbreDadosPedido;


  Documento.pDocName := PChar(concat('Pedido - ',Qr_Pedido.FieldByname('PED_NUMERO').AsString));
  Documento.pOutputFile := nil;
  Documento.pDataType := 'RAW';

  //Inicia um novo documento no Spool do Windows
  StartDocPrinter(Handle, 1, @Documento);

 //Apenas notifica o Windows que uma nova página começará.
  //Nenhum controle é aplicado a impressora.
  StartPagePrinter(Handle);

  Lc_Linha := 1;
  Lc_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)

  //Define o tamanhho do Traço
  Traco := '';
  For Lc_I:= 1 to Lc_Nr_Colunas do
    Traco := Traco + '-';

  Pc_AtivaEstabelecimento;
  DM.Qr_Estabelecimento.First;

  TextoUnicode := #27#69 + Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString,Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := #27#69 + Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('END_Numero').AsString,Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := #27#69 + Pc_AlinhaC(DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString,Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := #27#69 + Pc_AlinhaC(fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString),Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  //Verifica se o cupom foi registrado em um cliente diferente do consumidor
  if Qr_Pedido.FieldByName('PED_CODEMP').AsInteger <> StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0) then
  Begin
    TextoUnicode := #27#69 + Pc_AlinhaE(traco,Lc_Nr_Colunas);
    TextoAnsiString := AnsiString(TextoUnicode);
    WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

    TextoUnicode := #27#69 + Pc_AlinhaE('CLIENTE: ' + Qr_Pedido.FieldByname('EMP_FANTASIA').AsString ,Lc_Nr_Colunas);
    TextoAnsiString := AnsiString(TextoUnicode);
    WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

    if (Qr_Pedido.FieldByname('END_FONE').AsString <> '') then
    Begin
      TextoUnicode := #27#69 + Pc_AlinhaE('FONE   : ' + Qr_Pedido.FieldByname('END_FONE').AsString ,Lc_Nr_Colunas);
      TextoAnsiString := AnsiString(TextoUnicode);
      WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);
    End
    else
    Begin
      if (Qr_Pedido.FieldByname('END_CELULAR').AsString <> '') then
      Begin
        TextoUnicode := #27#69 + Pc_AlinhaE('FONE   : ' + Qr_Pedido.FieldByname('END_CELULAR').AsString ,Lc_Nr_Colunas);
        TextoAnsiString := AnsiString(TextoUnicode);
        WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);
      End;
    End;

  end;

  TextoUnicode := #27#69 + Pc_AlinhaE(traco,Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := #27#69 + Pc_AlinhaE('Nº ' + Qr_Pedido.FieldByname('PED_NUMERO').AsString + '   ' + Qr_Pedido.FieldByname('DATA').AsString +' - ' + TimeToStr(time)  ,Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := #27#69 + Pc_AlinhaE(traco,Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := #27#69 + Pc_AlinhaE('Descriçao dos Produtos  ',Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := #27#69 + Pc_AlinhaE('Qte    VL. Unitário            Sub-Total',Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := #27#69 + Pc_AlinhaE(traco,Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);


  // Imprime itens do pedido...
  while not Qr_Itens.eof do
  begin
    subtotal := Qr_Itens.FieldByname('ITF_QTDE').Value * Qr_Itens.FieldByname('ITF_VL_UNIT').Value;
    subtotal := RoundTo(subtotal,-2);
    total := total + subtotal;
    //1º Linha dos Itens
    if Length(Trim(Qr_Itens.FieldByname('IAV_DESCRICAO').AsString)) > 0 then
      TextoUnicode := #27#69 + Pc_AlinhaE(Copy(Qr_Itens.FieldByname('IAV_DESCRICAO').Value,1,Lc_Nr_Colunas),Lc_Nr_Colunas)
    else
      TextoUnicode := #27#69 + Pc_AlinhaE(Copy(Qr_Itens.FieldByname('PRO_DESCRICAO').Value,1,Lc_Nr_Colunas),Lc_Nr_Colunas);




    TextoAnsiString := AnsiString(TextoUnicode);
    WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

    //º Linha dos Itens
    TextToPrint := Concat(Pc_AlinhaE(FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value),6),
                          Pc_AlinhaE( ' X ',3),
                          Pc_AlinhaD(FormatFloat('###,##0.00', Qr_Itens.FieldByname('ITF_VL_UNIT').Value),10),
                          Pc_AlinhaD(FormatFloat('###,###,##0.00', subtotal),19)
                         );
    TextoUnicode := #27#69 + Pc_AlinhaE(TextToPrint,Lc_Nr_Colunas);
    TextoAnsiString := AnsiString(TextoUnicode);
    WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

    Qr_Itens.Next;
    Inc(Lc_linha);
  end;

  // Total...
  TextoUnicode := #27#69 + Pc_AlinhaE(traco,Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);


  TextToPrint := Concat(Pc_AlinhaE('Total Geral do Cupom',22),
                        Pc_AlinhaD(FormatFloat('###,###,##0.00', total),17)
                        );

  TextoUnicode := #27#69 + Pc_AlinhaE(TextToPrint,Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);


  // Desconto Global
  if Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency > 0 then
  begin
    TextToPrint := Concat(Pc_AlinhaE('(-) Desconto Global',22),
                          Pc_AlinhaD(FormatFloat('-##,###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_DESCONTO').Text, 0)),17)
                          );
    TextoUnicode := #27#69 + Pc_AlinhaE(TextToPrint,Lc_Nr_Colunas);
    TextoAnsiString := AnsiString(TextoUnicode);
    WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

    // Total Liquido...
    TextToPrint := Concat(Pc_AlinhaE('VALOR A PAGAR R$',22),
                          Pc_AlinhaD(FormatFloat('###,###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_PEDIDO').Text, 0)),17)
                          );
    TextoUnicode := #27#69 + Pc_AlinhaE(TextToPrint,Lc_Nr_Colunas);
    TextoAnsiString := AnsiString(TextoUnicode);
    WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  end;

  Pc_AbreDadosFinanceiro;
  if Qr_Financeiro.RecordCount > 0 then
  Begin
    TextoUnicode := #27#69 + Pc_AlinhaE(traco,Lc_Nr_Colunas);
    TextoAnsiString := AnsiString(TextoUnicode);
    WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

    TextToPrint := Concat(Pc_AlinhaE('VALOR RECEBIDO',22),
                          Pc_AlinhaD(FloatToStrF(Qr_Pedido.FieldByname('VALUE_RECIVED').AsFloat,ffFixed,10,2),17)
                          );

    TextoUnicode := #27#69 + TextToPrint;
    TextoAnsiString := AnsiString(TextoUnicode);
    WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

    while not Qr_Financeiro.Eof do
    Begin
      inc(Lc_linha);
      if (Pos('DINHEIRO',Trim(Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString))>0) then
      Begin
        TextToPrint := Concat(Pc_AlinhaE(Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString,22),
                              Pc_AlinhaD(FloatToStrF(Qr_Financeiro.FieldByname('FIN_VL_PARCELA').AsCurrency + Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat,ffFixed,10,2) ,17)
                              )
      End
      else
      Begin
        TextToPrint := Concat(Pc_AlinhaE(Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString,22),
                              Pc_AlinhaD(FloatToStrF(Qr_Financeiro.FieldByname('FIN_VL_PARCELA').AsCurrency,ffFixed,10,2) ,17)
                              );
      End;
      TextoUnicode := #27#69 + TextToPrint;
      TextoAnsiString := AnsiString(TextoUnicode);
      WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

      Qr_Financeiro.Next;
    End;
  End;

  if Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat > 0 then
  begin
    TextToPrint := Concat(Pc_AlinhaE('VALOR DO TROCO R$ ',22),
                          Pc_AlinhaD(FloatToStrF(Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat,ffFixed,10,2) ,17)
                          );
    TextoUnicode := #27#69 + TextToPrint;
    TextoAnsiString := AnsiString(TextoUnicode);
    WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  end;

  if ( Qr_Pedido.FieldByName('PED_INDPRES').AsInteger  = 4 ) then
  Begin
    Lc_LInha := Lc_LInha + 1;
    TextoUnicode := #27#69 + Pc_AlinhaE(traco,Lc_Nr_Colunas);
    Lc_LInha := Lc_LInha + 1;
    //bAIRRO
    Lc_Linha := Lc_Linha + 2;
    TextoUnicode := #27#69 + Pc_AlinhaC(Qr_Pedido.FieldByName('END_BAIRRO').AsString,Lc_Nr_Colunas);
    Lc_Linha := Lc_Linha + 1;
    TextoUnicode := #27#69 + Pc_AlinhaE(Copy((Qr_Pedido.FieldByName('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByName('END_NUMERO').AsString),1,Lc_Nr_Colunas),Lc_Nr_Colunas);
    if Length(Qr_Pedido.FieldByName('END_COMPLEM').AsString) > 0 then
    Begin
      Lc_Linha := Lc_Linha + 1;
      TextoUnicode := #27#69 + Pc_AlinhaE(copy(Qr_Pedido.FieldByName('END_COMPLEM').AsString,1,Lc_Nr_Colunas),Lc_Nr_Colunas);
    end;
    Lc_LInha := Lc_LInha + 1;
    TextoUnicode := #27#69 + Pc_AlinhaE(traco,Lc_Nr_Colunas);
  End;

  IF trim(Qr_Pedido.FieldByname('PED_OBS').AsString) <> '' then
  Begin
    Lc_LInha := Lc_LInha + 2;
    Pc_TextOutLC(Lc_Linha,1,'Observacao:' );
    It_Observacao.Lines.Add('');
    It_Observacao.Text := Qr_Pedido.FieldByname('PED_OBS').AsString;
    For lc_I := 0 to It_Observacao.Lines.Count - 1 do
    Begin
      Inc(Lc_Linha);
      TextoUnicode := #27#69 + copy(It_Observacao.Lines[Lc_I],1,Lc_Nr_Colunas );
      TextoAnsiString := AnsiString(TextoUnicode);
      WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);
    End;
  end;

  //PROGRAMA PAYBACK
  Lc_LInha := Lc_LInha + 2;
  Lc_Aux_List := ImprimeProgramaPayBack(Lc_Nr_Colunas,Qr_Pedido.FieldByName('EMP_CODIGO').AsInteger);
  if Lc_Aux_List.Count > 0 then
  Begin
    for Lc_I := 0 to Lc_Aux_List.Count-1 do
    Begin
      Lc_LInha := Lc_LInha + 1;
      TextoUnicode := #27#69 + Lc_Aux_List[Lc_I];
      TextoAnsiString := AnsiString(TextoUnicode);
      WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);
    End;
  End;

  //PROGRAMA CARTÃO PRE-PAGO
  Lc_Aux_List := ImprimeProgramaCartaoPrePago(Lc_Nr_Colunas,Qr_Pedido.FieldByName('EMP_CODIGO').AsInteger);
  if Lc_Aux_List.Count > 0 then
  Begin
    for Lc_I := 0 to Lc_Aux_List.Count-1 do
    Begin
      TextoUnicode := #27#69 + Lc_Aux_List[Lc_I];
      TextoAnsiString := AnsiString(TextoUnicode);
      WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);
    End;
  End;

  Lc_LInha := Lc_LInha + 3;

  TextoUnicode := #27#69 + Pc_AlinhaC('***  SEM VALOR FISCAL  ***',Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  TextoUnicode := #27#69 + Pc_AlinhaC('***  CAIXA: '+ GB_Nm_Usuario +' ***',Lc_Nr_Colunas);
  TextoAnsiString := AnsiString(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoAnsiString), Length(TextoAnsiString), CaracteresImpressos);

  //Apenas notifica o Windows que a página finalizou.
  //Nenhum controle é aplicado a impressora.
  EndPagePrinter(Handle);

  //Finaliza o documento no Spool
  EndDocPrinter(Handle);

  //Fecha a impressora
  ClosePrinter(Handle);

End;


procedure  TimpModImpressao.Pc_Imp_Frt_Termica(Pc_Cd_Pedido:Integer;Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real);
Begin
 it_Modelo_Termica := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_MOD_TERMICA', '1'),0);
  FCodigoPedido := Pc_Cd_Pedido;
  case it_Modelo_Termica of
    1:Pc_Imp_Frt_Termica_Vda_1(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco);
    2:Pc_Imp_Frt_Termica_Vda_2(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Frt_Termica_Vda_1(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real);
var
  subtotal, total: currency;
  traco: string;
  linha: integer;
  Lc_I : Integer;
  Lc_ColunaCentro : Integer;
  Lc_Nr_Colunas : Integer;
begin
  //Cria a Consulta
  Pc_AbreDadosPedido;
  total := 0;

  {with Fr_Principal.RdPrint_DP do
  Begin
    Try
      // Cabeçalho do Cupom...
      Fr_Principal.RdPrint_DP.abrir;
      TamanhoQteLinhas := 1; // Linhas (deve ser 1 quando for CUPOM)
      Lc_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)
      TamanhoQteColunas := Lc_Nr_Colunas;
      //Define o tamanhho do Traço
      Traco := '';
      For Lc_I:= 1 to Lc_Nr_Colunas do
        Traco := Traco + '-';
      Lc_ColunaCentro := Trunc(Lc_Nr_Colunas/2);

      FonteTamanhoPadrao := s20cpp; // Fonte Comprimido em 20 cpp
      Acentuacao := Transliterate;
      UsaGerenciadorImpr := true;
      if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_VISUAL','S') = 'S') then
      Begin
        Fr_Principal.RdPrint_DP.ImpressoraPersonalizada.NomeImpressora := '';
        OpcoesPreview.Preview := True;
      End
      else
      Begin
        NomeImpressora :=  Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NOME_IMPRESSORA','' );
        Fr_Principal.RdPrint_DP.ImpressoraPersonalizada.NomeImpressora := NomeImpressora;
        OpcoesPreview.Preview := False;
      End;

      Pc_AtivaEstabelecimento;
      DM.Qr_Estabelecimento.First;
      linha := 1;
      impc(linha, Lc_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString, [comp17]);
      Inc(linha);
      impc(linha, Lc_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ', ' + DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString, [comp17]);
      Inc(linha);
      impc(linha, Lc_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString, [comp17]);
      Inc(linha);
      impc(linha, Lc_ColunaCentro, fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString), [comp17]);

      //Verifica se o cupom foi registrado em um cliente diferente do consumidor
      if Qr_Pedido.FieldByName('PED_CODEMP').AsInteger <> StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0) then
      Begin
        Inc(linha);
        imp(linha, 01, traco);
        Inc(linha);
        imp(linha, 01, 'CLIENTE: ' + Qr_Pedido.FieldByname('EMP_FANTASIA').AsString );
      end;
      Inc(linha);
      imp(linha, 01, 'Nº ' + Qr_Pedido.FieldByname('PED_NUMERO').AsString + '   ' + Qr_Pedido.FieldByname('DATA').AsString +' - ' + TimeToStr(time) );
      Inc(linha);
      imp(linha, 01, traco);
      Inc(linha);
      imp(linha, 01, 'Descriçao dos Produtos  ');
      Inc(linha);
      imp(linha, 01, 'Qte    VL. Unitário                    Sub-Total');
      Inc(linha);
      imp(linha, 01, traco);

       // Imprime itens do pedido...
      Inc(linha);
      while not Qr_Itens.eof do
      begin
        if Length(Trim(Qr_Itens.FieldByname('IAV_DESCRICAO').AsString)) > 0 then
          Imp(linha, 01, Copy(Qr_Itens.FieldByname('IAV_DESCRICAO').Value,1,Lc_Nr_Colunas))
        else
          imp(linha, 01, Copy(Qr_Itens.FieldByname('PRO_DESCRICAO').Value,1,Lc_Nr_Colunas));
        linha:=linha+1;
        imp(linha, 01, FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value));
        imp(linha, 08, ' X ');
        imp(linha, 11, FormatFloat('###,##0.00', Qr_Itens.FieldByname('ITF_VL_UNIT').Value));
        subtotal := Qr_Itens.FieldByname('ITF_QTDE').Value * Qr_Itens.FieldByname('ITF_VL_UNIT').Value;
        subtotal := RoundTo(subtotal,-2);
        total := total + subtotal;
        impval(linha, 35, '###,###,##0.00', subtotal, []);
        IF linha > 70 THEN
        begin
          Novapagina;
          linha:=1;
        end
        else
          inc(linha);
        Qr_Itens.Next;
      end;

      // Total...
      imp(linha, 01, traco);
      inc(linha);
      imp(linha, 01, 'Total Geral do Cupom');
      impval(linha, 35, '###,###,##0.00', total, []);

      // Desconto Global
      if Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency > 0 then
      begin
        inc(linha);
        imp(linha, 01, '(-) Desconto Global');
        impval(linha, 35, '-##,###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_DESCONTO').Text, 0), []);
        // Total Liquido...
        inc(linha);
        impf(linha, 01, 'VALOR A PAGAR R$', []);
        impval(linha, 35, '###,###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_PEDIDO').Text, 0), []);
      end;

      Pc_AbreDadosFinanceiro;
      if Qr_Financeiro.RecordCount > 0 then
      Begin
        Inc(linha);
        imp(linha, 01, traco);
        inc(linha);
        impf(linha, 01, 'VALOR RECEBIDO R$ ', []);
        impval(linha, 35, '###,###,##0.00', Qr_Pedido.FieldByname('VALUE_RECIVED').AsFloat, []);
        while not Qr_Financeiro.Eof do
        Begin
          inc(linha);
          impf(linha, 01, Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString, []);
          if (Pos('DINHEIRO',Trim(Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString))>0) then
            impval(linha, 35, '###,###,##0.00', Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency, [])
          else
            impval(linha, 35, '###,###,##0.00', Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency + Pc_vl_Troco, []);
          Qr_Financeiro.Next;
        End;
      End;

      if (Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat > 0) then
      begin
        inc(linha);
        impf(linha, 01, 'VALOR DO TROCO R$ ', []);
        impval(linha, 35, '###,###,##0.00', Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat, []);
      end;

      linha := linha + 3;
      inc(linha);
      impc(linha, Lc_ColunaCentro, '***  SEM VALOR FISCAL  ***', []);
      inc(linha);
      impc(linha, Lc_ColunaCentro, '***  CAIXA: '+ GB_Nm_Usuario +' ***', []);
      linha := linha + StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRETE','FRT_P_SALTO','0'), 0);
      imp(linha, 01, ' ');

      TamanhoQteLinhas := linha;
      //Tipo de Impressão
      case (StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_TIPO_IMPRESSORA', '1'),1)) of
        1:Impressora := Bobina;
        2:Impressora := Epson;
        3:Impressora := Grafico;
        4:Impressora := HP;
        5:Impressora := Personalizado;
        6:Impressora := Rima;
      end;
    Finally
      Fr_Principal.RdPrint_DP.fechar;
    End;
  end;}
end;

procedure  TimpModImpressao.Pc_Imp_Frt_Termica_Vda_2(Pc_VL_Pagar,Pc_Vl_recebido,Pc_VL_Troco:Real);
var
  subtotal, total: currency;
  traco: string;
  linha: integer;
  Lc_I : Integer;
  Lc_ColunaCentro : Integer;
  Lc_Nr_Colunas : Integer;
begin
  //Cria a Consulta
  Pc_AbreDadosPedido;
  total := 0;

  {with Fr_Principal.RdPrint_DP do
    Begin
    // Cabeçalho do Cupom...
    PortaComunicacao := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', 'COM1');
    Fr_Principal.RdPrint_DP.abrir;

    TamanhoQteLinhas := 1; // Linhas (deve ser 1 quando for CUPOM)
    Lc_Nr_Colunas := 30;
    TamanhoQteColunas := Lc_Nr_Colunas;
    //Define o tamanhho do Traço
    Traco := '';
    For Lc_I:= 1 to Lc_Nr_Colunas do
      Traco := Traco + '-';
    Lc_ColunaCentro := Trunc(Lc_Nr_Colunas/2);

    FonteTamanhoPadrao := s20cpp; // Fonte Comprimido em 20 cpp
    Acentuacao := Transliterate;
    if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_IMP_P_CUPOM_VISUAL','S') = 'S') then
    Begin
      NomeImpressora :=  '';
      OpcoesPreview.Preview := True;
    End
    else
    Begin
      NomeImpressora :=  Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NOME_IMPRESSORA','' );
      OpcoesPreview.Preview := False;
    End;

    Pc_AtivaEstabelecimento;
    DM.Qr_Estabelecimento.First;
    linha := 1;
    impc(linha, Lc_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString, [comp17]);
    Inc(linha);
    impc(linha, Lc_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ', ' + DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString, [comp17]);
    Inc(linha);
    impc(linha, Lc_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString, [comp17]);
    Inc(linha);
    impc(linha, Lc_ColunaCentro, fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString), [comp17]);

  //Verifica se o cupom foi registrado em um cliente diferente do consumidor
  if Qr_Pedido.FieldByName('PED_CODEMP').AsInteger <> StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0) then
    Begin
    Inc(linha);
    imp(linha, 01, traco);
    Inc(linha);
    imp(linha, 01, 'CLIENTE: ' + Qr_Pedido.FieldByname('EMP_FANTASIA').AsString );
    end;
    Inc(linha);
    imp(linha, 01, 'Nº ' + Qr_Pedido.FieldByname('PED_NUMERO').AsString + '   ' + Qr_Pedido.FieldByname('DATA').AsString +' - ' + TimeToStr(time) );
    Inc(linha);
    imp(linha, 01, traco);
    Inc(linha);
    imp(linha, 01, 'Descriçao dos Produtos  ');
    Inc(linha);
    imp(linha, 01, 'Qte    V.Unit        Sub-Total ');
    Inc(linha);
    imp(linha, 01, traco);

     // Imprime itens do pedido...
    Inc(linha);
    while not Qr_Itens.eof do
    begin
      if Length(Trim(Qr_Itens.FieldByname('IAV_DESCRICAO').AsString)) > 0 then
        imp(linha, 01, Copy(Qr_Itens.FieldByname('IAV_DESCRICAO').Value,1,Lc_Nr_Colunas))
      else
        imp(linha, 01, Copy(Qr_Itens.FieldByname('PRO_DESCRICAO').Value,1,Lc_Nr_Colunas));

      linha:=linha+1;
      imp(linha, 01, FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value));
      imp(linha, 08, ' X ');
      imp(linha, 12, FormatFloat('##0.00', Qr_Itens.FieldByname('ITF_VL_UNIT').Value));
      subtotal := Qr_Itens.FieldByname('ITF_QTDE').Value * Qr_Itens.FieldByname('ITF_VL_UNIT').Value;
      subtotal := RoundTo(subtotal,-2);
      total := total + subtotal;
      impval(linha, 19, '###,##0.00', subtotal, []);
      IF linha > 70 THEN
        begin
        Novapagina;
        linha:=1;
        end
      else
        inc(linha);
      Qr_Itens.Next;
      end;

    // Total...
    imp(linha, 01, traco);
    inc(linha);
    imp(linha, 01, 'VALOR TOTAL    R$ ');
    impval(linha, 19, '###,##0.00', total, []);

    // Desconto Global
    if Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency > 0 then
    begin
      inc(linha);
      imp(linha, 01, '(-) Desconto Global');
      impval(linha, 19, '###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_DESCONTO').Text, 0), []);
      // Total Liquido...
      inc(linha);
      impf(linha, 01, 'VALOR A PAGAR R$', []);
      impval(linha, 19, '###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_PEDIDO').Text, 0), []);
    end;

    Pc_AbreDadosFinanceiro;
    if Qr_Financeiro.RecordCount > 0 then
    Begin
      Inc(linha);
      imp(linha, 01, traco);
      inc(linha);
      impf(linha, 01, 'VALOR RECEBIDO R$ ', []);
      impval(linha, 35, '###,###,##0.00', Qr_Pedido.FieldByname('VALUE_RECIVED').AsFloat, []);
      while not Qr_Financeiro.Eof do
      Begin
        inc(linha);
        impf(linha, 01, Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString, []);
        if (Pos('DINHEIRO',Trim(Qr_Financeiro.FieldByName('FPT_DESCRICAO').AsString))>0) then
          impval(linha, 35, '###,###,##0.00', Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency, [])
        else
          impval(linha, 35, '###,###,##0.00', Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsCurrency, []);
        Qr_Financeiro.Next;
      End;
    End;

    if (Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat > 0) then
    begin
      inc(linha);
      impf(linha, 01, 'VALOR DO TROCO R$ ', []);
      impval(linha, 19, '###,##0.00', Qr_Pedido.FieldByname('VALUE_CHANGE').AsFloat, []);
    end;

    linha := linha + 3;
    inc(linha);
    impc(linha, Lc_ColunaCentro, '***  SEM VALOR FISCAL  ***', []);
    inc(linha);
    impc(linha, Lc_ColunaCentro, '***  CAIXA: '+ GB_Nm_Usuario +' ***', []);
    linha := linha + StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRETE','FRT_P_SALTO','0'), 0);
    imp(linha, 01, ' ');

    TamanhoQteLinhas := linha;
    //Tipo de Impressão

    case (StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_TIPO_IMPRESSORA', '1'),1)) of
      1:Impressora := Bobina;
      2:Impressora := Epson;
      3:Impressora := Grafico;
      4:Impressora := HP;
      5:Impressora := Personalizado;
      6:Impressora := Rima;
    end;
    Fr_Principal.RdPrint_DP.fechar;
  end;}
end;

procedure TImpModImpressao.Pc_Imp_ModuloEletronicos(OrderID:Integer);
Var
  Lc_Escolha : Integer;
begin
  FCodigoPedido := OrderID;
  Lc_Escolha := (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Qual o tipo de impressão?.' + EOLN + EOLN + EOLN ,
                      ['Ordem de Serviço', 'Termo de Garantia','Cancelar'], [bNormal,bNormal,bEscape], mpConfirmacao, clBtnFace));
  case Lc_Escolha of
    0:ImpModuloOrdemEletronicos(FCodigoPedido);
    1:ImpModuloGarantiaEletronicos(FCodigoPedido);
  end;
end;

procedure TImpModImpressao.Pc_Imp_ModuloFurniture(OrderID: Integer);
begin
  //Esta funcção para o caso de ter que controlar mensagem para a escolha do relatorio (a exemplo do eletronicos
  FCodigoPedido := OrderID;
  ImpModuloOrdemEletronicos(FCodigoPedido);

end;

procedure  TimpModImpressao.Pc_Imp_Cpa(Fc_cd_Pedido,Fc_Cd_Nota:integer);
var
  Lc_Escolha : Integer;
begin
  Pc_LimpaQrPreviweMemoria;
  FCodigoPedido:=Fc_cd_Pedido;
  Pc_DadosPedido(2);
  it_Tp_Impressora :=  StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE COMPRA','CPA_P_IMPRESSORA',''),0);
  case it_Tp_Impressora of
    0:Begin
      Pc_Imp_Cpa_Matricial;
      end;
    1:Begin
      Pc_Imp_Cpa_JatoLaser;
      end;
    2:Begin
      Lc_escolha:=0;
      Lc_Escolha := (MensagemPadrao(TITULO_INFORMACAO,
                                    'Deseja enviar para?',
                                    ['MATRICIAL', 'LASER/JATO', 'CANCELA'], [bNormal, bNormal, bEscape], mpConfirmacao, clBtnFace));
      case Lc_Escolha of
        0:Pc_Imp_Cpa_Matricial;
        1:Pc_Imp_Cpa_JatoLaser;
      end;
      end;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Cpa_Matricial;
begin
  if not fc_ChamaImpressora then exit;
  it_Modelo_matricial:= StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE COMPRA','CPA_P_MOD_MATRICIAL', ''),1);
  case it_Modelo_matricial of
     1:Pc_Imp_Cpa_Matricial_1;
  end;
  Printer.PrinterIndex := It_Imp_Atual ;
end;

procedure  TimpModImpressao.Pc_Imp_Cpa_Matricial_1;
Var
  F: TextFile;
  I,J, Lc_I:Integer;
  Lc_Itens:Integer;
  Lc_TExto : String;
  Lc_ItensPP : Integer;
  Lc_ItensSP : Integer;
  Lc_Quebra : Integer;
  Lc_Prin : TPrin;
Begin
  try
    //Chama o pedido
    Pc_AbreDadosPedido;
    //---------------------------------
    Lc_ItensPP := StrToIntdEF(Fc_Aq_Geral('L','CONTROLE DE VENDA','CPA_P_ITENS_FOLHA','16'),16);
    Lc_ItensSP := StrToIntdef(Fc_Aq_Geral('L','PARAMETRO','SP',''),20);
    Lc_Quebra := StrToIntDEf(Fc_Aq_Geral('L','PARAMETRO','QP',''),16);
    Lc_Prin:=TPrin.Create(nil);
    With Lc_Prin Do
      begin
      Pc_AtivaEstabelecimento;
      Initialize(It_Porta);
      TextOutLC(1,1,Copy(DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString,1,35));
      TextOutLC(1,37,StrZero(Gb_CodMha,3,0) + '|' + 'PEDIDO: ');
      textoutLc(1,49,Padr(Qr_Pedido.FieldByname('PED_NUMERO').AsString,8));
      TextOutLC(1,65,'DATA: ');
      textoutLc(1,70,Padr(Qr_Pedido.FieldByname('DATA').AsString,10));
      TextOutLC(2,1,'-------------------------------------------------------------------------------');
      TextOutLC(3,1,'NOME DO FORNECEDOR: ');
      TextOutLC(3,21,Qr_Pedido.FieldByname('EMP_NOME').AsString);
      TextOutLC(3,60,'CNPJ: ');
      TextOutLC(3,16,Padr(Qr_Pedido.FieldByname('EMP_CNPJ').AsString,14));

      TextOutLC(4,1,'ENDERECO: ');
      TextOutLC(4,11,Qr_Pedido.FieldByname('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByname('END_NUMERO').AsString );
      TextOutLC(4,54,'BAIRRO:');
      TextOutLC(4,62,Qr_Pedido.FieldByname('END_BAIRRO').AsString);
      TextOutLC(5,1,'CEP: '   +Qr_Pedido.FieldByname('END_CEP').AsString    +'  -  '+
                    'CIDADE: '+Qr_Pedido.FieldByname('CDD_DESCRICAO').AsString +'  -  '+
                    'UF: '+Qr_Pedido.FieldByname('UFE_SIGLA').AsString     +'  -  '+
                    'FONE/FAX: '+Qr_Pedido.FieldByname('END_FONE').AsString +'/'+
                                 Qr_Pedido.FieldByname('END_FAX').AsString);
      TextOutLC(6,1,'-------------------------------------------------------------------------------');

      TextOutLC(7,1,'DESCRICAO DOS PRODUTOS');
      TextOutLC(7,49,'QTDE');
      TextOutLC(7,58,'PRECO');
      TextOutLC(7,70,'SUBTOTAL');
      Lc_Itens:= Qr_Itens.RecordCount;
      Qr_Itens.First;
      IF lc_Itens<=Lc_ItensPP then
        Begin
        //imprime itens pulando as linhas restantes
        I:=1;
        While not Qr_Itens.EOF do
          BEGIN
          TextOutLC(7+I,1,Copy(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString + ' - ' + Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,1,47));
          TextOutLC(7+I,49,Padr( Qr_Itens.FieldByname('ITF_QTDE').AsString,6));
          TextOutLC(7+I,57,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
          TextOutLC(7+I,69,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
          I:=I+1;
          Qr_Itens.Next;
          END;
        for J:=0 to (Lc_ItensPP-Lc_Itens) do
          begin
          TextOutLC(7+I+J,1,'');
          end;
        //Imprimi o Rodape
        TextOutLC(7+I+J,1,'-------------------------------------------------------------------------------');
        TextOutLC(7+I+J+1,1,'COND. PAGTO: ');
        TextOutLC(7+I+J+1,14,Qr_Pedido.FieldByname('FPT_DESCRICAO').AsString   + ' - ' +  Fc_Parcelamento('I'));

        TextOutLC(7+I+J+2,49,'TOTAL DOS PRODUTOS:');
        TextOutLC(7+I+J+2,69,Padr(FloatToStrf(Qr_Pedido.FieldByname('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),11));

        TextOutLC(7+I+J+5,49,'TOTAL DO PEDIDO   :');
        TextOutLC(7+I+J+5,69,Padr(FloatToStrf(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),11));
        Lc_Prin.Eject;
        Lc_Prin.Finalize;
        FreeAndNil(Lc_Prin);
        Exit;
        end
      else //Imprime mais de 16
        Begin
        //imprime itens pulando as linhas restantes
        I:=0;
        While not Qr_Itens.EOF do
          BEGIN
          I:=I+1;
          if I=Lc_Quebra then
            Begin
            TextOutLC(7+I,1,'-------------------------------------------------------------------------------');
            I:=I+1;
            TextOutLC(7+I,1,'                                                                    CONTINUA...');
            I:=I+2;
            end
          else
            Begin
            TextOutLC(7+I,1,Copy(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString + ' - ' + Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,1,47));
            TextOutLC(7+I,48,Padr(FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value),6));
            TextOutLC(7+I,57,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
            TextOutLC(7+I,69,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
            Qr_Itens.Next;
            end;
          END;
        j:=0;
        for J:=0 to (Lc_ItensSP-Lc_Itens) do
          begin
          TextOutLC(7+I+J,1,'');
          end;
        //Imprimi o Rodape
        TextOutLC(7+I+J,1,'-------------------------------------------------------------------------------');
        TextOutLC(7+I+J+1,1,'COND. PAGTO: ');
        TextOutLC(7+I+J+1,14,Qr_Pedido.FieldByname('FPT_DESCRICAO').AsString  + ' - ' + Fc_Parcelamento('I'));


        TextOutLC(7+I+J+2,49,'TOTAL DOS PRODUTOS:');
        TextOutLC(7+I+J+2,69,Padr(FloatToStrf(Qr_Pedido.FieldByname('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),11));

        TextOutLC(7+I+J+5,49,'TOTAL DO PEDIDO   :');
        TextOutLC(7+I+J+5,69,Padr(FloatToStrf(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),11));
        If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
          begin
          Lc_Prin.Eject;
          end
        else
          begin
          For Lc_I := 1 to (StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE COMPRA','CPA_P_SALTO',''),2)+1) do
            Begin;
            Inc(I);
            TextOutLC(6+Lc_I,1,'');
            end;
          end;
        Lc_Prin.Finalize;
        FreeAndnil(Lc_Prin);
        end;
      end;
  except
    If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
      Lc_Prin.Eject;
    Lc_Prin.Finalize;
    FreeAndNil(Lc_Prin);
    Exit;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Cpa_JatoLaser;
begin
  it_Modelo_jatolaser:= StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE COMPRA','CPA_P_MOD_JATOLASER', ''),1) ;
  case it_Modelo_jatolaser of
    1:Pc_Imp_Cpa_JatoLaser_1;
    2:Pc_Imp_Cpa_JatoLaser_2;
    3:Pc_Imp_Cpa_JatoLaser_3;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Cpa_JatoLaser_1;
Var
  Lc_Form : TRL_PedidoCompra_1;
begin
  try
    Lc_Form := TRL_PedidoCompra_1.Create(nil);
    Lc_Form.It_Codigo := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Cpa_JatoLaser_2;
Var
  Lc_Form : TRL_PedidoCompra_2;
begin
  try
    Lc_Form := TRL_PedidoCompra_2.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Cpa_JatoLaser_3;
Var
  Lc_Form : TRL_PedidoCompra_3;
begin
  try
    Lc_Form := TRL_PedidoCompra_3.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_Ajt(Fc_cd_Pedido,Fc_Cd_Nota:integer);
var
  Lc_Escolha : Integer;
  Lc_tipo:integer;
begin
  Pc_LimpaQrPreviweMemoria;
  FCodigoPedido:=Fc_cd_Pedido;
  Pc_DadosPedido(3);
  //Mostra esta opção somente se for estiver com a tela de nota fiscal
  if (Fc_Cd_Nota>0) then
    Begin
    Lc_tipo:=(MensagemPadrao(TITULO_INFORMACAO,
                             'Deseja enviar para?',
                              ['CUPOM','NORMAL','CANCELA'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
    end
  else
    Begin
    Lc_tipo := 1;
    end;

    Case Lc_tipo of
    0:Pc_Imp_Cupom;
    1:begin
      it_Tp_Impressora :=  StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE AJUSTE','AJT_P_IMPRESSORA',''),0);
      case it_Tp_Impressora of
      0:Begin
        Pc_Imp_Ajt_Matricial;
        end;
      1:Begin
        Pc_Imp_Ajt_JatoLaser;
        end;
      2:Begin
        Lc_escolha:=0;
        Lc_Escolha := (MensagemPadrao(TITULO_INFORMACAO,
                                      'Deseja enviar para?',
                                      ['MATRICIAL', 'LASER/JATO', 'CANCELA'], [bNormal, bNormal, bEscape], mpConfirmacao, clBtnFace));
          case Lc_Escolha of
          0:Pc_Imp_Ajt_Matricial;
          1:Pc_Imp_Ajt_JatoLaser;
          end;
        end;
      end;
    end;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Ajt_Matricial;
begin
  if not fc_ChamaImpressora then exit;
  it_Modelo_matricial:= StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE AJUSTE','AJT_P_MOD_MATRICIAL', ''),1);
  case it_Modelo_matricial of
    1:Pc_Imp_Ajt_Matricial_1;
  end;
  Printer.PrinterIndex := It_Imp_Atual ;
end;

procedure  TimpModImpressao.Pc_Imp_Ajt_Matricial_1;
Var
  F: TextFile;
  Lc_Linha : Integer;
  lc_J:Integer;
  lc_II : Integer;
  Lc_Itens:Integer;
  Lc_ItensPP : Integer;
  Lc_ItensSP : Integer;
  Lc_Quebra : Integer;
  Lc_Total: Real;
  Lc_Observacao : TMemo;
  Lc_Prin : TPrin;
begin
  Try
    TRY
      //Campo Observação
      Lc_Observacao:= TMemo.Create(nil);
      Lc_Observacao.Parent:= Fr_principal;
      Lc_Observacao.Visible:=FALSE;
      Lc_Observacao.WordWrap := True;
      Lc_Observacao.Width := 640;
      Lc_Observacao.Height := 90;
      Lc_Observacao.Top := 0;
      Lc_Observacao.Left := 0;
      Lc_Observacao.Font.Name := 'Courier';
      Lc_Observacao.Lines.Clear;

      Pc_AbreDadosPedido;

      Lc_ItensPP := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE AJUSTE','AJT_P_ITENS_FOLHA','16'),16);
      Lc_ItensSP := StrToIntDef(Fc_Aq_Geral('L','PARAMETRO','SP',''),15);
      Lc_Quebra := StrToIntDef(Fc_Aq_Geral('L','PARAMETRO','QP',''),13);
      Lc_Prin := TPrin.Create(nil);
      Lc_Prin.Porta := It_Porta;
      Lc_Prin.Initialize(It_Porta);
      With Lc_Prin Do
      begin
      Lc_Linha := 1;
      TextOutLC(Lc_Linha,1,StrZero(Gb_CodMha,3,0) + '|' + 'AJUSTE DE ESTOQUE');

      textoutLc(Lc_Linha,23,Padr(Qr_Pedido.Fieldbyname('PED_NUMERO').AsString,8));
      TextOutLC(Lc_Linha,57,'DATA  :');
      textoutLc(Lc_Linha,70,Padr(Qr_Pedido.Fieldbyname('DATA').AsString,10));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,'-------------------------------------------------------------------------------');
      Inc(Lc_Linha);
      if Qr_Pedido.FieldByName('EMP_TIPO').AsInteger = 1 then
        TextOutLC(Lc_Linha,1,'NOME DO CLIENTE: ')
      else
        TextOutLC(Lc_Linha,1,'NOME DO FORNECEDOR: ');
      TextOutLC(Lc_Linha,18,Qr_Pedido.FieldByName('EMP_NOME').AsString);
      TextOutLC(Lc_Linha,60,'CNPJ: ');
      TextOutLC(Lc_Linha,16,Padr(Qr_Pedido.FieldByName('EMP_CNPJ').AsString,14));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,'ENDERECO: ');
      TextOutLC(Lc_Linha,11,Qr_Pedido.Fieldbyname('END_ENDER').AsString + ', ' + Qr_Pedido.Fieldbyname('END_NUMERO').AsString);
      TextOutLC(Lc_Linha,54,'BAIRRO:');
      TextOutLC(Lc_Linha,62,Qr_Pedido.Fieldbyname('END_BAIRRO').AsString);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,'CEP: '   +Qr_Pedido.Fieldbyname('END_CEP').AsString    +'  -  '+
                           'CIDADE: '+Qr_Pedido.Fieldbyname('CDD_DESCRICAO').AsString +'  -  '+
                           'UF: '+Qr_Pedido.Fieldbyname('UFE_SIGLA').AsString     +'  -  '+
                           'FONE/FAX: '+Qr_Pedido.Fieldbyname('END_FONE').AsString +'/'+
                                       Qr_Pedido.Fieldbyname('END_FAX').AsString);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,'-------------------------------------------------------------------------------');
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,'DESCRICAO DOS PRODUTOS');
      TextOutLC(Lc_Linha,49,'QTDE');
      TextOutLC(Lc_Linha,58,'PRECO');
      TextOutLC(Lc_Linha,70,'SUBTOTAL');
      Lc_Itens:= Qr_Itens.RecordCount;
      Qr_Itens.First;
      IF lc_Itens<=Lc_ItensPP then
      Begin
       //imprime itens pulando as linhas restantes
        While not Qr_Itens.EOF do
        BEGIN
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,Copy(Qr_Itens.Fieldbyname('PRO_CODIGOFAB').AsString + ' - ' + Qr_Itens.Fieldbyname('PRO_DESCRICAO').AsString,1,47));
          TextOutLC(Lc_Linha,48,Padr( FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value) ,6));
          TextOutLC(Lc_Linha,57,Padr((floattostrf((Qr_Itens.Fieldbyname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
          TextOutLC(Lc_Linha,69,Padr((floattostrf((Qr_Itens.Fieldbyname('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
          Qr_Itens.Next;
        END;
        for Lc_J:=0 to (Lc_ItensPP-Lc_Itens) do
        begin
          inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'');
        end;
        //Imprimi o Rodape
        TextOutLC(Lc_Linha,1,'-------------------------------------------------------------------------------');
        Lc_Total := 0;
        Lc_Total := (Qr_Pedido.Fieldbyname('PED_VL_PRODUTO').AsCurrency + Qr_Pedido.Fieldbyname('PED_VL_DESCONTO').AsCurrency);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'NOME DO USUARIO      :');
        TextOutLC(Lc_Linha,18,copy(GB_Nm_Usuario,1,24));
        TextOutLC(Lc_Linha,49,'TOTAL DOS PRODUTOS:');
        TextOutLC(Lc_Linha,69,Padr((FloatToStrf(Lc_Total,ffFixed,10,2)),11));
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,49,'DESCONTO          :');
        TextOutLC(Lc_Linha,69,Padr(FloatToStrf(Qr_Pedido.Fieldbyname('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2),11));
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,49,'TOTAL DO PEDIDO   :');
        TextOutLC(Lc_Linha,69,Padr(FloatToStrf(Qr_Pedido.Fieldbyname('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),11));
        //Obseervações;
        IF trim(Qr_Pedido.FieldByname('PED_OBS').AsString) <> '' then
        Begin
          For lc_II:= It_Observacao.Lines.Count to 4 do
            It_Observacao.Lines.Add('');
          Lc_Observacao.Text := Qr_Pedido.FieldByname('PED_OBS').AsString;
          For lc_II := 0 to Lc_Observacao.Lines.Count - 1 do
            It_Observacao.Lines.Add(Lc_Observacao.Lines.Strings[lc_II]);
        end;
        for Lc_II := 5 to It_Observacao.Lines.Count do
        Begin
          inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,It_Observacao.Lines.Strings[Lc_II]);
        end;
      end
      else   //Imprime mais de 16
      Begin
        //imprime itens pulando as linhas restantes
        While not Qr_Itens.EOF do
          BEGIN
          Inc(Lc_Linha);
          if Lc_Linha = Lc_Quebra then
            Begin
            TextOutLC(Lc_Linha,1,'-------------------------------------------------------------------------------');
            inc(Lc_Linha);
            TextOutLC(Lc_Linha,1,'                                                                    CONTINUA...');
            inc(Lc_Linha);
            end
          else
          Begin
            TextOutLC(Lc_Linha,1,Copy(Qr_Itens.Fieldbyname('PRO_CODIGOFAB').AsString + ' - ' + Qr_Itens.Fieldbyname('PRO_DESCRICAO').AsString,1,47));
            TextOutLC(Lc_Linha,48,Padr( FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value) ,6));
            TextOutLC(Lc_Linha,57,Padr((floattostrf((Qr_Itens.Fieldbyname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
            TextOutLC(Lc_Linha,69,Padr((floattostrf((Qr_Itens.Fieldbyname('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
            Qr_Itens.Next;
          end;
        END;
        Lc_j:=0;
        for Lc_J:=0 to (Lc_ItensSP-Lc_Itens) do
          begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'');
          end;
            //Imprimi o Rodape
        TextOutLC(Lc_Linha,1,'-------------------------------------------------------------------------------');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'CONDICOES DE PAGAMENTO:');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'NOME DO USUARIO      :');
        TextOutLC(Lc_Linha,18,GB_Nm_Usuario);
        TextOutLC(Lc_Linha,49,'TOTAL DOS PRODUTOS:');
        TextOutLC(Lc_Linha,69,Padr((FloatToStrf(Qr_Pedido.Fieldbyname('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2)+FloatToStrf(Qr_Pedido.Fieldbyname('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2)),11));
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,49,'DESCONTO          :');
        TextOutLC(Lc_Linha,69,Padr(FloatToStrf(Qr_Pedido.Fieldbyname('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2),11));
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,49,'TOTAL DO PEDIDO   :');
        TextOutLC(Lc_Linha,69,Padr(FloatToStrf(Qr_Pedido.Fieldbyname('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),11));
        //Obseervações;
        IF trim(Qr_Pedido.FieldByname('PED_OBS').AsString) <> '' then
          Begin
          For lc_II:= It_Observacao.Lines.Count to 4 do
            It_Observacao.Lines.Add('');
          Lc_Observacao.Text := Qr_Pedido.FieldByname('PED_OBS').AsString;
          For lc_II := 0 to Lc_Observacao.Lines.Count - 1 do
            It_Observacao.Lines.Add(Lc_Observacao.Lines.Strings[lc_II]);
          end;
        for Lc_II := 5 to It_Observacao.Lines.Count do
          Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,It_Observacao.Lines.Strings[Lc_II]);
          end;


        If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
          Lc_Prin.Eject;
        end;
      end;
    except
      If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
        Lc_Prin.Eject;
    end;
  Finally
    Lc_Prin.Finalize;
    FreeAndNil(Lc_Prin);
    FreeAndNil(Lc_Observacao);
  End;
end;

procedure  TimpModImpressao.Pc_Imp_Ajt_JatoLaser;
begin
  it_Modelo_jatolaser:= StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE AJUSTE','AJT_P_MOD_JATOLASER', ''),1);
  case it_Modelo_jatolaser of
  1:Pc_Imp_Ajt_JatoLaser_1;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Ajt_JatoLaser_1;
Var
  Lc_Form : TRL_PedidoAjuste;
begin
  try
    Lc_Form := TRL_PedidoAjuste.Create(nil);
    Lc_Form.It_Codigo := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  FINALLY
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Cupom;
Var
  Lc_Nr_Vias : Integer;
  LcGetVia : String;
  Lc_I :Integer;
begin
  Pc_AtivaEstabelecimento;

  WITH Qr_Cotacao DO
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add(' SELECT CTC_CONTATO, CTC_DATA DATA ,CTC_NUMERO ');
    SQL.Add(' FROM TB_COTACAO tb_cotacao ');
    SQL.Add(' LEFT OUTER JOIN TB_EMPRESA tb_empresa ON (tb_empresa.EMP_CODIGO = tb_cotacao.CTC_CODEMP) ');
    SQL.Add(' WHERE(CTC_CODPED =:CTC_CODPED) ');
    ParamByName('CTC_CODPED').AsInteger := FCodigoPedido;
    Active := True;
    FetchAll;
    First;
  End;

  Pc_AbreDadosOrdem('COTACAO');

  with Qr_Conserto do
  begin
    Active:=false;
    sql.clear;
    sql.add(' SELECT CST_APARELHO,CST_MARCA,CST_MODELO,CST_NUMERO,CST_ACESSORIO,CST_RELATADO, ');
    sql.add(' CST_CONSTATADO,CST_DT_CONSERTO,CST_DT_ENTREGA,SIT_DESCRICAO ');
    sql.add(' FROM TB_CONSERTO tb_conserto ');
    sql.add(' LEFT OUTER JOIN TB_EMPRESA tb_empresa ON (tb_empresa.EMP_CODIGO = tb_conserto.CST_CODFOR) ');
    sql.add(' INNER JOIN TB_SITUACAO tb_situacao ON (tb_situacao.SIT_CODIGO = tb_conserto.CST_CODSIT) ');
    sql.add(' WHERE (CST_CODPED=:PED_CODIGO)  ');
    ParamByName('PED_CODIGO').AsInteger:= FCodigoPedido;
    Active:=True;
    FetchAll;
    First;
    if (RecordCount >0) then
      It_Tp_Doc:='ORC - '
    else
      It_Tp_Doc:='PEDIDO: ';
  end;

  //Consulta de Pedidos
  Pc_AbreDadosPedido;
  Pc_AbreDadosParcelamento;

  LcGetVia := Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_VIAS','1');
  //O X indica que o usuario deverá informar na hora quantas vias
  if LcGetVia = 'X' then
  Begin
    LcGetVia := '1';
    InputQuery('Número de vias', 'Informe quantas vias ou Enter para 1 Via',LcGetVia);
  End;
  Lc_Nr_Vias := StrToIntDef(LcGetVia,1);

  if Lc_Nr_Vias = 0 then Lc_Nr_Vias := 1;
  case StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_P_MOD_IMPRESSAO', ''),0) of
    1:Begin
        if (MensagemPadrao(TITULO_CONFIRMACAO,
                           'Imprimir Cupom para o Cliente.'+EOLN+EOLN+
                           'Confirmar a Impressão ?',
                          [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
        begin
          For Lc_I := 1 to Lc_Nr_Vias do
            Pc_Imp_Cupom_Pedido_1;
        end;
        Pc_Imp_Cupom_Financeiro_1;
      end;
    2:Begin
        Pc_Imp_Cupom_Pedido_2;
        Pc_Imp_Cupom_Financeiro_2;
      end;
    3:Begin
        For Lc_I := 1 to Lc_Nr_Vias do
          Pc_Imp_Cupom_Pedido_3;
      end;
    4:Begin
        For Lc_I := 1 to Lc_Nr_Vias do
          Pc_Imp_Cupom_Pedido_4;
      end;
    5:Begin
        For Lc_I := 1 to Lc_Nr_Vias do
          Pc_Imp_Cupom_Pedido_5;
      end;
    6:Begin
        Pc_Imp_Cupom_Pedido_6;
      end;
    end;
end;

procedure  TimpModImpressao.Pc_Imp_Cupom_Pedido_1;
Var
  Lc_Entrada:Integer;
  Lc_Device : PChar;
  Lc_Driver : Pchar;
  Lc_Porta : Pchar;
  Lc_HdeviceMode: Thandle;
  Lc_ImpAtual:integer;
  Lc_I, Lc_J : Integer;
  Lc_Linha : Integer;
  Lc_Prin : TPrin;
  Lc_TExto : String;
Label
  Desvio;
Begin
  try
    Lc_Linha := 0;
    It_Porta := Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_PORTA','LPT1');
    Lc_Prin := TPrin.Create(nil);
    Lc_Prin.Porta := It_Porta;
    Lc_Prin.Initialize(It_Porta);
    Lc_prin.Condensa(True);
    With Lc_Prin Do
    begin
      Pc_AtivaEstabelecimento;
      Expandido(true);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString);
      Expandido(false);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ', '+ DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString + ' ' + DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString + ' ' +  DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,'Fone: '+ fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString) + ' FAX: ' + fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FAX').AsString));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,'site: ' + DM.Qr_Estabelecimento.FieldByname('EMP_SITE').AsString);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,'e-mail: '+DM.Qr_Estabelecimento.FieldByname('EMP_EMAIL').AsString);

      Expandido(true);
      Inc(Lc_Linha);
      Inc(Lc_Linha);
      if (It_Tp_Doc ='ORC - ') then
        TextOutLC(Lc_Linha,1,It_Tp_Doc + Qr_Cotacao.fieldbyname('CTC_NUMERO').AsString)
      else
        TextOutLC(Lc_Linha,1,It_Tp_Doc + Qr_Pedido.fieldbyname('ped_numero').AsString);
      Expandido(false);
      textoutLc(Lc_Linha,23,Padr(Qr_Pedido.fieldbyname('PED_DT_ALTERA').AsString,19));
      Inc(Lc_Linha);
      if (Qr_Pedido.FieldByName('PED_TIPO').AsInteger = 1) then
        Begin
        Negrito(True);
        TextOutLC(Lc_Linha,1,'CLIENTE: ');
        Negrito(False);
        TextOutLC(Lc_Linha,10,copy(Qr_Pedido.fieldbyname('EMP_NOME').AsString,1,49));
        end;
      if  (Qr_Pedido.FieldByName('PED_TIPO').AsInteger = 3) then  TextOutLC(Lc_Linha,1,'EMPRESA: '+copy(Qr_Pedido.fieldbyname('EMP_NOME').AsString,1,49));
      if  (Qr_Pedido.FieldByName('PED_TIPO').AsInteger = 2) then  TextOutLC(Lc_Linha,1,'FORNECEDOR: '+copy(Qr_Pedido.fieldbyname('EMP_NOME').AsString,1,46));
      if Qr_Pedido.RecordCount >0 then
        Begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'FONE: '+fc_MascaraFone(Qr_Pedido.FieldByName('END_FONE').AsString));
        Inc(Lc_Linha);
        IF Length(Qr_Pedido.FieldByName('EMP_CNPJ').AsString) > 11 THEN
          TextOutLC(Lc_Linha,1,'CNPJ: ' + fc_MascaraCNPJ(Qr_Pedido.FieldByName('EMP_CNPJ').AsString))
        else
          TextOutLC(Lc_Linha,1,'CPF: ' + fc_MascaraCPF(Qr_Pedido.FieldByName('EMP_CNPJ').AsString));
        end
      else
        Begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'FONE: '+Qr_Cotacao.FieldByName('CTC_CONTATO').AsString);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'CNPJ: ');
        end;
      lc_I:=1;
      if Qr_Itens.RecordCount > 0 then
        Begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'=====================================================');
        Negrito(true);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'DESCRICAO DOS PRODUTOS/PECA             QTDE   VALOR ');
        Negrito(false);
        Qr_Itens.First;
        while  not Qr_Itens.Eof do
          Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,Copy(Qr_Itens.FieldByName('PRO_CODIGOFAB').AsString + ' - ' + Qr_Itens.FieldByName('PRO_DESCRICAO').AsString,1,37));
          TextOutLC(Lc_Linha,39,padr(FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value),6));
          TextOutLC(Lc_Linha,46,padr(FloatToStrF(Qr_Itens.FieldByName('ITF_VL_SUBTOTAL').AsCurrency,ffFixed,10,2),8));
          Qr_Itens.Next;
          end
        end;

      if Qr_ItensSrv.RecordCount > 0 then
        Begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'=====================================================');
        Negrito(true);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'DESCRICAO DOS SERVICOS                  QTDE   VALOR ');
        Negrito(false);
        Qr_ItensSrv.First;
        while  not Qr_ItensSrv.Eof do
          Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,Copy(Qr_ItensSrv.FieldByName('ITF_CODPRO').AsString + ' - ' + Qr_ItensSrv.FieldByName('PRO_DESCRICAO').AsString,1,37));
          TextOutLC(Lc_Linha,39,padr(FormatFloat('#0.###', Qr_ItensSrv.FieldByname('ITF_QTDE').Value),6));
          TextOutLC(Lc_Linha,46,padr(FloatToStrF(Qr_ItensSrv.FieldByName('ITF_VL_SUBTOTAL').AsCurrency,ffFixed,10,2),8));
          Qr_ItensSrv.Next;
          end
       end;

      if Length(Qr_Ordem.FieldByName('OBS').AsString) > 0  then
        Begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'=====================================================');
        //Obsrvação da Ordem de Serviço
        It_Observacao.Lines.Clear;
        It_Observacao.Lines.Add(Qr_Ordem.FieldByName('OBS').AsString);
        For Lc_I:=0 to (It_Observacao.Lines.Count - 1) do
          Begin
          if Lc_I = 0 then
            Begin
            Inc(Lc_Linha);
            TextOutLC(Lc_Linha,1,'OBS.: ' + It_Observacao.Lines[lc_I])
            end
          else
            Begin
            Inc(Lc_Linha);
            TextOutLC(Lc_Linha,1,'      ' + It_Observacao.Lines[lc_I]);
            end;
          end;
        END;
      if Qr_Conserto.RecordCount > 0 then
        Begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'=====================================================');
        Negrito(true);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'ENCERRAMENTO DE CONSERTO ');
        Negrito(false);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'APARELHO : ' + Qr_Conserto.FieldByName('CST_APARELHO').AsString);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'MARCA : ' + Qr_Conserto.FieldByName('CST_MARCA').AsString);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'MODELO : ' + Qr_Conserto.FieldByName('CST_MODELO').AsString);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'N. SERIE : ' + Qr_Conserto.FieldByName('CST_NUMERO').AsString);
        //Acessorios
         It_Observacao.Lines.Clear;
         It_Observacao.Lines.Add(Qr_Conserto.FieldByName('CST_ACESSORIO').Text);
         For Lc_I:=0 to (It_Observacao.Lines.Count - 1) do
          Begin
          if Lc_I = 0 then
            Begin
            Inc(Lc_Linha);
            TextOutLC(Lc_Linha,1,'ACESSÓRIOS : ' + It_Observacao.Lines[lc_I])
            end
          else
            Begin
            Inc(Lc_Linha);
            TextOutLC(Lc_Linha,1,'           ' + It_Observacao.Lines[lc_I]);
            end;
          end;
        //Defeito Reclamado
        Negrito(true);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'DEFEITO RECLAMADO');
        Negrito(false);
        It_Observacao.Lines.Clear;
        It_Observacao.Lines.Add(Qr_Conserto.FieldByName('CST_RELATADO').Text);
        For Lc_I:=0 to (It_Observacao.Lines.Count - 1) do
          Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,It_Observacao.Lines[lc_I])
          end;
        //Defeito Constatado
        Negrito(true);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'DEFEITO CONSTATADO');
        Negrito(false);
        It_Observacao.Lines.Clear;
        It_Observacao.Lines.Add(Qr_Conserto.FieldByName('CST_CONSTATADO').Text);
        For Lc_I:=0 to (It_Observacao.Lines.Count - 1) do
          Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,It_Observacao.Lines[lc_I])
          end;
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'Data Entrada : ' + Qr_Cotacao.FieldByName('DATA').AsString);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'Data Conserto : ' + Qr_Conserto.FieldByName('CST_DT_CONSERTO').AsString);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'Data Saida : ' + Qr_Conserto.FieldByName('CST_DT_ENTREGA').AsString);
        Negrito(true);
        Inc(Lc_Linha,2);
        Negrito(True);
        TextOutLC(Lc_Linha,1,'SITUACAO : ');
        Negrito(False);
        TextOutLC(Lc_Linha,12,Qr_Conserto.FieldByName('SIT_DESCRICAO').AsString);
        Negrito(False);
        Inc(Lc_Linha,2);
        TextOutLC(Lc_Linha,1,'VENDEDOR : ' + Qr_Pedido.FieldByName('CLB_NOME').AsString);

        END; //FINAL DO CONSERTO

      Inc(Lc_Linha);

      TextOutLC(Lc_Linha,1,'=====================================================');
      Expandido(true);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,7,'PRODUTOS : ');
      TextOutLC(Lc_Linha,19,PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),8));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,7,'SERVICOS : ');
      TextOutLC(Lc_Linha,19,PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_SERVICO').AsCurrency,ffFixed,10,2),8));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,7,'DESCONTOS: ');
      TextOutLC(Lc_Linha,19,PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2),8));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,7,'TOTAL    :');
      TextOutLC(Lc_Linha,19,PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),8));
      Expandido(false);
      Qr_Conserto.Active:=True;
      Qr_Conserto.First;
      if Qr_Conserto.RecordCount > 0 then
        Begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'================ D E C L A R A C A O ================');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'DECLARO ESTAR RECEBENDO O EQUIPAMENTO DESCRITO NESTE');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'RECIBO, CONFORME A SITUAÇÃO DIAGNOSTICADA');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'GARANTIA DE TRES MESES REFERENTE SERVICOS EXECUTADOS');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'========== NAO SERVE COMO CUPOM FISCAL ==============');
        Inc(Lc_Linha,2);
        TextOutLC(Lc_Linha,1,'----------------------------------------------------');

        Expandido(true);
        Inc(Lc_Linha,2);
        TextOutLC(Lc_Linha,1,Qr_Pedido.FieldByname('PED_NUMERO').AsString);
        Expandido(false);
        textoutLc(Lc_Linha,23,Padr(Qr_Pedido.fieldbyname('PED_DT_ALTERA').AsString,19));

        Inc(Lc_Linha,2);
        TextOutLC(Lc_Linha,2,'================ D E C L A R A C A O ================');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'DECLARO ESTAR RECEBENDO O EQUIPAMENTO DESCRITO NESTE');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'RECIBO, CONFORME A SITUAÇÃO DIAGNOSTICADA');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'GARANTIA DE TRES MESES REFERENTE SERVICOS EXECUTADOS');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'========== NAO SERVE COMO CUPOM FISCAL ==============');
        Inc(Lc_Linha,2);
        Negrito(True);
        TextOutLC(Lc_Linha,1,'SITUACAO : ');
        Negrito(False);
        TextOutLC(Lc_Linha,12,Qr_Conserto.FieldByName('SIT_DESCRICAO').AsString);
        Negrito(False);

        Inc(Lc_Linha,3);
        TextOutLC(Lc_Linha,1,'____________________________________________________');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,Qr_Pedido.fieldbyname('EMP_NOME').AsString);
        end
      else
        Begin

        if (Fc_Tb_Geral('L','OSR_G_ATIVAR','S') = 'S') then
          Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'================ G A R A N T I A S ==================');
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'NACIONAIS 1-ANO / IMPORTADOS 3 MESES / USADOS 3-MESES');
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'SERVIÇOS EXECUTADOS - 3 MESES A PARTIR DATA DO LACRE');
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'========== NAO SERVE COMO CUPOM FISCAL ==============');
          end;
        end;


      For Lc_I:= 1 to (StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),1)) do
        Begin
        inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'');
        end;
      Reset;
      Finalize;
    END;
  finally
    FreeAndNil(Lc_Prin);
  end;

end;


procedure  TimpModImpressao.Pc_Imp_Cupom_Pedido_2;
begin
  {with Fr_Principal.RdPrint_DP do
    Begin
    // Cabeçalho do Cupom...
    Lc_TipoFonte :=[negrito];

    //Numero de Copias
    NumerodeCopias := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_VIAS','1'),1);
    //Tamanho doa fonte padrão
    case StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_RPD_FTE_PADRAO', '1'),1) of
      0:FonteTamanhoPadrao := s10cpp; //(Normal)
      1:FonteTamanhoPadrao := s12cpp; //(Comprimido)
      2:FonteTamanhoPadrao := s15cpp;
      3:FonteTamanhoPadrao := s17cpp; //(Condensado)
      4:FonteTamanhoPadrao := s20cpp; //(Comprimido + Condensado)
      5:FonteTamanhoPadrao := s05cpp; //cpp (Expandido);
    end;

    Acentuacao := Transliterate;
    PortaComunicacao := Fc_Aq_Geral('L','IMPRESSAO','PORTA','LPT1');

    Lc_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)
    TamanhoQteColunas := Lc_Nr_Colunas;
    //Define o tamanhho do Traço
    Lc_Traco := '';
    For Lc_I:= 1 to Lc_Nr_Colunas do
      Lc_Traco := Lc_Traco + '-';
    Lc_ColunaCentro := Trunc(Lc_Nr_Colunas/2);


    abrir;
    OpcoesPreview.Preview := true;
    UsaGerenciadorImpr := True;

    TamanhoQteLinhas := 25 + Qr_Itens.RecordCount;
    Pc_AtivaEstabelecimento;
    ImpC(01, Lc_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString,Lc_TipoFonte);
    impc(02, Lc_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ', ' + DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString, Lc_TipoFonte);
    impc(03, Lc_ColunaCentro, DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString + '-' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + '-' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString + ' - CEP:' + Fc_MascaraCep(DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString), Lc_TipoFonte);
    impc(04, Lc_ColunaCentro, fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString), Lc_TipoFonte);

    imp(05, 01, Lc_traco);

    ImpF(06, 01,   'Nº      : ' + Qr_Pedido.FieldByname('PED_NUMERO').AsString,Lc_TipoFonte);
    impF(06, 20,   'DATA    : ' + Qr_Pedido.FieldByname('DATA').AsString + ' ' + TimeToStr(Now),Lc_TipoFonte) ;
    impF(07, 01,   'CLIENTE : ' + Qr_Pedido.FieldByName('EMP_FANTASIA').AsString, Lc_TipoFonte);
    impF(08, 01,   'FONES   : ' + fc_MascaraFone(Qr_Pedido.FieldByName('END_FONE').AsString), Lc_TipoFonte);
    if (Qr_Pedido.FieldByName('EMP_PESSOA').AsString = 'F') then
      impF(09, 01, 'CPF     : ' + fc_MascaraCPF(Qr_Pedido.FieldByName('EMP_CNPJ').AsString), Lc_TipoFonte)
    else
      impF(09, 01, 'CNPJ    : ' + fc_MascaraCNPJ(Qr_Pedido.FieldByName('EMP_CNPJ').AsString), Lc_TipoFonte);

    impF(10, 01, Lc_traco, Lc_TipoFonte);

    impF(11, 01, 'ENDERECO: ', Lc_TipoFonte);
    impF(12, 01, Qr_Pedido.FieldByname('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByname('END_NUMERO').AsString, Lc_TipoFonte);
    impF(13, 01, Qr_Pedido.FieldByname('END_BAIRRO').AsString + '-' + Qr_Pedido.FieldByname('CDD_DESCRICAO').AsString + '-' + Qr_Pedido.FieldByname('UFE_SIGLA').AsString + ' - CEP:' + Fc_MascaraCep(Qr_Pedido.FieldByname('END_CEP').AsString), Lc_TipoFonte);
    impF(14, 01, Lc_traco, Lc_TipoFonte);

    impF(15, 01, 'Descriçao dos Produtos  ', Lc_TipoFonte);
    impF(16, 01, 'Qte    VL. Unitário                    Sub-Total', Lc_TipoFonte);
    impF(17, 01, Lc_traco, Lc_TipoFonte);

     // Imprime itens do pedido...
    Lc_linha := 18;
    while not Qr_Itens.eof do
      begin
      impF(Lc_linha, 01, Copy(Qr_Itens.FieldByname('PRO_DESCRICAO').Value,1,Lc_Nr_Colunas), Lc_TipoFonte);
      Lc_linha := Lc_linha+1;
      impF(Lc_linha, 01, FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value), Lc_TipoFonte);
      impF(Lc_linha, 08, ' X ', Lc_TipoFonte);
      impF(Lc_linha, 11, FormatFloat('###,##0.00', Qr_Itens.FieldByname('ITF_VL_UNIT').Value), Lc_TipoFonte);
      Lc_subtotal := Qr_Itens.FieldByname('ITF_QTDE').Value * Qr_Itens.FieldByname('ITF_VL_UNIT').Value;
      Lc_subtotal := RoundTo( Lc_subtotal,-2);
      Lc_total := Lc_total + Lc_subtotal;
      impval(Lc_linha, 35, '###,###,##0.00', Lc_subtotal, Lc_TipoFonte);
      IF Lc_linha > 70 THEN
      begin
        Novapagina;
      end
      else
        inc(Lc_linha);
      Qr_Itens.Next;
      end;

    // Total...
    impF(Lc_linha, 01, Lc_traco, Lc_TipoFonte);
    inc(Lc_linha);
    impF(Lc_linha, 01, 'Total Geral do Cupom', Lc_TipoFonte);
    impval(Lc_linha, 35, '###,###,##0.00', Lc_total, Lc_TipoFonte);

    // Desconto Global
    if Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency > 0 then
      begin
      inc(Lc_linha);
      impF(Lc_linha, 01, '(-) Desconto Global', Lc_TipoFonte);
      impval(Lc_linha, 35, '-##,###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_DESCONTO').Text, 0), Lc_TipoFonte);
      // Total Liquido...
      inc(Lc_linha);
      impf(Lc_linha, 01, 'VALOR A PAGAR R$', []);
      impval(Lc_linha, 35, '###,###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_PEDIDO').Text, 0), []);
      end;
    //Vendedor
    inc(Lc_linha);
    impF(Lc_linha, 01, 'VENDEDOR: ' + Qr_Pedido.FieldByName('CLB_NOME').AsString, Lc_TipoFonte);

    //Garantia
    inc(Lc_linha);
    impF(Lc_linha, 01, 'GARANTIA 6 MESES', Lc_TipoFonte);

    //Asstinatura
    Lc_linha := Lc_linha + 3;
    impc(Lc_linha, Lc_ColunaCentro, '___________________________________', []);
    inc(Lc_linha);
    impc(Lc_linha, Lc_ColunaCentro, Qr_Pedido.FieldByName('EMP_FANTASIA').AsString, []);

    inc(Lc_linha);
    imp(Lc_linha, 01, ' ');
    TamanhoQteLinhas := Lc_linha ;

    //Tipo de Impressão
    case StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_TIPO_IMPRESSORA', '1'),1) of
      1:Impressora := Bobina;
      2:Impressora := Epson;
      3:Impressora := Grafico;
      4:Impressora := HP;
      5:Impressora := Personalizado;
      6:Impressora := Rima;
    end;
    fechar;
    end;}
end;

procedure  TimpModImpressao.Pc_Imp_Cupom_Pedido_3;
var
   Lc_Entrada: Integer;
   Lc_Device: PChar;
   Lc_Driver: Pchar;
   Lc_Porta: Pchar;
   Lc_HdeviceMode: Thandle;
   Lc_ImpAtual: integer;
   Lc_I, Lc_J: Integer;
   Lc_Linha: Integer;
   Lc_Texto: String;
   lc_contador: integer;
   Lc_Prin : TPrin;
   Lc_total : Real;
   Lc_Nr_Colunas,Lc_ColunaCentro : Integer;
   Lc_Traco : String;
begin
  Try
    It_Porta := Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_PORTA','LPT1');
    Lc_Prin := TPrin.Create(nil);
    Lc_Prin.Porta := It_Porta;
    Lc_Prin.Initialize(It_Porta);
    Lc_prin.Condensa(false);
    Lc_total := 0;
    Lc_Linha := 0;
    With Lc_Prin Do
    begin
      Lc_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)
      //Define o tamanhho do Traço
      Lc_Traco := '';
      For Lc_I:= 1 to Lc_Nr_Colunas do
        Lc_Traco := Lc_Traco + '-';
      Lc_ColunaCentro := Trunc(Lc_Nr_Colunas/2);

      //impF(11, 01, 'ENDERECO: ', Lc_TipoFonte);
      Inc(Lc_Linha);
      if (It_Tp_Doc ='ORC - ') then
        TextOutLC(Lc_Linha,1,It_Tp_Doc + Qr_Cotacao.fieldbyname('CTC_NUMERO').AsString)
      else
        TextOutLC(Lc_Linha,1,It_Tp_Doc + Qr_Pedido.fieldbyname('ped_numero').AsString);

      TextOutLC(Lc_Linha,23,Padr(Qr_Pedido.fieldbyname('PED_DT_ALTERA').AsString,19));
      Inc(Lc_Linha);
      if Qr_Pedido.RecordCount >0 then
      Begin
        case Qr_Pedido.FieldByName('PED_TIPO').AsInteger of
          1:Begin
              TextOutLC(Lc_Linha,1,copy('FANTASIA : ' + Qr_Pedido.fieldbyname('EMP_FANTASIA').AsString,1,Lc_Nr_Colunas));
              Inc(Lc_Linha);
              TextOutLC(Lc_Linha,1,copy('RAZAO S. : '+ Qr_Pedido.fieldbyname('EMP_NOME').AsString,1,Lc_Nr_Colunas));
              Inc(Lc_Linha);
              TextOutLC(Lc_Linha,1,copy('VENDEDOR : '+ Qr_Pedido.fieldbyname('CLB_NOME').AsString,1,Lc_Nr_Colunas));
            End;
          2:Begin
              TextOutLC(Lc_Linha,1,copy('FORNECEDOR: '+ Qr_Pedido.fieldbyname('EMP_FANTASIA').AsString,1,Lc_Nr_Colunas));
            End;
          3:Begin
              TextOutLC(Lc_Linha,1,copy('EMPRESA   : '+Qr_Pedido.fieldbyname('EMP_FANTASIA').AsString,1,Lc_Nr_Colunas));
            End;
        end;
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'ENDEREÇO : ' + Qr_Pedido.FieldByName('END_ENDER').AsString + ',' + Qr_Pedido.FieldByName('END_NUMERO').AsString);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,copy('BAIRRO   : '+ Qr_Pedido.FieldByName('END_BAIRRO').AsString + ' - ' + Qr_Pedido.FieldByName('CDD_DESCRICAO').AsString,1,Lc_Nr_Colunas));
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,copy('COMPLE   : '+ Qr_Pedido.FieldByName('END_COMPLEM').AsString,1,Lc_Nr_Colunas));
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'C.E.P.   : '+ Fc_MascaraCep( Qr_Pedido.FieldByName('END_CEP').AsString));

        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'FONE     : '+fc_MascaraFone(Qr_Pedido.FieldByName('END_FONE').AsString));
        Inc(Lc_Linha);
        IF Length(Qr_Pedido.FieldByName('EMP_CNPJ').AsString) > 11 THEN
          TextOutLC(Lc_Linha,1,'CNPJ     : ' + fc_MascaraCNPJ(Qr_Pedido.FieldByName('EMP_CNPJ').AsString))
        else
          TextOutLC(Lc_Linha,1,'CPF      : ' + fc_MascaraCPF(Qr_Pedido.FieldByName('EMP_CNPJ').AsString));
      end
      else
      Begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'FONE: '+Qr_Cotacao.FieldByName('CTC_CONTATO').AsString);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'CNPJ: ');
      end;
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, Lc_Traco);
      Inc(Lc_Linha);
      Lc_prin.Condensa(True);
      TextOutLC(Lc_Linha, 1, 'DESCRICAO DOS PRODUTOS/PECA              UNIT.  QTDE   VALOR ');
      while not Qr_Itens.Eof do
        begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha, 1, Copy(Qr_Itens.FieldByName('PRO_DESCRICAO').AsString,1,38));
        TextOutLC(Lc_Linha, 40, padr(FloatToStrF(Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency, ffFixed, 10, 2), 6));
        TextOutLC(Lc_Linha, 48, padr(FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value), 4));
        TextOutLC(Lc_Linha, 54, padr(FloatToStrF(Qr_Itens.FieldByName('ITF_VL_SUBTOTAL').AsCurrency, ffFixed, 10, 2), 8));
        Qr_Itens.Next;
        end;
      Lc_prin.Condensa(false);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1,Lc_Traco);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 27, 'PRODUTOS: ');
      TextOutLC(Lc_Linha, 38, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_PRODUTO').AsCurrency, ffFixed, 10, 2), 11));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 27, 'SUBS.TRIB: ');
      TextOutLC(Lc_Linha, 38, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_ST').AsCurrency, ffFixed, 10, 2), 11));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 27, 'FRETE: ');
      TextOutLC(Lc_Linha, 38, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_FRETE').AsCurrency, ffFixed, 10, 2), 11));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 27, 'DESPESAS: ');
      TextOutLC(Lc_Linha, 38, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_ODESPESA').AsCurrency, ffFixed, 10, 2), 11));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 27, 'DESCONTOS: ');
      TextOutLC(Lc_Linha, 38, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_DESCONTO').AsCurrency, ffFixed, 10, 2), 11));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 27, 'TOTAL   :');
      TextOutLC(Lc_Linha, 38, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_PEDIDO').AsCurrency, ffFixed, 10, 2), 11));
      Pc_Historico;
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, '=========== I N F O R M A C O E S ==============');
      Inc(Lc_Linha);

      //Cheque Devolvido
      Lc_TExto := 'Cheque(s) Devolvido(s) : ' + FloatToStrF(It_Vl_Chq_DEv, ffFixed, 10, 2);
      TextOutLC(Lc_Linha, 1, lc_texto);
      Inc(Lc_Linha);

      //Saldo Devedor
      Lc_TExto := 'Saldo Devedor          : ' + FloatToStrF(It_Vl_Devedor + It_Vl_Chq_DEv, ffFixed, 10, 2);
      TextOutLC(Lc_Linha, 1, lc_texto);
      Inc(Lc_Linha);
      //Parcelamento
      Qr_Parcelamento.Active := True;
      Qr_Parcelamento.First;
      while not Qr_Parcelamento.Eof do
      Begin
        if Qr_Parcelamento.Bof then
        Begin
          Lc_TExto := 'Data do Vencimento : ' + Qr_Parcelamento.FieldByName('PAR_DATA').AsString;
          TextOutLC(Lc_Linha, 1, lc_texto);
          Inc(Lc_Linha);
        end
        else
        Begin
          Lc_TExto := '                     ' + Qr_Parcelamento.FieldByName('PAR_DATA').AsString;
          TextOutLC(Lc_Linha, 1, lc_texto);
          Inc(Lc_Linha);
        end;
        Qr_Parcelamento.Next;
      end;


      //Mensagem de troca
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,'ATENCAO! Troca de mercadoria so sera efetuada caso ');
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,'haja defeito de fabricacao.');
      Inc(Lc_Linha);

      Inc(Lc_Linha);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, '======= NAO SERVE COMO CUPOM FISCAL ============');

      For Lc_I:= 1 to (StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),1)) do
      Begin
        inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'');
      end;
      Reset;
      Finalize;
    end;
  Finally
    FreeAndNil(Lc_Prin);
  End;
end;

procedure  TimpModImpressao.Pc_Imp_Cupom_Pedido_4;
var
  Lc_Prin : TPrin;
  Lc_Linha : Integer;
  Lc_Nr_Colunas : Integer;
  Lc_Traco : String;
  Lc_I : Integer;
  Lc_subtotal : Real;
  Lc_TL_Produtos : Real;
  Lc_TL_Servicos : Real;
  Lc_Salto : Integer;
  Lc_Finaliza: TextFile;
  LcPlaca : String;
begin
  TRy
    It_Porta := Fc_Aq_Geral('L','IMPRESSAO','PORTA','LPT1');
    Lc_Prin := TPrin.Create(nil);
    Lc_Prin.Porta := It_Porta;
    Lc_Prin.Initialize(It_Porta);
    Lc_prin.Condensa(false);
    Lc_Linha := 0;
    With Lc_Prin Do
    Begin
      Lc_Linha := 0;
      Lc_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_COLUNAS', ''),55);
      Lc_Linha := Lc_Linha + 1;
      //Define o tamanhho do Traço
      Lc_Traco := '';
      Pc_AtivaEstabelecimento;
      For Lc_I:= 1 to Lc_Nr_Colunas do
        Lc_Traco := Lc_Traco + '-';
      Lc_Linha := 0;
      with DM.Qr_Estabelecimento do
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(FieldByname('EMP_FANTASIA').AsString,Lc_Nr_Colunas, ' '));
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(
                                    concat(
                                        FieldByname('END_ENDER').AsString , ', ' ,
                                        FieldByname('END_NUMERO').AsString),
                                        Lc_Nr_Colunas, ' '
                                        )
        );
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(
                                    concat(
                                        FieldByname('END_BAIRRO').AsString , '-' ,
                                        FieldByname('CDD_DESCRICAO').AsString , '-' ,
                                        FieldByname('UFE_SIGLA').AsString ,
                                        ' - CEP:' , Fc_MascaraCep(FieldByname('END_CEP').AsString)),
                                        Lc_Nr_Colunas, ' '
                                        )
        );
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto(fc_MascaraFone(FieldByname('END_FONE').AsString),Lc_Nr_Colunas, ' '));
      end;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_Nr_Colunas, '-'));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'Nº : ' + Qr_Pedido.FieldByname('PED_NUMERO').AsString);
      TextOutLC(Lc_Linha,14,'DATA: ' + Qr_Pedido.FieldByname('DATA').AsString + ' ' + TimeToStr(Now));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'CLIENTE : ' + Qr_Pedido.FieldByName('EMP_FANTASIA').AsString);
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'FONES   : ' + fc_MascaraFone(Qr_Pedido.FieldByName('END_FONE').AsString));
      Lc_Linha := Lc_Linha + 1;
      if (Qr_Pedido.FieldByName('EMP_PESSOA').AsString = 'F') then
        TextOutLC(Lc_Linha,1,'CPF     : ' + fc_MascaraCPF(Qr_Pedido.FieldByName('EMP_CNPJ').AsString))
      else
        TextOutLC(Lc_Linha,1,'CNPJ    : ' + fc_MascaraCNPJ(Qr_Pedido.FieldByName('EMP_CNPJ').AsString));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_Nr_Colunas, '-'));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'ENDERECO: ');
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,Qr_Pedido.FieldByname('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByname('END_NUMERO').AsString);
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,Qr_Pedido.FieldByname('END_BAIRRO').AsString + '-' + Qr_Pedido.FieldByname('CDD_DESCRICAO').AsString + '-' + Qr_Pedido.FieldByname('UFE_SIGLA').AsString + ' - CEP:' + Fc_MascaraCep(Qr_Pedido.FieldByname('END_CEP').AsString));
      //DADOS DOS VEICULOS
      Pc_AbreDadosOrdem('PEDIDO');
      with Qr_Ordem do
      Begin
        IF RecordCount > 0 THEN
        begin
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,CentralizaTexto('VEICULO',Lc_Nr_Colunas, '-'));
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,Copy('MARCA  : ' + FieldByName('MRC_DESCRICAO').AsString ,1,Lc_Nr_Colunas));
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,Copy('MODELO : ' + FieldByName('MOD_DESCRICAO').AsString ,1,Lc_Nr_Colunas));
          LcPlaca := Copy(FieldByName('VEI_PLACA').AsString,1,3) + '-' + Copy(FieldByName('VEI_PLACA').AsString,4,4);
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,Copy('PLACA  : ' + LcPlaca,1,Lc_Nr_Colunas));
          Lc_Linha := Lc_Linha + 1;
          TextOutLC(Lc_Linha,1,Copy('COR    : ' + FieldByName('COR_DESCRICAO').AsString,1,Lc_Nr_Colunas));
        end;
      End;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_Nr_Colunas, '-'));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'Descriçao dos Produtos  ');
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'Qte    VL. Unitário           Sub-Total');
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_Nr_Colunas, '-'));
      // Imprime produtos  do pedido...
      Lc_TL_Produtos := 0;
      Lc_TL_Servicos := 0;

      Qr_Itens.First;
      while not Qr_Itens.eof do
      begin
        Lc_linha := Lc_linha + 1;
        TextOutLC(Lc_Linha,1,Copy(Qr_Itens.FieldByname('PRO_DESCRICAO').Value,1,Lc_Nr_Colunas));
        Lc_linha := Lc_linha + 1;
        TextOutLC(Lc_Linha,1,FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value));
        TextOutLC(Lc_Linha,8,' X ');
        TextOutLC(Lc_Linha,13, FormatFloat('###,##0.00', Qr_Itens.FieldByname('ITF_VL_UNIT').Value));
        Lc_subtotal := Qr_Itens.FieldByname('ITF_QTDE').Value * Qr_Itens.FieldByname('ITF_VL_UNIT').Value;
        Lc_subtotal := RoundTo( Lc_subtotal,-2);
        Lc_TL_Produtos  := Lc_TL_Produtos  + Lc_subtotal;
        TextOutLC(Lc_Linha,Lc_Nr_Colunas - 27,PAdr(FloatToStrF(Lc_subtotal,ffFixed,10,2),10));
        Qr_Itens.Next;
      end;
      Lc_Linha := Lc_Linha + 1;

      if Qr_ItensSrv.RecordCount > 0 then
      Begin
        TextOutLC(Lc_Linha,1,Lc_Traco);
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'Descriçao dos Serviços  ');
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'Qte    VL. Unitário           Sub-Total');
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_Nr_Colunas, '-'));
        // Imprime produtos  do pedido...
        Qr_ItensSrv.First;
        while not Qr_ItensSrv.eof do
        begin
          Lc_linha := Lc_linha + 1;
          TextOutLC(Lc_Linha,1,Copy(Qr_ItensSrv.FieldByname('PRO_DESCRICAO').Value,1,Lc_Nr_Colunas));
          Lc_linha := Lc_linha + 1;
          TextOutLC(Lc_Linha,1,FormatFloat('#0.###', Qr_ItensSrv.FieldByname('ITF_QTDE').Asfloat));
          TextOutLC(Lc_Linha,8,' X ');
          TextOutLC(Lc_Linha,13, FormatFloat('###,##0.00', Qr_ItensSrv.FieldByname('ITF_VL_UNIT').AsCurrency));
          Lc_subtotal := Qr_ItensSrv.FieldByname('ITF_QTDE').Asfloat * Qr_ItensSrv.FieldByname('ITF_VL_UNIT').AsCurrency;
          Lc_subtotal := RoundTo( Lc_subtotal,-2);
          Lc_TL_Servicos := Lc_TL_Servicos + Lc_subtotal;
          TextOutLC(Lc_Linha,Lc_Nr_Colunas - 27,PAdr(FloatToStrF(Lc_subtotal,ffFixed,10,2),10));
          Qr_ItensSrv.Next;
        end;
        Lc_Linha := Lc_Linha + 1;
      End;


      TextOutLC(Lc_Linha,1,CentralizaTexto('-',Lc_Nr_Colunas, '-'));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'Total Produtos : ');
      TextOutLC(Lc_Linha,18,PAdr(FloatToStrF(Lc_TL_Produtos,ffFixed,10,2),Lc_Nr_Colunas - 18));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'Total Serviços');
      TextOutLC(Lc_Linha,18,PAdr(FloatToStrF(Lc_TL_Servicos,ffFixed,10,2),Lc_Nr_Colunas - 18));

      // Desconto Global
      if Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency > 0 then
      begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'(-) Desconto Global');
        TextOutLC(Lc_Linha,Lc_Nr_Colunas - 10,PAdr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2),10));
      end;
      // Desconto Global
      if Qr_Pedido.FieldByname('PED_VL_FRETE').AsCurrency > 0 then
      begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'(+) Valor Frete');
        TextOutLC(Lc_Linha,Lc_Nr_Colunas - 10,PAdr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_FRETE').AsCurrency,ffFixed,10,2),10));
      end;

      // Total Liquido...
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'VALOR TOTAO R$');
      TextOutLC(Lc_Linha,Lc_Nr_Colunas - 10,PAdr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),10));

      //Vendedor
      Lc_Linha := Lc_Linha +2;
      TextOutLC(Lc_Linha,1,'VENDEDOR: ' + Qr_Pedido.FieldByName('CLB_NOME').AsString);
      //Garantia
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'GARANTIA 6 MESES');
      //Asstinatura
      Lc_linha := Lc_linha + 3;
      TextOutLC(Lc_Linha,1,CentralizaTexto('___________________________________',Lc_Nr_Colunas, ' '));
      Lc_linha := Lc_linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto(Qr_Pedido.FieldByName('EMP_FANTASIA').AsString,Lc_Nr_Colunas, ' '));
      Lc_linha := Lc_linha + 1;
      //sALTO
      Lc_Salto := StrToIntDef(Fc_Aq_Geral('L','IMPRESSAO','SALTO','0'),3);
      For Lc_I :=1 to Lc_Salto do
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'');
      end;
      Reset;
      Finalize;
    end;
  Finally
    FreeAndNil(Lc_Prin);
    //Aciona Guilhotina
    Pc_AcionaGuilhotina(It_Porta);
  End;
End;

procedure  TimpModImpressao.Pc_Imp_Cupom_Pedido_5;
var
   Lc_Entrada: Integer;
   Lc_Device: PChar;
   Lc_Driver: Pchar;
   Lc_Porta: Pchar;
   Lc_HdeviceMode: Thandle;
   Lc_ImpAtual: integer;
   Lc_I, Lc_J: Integer;
   Lc_Linha: Integer;
   Lc_Texto: String;
   lc_contador: integer;
   Lc_Prin : TPrin;
   Lc_total : Real;
   Lc_Nr_Colunas,Lc_ColunaCentro : Integer;
   Lc_Traco : String;
begin
  Try
    It_Porta := Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_PORTA','LPT1');
    Lc_Prin := TPrin.Create(nil);
    Lc_Prin.Porta := It_Porta;
    Lc_Prin.Initialize(It_Porta);
    Lc_prin.Condensa(false);
    Lc_total := 0;
    Lc_Linha := 0;
    With Lc_Prin Do
    begin
      Lc_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)
      //Define o tamanhho do Traço
      Lc_Traco := '';
      For Lc_I:= 1 to Lc_Nr_Colunas do
        Lc_Traco := Lc_Traco + '-';
      Lc_ColunaCentro := Trunc(Lc_Nr_Colunas/2);

      //impF(11, 01, 'ENDERECO: ', Lc_TipoFonte);
      Inc(Lc_Linha);
      if (It_Tp_Doc ='ORC - ') then
        TextOutLC(Lc_Linha,1,It_Tp_Doc + Qr_Cotacao.fieldbyname('CTC_NUMERO').AsString)
      else
        TextOutLC(Lc_Linha,1,It_Tp_Doc + Qr_Pedido.fieldbyname('ped_numero').AsString);

      TextOutLC(Lc_Linha,23,Padr(Qr_Pedido.fieldbyname('PED_DT_ALTERA').AsString,19));
      Inc(Lc_Linha);

      if Qr_Pedido.RecordCount >0 then
      Begin
        case Qr_Pedido.FieldByName('PED_TIPO').AsInteger of
          1:Begin
              TextOutLC(Lc_Linha,1,'CLIENTE   : '+ copy(Qr_Pedido.fieldbyname('EMP_FANTASIA').AsString,1,Lc_Nr_Colunas));
            End;
          2:Begin
              TextOutLC(Lc_Linha,1,'FORNECEDOR: '+ copy(Qr_Pedido.fieldbyname('EMP_FANTASIA').AsString,1,Lc_Nr_Colunas));
            End;
          3:Begin
              TextOutLC(Lc_Linha,1,'EMPRESA   : '+ copy(Qr_Pedido.fieldbyname('EMP_FANTASIA').AsString,1,Lc_Nr_Colunas));
            End;
        end;
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'ENDEREÇO : '+ copy( Qr_Pedido.FieldByName('END_ENDER').AsString + ',' + Qr_Pedido.FieldByName('END_NUMERO').AsString,1,Lc_Nr_Colunas));
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'BAIRRO : '+ copy( Qr_Pedido.FieldByName('END_BAIRRO').AsString + ' - ' + Qr_Pedido.FieldByName('CDD_DESCRICAO').AsString,1,Lc_Nr_Colunas));

        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,copy( 'FONE: '+fc_MascaraFone(Qr_Pedido.FieldByName('END_FONE').AsString),1,Lc_Nr_Colunas));
        Inc(Lc_Linha);
        IF Length(Qr_Pedido.FieldByName('EMP_CNPJ').AsString) > 11 THEN
          TextOutLC(Lc_Linha,1,copy( 'CNPJ: ' + fc_MascaraCNPJ(Qr_Pedido.FieldByName('EMP_CNPJ').AsString),1,Lc_Nr_Colunas))
        else
          TextOutLC(Lc_Linha,1,copy( 'CPF: ' + fc_MascaraCPF(Qr_Pedido.FieldByName('EMP_CNPJ').AsString),1,Lc_Nr_Colunas));
      end
      else
      Begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'FONE: '+Qr_Cotacao.FieldByName('CTC_CONTATO').AsString);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'CNPJ: ');
      end;

      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, Lc_Traco);
      Inc(Lc_Linha);
      Lc_prin.Condensa(True);
      TextOutLC(Lc_Linha, 1, Copy('DESCRICAO DOS PRODUTOS ',1,Lc_Nr_Colunas));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, Copy('CODIGO   QTDE X   VL.UNIT   SUBTOTAL',1,Lc_Nr_Colunas));
      while not Qr_Itens.Eof do
        begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha, 1, Copy(Qr_Itens.FieldByName('PRO_DESCRICAO').AsString,1,Lc_Nr_Colunas));
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha, 1, Qr_Itens.FieldByName('PRO_CODIGO').AsString);
        TextOutLC(Lc_Linha, 8, padr( FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Asfloat), 6));
        TextOutLC(Lc_Linha, 17, padr(FloatToStrF(Qr_Itens.FieldByName('ITF_VL_UNIT').AsCurrency, ffFixed, 10, 2), 9));
        TextOutLC(Lc_Linha, 27, padr(FloatToStrF(Qr_Itens.FieldByName('ITF_VL_SUBTOTAL').AsCurrency, ffFixed, 10, 2), 10));
        Qr_Itens.Next;
        end;
      Lc_prin.Condensa(false);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1,Lc_Traco);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, PADR('PRODUTOS  :', Lc_Nr_Colunas -  12));
      TextOutLC(Lc_Linha, Lc_Nr_Colunas -  14, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_PRODUTO').AsCurrency, ffFixed, 10, 2), 11));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, PADR('SUBS.TRIB :', Lc_Nr_Colunas -  12));
      TextOutLC(Lc_Linha, Lc_Nr_Colunas -  14, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_ST').AsCurrency, ffFixed, 10, 2), 11));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, PADR('FRETE     :', Lc_Nr_Colunas -  12));
      TextOutLC(Lc_Linha, Lc_Nr_Colunas -  14, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_FRETE').AsCurrency, ffFixed, 10, 2), 11));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, PADR('DESPESAS  :', Lc_Nr_Colunas -  12));
      TextOutLC(Lc_Linha, Lc_Nr_Colunas -  14, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_ODESPESA').AsCurrency, ffFixed, 10, 2), 11));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, PADR('DESCONTOS :', Lc_Nr_Colunas -  12));
      TextOutLC(Lc_Linha, Lc_Nr_Colunas -  14, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_DESCONTO').AsCurrency, ffFixed, 10, 2), 11));
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, PADR('TOTAL     :', Lc_Nr_Colunas -  12));
      TextOutLC(Lc_Linha, Lc_Nr_Colunas -  14, PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_PEDIDO').AsCurrency, ffFixed, 10, 2), 11));
      Pc_Historico;
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, Pad('I N F O R M A C O E S',Lc_Nr_Colunas,taCenter));
      Inc(Lc_Linha);

      //Cheque Devolvido
      Lc_TExto := 'Cheque(s) Devolvido(s) : ' + FloatToStrF(It_Vl_Chq_DEv, ffFixed, 10, 2);
      TextOutLC(Lc_Linha, 1, lc_texto);
      Inc(Lc_Linha);

      //Saldo Devedor
      Lc_TExto := 'Saldo Devedor          : ' + FloatToStrF(It_Vl_Devedor + It_Vl_Chq_DEv, ffFixed, 10, 2);
      TextOutLC(Lc_Linha, 1, lc_texto);
      Inc(Lc_Linha);
      //Parcelamento
      Qr_Parcelamento.Active := True;
      Qr_Parcelamento.First;
      while not Qr_Parcelamento.Eof do
      Begin
        if Qr_Parcelamento.Bof then
        Begin
          Lc_TExto := 'Data do Vencimento : ' + Qr_Parcelamento.FieldByName('PAR_DATA').AsString;
          TextOutLC(Lc_Linha, 1, lc_texto);
          Inc(Lc_Linha);
        end
        else
        Begin
          Lc_TExto := '                     ' + Qr_Parcelamento.FieldByName('PAR_DATA').AsString;
          TextOutLC(Lc_Linha, 1, lc_texto);
          Inc(Lc_Linha);
        end;
        Qr_Parcelamento.Next;
      end;


      //Mensagem de troca
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha,1,'ATENCAO! Troca de mercadoria so sera efetuada caso haja defeito de fabricacao.');
      Inc(Lc_Linha);

      Inc(Lc_Linha);
      Inc(Lc_Linha);
      TextOutLC(Lc_Linha, 1, Pad('NAO SERVE COMO CUPOM FISCAL',Lc_Nr_Colunas,taCenter));

      For Lc_I:= 1 to (StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),1)) do
      Begin
        inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'');
      end;
      Reset;
      Finalize;
    end;
  Finally
    FreeAndNil(Lc_Prin);
  End;
end;

procedure TImpModImpressao.Pc_Imp_Cupom_Pedido_6;
Var
  Lc_Form : TFrxImpCupomPedido6;
begin
  TRY
    Lc_Form := TFrxImpCupomPedido6.create(Self);
    Lc_Form.Caption := 'CUPOM';
    Lc_Form.CodigoPedido := FCodigoPedido;
    Lc_Form.IniciaVariaveis;
    Lc_Form.frxBase.ShowReport;
  Finally
    Lc_Form.close;
    FreeAndNil(Lc_Form);
  End;
end;

procedure  TimpModImpressao.Pc_Imp_Cupom_Financeiro_1;
Var
  Lc_Linha, Lc_I : Integer;
  Lc_Prin : TPrin;
Begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Imprimir Recibo para o Financeiro.'+EOLN+EOLN+
                     'Confirmar a Impressão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  begin
    try
      It_Porta := Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_PORTA','LPT1');
      Lc_Prin := TPrin.Create(nil);
      Lc_Prin.Porta := It_Porta;
      Lc_Prin.Initialize(It_Porta);
      Lc_prin.Condensa(True);

      Lc_Linha :=0;
      with Qr_Pedido do
      Begin
        Active := False;
        SQL.Clear;
        SQL.Add(' SELECT PED_TIPO,EMP_NOME,EMP_CNPJ, PED_CODEMP,PED_VL_PEDIDO,END_FONE,PED_NUMERO,Ped_DT_ALTERA '+
                ' FROM TB_PEDIDO tb_pedido '+
                ' INNER JOIN TB_EMPRESA tb_empresa ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) '+
                ' LEFT OUTER JOIN TB_FORMAPAGTO tb_formapagto ON (tb_formapagto.FPT_CODIGO = tb_pedido.PED_CODFPG) '+
                ' INNER  JOIN TB_ENDERECO tb_endereco  ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND) '+
                ' LEFT OUTER JOIN TB_COLABORADOR tb_colaborador ON (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO) '+
                ' LEFT OUTER JOIN TB_COTACAO tb_cotacao ON (tb_cotacao.CTC_CODPED = tb_pedido.PED_CODIGO) '+
                ' LEFT OUTER JOIN TB_CIDADE tb_cidade ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '+
                ' LEFT OUTER JOIN TB_UF tb_uf ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
                ' WHERE(PED_CODIGO =:PED_CODIGO) ');
        ParamByName('PED_CODIGO').AsInteger := FCodigoPedido;
        Active := True;
        FetchAll;
        First;
      end;

      with Qr_Cotacao do
      Begin
        Active := False;
        SQL.Clear;
        SQL.Add(' SELECT CTC_CONTATO '+
                ' FROM TB_COTACAO tb_cotacao '+
                ' LEFT OUTER JOIN TB_EMPRESA tb_empresa ON (tb_empresa.EMP_CODIGO = tb_cotacao.CTC_CODEMP) '+
                ' WHERE(CTC_CODPED =:CTC_CODPED) ');
        ParamByName('CTC_CODPED').AsInteger := FCodigoPedido;
        Active := True;
        FetchAll;
        First;
      end;

      With Lc_Prin Do
      begin
        Expandido(true);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,It_Tp_Doc + Qr_Pedido.FieldByName('PED_NUMERO').AsString);
        Expandido(false);
        textoutLc(Lc_Linha,23,Padr(DateTimeToStr(Qr_Pedido.fieldbyname('Ped_DT_ALTERA').AsDateTime),19));

        Inc(Lc_Linha);
        if Qr_Pedido.FieldByName('PED_TIPO').AsString = '1' then  TextOutLC(Lc_Linha,1,'CLIENTE: '+copy(Qr_Pedido.FieldByName('EMP_NOME').AsString,1,49));
        if Qr_Pedido.FieldByName('PED_TIPO').AsString = '3' then  TextOutLC(Lc_Linha,1,'EMPRESA: '+copy(Qr_Pedido.FieldByName('EMP_NOME').AsString,1,49));
        if Qr_Pedido.FieldByName('PED_TIPO').AsString = '2' then  TextOutLC(Lc_Linha,1,'FORNECEDOR: '+copy(Qr_Pedido.FieldByName('EMP_NOME').AsString,1,46));
        if Qr_Pedido.RecordCount >0 then
        Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'FONE: '+fc_MascaraFone(Qr_Pedido.FieldByName('END_FONE').AsString));
          Inc(Lc_Linha);

          IF Length(Qr_Pedido.FieldByName('EMP_CNPJ').AsString) > 11 THEN
            TextOutLC(Lc_Linha,1,'CNPJ: ' + fc_MascaraCNPJ(Qr_Pedido.FieldByName('EMP_CNPJ').AsString))
          else
            TextOutLC(Lc_Linha,1,'CPF: ' + fc_MascaraCPF(Qr_Pedido.FieldByName('EMP_CNPJ').AsString));
        end
        else
        Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'FONE: '+Qr_Cotacao.FieldByName('CTC_CONTATO').AsString);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'CNPJ: ');
        end;
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'=====================================================');
        Inc(Lc_Linha);
        Expandido(true);
        TextOutLC(Lc_Linha,7,'TOTAL   :');
        TextOutLC(Lc_Linha,19,PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),8));
        Expandido(false);
        For Lc_I:= 1 to (StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),1)+3) do
        bEGIN
          Inc(Lc_Linha);
          TextOutLC(6+Lc_I,1,'');
        end;
        Finalize;
      END;
    finally
      FreeAndNil(Lc_Prin);
    end;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Cupom_Financeiro_2;
Begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Imprimir Recibo para o Financeiro.'+EOLN+EOLN+
                     'Confirmar a Impressão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    begin
    {with Fr_Principal.RdPrint_DP do
      Begin
      // Cabeçalho do Cupom...
      Lc_TipoFonte :=[negrito];
      abrir;
      TamanhoQteLinhas := 1; // Linhas (deve ser 1 quando for CUPOM)
      Lc_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)
      TamanhoQteColunas := Lc_Nr_Colunas;
      //Define o tamanhho do Traço
      Lc_Traco := '';
      For Lc_I:= 1 to Lc_Nr_Colunas do
        Lc_Traco := Lc_Traco + '-';

      Lc_ColunaCentro := Trunc(Lc_Nr_Colunas/2);

      Inc(Lc_Linha);
      ImpF(Lc_Linha,01,It_Tp_Doc + Qr_Pedido.FieldByName('PED_NUMERO').AsString,Lc_TipoFonte);
      ImpF(Lc_Linha,23,Padr(DateTimeToStr(Qr_Pedido.fieldbyname('Ped_DT_ALTERA').AsDateTime),19),Lc_TipoFonte);
      //Traço
      Inc(Lc_Linha);
      imp(Lc_Linha, 01, Lc_traco);
      
      Inc(Lc_Linha);
      if Qr_Pedido.FieldByName('PED_TIPO').AsString = '1' then  ImpF(Lc_Linha,1,'CLIENTE: '+copy(Qr_Pedido.FieldByName('EMP_NOME').AsString,1,49),Lc_TipoFonte);
      if Qr_Pedido.FieldByName('PED_TIPO').AsString = '3' then  ImpF(Lc_Linha,1,'EMPRESA: '+copy(Qr_Pedido.FieldByName('EMP_NOME').AsString,1,49),Lc_TipoFonte);
      if Qr_Pedido.FieldByName('PED_TIPO').AsString = '2' then  ImpF(Lc_Linha,1,'FORNECEDOR: '+copy(Qr_Pedido.FieldByName('EMP_NOME').AsString,1,46),Lc_TipoFonte);
      if Qr_Pedido.RecordCount >0 then
        Begin
        Inc(Lc_Linha);
        ImpF(Lc_Linha,1,'FONE: '+fc_MascaraFone(Qr_Pedido.FieldByName('END_FONE').AsString),Lc_TipoFonte);
        Inc(Lc_Linha);

        IF Length(Qr_Pedido.FieldByName('EMP_CNPJ').AsString) > 11 THEN
          ImpF(Lc_Linha,1,'CNPJ: ' + fc_MascaraCNPJ(Qr_Pedido.FieldByName('EMP_CNPJ').AsString),Lc_TipoFonte)
        else
          ImpF(Lc_Linha,1,'CPF: ' + fc_MascaraCPF(Qr_Pedido.FieldByName('EMP_CNPJ').AsString),Lc_TipoFonte);
        end
      else
        Begin
        Inc(Lc_Linha);
        ImpF(Lc_Linha,1,'FONE: '+Qr_Cotacao.FieldByName('CTC_CONTATO').AsString,Lc_TipoFonte);
        Inc(Lc_Linha);
        ImpF(Lc_Linha,1,'CNPJ: ',Lc_TipoFonte);
        end;
      //Traço
      Inc(Lc_Linha);
      imp(Lc_Linha, 01, Lc_traco);

      Inc(Lc_Linha);
      ImpF(Lc_Linha,7,'TOTAL   :',Lc_TipoFonte);
      ImpF(Lc_Linha,19,PADR(FloatToStrF(Qr_Pedido.FieldByName('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),8),Lc_TipoFonte);

      For Lc_I:= 1 to (StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),1)+3) do
        bEGIN
        inc(Lc_linha);
        imp(Lc_linha, 01, ' ');
        end;

      TamanhoQteLinhas := Lc_linha;
      //Tipo de Impressão
      case StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_TIPO_IMPRESSORA', '1'),1) of
        1:Impressora := Bobina;
        2:Impressora := Epson;
        3:Impressora := Grafico;
        4:Impressora := HP;
        5:Impressora := Personalizado;
        6:Impressora := Rima;
        end;
      fechar;
      end;}
    end;
end;


procedure  TimpModImpressao.Pc_Imp_Cupom_Financeiro_3;
Begin
  Pc_Imp_Cupom_Financeiro_2;
end;

procedure  TimpModImpressao.Pc_Imp_Cupom_Financeiro_4;
Begin
  Pc_Imp_Cupom_Financeiro_1;
end;

function  TimpModImpressao.Fc_VerificaConserto:Boolean;
begin
  with Qr_Conserto do
  Begin
    Active:=false;
    SQL.Clear;
    SQL.Add(concat(
              'SELECT CST_CODIGO,CST_DT_ENTREGA ',
              'FROM TB_CONSERTO tb_conserto ',
              '  LEFT OUTER JOIN TB_EMPRESA tb_empresa ',
              '  ON (tb_empresa.EMP_CODIGO = tb_conserto.CST_CODFOR) ',
              '  INNER JOIN TB_SITUACAO tb_situacao ',
              '  ON (tb_situacao.SIT_CODIGO = tb_conserto.CST_CODSIT) ',
              'WHERE (CST_CODPED=:PED_CODIGO) '
    ));
    ParamByName('PED_CODIGO').AsInteger:=FCodigoPedido;
    Active:=true;
    FetchAll;
    if Qr_Conserto.IsEmpty then
      Result:=false
    else
      Result:=true;
  End;
end;

procedure  TimpModImpressao.Pc_Imp_Conserto;
Var
  Lc_tipo : Integer;
  Lc_Faturado : boolean;
Begin
  Lc_Faturado := False;
  with Qr_Pedido do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add(' SELECT PED_CODIGO,PED_FATURADO '+
            ' FROM TB_PEDIDO tb_pedido '+
            ' INNER JOIN TB_EMPRESA tb_empresa ON (tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP) '+
            ' LEFT OUTER JOIN TB_FORMAPAGTO tb_formapagto ON (tb_formapagto.FPT_CODIGO = tb_pedido.PED_CODFPG) '+
            ' INNER  JOIN TB_ENDERECO tb_endereco  ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND) '+
            ' LEFT OUTER JOIN TB_COLABORADOR tb_colaborador ON (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO) '+
            ' LEFT OUTER JOIN TB_COTACAO tb_cotacao ON (tb_cotacao.CTC_CODPED = tb_pedido.PED_CODIGO) '+
            ' LEFT OUTER JOIN TB_CIDADE tb_cidade ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '+
            ' LEFT OUTER JOIN TB_UF tb_uf ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
            ' WHERE(PED_CODIGO =:PED_CODIGO) ');
    ParamByName('PED_CODIGO').AsInteger := FCodigoPedido;
    Active := True;
    FetchAll;
    Lc_Faturado := (FieldByName('PED_FATURADO').AsString = 'S');
    IF IsEmpty THEN// se nao encontra conserto atraves do pedido , verifica so conserto
      Begin
      Active := False;
      SQL.Clear;
      SQL.Add(' SELECT CTC_CODPED '+
              ' FROM TB_COTACAO tb_cotacao '+
              ' LEFT OUTER JOIN TB_EMPRESA tb_empresa ON (tb_empresa.EMP_CODIGO = tb_cotacao.CTC_CODEMP) '+
              ' WHERE(CTC_CODPED =:CTC_CODPED) ');
      ParamByName('CTC_CODPED').AsInteger := FCodigoPedido;
      Active := True;
      FCodigoPedido:= fieldbyname('CTC_CODPED').AsInteger;
      end;
    end;

  Lc_tipo:=(MensagemPadrao(TITULO_INFORMACAO,
                           'Deseja enviar para?',
                           ['CUPOM','NORMAL','CANCELA'],[bNormal,bNormal,bEscape],mpConfirmacao,clBtnFace));
  case Lc_tipo of
    0:Begin
      if Lc_Faturado then
        It_Tp_Doc:='PEDIDO: '
      else
        It_Tp_Doc:='ORC - ';
      Pc_Imp_Cupom;
      end;
    1:Begin
      if not Qr_Conserto.fieldbyname('CST_DT_ENTREGA').isnull then
        Pc_Imp_ConsertoDataEntrega
      else
        Pc_Imp_ConsertoSemDataEntrega;
      end;
    end;
end;

procedure  TimpModImpressao.Pc_Imp_Tipo(Pc_TipoPed:integer; Pc_cd_Pedido,Pc_cd_Nota:integer);
begin
  FCodigoPedido:=Pc_cd_Pedido;
  if Pc_TipoPed = 0 then Pc_Imp_Orc(FCodigoPedido)
  else
    if Pc_TipoPed = 1 then Pc_Imp_Vda(FCodigoPedido,Pc_cd_Nota)
  else
    if Pc_TipoPed = 2 then Pc_Imp_CPa(FCodigoPedido,Pc_cd_Nota)
  else
    if Pc_TipoPed = 3 then Pc_Imp_Ajt(FCodigoPedido,Pc_cd_Nota)
  else
    if Pc_TipoPed = 4 then Pc_Imp_Vda(FCodigoPedido,Pc_cd_Nota);
end;

procedure  TimpModImpressao.Pc_Imp_Pizzaria(Pc_cd_Pedido,Pc_cd_Nota:integer);
var
  Lc_Escolha : Integer;
  Lc_tipo:integer;
begin
  FCodigoPedido:=Pc_cd_Pedido;
  Pc_DadosPedido(1);
  it_Tp_Impressora :=  StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_IMPRESSORA',''),0);
  case it_Tp_Impressora of
    0:Begin
        Pc_Imp_Piz_Matricial;
      end;
    1:Begin
        Pc_Imp_Piz_Termica;
      end;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Piz_Matricial;
Begin
  if fc_ChamaImpressora then
  Begin;
    it_Modelo_matricial:= StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_P_MOD_MATRICIAL', '1'),1);
    case it_Modelo_matricial of
      1:Pc_Imp_Piz_Matricial_1;
    end;
    Printer.PrinterIndex := It_Imp_Atual ;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Piz_Matricial_1;
begin

end;

procedure  TimpModImpressao.Pc_Imp_Piz_Termica;
Begin
  if fc_ChamaImpressora then
  Begin;
    it_Modelo_Termica:= StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE PIZZARIA','PIZ_P_MOD_TERMICA', '1'),1);
    case it_Modelo_Termica of
      1:Pc_Imp_Piz_Termica_1;
    end;
    Printer.PrinterIndex := It_Imp_Atual ;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Piz_Termica_1;
Begin

end;

procedure  TimpModImpressao.Pc_Imp_ConsertoDataEntrega;
Var
  Lc_Form : TRL_OrcaCst_Entg;
begin
  try
    Lc_Form := TRL_OrcaCst_Entg.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_ConsertoSemDataEntrega;
Var
  Lc_Form : TRL_OrcaConserto;
begin
  try
    Lc_Form := TRL_OrcaConserto.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_Orc(it_cod_Pedido:integer);
var
lc_escolha:Integer;
begin
  it_Tp_Impressora :=  StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_P_IMPRESSORA',''),0);
  case it_Tp_Impressora of
  0:Begin
      Pc_Imp_Orc_Matricial;
    end;
  1:Begin
      Pc_Imp_Orc_JatoLaser;
    end;
  2:Begin
      Lc_escolha:=0;
      Lc_Escolha := (MensagemPadrao(TITULO_INFORMACAO,
                                    'Deseja enviar para?',
                                    ['MATRICIAL', 'LASER/JATO', 'CANCELA'], [bNormal, bNormal, bEscape], mpConfirmacao, clBtnFace));
      case Lc_Escolha of
        0:Pc_Imp_Orc_Matricial;
        1:Pc_Imp_Orc_JatoLaser;
      end;
    end;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_Matricial;
begin
  if not fc_ChamaImpressora then exit;
  it_Modelo_matricial:= StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_G_MOD_MATRICIAL', ''),1);
  case it_Modelo_matricial of
     1:Pc_Imp_Orc_Matricial_1;
     2:Pc_Imp_Orc_Matricial_2;
     3:Pc_Imp_Orc_Matricial_3;
  ELSE Pc_Pc_Modelo_Inexistente(0,0);                           
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser;
begin
  IF fc_VerificaOrdemOrc then
  Begin
    it_Modelo_jatolaser:= StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_G_MOD_JATOLASER', ''),1);
    case it_Modelo_jatolaser of
      1:Pc_Imp_Orc_JatoLaser_Srv_1;
      2:Pc_Imp_Orc_JatoLaser_Srv_2;
      3:Pc_Imp_Orc_JatoLaser_Srv_3;
      4:Pc_Imp_Orc_JatoLaser_Srv_4;
      5:Pc_Imp_Orc_JatoLaser_Srv_5;
      6:Pc_Imp_Orc_JatoLaser_Srv_6;
      7:Pc_Imp_Orc_JatoLaser_Srv_7;
      8:Pc_Imp_Orc_JatoLaser_Srv_8;
      9:Pc_Imp_Orc_JatoLaser_Srv_9;
      10:Pc_Imp_Orc_JatoLaser_Srv_10;
      11:Pc_Imp_Orc_JatoLaser_Srv_11;
      12:Pc_Imp_Orc_JatoLaser_Srv_12;
      13:Pc_Imp_Orc_JatoLaser_Srv_13;
    ELSE
      Pc_Imp_Orc_JatoLaser_Srv_1;
    end;
  end
  else
  begin
    it_Modelo_jatolaser:= StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_G_MOD_JATOLASER', ''),1);
    case it_Modelo_jatolaser of
      1:Pc_Imp_Orc_JatoLaser_1;
      2:Pc_Imp_Orc_JatoLaser_2;
      3:Pc_Imp_Orc_JatoLaser_3;
      4:Pc_Imp_Orc_JatoLaser_4;
      5:Pc_Imp_Orc_JatoLaser_5;
      6:Pc_Imp_Orc_JatoLaser_6;
      7:Pc_Imp_Orc_JatoLaser_7;
      8:Pc_Imp_Orc_JatoLaser_8;
      9:Pc_Imp_Orc_JatoLaser_9;
      10:Pc_Imp_Orc_JatoLaser_10;
      11:Pc_Imp_Orc_JatoLaser_11;
      12:Pc_Imp_Orc_JatoLaser_12;
      13:Pc_Imp_Orc_JatoLaser_13;
    ELSE
      Pc_Pc_Modelo_Inexistente(0,0);
    end;
  END;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_Matricial_1;
Var
  F: TextFile;
  Lc_TExto : String;
  Lc_ItensPP : Integer;
  lc_contador : Integer;
  lc_I, lc_J : Integer;
  Lc_Prin : TPrin;
Begin
  try
    Pc_Imp_ContultaOrcamento;
    Lc_ItensPP := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_P_ITENS_FOLHA','16'),16);
    lc_contador := Lc_ItensPP + 4;
    Lc_Prin:=TPrin.Create(nil);
    With Lc_Prin Do
      begin
      Initialize(It_Porta);
      lc_I := 1;
      TextOutLC(lc_I,1,'PEDIDO: ');
      textoutLc(lc_I,9,Qr_Cotacao.fieldbyname('CTC_NUMERO').AsString);
      TextOutLC(lc_I,52,'DATA  : ');
      textoutLc(lc_I,60,Padr(Qr_Cotacao.fieldbyname('DATA').AsString,10) + ' - ' + Copy(TimeToStr(Time),1,5));
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'NOME DO CLIENTE: ');
      TextOutLC(lc_I,18,Copy(Qr_Cotacao.fieldbyname('CTC_FANTASIA').AsString,1,32));

      IF Qr_Pedido.RecordCount > 0 THEN
      BEGIN
        IF Qr_Pedido.FIELDBYNAME('EMP_PESSOA').AsString = 'F' then
        Begin
        TextOutLC(lc_I,51,'C.P.F: ');
        TextOutLC(lc_I,60,Padr(fc_MascaraCPF(Qr_Pedido.FIELDBYNAME('EMP_CNPJ').AsString),18));
        end
      else
        Begin
        TextOutLC(lc_I,51,'C.N.P.J: ');
        TextOutLC(lc_I,60,Padr(fc_MascaraCNPJ(Qr_Pedido.FIELDBYNAME('EMP_CNPJ').AsString),18));
        end;
      END;
      
      lc_I := lc_I +1;
      TextOutLC(lc_I,1,Copy('ENDERECO: ' + Qr_Pedido.Fieldbyname('END_ender').AsString + ', '+ Qr_Pedido.Fieldbyname('END_NUMERO').AsString +'  -  '+
                     ' BAIRRO: ' + Qr_Pedido.Fieldbyname('END_BAIRRO').AsString,1,79));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'CEP: '+Copy(Qr_Pedido.Fieldbyname('END_CEP').AsString,1,5)+'-'+Copy(Qr_Pedido.Fieldbyname('END_CEP').AsString,6,3));
      TextOutLC(lc_I,16,'CIDADE: '+Copy(Qr_Pedido.Fieldbyname('CDD_DESCRICAO').AsString + ' - '+Qr_Pedido.Fieldbyname('UFE_DESCRICAO').AsString,1,50));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'FONE: '+fc_MascaraFone(Qr_Pedido.Fieldbyname('END_FONE').AsString)+'  -  ');
      TextOutLC(lc_I,26,'CONTATO: '+Copy(Qr_Pedido.Fieldbyname('END_CONTATO').AsString,1,16));
      TextOutLC(lc_I,51,'VENDEDOR: '+Copy(qr_Cotacao.Fieldbyname('CLB_NOME').AsString,1,28));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'CODIGO');
      TextOutLC(lc_I,22,'DESCRICAO DOS PRODUTOS');
      TextOutLC(lc_I,49,'QTDE');
      TextOutLC(lc_I,58,'PRECO');
      TextOutLC(lc_I,70,'SUBTOTAL');
      While not Qr_Itens.EOF do
        BEGIN
        if (lc_contador > 0) then
          Begin
          lc_I := lc_I + 1;
          lc_contador := lc_contador - 1;
          TextOutLC(lc_I,1,Copy(Qr_Itens.Fieldbyname('PRO_CODIGOFAB').AsString,1,20));
          TextOutLC(lc_I,22,Copy(Qr_Itens.Fieldbyname('ICT_DESCRICAO').AsString,1,25));
          TextOutLC(lc_I,48,Padr(Qr_Itens.Fieldbyname('ICT_QTDE').AsString,6));
          TextOutLC(lc_I,57,Padr((floattostrf((Qr_Itens.Fieldbyname('ICT_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
          TextOutLC(lc_I,69,Padr((floattostrf((Qr_Itens.Fieldbyname('ICT_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
          Qr_Itens.Next;
          end;

        if (lc_contador = 0) OR (Qr_Itens.Eof and (lc_contador < 4)) then
          Begin
          for Lc_J:=1 to (lc_contador) do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'                                                                    CONTINUA...');
          lc_I := lc_I + 2;
          lc_contador := Lc_ItensPP + 12;
          end;
       end;
      for Lc_J:=1 to (lc_contador - 4) do
        Begin
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'');
        end;


      //Imprimi o Rodape
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,'CONFERIR O MATERIAL NO ATO DA ENTREGA. NAO ACEITAMOS RECLAMACOES POSTERIORES.');
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
      if Length(Qr_Cotacao.fieldbyname('CTC_OBS').AsString)>0 then
        Begin
        It_Observacao.Lines.Clear;
        It_Observacao.Lines.Add(Qr_Cotacao.fieldbyname('CTC_OBS').AsString);
        For lc_J := 0 to It_Observacao.Lines.Count - 1 do
          Begin
          if lc_J = 0 then
            begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'OBSERVACAO: ');
            TextOutLC(lc_I,13,It_Observacao.Lines[lC_j]);
            end
          else
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,13,It_Observacao.Lines[lC_j]);
            end;
          end;
        lc_I := lc_I + 1;
        end;

      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,49,'TOTAL DOS PRODUTOS:');
      TextOutLC(lc_I,69,Padr(formatFloat('#,##0.00', Qr_Cotacao.fieldbyname('CTC_VL_PRODUTO').AsCurrency),11));

      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,49,'TAXA DE ENTREGA   :');
      TextOutLC(lc_I,69,Padr(formatFloat('#,##0.00',Qr_Cotacao.fieldbyname('CTC_VL_FRETE').AsCurrency),11));

      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1 ,'________________________________________');
      TextOutLC(lc_I,49,'DESCONTO ');
      TextOutLC(lc_I,58,Padr(formatFloat('#,##0.00',Qr_Cotacao.fieldbyname('CTC_ALIQ_DESCONTO').AsCurrency),8) + ' :');
      TextOutLC(lc_I,69,Padr(formatFloat('#,##0.00',Qr_Cotacao.fieldbyname('CTC_VL_DESCONTO').AsCurrency),11));

      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1 ,'ASSINATURA');
      TextOutLC(lc_I,49,'TOTAL DO PEDIDO   :');
      TextOutLC(lc_I,69,Padr(formatFloat('#,##0.00',Qr_Cotacao.fieldbyname('CTC_VL_COTACAO').AsCurrency),11));
      lc_I := lc_I + 3 ;
      TextOutLC(lc_I,1 ,'');
      end;
      Lc_Prin.Finalize;
      FreeAndNil(Lc_Prin);
    except
      Lc_Prin.Finalize;
      FreeAndNil(Lc_Prin);
      Exit;
    end;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_Matricial_2;
Var
  F: TextFile;
  Lc_TExto : String;
  Lc_ItensPP : Integer;
  lc_contador : Integer;
  lc_I, lc_J : Integer;
  Lc_Prin : TPrin;
Begin
 try
    Pc_Imp_ContultaOrcamento;

    Lc_ItensPP := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE ORCAMENTO','ORC_P_ITENS_FOLHA','16'),16);
    lc_contador := Lc_ItensPP + 4;
    Lc_Prin:=TPrin.Create(nil);
    With Lc_Prin Do
      begin
      Initialize(It_Porta);
      lc_I := 1;
      TextOutLC(lc_I,1,'PEDIDO: ');
      textoutLc(lc_I,9,(Qr_Cotacao.fieldbyname('CTC_NUMERO').AsString));
      TextOutLC(lc_I,52,'DATA  : ');
      textoutLc(lc_I,60,Padr(Qr_Cotacao.fieldbyname('DATA').AsString,10) + ' - ' + Copy(TimeToStr(Time),1,5));
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'NOME DO CLIENTE: ');
      TextOutLC(lc_I,18,Copy(Qr_Cotacao.fieldbyname('CTC_FANTASIA').AsString,1,32));

      lc_I := lc_I + 1;

      IF Qr_Ordem.RecordCount > 0 THEN
        begin
          TextOutLC(lc_I,1,'PLACA: ' + Copy(Qr_Ordem.FieldByName('VEI_PLACA').AsString,1,3) + '-' + Copy(Qr_Ordem.FieldByName('VEI_PLACA').AsString,4,4));
          TextOutLC(lc_I,18,'  VEICULO: ' + Copy(Qr_Ordem.FieldByName('TPV_DESCRICAO').AsString + ' ' +Qr_Ordem.FieldByName('MOD_DESCRICAO').AsString ,1,28));
        end;

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'VENDEDOR: '+Copy(Qr_Cotacao.Fieldbyname('CLB_NOME').AsString,1,16));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'CODIGO');
      TextOutLC(lc_I,22,'DESCRICAO DOS PRODUTOS');
      TextOutLC(lc_I,49,'QTDE');
      TextOutLC(lc_I,58,'PRECO');
      TextOutLC(lc_I,70,'SUBTOTAL');

      While not Qr_Itens.EOF do
        BEGIN
        if (lc_contador > 0) then
          Begin
          lc_I := lc_I + 1;
          lc_contador := lc_contador - 1;
          TextOutLC(lc_I,1,Qr_Itens.Fieldbyname('PRO_CODIGOFAB').AsString);
          TextOutLC(lc_I,22,Qr_Itens.Fieldbyname('ICT_DESCRICAO').AsString);
          TextOutLC(lc_I,48,Qr_Itens.Fieldbyname('ICT_QTDE').AsString);
          TextOutLC(lc_I,57,Padr((floattostrf((Qr_Itens.Fieldbyname('ICT_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
          TextOutLC(lc_I,69,Padr((floattostrf((Qr_Itens.Fieldbyname('ICT_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
          Qr_Itens.Next;
          end;
        END;

       While not Qr_ItensSrv.EOF do
        BEGIN
        if (lc_contador > 0) then
          Begin
          lc_I := lc_I + 1;
          lc_contador := lc_contador - 1;
          TextOutLC(lc_I,1,Qr_ItensSrv.Fieldbyname('ICT_CODIGO').AsString);
          TextOutLC(lc_I,22,Qr_ItensSrv.Fieldbyname('ICT_DESCRICAO').AsString);
          TextOutLC(lc_I,48,Padr(Qr_ItensSrv.Fieldbyname('ICT_QTDE').AsString,6));
          TextOutLC(lc_I,57,Padr((floattostrf((Qr_ItensSrv.Fieldbyname('ICT_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
          TextOutLC(lc_I,69,Padr((floattostrf((Qr_ItensSrv.Fieldbyname('ICT_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
          Qr_ItensSrv.Next;
          end;

        if (lc_contador = 0) OR (Qr_Itens.Eof and (lc_contador < 4)) AND (Qr_Itens.Eof and (lc_contador < 4)) then
          Begin
          for Lc_J:=1 to (lc_contador) do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'                                                                    CONTINUA...');
          lc_I := lc_I + 2;
          lc_contador := Lc_ItensPP + 12;
          end;
       end;
      for Lc_J:=1 to (lc_contador - 4) do
        Begin
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'');
        end;


      //Imprimi o Rodape
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,'CONFERIR O MATERIAL NO ATO DA ENTREGA. NAO ACEITAMOS RECLAMACOES POSTERIORES.');
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
      It_Observacao.Lines.Clear;
      if Length(Qr_Cotacao.Fieldbyname('CTC_OBS').AsString)>0 then
        Begin
        It_Observacao.Text := Qr_Cotacao.Fieldbyname('CTC_OBS').AsString;
        For lc_J := 0 to It_Observacao.Lines.Count - 1 do
          Begin
          if lc_J = 0 then
            begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'OBSERVACAO: ');
            TextOutLC(lc_I,13,It_Observacao.Lines[lC_j]);
            end
          else
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,13,It_Observacao.Lines[lC_j]);
            end;
          end;
        lc_I := lc_I + 1;
        end;

      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,49,'TOTAL DOS PRODUTOS:');
      TextOutLC(lc_I,69,Padr((floattostrf((Qr_Cotacao.Fieldbyname('CTC_VL_PRODUTO').AsCurrency),ffFixed,16,2)),11));

      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,49,'TAXA DE ENTREGA   :');
      TextOutLC(lc_I,69,Padr((floattostrf((Qr_Cotacao.Fieldbyname('CTC_VL_FRETE').AsCurrency),ffFixed,16,2)),11));

      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1 ,'________________________________________');
      TextOutLC(lc_I,49,'DESCONTO ');
      TextOutLC(lc_I,58,Padr((floattostrf((Qr_Cotacao.Fieldbyname('CTC_ALIQ_DESCONTO').AsCurrency),ffFixed,16,2)),8) + ' :');
      TextOutLC(lc_I,69,Padr((floattostrf((Qr_Cotacao.Fieldbyname('CTC_VL_DESCONTO').AsCurrency),ffFixed,16,2)),11));

      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1 ,'ASSINATURA');
      TextOutLC(lc_I,49,'TOTAL DO PEDIDO   :');
      TextOutLC(lc_I,69,Padr((floattostrf((Qr_Cotacao.Fieldbyname('CTC_VL_COTACAO').AsCurrency),ffFixed,16,2)),11));
      lc_I := lc_I + 3 ;
      TextOutLC(lc_I,1 ,'');
      end;
      Lc_Prin.Finalize;
      FreeAndNil(Lc_Prin);
    except
      Lc_Prin.Finalize;
      FreeAndNil(Lc_Prin);
      Exit;
    end;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_Matricial_3;
Var
  F: TextFile;
  Lc_I:Integer;
  Lc_Linha : Integer;
  Lc_Mecanicos : String;
  Lc_Prin : TPrin;
Begin
  Try
    //Monta o Orçamento
    Pc_Imp_ContultaOrcamento;
    Pc_AbreDadosOrdem('COTACAO');
    Lc_Linha := 1;
    Lc_Prin:=TPrin.Create(self);
    With Lc_Prin Do
    begin
      Initialize(It_Porta);

      Negrito(False);
      Condensa(True);
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'ORCAMENTO DE SERVICO: ');

      textoutLc(Lc_Linha,19,Padr(Qr_Cotacao.fieldbyname('CTC_NUMERO').Value,15));
      TextOutLC(Lc_Linha,117,'DATA  : ' + Qr_Cotacao.FieldByName('DATA').AsString  );

      Lc_Linha := Lc_Linha + 1;

      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Pc_AtivaEstabelecimento;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'EMPRESA: ' + Copy(DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString,1,70));
      TextOutLC(Lc_Linha,72,'ENDERECO: ' + Copy(DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ', ' +DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString ,1,37));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'BAIRRO: ' + Copy(DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString,1,50));
      TextOutLC(Lc_Linha,47,'CIDADE: ' + Copy(DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString,1,30));
      TextOutLC(Lc_Linha,87,'UF: ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString);
      TextOutLC(Lc_Linha,9,'CEP: ' + Fc_MascaraCep(DM.Qr_Estabelecimento.FieldByname('END_CEP').AsString));
      TextOutLC(Lc_Linha,115,'FONE: ' + fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'CNPJ: ' + fc_MascaraCNPJ(DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString));
      TextOutLC(Lc_Linha,57,'INSCRICAO : ' + DM.Qr_Estabelecimento.FieldByname('EMP_INSC_EST').AsString);
      TextOutLC(Lc_Linha,115,'FAX : ' + fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FAX').AsString));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'CLIENTE: ' + Copy(Qr_Cotacao.FieldByName('CTC_FANTASIA').AsString,1,70));
      TextOutLC(Lc_Linha,72,'ENDERECO: ' + Copy(Qr_Pedido.FieldByName('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByName('END_NUMERO').AsString + ' ' + Qr_Pedido.FieldByName('END_COMPLEM').AsString,1,50));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'BAIRRO: ' + Copy(Qr_Pedido.FieldByName('END_BAIRRO').AsString,1,37));
      TextOutLC(Lc_Linha,47,'CIDADE: ' + Copy(Qr_Pedido.FieldByName('CDD_DESCRICAO').AsString,1,30));
      TextOutLC(Lc_Linha,87,'UF: ' + Qr_Pedido.FieldByName('UFE_SIGLA').AsString);
      TextOutLC(Lc_Linha,9,'CEP: ' + Fc_MascaraCep(Qr_Pedido.FieldByName('END_CEP').AsString));
      TextOutLC(Lc_Linha,115,'FONE: ' + fc_MascaraFone(Qr_Pedido.FieldByName('END_FONE').AsString));

      Lc_Linha := Lc_Linha + 1;
      if Length(Qr_Pedido.FieldByName('EMP_CNPJ').AsString)>11 then
        TextOutLC(Lc_Linha,1,'CNPJ: ' + fc_MascaraCNPJ(Qr_Pedido.FieldByName('EMP_CNPJ').AsString))
      else
        TextOutLC(Lc_Linha,1,'CPF: ' + fc_MascaraCPF(Qr_Pedido.FieldByName('EMP_CNPJ').AsString));
      TextOutLC(Lc_Linha,57,'I.E.RG : ' + Qr_Pedido.FieldByName('EMP_INSC_EST').AsString);
      TextOutLC(Lc_Linha,115,'FAX : ' + fc_MascaraFone(Qr_Pedido.FieldByName('END_FAX').AsString));

      Lc_Linha := Lc_Linha + 1;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,Copy('MARCA: ' + Qr_Ordem.FieldByName('TPV_DESCRICAO').AsString + ' ' +Qr_Ordem.FieldByName('MRC_DESCRICAO').AsString ,1,27));
      TextOutLC(Lc_Linha,29,Copy('MODELO: ' + Qr_Ordem.FieldByName('MOD_DESCRICAO').AsString,1,32));
      TextOutLC(Lc_Linha,62,'PLACA : ' + Copy(Qr_Ordem.FieldByName('VEI_PLACA').AsString,1,3) + '-' + Copy(Qr_Ordem.FieldByName('VEI_PLACA').AsString,4,4));
      TextOutLC(Lc_Linha,81,'KM/HR : '+  Qr_Ordem.FieldByName('VEI_KM').AsString);
      TextOutLC(Lc_Linha,99,'FROTA : ' + Qr_Ordem.FieldByName('VEI_FROTA').AsString);
      TextOutLC(Lc_Linha,116,'COR: ' + Copy(Qr_Ordem.FieldByName('COR_DESCRICAO').AsString,1,13));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');
      It_Observacao.Clear;
      It_Observacao.Lines.Add(Qr_Ordem.FieldByName('OBS').AsString);
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'SERVICO SOLICITADO/IDENTIFICADO E OBSERVACOES');
      For Lc_I := 0 to (It_Observacao.Lines.Count - 1) do
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,It_Observacao.Lines[Lc_I]);
      end;

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'MECANICO              DESCRICAO DOS SERVICOS                                                         QTDE/HORAS              SUBTOTAL');

      Qr_ItensSrv.FetchAll;
      Qr_ItensSrv.First;
      while not Qr_ItensSrv.Eof do
      Begin
        {
        Qr_Tecnico.Active := False;
        Qr_Tecnico.SQL.Clear;
        Qr_Tecnico.SQL.Add(' SELECT TEC_CODCLB '+
                           ' FROM TB_TECNICO tb_tecnico '+
                           ' WHERE  TEC_CODITF =:ITF_CODIGO ');
        Qr_Tecnico.ParamByName('ITF_CODIGO').AsInteger := Qr_ItensSrv.FieldByName('ITF_CODIGO').AsInteger;
        Qr_Tecnico.Active := True;
        Qr_Tecnico.First;
        Lc_Mecanicos := '';
        while not Qr_Tecnico.eof do
        Begin
          if Qr_Tecnico.Bof then
            Lc_Mecanicos := Qr_Tecnico.FieldByName('TEC_CODCLB').AsString
          else
            Lc_Mecanicos := Lc_Mecanicos + '/' +Qr_Tecnico.FieldByName('TEC_CODCLB').AsString;
          Qr_Tecnico.Next;
        end;
        }
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,Copy(Lc_Mecanicos,1,20));
        TextOutLC(Lc_Linha,23,Copy(Qr_ItensSrv.FieldByName('ICT_DESCRICAO').AsString,1,77));
        TextOutLC(Lc_Linha,100,Padr((floattostrf((Qr_ItensSrv.FieldByName('ICT_QTDE').asfloat),ffFixed,10,2)),11));
        TextOutLC(Lc_Linha,123,Padr((floattostrf((Qr_ItensSrv.FieldByName('ICT_VL_SUBTOTAL').AsCurrency),ffFixed,10,2)),11));
        Qr_ItensSrv.Next;
      end;

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'CODIGO      DESCRICAO DOS PRODUTOS                                                           QTDE         VL.UNIT.           SUBTOTAL');

      Qr_Itens.Active := True;
      Qr_Itens.First;

      while not Qr_Itens.Eof do
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,Padr(Qr_Itens.FieldByName('PRO_CODIGOFAB').AsString,6));
        TextOutLC(Lc_Linha,13,copy(Qr_Itens.FieldByName('ICT_DESCRICAO').AsString,1,77));
        TextOutLC(Lc_Linha,93,Padr(Qr_Itens.FieldByName('ICT_QTDE').AsString,6));
        TextOutLC(Lc_Linha,109,Padr((floattostrf((Qr_Itens.FieldByName('ICT_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
        TextOutLC(Lc_Linha,123,Padr((floattostrf((Qr_Itens.FieldByName('ICT_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
        Qr_Itens.Next;
      end;

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'---------------------------------------------------------------------------------------------------------------------------------------');

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'COND. PAGTO: ' + Copy(Qr_Cotacao.FieldByName('FPT_DESCRICAO').AsString +' / ' + Copy(Qr_Cotacao.FieldByName('CTC_PRAZO').AsString,5,length(Qr_Cotacao.FieldByName('CTC_PRAZO').AsString)-4),1,40));
      TextOutLC(Lc_Linha,108,'VALOR SERVICO :');

      TextOutLC(Lc_Linha,123,Padr(FloatToStrF(Qr_Cotacao.FieldByName('CTC_VL_SERVICO').AsCurrency, ffFixed, 10,2),11));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'GARANTIA   :' );
      TextOutLC(Lc_Linha,108,'VALOR PECAS   :');
      TextOutLC(Lc_Linha,123,Padr(FloatToStrF(Qr_Cotacao.FieldByName('CTC_VL_PRODUTO').AsCurrency, ffFixed, 10,2),11));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,108,'SUBTOTAL      :');
      TextOutLC(Lc_Linha,123,Padr(FloatTostrF(Qr_Cotacao.FieldByName('CTC_VL_SERVICO').AsCurrency + Qr_Cotacao.FieldByName('CTC_VL_PRODUTO').AsCurrency,ffFixed,10,2),11));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'DATA SAIDA :' + Qr_Ordem.FieldByName('EXIT_DATE').AsString  );
      TextOutLC(Lc_Linha,108,'DESCONTOS     :');
      TextOutLC(Lc_Linha,123,Padr(FloatToStrF(Qr_Cotacao.FieldByName('CTC_VL_DESCONTO').AsCurrency, ffFixed, 10,2),11));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'KM/HR SAIDA:' );
      TextOutLC(Lc_Linha,108,'TOTAL GERAL   :');
      TextOutLC(Lc_Linha,123,Padr(FloatToStrF(Qr_Cotacao.FieldByName('CTC_VL_COTACAO').AsCurrency, ffFixed, 10,2),11));

      Lc_Linha := Lc_Linha + 3;
      TextOutLC(Lc_Linha,1,DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString +  '  ____/____/_______       _____________________________________________');
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'                                          NOME E ASSINATURA DO CLIENTE');

    end;
    Lc_Prin.Eject;
  Finally
    Lc_Prin.Finalize;
    FreeAndNil(Lc_Prin);
  End;
End;

function  TimpModImpressao.Fc_VerificaOrdemOrc:boolean;
Var
  OrdemServico : TControllerVehicleOs;
begin
  Result := False;
  with QR_Ordem do
  Begin
    Active:=false;
    SQL.Clear;
    SQL.Add(' select CTC_CODIGO FROM TB_COTACAO '+
            ' WHERE  CTC_CODPED =:CTC_CODPED ');
    ParamByName('CTC_CODPED').AsInteger:=FCodigoPedido;
    Active:=true;
    it_cd_orc:= FIELDBYNAME('CTC_CODIGO').AsInteger;
    //Verifica se tem item de serviço no orçamento
    Active:=false;
    SQL.Clear;
    SQL.Add('select ICT_CODIGO '+
            'FROM TB_ITENS_CTC '+
            'WHERE '+
            '(ICT_CODCTC =:ICT_CODCTC) AND (ICT_TIPO = ''S'')'+
             'ORDER BY ICT_CODIGO ');
    ParamByName('ICT_CODCTC').AsInteger:=it_cd_orc;
    Active:=true;
    FetchAll;

    if RecordCount > 0 then
    Begin
      Result:=true;
      exit;
    End;
    try
      //Verifica se tem dados do veiculo
      OrdemServico := TControllerVehicleOs.Create(self);
      with OrdemServico do
      Begin
        Registro.CodigoEstabelecimento := gb_codmha;
        Registro.CodigoCotacao := it_cd_orc;
        getByCotacao;
        if exist then
        Begin
          Result := true;
          exit;
        End;
      end;
    finally
      OrdemServico.Clear;
      FreeAndNil(OrdemServico);
    end;
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_1;
Var
  Lc_Form : TRL_Orcamento_1;
begin
  try
    Lc_Form := TRL_Orcamento_1.Create(NIL);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_1;
Var
  Lc_Form : TRl_Servico_Orc;
begin
  try
    Lc_Form := TRl_Servico_Orc.Create(nil);
    Lc_Form.It_Cd_Cotacao := it_cd_orc;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;
end;


procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_2;
Var
  Lc_Form : TRL_Orcamento_2;
begin
  try
    Lc_Form := TRL_Orcamento_2.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_2;
begin
  Pc_Imp_Orc_JatoLaser_2;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_3;
Var
  Lc_Form : TRL_Orcamento_3;
begin
  try
    Lc_Form := TRL_Orcamento_3.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_3;
begin
  Pc_Imp_Orc_JatoLaser_3;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_4;
Var
  Lc_Form : TRL_Orcamento_4;
begin
  try
    Lc_Form := TRL_Orcamento_4.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_4;
begin
  Pc_Imp_Orc_JatoLaser_4;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_5;
begin
//ricamo
  ShowMessage('Desativado')
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_5;
begin
  Pc_Imp_Orc_JatoLaser_5;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_6;
Var
  Lc_Form : TRL_Orcamento_6;
begin
  try
    Lc_Form := TRL_Orcamento_6.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_6;
begin
  Pc_Imp_Orc_JatoLaser_6;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_7;
Var
  Lc_Form : TRL_Orcamento_7;
begin
  TRy
    Lc_Form := TRL_Orcamento_7.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_7;
begin
  Pc_Imp_Orc_JatoLaser_7;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_8;
Var
  Lc_Form : TRL_Orcamento_8;
begin
  try
    Lc_Form := TRL_Orcamento_8.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_8;
begin
  Pc_Imp_Orc_JatoLaser_8;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_9;
Var
  Lc_Form : TRL_Orcamento_9;
begin
  try
    Lc_Form := TRL_Orcamento_9.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_9;
begin
  Pc_Imp_Orc_JatoLaser_9;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_10;
Var
  Lc_Form : TRL_ReportBudget_10;
begin
  try
    Lc_Form := TRL_ReportBudget_10.Create(nil);
    Lc_Form.CodigoPedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_10;
begin
  Pc_Imp_Orc_JatoLaser_10;
end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_11;
Var
  Lc_Form : TRL_ReportBudget_11;
begin
  try
    Lc_Form := TRL_ReportBudget_11.Create(nil);
    Lc_Form.CodigoPedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;

end;

procedure TImpModImpressao.Pc_Imp_Orc_JatoLaser_12;
Var
  Lc_Form : TRL_ReportBudget_12;
begin
  try
    Lc_Form := TRL_ReportBudget_12.Create(nil);
    Lc_Form.CodigoPedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;

end;

procedure TImpModImpressao.Pc_Imp_Orc_JatoLaser_13;
Var
  Lc_Form : TRL_Orcamento_13;
begin
  try
    Lc_Form := TRL_Orcamento_13.Create(nil);
    Lc_Form.It_Cd_Pedido := FCodigoPedido;
    Print(Lc_Form.Qrpt);
  finally
     Lc_Form.Close;
     FreeAndNil(Lc_Form);
  end;

end;

procedure  TimpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_11;
begin
  Pc_Imp_Orc_JatoLaser_11;
end;

procedure TImpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_12;
begin
  Pc_Imp_Orc_JatoLaser_12;
end;

procedure TImpModImpressao.Pc_Imp_Orc_JatoLaser_Srv_13;
begin
  Pc_Imp_Orc_JatoLaser_13;
end;

//Modelo Clara Lua
procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_Vda_2;
Var
  F: TextFile;
  Lc_TExto : String;
  Lc_ItensPP : Integer;
  lc_contador : Integer;
  lc_I, Lc_II, lc_J : Integer;
  Lc_Pro_Descricao : String;
  Lc_SqlTxt : String;
  Lc_Prin : TPrin;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := nil;
  Lc_Qry := nil;
  try
    try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    //Monta o pedido
    Pc_AbreDadosPedido;

    Lc_ItensPP := StrToIntDEF(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_ITENS_FOLHA','16'),16);
    lc_contador := Lc_ItensPP + 4;
    Lc_Prin := TPrin.Create(self);
    With Lc_Prin Do
      begin
      Initialize(It_Porta);
      lc_I := 1;
      TextOutLC(lc_I,1,StrZero(Gb_CodMha,3,0) + '|' +'PEDIDO: ');
      textoutLc(lc_I,13,Padr(Qr_Pedido.FieldByname('PED_NUMERO').AsString,8));

      TextOutLC(lc_I,57,'DATA :');
      Lc_TExto := Qr_Pedido.FieldByname('DATA').AsString + ' ' + TimeToStr(Now);
      textoutLc(lc_I,64,Padr(Lc_TExto ,16));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
      Condensa(True);
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'NOME DO CLIENTE: ');
      TextOutLC(lc_I,18,Qr_Pedido.FieldByname('EMP_CODIGO').AsString + ' -  '+ Qr_Pedido.FieldByname('EMP_FANTASIA').AsString + ' - ' + Qr_Pedido.FieldByname('EMP_NOME').AsString);

      IF Qr_Pedido.FieldByname('EMP_PESSOA').AsString = 'F' then
        Begin
        TextOutLC(lc_I,106,'C.P.F: ');
        TextOutLC(lc_I,110,Padr(fc_MascaraCPF(Qr_Pedido.FieldByname('EMP_CNPJ').AsString),18));
        end
      else
        Begin
        TextOutLC(lc_I,106,'C.N.P.J: ');
        TextOutLC(lc_I,110,Padr(fc_MascaraCNPJ(Qr_Pedido.FieldByname('EMP_CNPJ').AsString),18));
        end;
      lc_I := lc_I +1;
      TextOutLC(lc_I,1,'ENDERECO: ' + Qr_Pedido.FieldByname('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByname('END_NUMERO').AsString +'  -  '+
                     ' BAIRRO: ' + Qr_Pedido.FieldByname('END_BAIRRO').AsString +'  -  '+
                     ' CEP: '    + Qr_Pedido.FieldByname('END_CEP').AsString    +'  -  '+
                     'CIDADE: '+Qr_Pedido.FieldByname('CDD_DESCRICAO').AsString +'  -  '+
                     'UF: ' + Qr_Pedido.FieldByname('UFE_SIGLA').AsString);

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'FONE: '+fc_MascaraFone(Qr_Pedido.FieldByname('END_FONE').AsString)+'  -  ');
      TextOutLC(lc_I,22,'CONTATO: '+Qr_Pedido.FieldByname('END_CONTATO').AsString);

      IF Qr_Pedido.FieldByname('EMP_PESSOA').AsString = 'F' then
        Begin
        TextOutLC(lc_I,106,'R.G: ');
        TextOutLC(lc_I,110,Padr(Qr_Pedido.FieldByname('EMP_INSC_EST').AsString,18));
        end
      else
        Begin
        TextOutLC(lc_I,106,'INSC. E: ');
        TextOutLC(lc_I,110,Padr(Qr_Pedido.FieldByname('EMP_INSC_EST').AsString,18));
        end;

      Condensa(FAlse);
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'DESCRICAO DOS PRODUTOS');
      TextOutLC(lc_I,49,'QTDE');
      TextOutLC(lc_I,61,'PRECO');
      TextOutLC(lc_I,70,'SUBTOTAL');
      Qr_Itens.First;
      While not Qr_Itens.EOF do
        BEGIN
        if (lc_contador > 0) then
          Begin
          lc_I := lc_I + 1;
          lc_contador := lc_contador - 1;
          TextOutLC(lc_I,1,Copy(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString + ' - ' + Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,1,43));
          TextOutLC(lc_I,45,Padr( FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value),6));
          TextOutLC(lc_I,59,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
          TextOutLC(lc_I,67,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
          Qr_Itens.Next;
          end
        else
          Begin
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'                                                                    CONTINUA...');
          lc_I := lc_I + 2;
          lc_contador := Lc_ItensPP + 4;
          end;
        END;

      if (lc_contador < 4) then
        Begin
          for lc_J:=0 to lc_contador do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
        TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'                                                                    CONTINUA...');
        lc_I := lc_I + 2;
        end
      else
        Begin
        if (lc_contador >= 6) then
          for Lc_J:=1 to (lc_contador - 4) do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
        end;
      //Imprimi o Rodape
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
      It_Observacao.Lines.Clear;
      It_Observacao.Lines.Add('Observações/Prazo e Forma de Pagamento;');
      //Mostra o Vendedors
      if (Fc_Tb_Geral('L','VDA_G_MOSTRA_VENDEDOR','S') ='S') then
        begin
        It_Observacao.Lines.Add('NOME DO VENDEDOR: ' + Copy(Qr_Pedido.FieldByname('CLB_NOME').AsString,1,24));
        end;
      //Cheque Devolvido
      if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_DEV','') = 'S') then
        Begin
        It_Observacao.Lines.Add(Fc_HistoricoFinanceiro(1,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger));
        end;
      //Cheque Pre-Datado
      if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_PRE','') = 'S') then
        Begin
        It_Observacao.Lines.Add(Fc_HistoricoFinanceiro(2,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger))
        end;
      //Saldo Devedor
      if (Fc_Tb_Geral('L','FIN_G_INF_SALDO_DEV','') = 'S') then
        Begin
        It_Observacao.Lines.Add(Fc_HistoricoFinanceiro(3,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger));
        end;
      //Parcelamento - Vai ser inserido no campo Memo
      Fc_Parcelamento('O');
      IF trim(Qr_Pedido.FieldByname('PED_OBS').AsString) <> '' then
        It_Observacao.Lines.Add(Qr_Pedido.FieldByname('PED_OBS').AsString);
      //Observações pré-Definidas
        Lc_SqlTxt := 'SELECT DISTINCT OBS_CODIGO, OBS_DETALHES '+
                     'FROM TB_OBSERVACAO tb_observacao         '+
                     'WHERE (OBS_GERAL = ''3'')                '+
                     ' AND (OBS_CODMHA =:OBS_CODMHA)           ';
        Lc_Qry.SQL.Add(Lc_SqlTxt);
        Lc_Qry.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;
        Lc_Qry.Active := True;
        Lc_Qry.First;
        while not Lc_Qry.Eof do
        begin
          //Registra a Observação
          It_Observacao.Lines.Add(Lc_Qry.FieldByname('OBS_DETALHES').AsString);
          Lc_Qry.Next;
        end;
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[0],1,47));
      TextOutLC(lc_I,49,'TOTAL DOS PRODUTOS:');
      TextOutLC(lc_I,69, Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),11));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[1],1,47));
      TextOutLC(lc_I,49,'QTD. PRODUTOS:');
      TextOutLC(lc_I,69, Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_QT_PRODUTO').AsFloat,ffFixed,10,2),11));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[2],1,47));
      TextOutLC(lc_I,49,'VALOR DO FRETE    :');
      TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_FRETE').AsCurrency,ffFixed,10,2),11));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[3],1,47));
      TextOutLC(lc_I,49,'DESCONTO          :');
      TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2),11));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[4],1,47));
      TextOutLC(lc_I,49,'TOTAL DO PEDIDO   :');
      TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),11));
      //Verifica se tem mais observação
      for Lc_II := 5 to It_Observacao.Lines.Count -1 do
        Begin
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[Lc_II],1,80));
        end;

      end;
      If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
        begin
        Lc_Prin.Eject;
        end
      else
        begin
        For Lc_II := 1 to (StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),2)+1) do
          Begin
          Inc(Lc_I);
          Lc_Prin.TextOutLC(Lc_I,1,'');
          end;
        end;
      Lc_Prin.Finalize;
      FreeAndNil(Lc_Prin);
  except
      If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
        Lc_Prin.Eject;
      Lc_Prin.Finalize;
      FreeAndNil(Lc_Prin);
      Exit;
    end;
  finally
    if LcBase <> nil then
    begin
      LcBase.FinalizaQuery(Lc_Qry);
      FreeAndNil(LcBase);
    end;
  end;
end;


procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_Srv_2;
Begin
  Pc_Imp_Vda_Matricial_Srv_1;
end;

procedure  TimpModImpressao.Pc_Coluna(Pc_Registro: Integer);
begin
  Case Pc_Registro of
    1:
      begin
      It_LcLinha := 5;  It_LcColuna := 17; It_LcParcela := '01) ';
      end;
    2:
      begin
      It_LcLinha := 5;  It_LcColuna := 45; It_LcParcela := '02) ';
      end;
    3:
      begin
      It_LcLinha := 5;  It_LcColuna := 73; It_LcParcela := '03) ';
      end;
    4:
      begin
      It_LcLinha := 5;  It_LcColuna := 101; It_LcParcela := '04) ';
      end;
    5:
      begin
      It_LcLinha := 6;  It_LcColuna := 17; It_LcParcela := '05) ';
      end;
    6:
      begin
      It_LcLinha := 6;  It_LcColuna := 45; It_LcParcela := '06) ';
      end;
    7:
      begin
      It_LcLinha := 6;  It_LcColuna := 73; It_LcParcela := '07) ';
      end;
    8:
      begin
      It_LcLinha := 6;  It_LcColuna := 101; It_LcParcela := '08) ';
      end;
    9:
      begin
      It_LcLinha := 7;  It_LcColuna := 17; It_LcParcela := '09) ';
      end;
    10:
      begin
      It_LcLinha := 7;  It_LcColuna := 45; It_LcParcela := '10) ';
      end;
    11:
      begin
      It_LcLinha := 7;  It_LcColuna := 73; It_LcParcela := '11) ';
      end;
    12:
      begin
      It_LcLinha := 5;  It_LcColuna := 101; It_LcParcela := '12) ';
      end;
  end;
end;


procedure  TimpModImpressao.Pc_Historico;
var
   Lc_TExto: string;
   Lc_codigo: Integer;
begin
  Lc_codigo := StrToIntdef(Qr_Pedido.FieldByname('PED_CODEMP').AsString, 0);
  //Cheque Devedor
  It_Vl_Chq_DEv := Fc_SaldoChequeDevolvido(Lc_codigo);
  if It_Vl_Chq_DEv > 0 then
    Lc_TExto := ' Cheque(s) Devolvido(s) : ' + FloatToStrF(It_Vl_Chq_DEv, ffFixed, 10, 2);

  //Cheque Pre-Datado
  It_Vl_Chq_Pre := Fc_SaldoChequePreDatado(Lc_codigo);
  if It_Vl_Chq_Pre > 0 then
    Lc_TExto := Lc_TExto + ' Cheque(s) PreDatado(s) : ' + FloatToStrF(It_Vl_Chq_Pre, ffFixed, 10, 2);

  //Saldo Devedor
  It_Vl_Devedor := Fc_SaldoDevedorCliente(Lc_codigo);
  if It_Vl_Devedor > 0 then
    Lc_TExto := Lc_TExto + ' Saldo Devedor : ' + FloatToStrF(It_Vl_Devedor, ffFixed, 10, 2);
end;

procedure TImpModImpressao.pc_ImprimeCupomNotaPromissoria;
var
  traco: string;
  Lc_I,Lc_Salto : Integer;
  Lc_Linha : Integer;
  Lc_Nr_Colunas : Integer;
  Lc_Finaliza: TextFile;
begin
  //Cria a Consulta
  Pc_AbreDadosPedido;
  Pc_AtivaEstabelecimento;
  DM.Qr_Estabelecimento.First;

  It_Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', '');
  if Trim(It_Porta) = '' then It_Porta := 'LPT1';
  It_FRow:=1;
  It_FCol:=1;
  AssignFile(It_Arquivo,It_Porta);
  Rewrite(It_Arquivo);
  Lc_Linha := 1;
  Lc_Nr_Colunas := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_NR_COLUNAS', '55'),55); // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)

  //Define o tamanhho do Traço
  Traco := '';
  For Lc_I:= 1 to Lc_Nr_Colunas do
    Traco := Traco + '-';

  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaC('Nota Promissoria',Lc_Nr_Colunas));
  Inc(Lc_linha);

  Pc_TextOutLC(Lc_Linha,1,Traco);
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Concat('Emissao: ',Qr_Pedido.FieldByname('DATA').asString));
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,'Quant Parcelas: 1 X ');
  Pc_TextOutLC(Lc_Linha,22,'Valor Total: ');
  Pc_TextOutLC(Lc_Linha,36,Pc_AlinhaD(FormatFloat('###,###,##0.00', StrToFloatDef(Qr_Pedido.FieldByname('PED_VL_PEDIDO').Text, 0)),17));
  Inc(Lc_linha);
  Inc(Lc_linha);

  Pc_TextOutLC(Lc_Linha,1,'Pagar(ei)(emos) por esta únicoa via de ');
  Inc(Lc_linha);

  Pc_TextOutLC(Lc_Linha,1,'NOTA PROMISSORIA');
  Inc(Lc_linha);
  Inc(Lc_linha);

  Pc_TextOutLC(Lc_Linha,1,Concat('Empresa: ',DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString));
  Inc(Lc_linha);

  Pc_TextOutLC(Lc_Linha,1,Concat('CNPJ:  : ',fc_MascaraCNPJ(DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsString)));
  Inc(Lc_linha);

  Pc_TextOutLC(Lc_Linha,1,Concat('( ',Fc_Extenso(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency),' )'));
  Inc(Lc_linha);
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Concat('Local pagamento: ',
                                 DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString,', ',
                                 DM.Qr_Estabelecimento.FieldByname('END_Numero').AsString
                                 ));
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Concat('Cidade: ',
                                 DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString,' - ',
                                 DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString
                                 ));
  Inc(Lc_linha);
  Inc(Lc_linha);

  Pc_TextOutLC(Lc_Linha,1,Concat('Emitente: ',
                                 Qr_Pedido.FieldByname('EMP_FANTASIA').AsString
                                 ));
  Inc(Lc_linha);
  if Length(Qr_Pedido.FieldByname('EMP_CNPJ').AsString)=11 then
  Begin
    Pc_TextOutLC(Lc_Linha,1,Concat('CPF/CNPJ: ',
                                   fc_MascaraCPF(Qr_Pedido.FieldByname('EMP_CNPJ').AsString)
                                   ));
  end
  else
  Begin
    Pc_TextOutLC(Lc_Linha,1,Concat('CNPJ: ',
                                   fc_MascaraCNPJ(Qr_Pedido.FieldByname('EMP_CNPJ').AsString)
                                   ));
  End;
  Inc(Lc_linha);
  Inc(Lc_linha);
  Inc(Lc_linha);
  Inc(Lc_linha);

  Traco := '';
  For Lc_I:= 1 to Lc_Nr_Colunas - 10 do
    Traco := Traco + '_';
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaC(Traco,Lc_Nr_Colunas));
  Inc(Lc_linha);
  Pc_TextOutLC(Lc_Linha,1,Pc_AlinhaC(Qr_Pedido.FieldByname('EMP_FANTASIA').AsString,Lc_Nr_Colunas));

  Writeln(It_Arquivo);
  CloseFile(It_Arquivo);

  //Finaliza o Cupom
  AssignFile(Lc_Finaliza,It_Porta);
  Rewrite(Lc_Finaliza);
  Lc_Salto := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRETE','FRT_P_SALTO','0'), 0);
  For Lc_I := 1 to Lc_Salto do
    Writeln(Lc_Finaliza);
  CloseFile(Lc_Finaliza);

  //Aciona Guilhotina
  Pc_AcionaGuilhotina(It_Porta);


end;

procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_Vda_3;
begin
  it_Traco130 := '----------------------------------------------------------------------------------------------------------------------------------';
  if not Assigned(Fr_Principal) then 
	Application.CreateForm(TFr_Principal,Fr_Principal);
	
  {Fr_Principal.RdPrint_DP.Abrir;
  if Fr_Principal.RdPrint_DP.Setup = false then
  begin
    showmessage('Cancelado pelo usuário...');
    exit;
  end;
  Fr_Principal.RdPrint_DP.OpcoesPreview.Preview := True;
  Fr_Principal.RdPrint_DP.FonteTamanhoPadrao    := S17cpp;

  //Monta o pedido
  Pc_AbreDadosPedido;

  it_Traco115 := '------------------------------------------------------------------------------------------------------------------';
  Pc_AtivaEstabelecimento;

  Pc_Cabecalho_RdPrint;
  // Imprime itens do pedido...
  It_Linha := 9;
  while not Qr_Itens.Eof do
    begin
    with Fr_Principal.RdPrint_DP do
      begin
      if It_Linha > 24 then
         BEGIN
         Pc_Cabecalho_RdPrint;
         It_Linha:=9;
         END;
      Inc(Lc_Item);
      ImpF  (It_Linha,01, '| '+StrZero(Lc_Item,3,0),[Lc_Fonte]);
      ImpF  (It_Linha,08, '| '+StrZero(Qr_Itens.FieldByName('ITF_CODPRO').Value,5,0) + ' |',[Lc_Fonte]);
      ImpVal(It_Linha,17, '#,##0.00', Qr_Itens.FieldByName('ITF_QTDE').Value,[Lc_Fonte]);
      ImpF  (It_Linha,25, '| '+Qr_Itens.FieldByName('MED_ABREVIATURA').Value,[Lc_Fonte]);
      ImpF  (It_Linha,31, '| '+Copy(Qr_Itens.FieldByName('PRO_DESCRICAO').Value,1,41),[Lc_Fonte]);
      ImpF  (It_Linha,75, '|',[Lc_Fonte]);
      ImpVal(It_Linha,77, '#,##0.00', Qr_Itens.FieldByName('ITF_VL_UNIT').Value,[Lc_Fonte]);
      ImpF  (It_Linha,89, '|',[Lc_Fonte]);
      ImpVal(It_Linha,91, '#,##0.00', Qr_Itens.FieldByName('ITF_VL_DESC').Value,[Lc_Fonte]);
      ImpF  (It_Linha,102, '|',[Lc_Fonte]);
      ImpVal(It_Linha,104, '#,##0.00', Qr_Itens.FieldByName('ITF_VL_SUBTOTAL').Value,[Lc_Fonte]);
      ImpF  (It_Linha,116, '|',[Lc_Fonte]);
      ImpVal(It_Linha,121, '#,##0.00', Qr_Itens.FieldByName('ITF_VL_SUBTOTAL').Value - Qr_Itens.FieldByName('ITF_VL_DESC').Value,[Lc_Fonte]);
      ImpF  (It_Linha,130, '|',[Lc_Fonte]);
      Inc(It_Linha);
      end;
  Qr_Itens.Next;
  end;

  Pc_Rodape_RdPrint;
  Fr_Principal.RdPrint_DP.OpcoesPreview.Preview := true;
  Fr_Principal.RdPrint_DP.Fechar;}
END;


procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_sRV_3;
BEGIN
  Pc_Imp_Vda_Matricial_Srv_1;
END;

procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_Vda_4;
Var
  F: TextFile;
  Lc_TExto : String;
  Lc_ItensPP : Integer;
  lc_contador : Integer;
  lc_I, Lc_II, lc_J : Integer;
  Lc_Traco: String;
  Lc_Prin : TPrin;
Begin
  try
  //Monta o pedido
  Pc_AbreDadosPedido;

  Lc_Traco := '---------------------------------------------------------------------------------------------------------------------------------';

  Lc_ItensPP := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_ITENS_FOLHA',''),16);
  lc_contador := Lc_ItensPP + 4;
  Lc_Prin:=TPrin.Create(self);
  With Lc_Prin Do
    begin
    Initialize(It_Porta);
    lc_I := 1;
    AcionaModoDraft;
    Condensa(True);
    TextOutLC(lc_I,1,StrZero(Gb_CodMha,3,0) + '|' +'PEDIDO: ');
    textoutLc(lc_I,13,Padr(Qr_Pedido.FieldByname('PED_NUMERO').AsString,8));

    TextOutLC(lc_I,57,'DATA :');
    Lc_TExto := Qr_Pedido.FieldByname('DATA').AsString + ' ' + TimeToStr(Now);
    textoutLc(lc_I,64,Padr(Lc_TExto ,16));

    lc_I := lc_I + 1;
    TextOutLC(lc_I,1,Lc_Traco);
    lc_I := lc_I + 1;
    TextOutLC(lc_I,1,'NOME DO CLIENTE: ');
    TextOutLC(lc_I,18,Qr_Pedido.FieldByname('EMP_FANTASIA').AsString + ' - ' + Qr_Pedido.FieldByname('EMP_NOME').AsString);

    IF Qr_Pedido.FieldByname('EMP_PESSOA').AsString = 'F' then
      Begin
      TextOutLC(lc_I,106,'C.P.F: ');
      TextOutLC(lc_I,110,Padr(fc_MascaraCPF(Qr_Pedido.FieldByname('EMP_CNPJ').AsString),18));
      end
    else
      Begin
      TextOutLC(lc_I,106,'C.N.P.J: ');
      TextOutLC(lc_I,110,Padr(fc_MascaraCNPJ(Qr_Pedido.FieldByname('EMP_CNPJ').AsString),18));
      end;
    lc_I := lc_I +1;
    TextOutLC(lc_I,1,'ENDERECO: ' + Qr_Pedido.FieldByname('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByname('END_NUMERO').AsString +'  -  '+
                     ' BAIRRO: ' + Qr_Pedido.FieldByname('END_BAIRRO').AsString +'  -  '+
                     ' CEP: '    + Qr_Pedido.FieldByname('END_CEP').AsString    +'  -  '+
                     'CIDADE: '+Qr_Pedido.FieldByname('CDD_DESCRICAO').AsString +'  -  '+
                     'UF: ' + Qr_Pedido.FieldByname('UFE_SIGLA').AsString);

    lc_I := lc_I + 1;
    TextOutLC(lc_I,1,'FONE: '+fc_MascaraFone(Qr_Pedido.FieldByname('END_FONE').AsString)+'  -  ');
    TextOutLC(lc_I,22,'CONTATO: '+Qr_Pedido.FieldByname('END_CONTATO').AsString);

    IF Qr_Pedido.FieldByname('EMP_PESSOA').AsString = 'F' then
      Begin
      TextOutLC(lc_I,106,'R.G: ');
      TextOutLC(lc_I,110,Padr(Qr_Pedido.FieldByname('EMP_INSC_EST').AsString,18));
      end
    else
      Begin
      TextOutLC(lc_I,106,'INSC. E: ');
      TextOutLC(lc_I,110,Padr(Qr_Pedido.FieldByname('EMP_INSC_EST').AsString,18));
      end;

    lc_I := lc_I + 1;
    TextOutLC(lc_I,1,Lc_Traco);

    lc_I := lc_I + 1;
    TextOutLC(lc_I,1,'DESCRICAO DOS PRODUTOS');
    TextOutLC(lc_I,80,'QTDE');
    TextOutLC(lc_I,90,'CF');
    TextOutLC(lc_I,98,'PRECO');
    TextOutLC(lc_I,110,'SUBTOTAL');
    lc_I := lc_I + 1;
    TextOutLC(lc_I,1,Lc_Traco);
    Qr_Itens.First;
    While not Qr_Itens.EOF do
      BEGIN
      if (lc_contador > 0) then
        Begin
        lc_I := lc_I + 1;
        lc_contador := lc_contador - 1;
        TextOutLC(lc_I,1,Copy(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString + ' - ' + Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,1,70));
        TextOutLC(lc_I,78,Padr( FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value),6));
        TextOutLC(lc_I,91,Padr(Qr_Itens.FieldByname('PRO_SUB_TRIB').AsString,1));
        TextOutLC(lc_I,98,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
        TextOutLC(lc_I,110,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
        Qr_Itens.Next;
        end
      else
        Begin
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,Lc_Traco);
        lc_I := lc_I + 1;
        TextOutLC(lc_I,110,'CONTINUA...');
        lc_I := lc_I + 2;
        lc_contador := Lc_ItensPP + 4;
        end;
      END;

    if (lc_contador < 4) then
      Begin
        for lc_J:=0 to lc_contador do
          Begin
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'');
          end;
      TextOutLC(lc_I,1,Lc_Traco);
      lc_I := lc_I + 1;
      TextOutLC(lc_I,110,'CONTINUA...');
      lc_I := lc_I + 2;
      end
    else
      Begin
      if (lc_contador >= 6) then
        for Lc_J:=1 to (lc_contador - 4) do
          Begin
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'');
          end;
      end;
    //Imprimi o Rodape
    lc_I := lc_I + 1 ;
    TextOutLC(lc_I,1,Lc_Traco);

    lc_I := lc_I + 1;
    TextOutLC(lc_I,1,'COND. PAGTO: ');
    TextOutLC(lc_I,14,Qr_Pedido.FieldByname('FPT_DESCRICAO').AsString  + ' | ' + Fc_Parcelamento('I'));


      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'NOME DO VENDEDOR:');
      TextOutLC(lc_I,18,Copy(Qr_Pedido.FieldByname('CLB_NOME').AsString,1,24));

    TextOutLC(lc_I,90,'TOTAL DOS PRODUTOS:');
    TextOutLC(lc_I,110,Padr(FloatToStrF((Qr_Pedido.FieldByname('PED_VL_PRODUTO').AsCurrency),ffFixed,10,2),11));

    //Cheque Devolvido
    lc_I := lc_I + 1;
    if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_DEV','') = 'S') then
      Begin
      Lc_TExto := Fc_HistoricoFinanceiro(1,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger);
      TextOutLC(lc_I,1,lc_texto);
      end;

    TextOutLC(lc_I,90,'VALOR DO FRETE    :');
    TextOutLC(lc_I,110,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_FRETE').AsCurrency,ffFixed,10,2),11));

    //Cheque Pre-Datado
    lc_I := lc_I + 1;
    if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_PRE','') = 'S') then
      Begin
      Lc_TExto := Fc_HistoricoFinanceiro(2,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger);
      TextOutLC(lc_I,1,lc_texto);
      end;

    TextOutLC(lc_I,90,'DESCONTO          :');
    TextOutLC(lc_I,110,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2),11));

    //Saldo Devedor
    lc_I := lc_I + 1;
    if (Fc_Tb_Geral('L','FIN_G_INF_SALDO_DEV','') = 'S') then
      Begin
      Lc_TExto := Fc_HistoricoFinanceiro(3,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger);
      TextOutLC(lc_I,1,lc_texto);
      end;

    TextOutLC(lc_I,90,'TOTAL DO PEDIDO   :');
    TextOutLC(lc_I,110,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),11));
    end;
    If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
      begin
      Lc_Prin.Eject;
      end
    else
      begin
      For Lc_II := 1 to (StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),1)+1) do
        Begin
        Inc(Lc_I);
        Lc_Prin.TextOutLC(Lc_I,1,'');
        end;
      end;
    Lc_Prin.Finalize;
    FreeAndNil(Lc_Prin);
  except
    If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
      Lc_Prin.Eject;
    Lc_Prin.Finalize;
    FreeAndnil(Lc_Prin);
    Exit;
  end;
END;


procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_sRV_4;
BEGIN
  Pc_Imp_Vda_Matricial_Srv_1;
END;

procedure  TimpModImpressao.Pc_Cabecalho_RdPrint;
begin
  {with Fr_Principal.RdPrint_DP do
    begin
    ImpF(01,02, DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString,[expandido]);
    ImpF(01,69,'Data Emissão: '+ Qr_Pedido.FieldByName('DATA').AsString,[]);
    ImpF(01,115,'Hora: '+ TimeToStr(now),[]);
    ImpF(02,02, 'Cliente..: '+ StrZero(Qr_Pedido.FieldByName('PED_CODEMP').AsInteger,6,0)+' - '+ Qr_Pedido.FieldByName('EMP_NOME').AsString,[]);
    ImpF(02,69, 'Fone.: '+ fc_MascaraFone(Qr_Pedido.FieldByName('END_FONE').AsString),[]);
    ImpF(02,100,'CNPJ/CPF.: '+ Qr_Pedido.FieldByName('EMP_CNPJ').AsString,[]);
    ImpF(03,02, 'Endereco.: '+ Qr_Pedido.FieldByName('END_ENDER').AsString+', '+Qr_Pedido.FieldByName('END_NUMERO').AsString,[]);
    ImpF(03,52, 'Bairro.: '+ Qr_Pedido.FieldByName('END_BAIRRO').AsString,[]);
    ImpF(03,81, 'Cidade.: '+ Qr_Pedido.FieldByName('CDD_DESCRICAO').AsString +'/'+ Qr_Pedido.FieldByName('UFE_SIGLA').AsString,[]);
    ImpF(03,115,'CEP.: '+ Qr_Pedido.FieldByName('END_CEP').AsString,[]);
    Imp (04,02, 'Datas de Pagto ' + it_Traco115);
    It_Linha :=5;
    Qr_Parcelamento.active := True;
    Qr_Parcelamento.First;
    while not Qr_Parcelamento.Eof do
      begin
        case It_Linha of
          5: Pc_Coluna(Qr_Parcelamento.FieldByName('PAR_PARCELA').AsInteger);
          6: Pc_Coluna(Qr_Parcelamento.FieldByName('PAR_PARCELA').AsInteger);
          7: Pc_Coluna(Qr_Parcelamento.FieldByName('PAR_PARCELA').AsInteger);
        end;
      It_Linha := It_LcLinha;

      ImpF(It_LcLinha, It_LcColuna, It_LcParcela+ Qr_Parcelamento.FieldByName('PAR_DATA').AsString +'   '+StrZero(Qr_Parcelamento.FieldByName('PAR_VALOR').Value,1,2),[]);
      Qr_Parcelamento.Next;
      end;
    if (Qr_Parcelamento.RecordCount = 0) then
      begin
        case It_Linha of
          5: Pc_Coluna(Qr_Parcelamento.FieldByName('PAR_PARCELA').AsInteger);
          6: Pc_Coluna(Qr_Parcelamento.FieldByName('PAR_PARCELA').AsInteger);
          7: Pc_Coluna(Qr_Parcelamento.FieldByName('PAR_PARCELA').AsInteger);
        end;
      It_Linha := It_LcLinha;

      ImpF(It_LcLinha, It_LcColuna, It_LcParcela + '00/00/0000'+'   '+StrZero(0,1,2),[]);
      end;
    Inc(It_Linha);
    Imp(It_Linha,01, Fc_CentralizaTexto('PEDIDO' + ' Nº.: '+ Qr_Pedido.FieldByName('PED_NUMERO').AsString,130, '-'));
    Inc(It_Linha);
    Imp(It_Linha,01, '|');
    Imp(It_Linha,03, 'ITEM');
    Imp(It_Linha,08, '|');
    Imp(It_Linha,10, 'CODIGO');
    Imp(It_Linha,17, '|');
    Imp(It_Linha,20, 'QTD');
    Imp(It_Linha,25, '|');
    Imp(It_Linha,27, 'UND');
    Imp(It_Linha,31, '|');
    Imp(It_Linha,33, 'DESCRICAO DO ITEM');
    Imp(It_Linha,75, '|');
    Imp(It_Linha,77, 'VLR.PRODUTO');
    Imp(It_Linha,89, '|');
    Imp(It_Linha,92, 'DESCONTO');
    Imp(It_Linha,102, '|');
    Imp(It_Linha,104, 'VLR.LIQUIDO');
    Imp(It_Linha,116, '|');
    Imp(It_Linha,119, 'VLR.TOTAL');
    Imp(It_Linha,130, '|');
    Inc(It_Linha);
    Imp(It_Linha,01, Fc_CentralizaTexto('-',130, '-'));
    Inc(It_Linha);
    end;}
end;

procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_Vda_5;
Var
  F: TextFile;
  Lc_TExto : String;
  Lc_ItensPP : Integer;
  lc_contador : Integer;
  lc_I, Lc_II, lc_J : Integer;
  Lc_Pro_Descricao : String;
  Lc_Observacao : Tmemo;
  Lc_Prin : TPrin;
Begin
  Try
    try
      //Campo Observação
      Lc_Observacao:= TMemo.Create(self);
      Lc_Observacao.Parent:= Fr_principal;
      Lc_Observacao.Visible:=FALSE;
      Lc_Observacao.WordWrap := True;
      Lc_Observacao.Width := 640;
      Lc_Observacao.Height := 90;
      Lc_Observacao.Top := 0;
      Lc_Observacao.Left := 0;
      Lc_Observacao.Font.Name := 'Courier';
      Lc_Observacao.Lines.Clear;
      //Monta o pedido
      Pc_AbreDadosPedido;

      Lc_ItensPP := StrToIntDEF(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_ITENS_FOLHA','16'),16);
      lc_contador := Lc_ItensPP + 4;
      Lc_Prin:=TPrin.Create(self);
      With Lc_Prin Do
        begin
        Initialize(It_Porta);
        lc_I := 1;
        TextOutLC(lc_I,1,StrZero(Gb_CodMha,3,0) + '|' +'PEDIDO: ');
        textoutLc(lc_I,9,Padr(Qr_Pedido.FieldByname('PED_NUMERO').AsString,8));

        TextOutLC(lc_I,57,'DATA :');
        Lc_TExto := Qr_Pedido.FieldByname('DATA').AsString + ' ' + TimeToStr(Now);
        textoutLc(lc_I,64,Padr(Lc_TExto ,16));

        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
        Condensa(True);
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'NOME DO CLIENTE: ');
        TextOutLC(lc_I,18,Qr_Pedido.FieldByname('EMP_CODIGO').AsString + ' -  '+ Qr_Pedido.FieldByname('EMP_FANTASIA').AsString + ' - ' + Qr_Pedido.FieldByname('EMP_NOME').AsString);

        IF Qr_Pedido.FieldByname('EMP_PESSOA').AsString = 'F' then
          Begin
          TextOutLC(lc_I,106,'C.P.F: ');
          TextOutLC(lc_I,110,Padr(fc_MascaraCPF(Qr_Pedido.FieldByname('EMP_CNPJ').AsString),18));
          end
        else
          Begin
          TextOutLC(lc_I,106,'C.N.P.J: ');
          TextOutLC(lc_I,110,Padr(fc_MascaraCNPJ(Qr_Pedido.FieldByname('EMP_CNPJ').AsString),18));
          end;
        lc_I := lc_I +1;
        TextOutLC(lc_I,1,'ENDERECO: ' + Qr_Pedido.FieldByname('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByname('END_NUMERO').AsString +'  -  '+
                       ' BAIRRO: ' + Qr_Pedido.FieldByname('END_BAIRRO').AsString +'  -  '+
                       ' CEP: '    + Qr_Pedido.FieldByname('END_CEP').AsString    +'  -  '+
                       'CIDADE: '+Qr_Pedido.FieldByname('CDD_DESCRICAO').AsString +'  -  '+
                       'UF: ' + Qr_Pedido.FieldByname('UFE_SIGLA').AsString);
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'FONE: '+fc_MascaraFone(Qr_Pedido.FieldByname('END_FONE').AsString)+'  -  ');
        TextOutLC(lc_I,22,'CONTATO: '+Qr_Pedido.FieldByname('END_CONTATO').AsString);

        IF Qr_Pedido.FieldByname('EMP_PESSOA').AsString = 'F' then
          Begin
          TextOutLC(lc_I,106,'R.G: ');
          TextOutLC(lc_I,110,Padr(Qr_Pedido.FieldByname('EMP_INSC_EST').AsString,18));
          end
        else
          Begin
          TextOutLC(lc_I,106,'INSC. E: ');
          TextOutLC(lc_I,110,Padr(Qr_Pedido.FieldByname('EMP_INSC_EST').AsString,18));
          end;

        Condensa(FAlse);
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');

        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'DESCRICAO DOS PRODUTOS');
        TextOutLC(lc_I,49,'QTDE');
        TextOutLC(lc_I,61,'PRECO');
        TextOutLC(lc_I,70,'SUBTOTAL');
        Qr_Itens.First;
        While not Qr_Itens.EOF do
          BEGIN
          if (lc_contador > 0) then
            Begin
            lc_I := lc_I + 1;
            lc_contador := lc_contador - 1;
            TextOutLC(lc_I,1,Copy(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString + ' - ' + Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,1,43));
            TextOutLC(lc_I,45,Padr( FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value),6));
            TextOutLC(lc_I,59,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),10));
            TextOutLC(lc_I,67,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
            Qr_Itens.Next;
            end
          else
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'                                                                    CONTINUA...');
            lc_I := lc_I + 2;
            lc_contador := Lc_ItensPP + 4;
            end;
          END;

        if (lc_contador < 4) then
          Begin
            for lc_J:=0 to lc_contador do
              Begin
              lc_I := lc_I + 1;
              TextOutLC(lc_I,1,'');
              end;
          TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'                                                                    CONTINUA...');
          lc_I := lc_I + 2;
          end
        else
          Begin
          if (lc_contador >= 6) then
            for Lc_J:=1 to (lc_contador - 4) do
              Begin
              lc_I := lc_I + 1;
              TextOutLC(lc_I,1,'');
              end;
          end;
        //Imprimi o Rodape
        lc_I := lc_I + 1 ;
        TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
        It_Observacao.Lines.Clear;
        //Mostra o Vendedors
        if (Fc_Tb_Geral('L','VDA_G_MOSTRA_VENDEDOR','S') ='S') then
          begin
          It_Observacao.Lines.Add('NOME DO VENDEDOR: ' + Copy(Qr_Pedido.FieldByname('CLB_NOME').AsString,1,24));
          end;

        It_Observacao.Lines.Add('Observações/Prazo e Forma de Pagamento;');
        //Cheque Devolvido
        if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_DEV','') = 'S') then
          Begin
          It_Observacao.Lines.Add(Fc_HistoricoFinanceiro(1,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger));
          end;
        //Cheque Pre-Datado
        if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_PRE','') = 'S') then
          Begin
          It_Observacao.Lines.Add(Fc_HistoricoFinanceiro(2,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger))
          end;
        //Saldo Devedor
        if (Fc_Tb_Geral('L','FIN_G_INF_SALDO_DEV','') = 'S') then
          Begin
          It_Observacao.Lines.Add(Fc_HistoricoFinanceiro(3,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger));
          end;
        //Parcelamento - Vai ser inserido no campo Memo
        Fc_Parcelamento('O');
        if (It_Observacao.Lines.Count >=5) then
          Begin
          IF trim(Qr_Pedido.FieldByname('PED_OBS').AsString) <> '' then
            Begin
            Lc_Observacao.Text := Qr_Pedido.FieldByname('PED_OBS').AsString;
            For lc_II := 0 to Lc_Observacao.Lines.Count - 1 do
              It_Observacao.Lines.Add(Lc_Observacao.Lines.Strings[lc_II]);
            end;
          end
        else
          Begin
          For lc_II:= It_Observacao.Lines.Count to 5 do
            It_Observacao.Lines.Add('');
          IF trim(Qr_Pedido.FieldByname('PED_OBS').AsString) <> '' then
            Begin
            Lc_Observacao.Text := Qr_Pedido.FieldByname('PED_OBS').AsString;
            For lc_II := 0 to Lc_Observacao.Lines.Count - 1 do
              It_Observacao.Lines.Add(Lc_Observacao.Lines.Strings[lc_II]);
            end;
          end;

        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[0],1,47));
        TextOutLC(lc_I,49,'TOTAL DOS PRODUTOS:');
        TextOutLC(lc_I,69, Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),11));

        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[1],1,47));
        TextOutLC(lc_I,49,'QTD. PRODUTOS:');
        TextOutLC(lc_I,69, Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_QT_PRODUTO').AsFloat,ffFixed,10,2),11));

        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[2],1,47));
        TextOutLC(lc_I,49,'VALOR DO FRETE    :');
        TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_FRETE').AsCurrency,ffFixed,10,2),11));

        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[3],1,47));
        TextOutLC(lc_I,49,'DESCONTO          :');
        TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2),11));

        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[4],1,47));
        TextOutLC(lc_I,49,'TOTAL DO PEDIDO   :');
        TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),11));
        //Verifica se tem mais observação
        for Lc_II := 5 to It_Observacao.Lines.Count do
          Begin
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,It_Observacao.Lines.Strings[Lc_II]);

          end;

        end;
        If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
          begin
          Lc_Prin.Eject;
          end
        else
          begin
          For Lc_II := 1 to (StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),2)+1) do
            Begin
            Inc(Lc_I);
            Lc_Prin.TextOutLC(Lc_I,1,'');
            end;
          end;
        Lc_Prin.Finalize;
    except
        If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
          Lc_Prin.Eject;
    end;
  Finally
    FreeAndNil(Lc_Prin);
    FreeAndNil(Lc_Observacao);
  End;
END;

procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_Vda_6;
Var
  F: TextFile;
  Lc_ItensPP : Integer;
  lc_contador : Integer;
  lc_I, Lc_II, lc_J : Integer;
  Lc_Pro_Descricao : String;
  Lc_Observacao : Tmemo;
  Lc_Prin : TPrin;
  //Novo controle
  Lc_Vl_SbuTotal : Real;
  Lc_Vl_SbuTotal_CD : Real;
  Lc_Nr_Parcelamento : Integer;
  Lc_Texto: TMemoryStream;
  Lc_Aux_Cod : String;
  Lc_Aux_Des : String;
  Lc_Aux_Float : Real;
Begin
  try
    //Campo Observação
    Lc_Observacao:= TMemo.Create(self);
    Lc_Observacao.Parent:= Fr_principal;
    Lc_Observacao.Visible:=FALSE;
    Lc_Observacao.WordWrap := True;
    Lc_Observacao.Width := 640;
    Lc_Observacao.Height := 90;
    Lc_Observacao.Top := 0;
    Lc_Observacao.Left := 0;
    Lc_Observacao.Font.Name := 'Courier';
    Lc_Observacao.Lines.Clear;
    //Zera as Variaveis
    Lc_Vl_SbuTotal := 0;
    Lc_Vl_SbuTotal_CD := 0;
    //Monta o pedido
    Pc_AbreDadosPedido;

    Lc_ItensPP := StrToIntDEF(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_ITENS_FOLHA','16'),16);
    lc_contador := Lc_ItensPP + 4;
    Lc_Prin:=TPrin.Create(self);
    With Lc_Prin Do
    begin
      Initialize(It_Porta);
      Condensa(False);
      lc_I := 1;
      TextOutLC(lc_I,1,'PEDIDO: ');
      textoutLc(lc_I,9,Padr(Qr_Pedido.FieldByname('PED_NUMERO').AsString,8));

      TextOutLC(lc_I,57,'DATA :');
      textoutLc(lc_I,64,Padr(Qr_Pedido.FieldByname('DATA').AsString + ' ' + TimeToStr(Now) ,16));
      Condensa(True);
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-----------------------------------------------------------------------------------------------------------------------------------');

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,Copy('CLIENTE  : ' + Qr_Pedido.FieldByname('EMP_CODIGO').AsString + ' -  '+ Qr_Pedido.FieldByname('EMP_NOME').AsString,1,64));
      TextOutLC(lc_I,56,Copy('- FANTASIA : ' + Qr_Pedido.FieldByname('EMP_NOME').AsString,1,66));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,Copy('ENDERECO : ' + Qr_Pedido.FieldByname('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByname('END_NUMERO').AsString,1,86));
      TextOutLC(lc_I,89,'- CEP: ' + Fc_MascaraCep(Qr_Pedido.FieldByname('END_CEP').AsString));
      TextOutLC(lc_I,106,'- FONE    : ' + fc_MascaraFone(Qr_Pedido.FieldByname('END_FONE').AsString));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,Copy('BAIRRO	 : ' + Qr_Pedido.FieldByname('END_BAIRRO').AsString,1,54));
      TextOutLC(lc_I,55,Copy('- CIDADE   : ' + Qr_Pedido.FieldByname('CDD_DESCRICAO').AsString,1,40));
      TextOutLC(lc_I,96,'- UF: ' + Qr_Pedido.FieldByname('UFE_SIGLA').AsString);
      TextOutLC(lc_I,105,'- FAX     : ' + fc_MascaraFone(Qr_Pedido.FieldByname('END_FAX').AsString));

      lc_I := lc_I + 1;
      IF Qr_Pedido.FieldByname('EMP_PESSOA').AsString = 'F' then
        Begin
        TextOutLC(lc_I,1,'C.P.F    : ' + fc_MascaraCPF(Qr_Pedido.FieldByname('EMP_CNPJ').AsString));
        TextOutLC(lc_I,56,'- RG/IDENT : ' + Qr_Pedido.FieldByname('EMP_INSC_EST').AsString);
        end
      else
        Begin
        TextOutLC(lc_I,1,Copy('C.N.P.J  : ' + fc_MascaraCNPJ(Qr_Pedido.FieldByname('EMP_CNPJ').AsString),1,54));
        TextOutLC(lc_I,56,Copy('- INSC. ESTADUAL : ' + Qr_Pedido.FieldByname('EMP_INSC_EST').AsString,1,48));
        end;
      TextOutLC(lc_I,106,'- CELULAR : ' + fc_MascaraFone(Qr_Pedido.FieldByname('END_CELULAR').AsString));

      lc_I := lc_I +1;
      TextOutLC(lc_I,1,Copy('E-MAIL   : ' + Qr_Pedido.FieldByname('EMP_EMAIL').AsString,1,53));
      TextOutLC(lc_I,56,Copy('- CONTATO  : ' + Qr_Pedido.FieldByname('END_CONTATO').AsString,1,36));
      TextOutLC(lc_I,94,Copy('- VENDEDOR: ' + Qr_Pedido.FieldByname('CLB_NOME').AsString,1,38));

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-----------------------------------------------------------------------------------------------------------------------------------');
      lc_I := lc_I + 1;

      TextOutLC(lc_I,1,'COD FABRICA  DESCRICAO DO PRODUTO                                   MARCA          QTDE    V.UNITÁRIO      V.UNIT C/     V.TOTAL C/');
			lc_I := lc_I + 1;
      TextOutLC(lc_I,108,'DESCONTO   	  DESCONTO');
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-----------------------------------------------------------------------------------------------------------------------------------');
      Qr_Itens.First;
      While not Qr_Itens.EOF do
        BEGIN
        lc_I := lc_I + 1;
        if (lc_contador > 0) then
          Begin
          lc_contador := lc_contador - 1;
          TextOutLC(lc_I,1,Copy(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString,1,11));
          TextOutLC(lc_I,13,Copy(Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,1,49));
          TextOutLC(lc_I,65,Copy(Qr_Itens.FieldByname('MRC_DESCRICAO').AsString,1,19));
          TextOutLC(lc_I,84,Padr( FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value),4));
          TextOutLC(lc_I,86,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),16));
          Lc_Aux_Float := Qr_Itens.FieldByname('ITF_QTDE').Value * Qr_Itens.FieldByname('ITF_VL_UNIT').Value;
          Lc_Vl_SbuTotal := Lc_Vl_SbuTotal + ( RoundTo( Lc_Aux_Float ,-2) );

          TextOutLC(lc_I,86,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency - ( Qr_Itens.FieldByname('ITF_VL_DESC').AsCurrency/ Qr_Itens.FieldByname('ITF_QTDE').Value)),ffFixed,16,2)),16));
          TextOutLC(lc_I,67,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_SUBTOTAL_CD').AsCurrency),ffFixed,16,2)),11));
          Lc_Vl_SbuTotal_CD := Lc_Vl_SbuTotal_CD + Qr_Itens.FieldByname('ITF_VL_SUBTOTAL_CD').AsCurrency;
          //Verifica se vai criar a segunda linha do produto
          Lc_Aux_Cod := Copy(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString,12,(Length(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString) - 11));
          Lc_Aux_Des := Copy(Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,50,(Length(Qr_Itens.FieldByname('PRO_DESCRICAO').AsString) - 49));
          if (Trim(Lc_Aux_Des) <> '') or (Trim(Lc_Aux_Des) <> '') then
            Begin
            lc_I := lc_I + 1;
            //Descrição
            TextOutLC(lc_I,1,Copy(Lc_Aux_Cod,1,11));
            //Descrição
            TextOutLC(lc_I,13,Copy(Lc_Aux_Des,1,49));
            lc_contador := lc_contador - 1;
            end;
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'-----------------------------------------------------------------------------------------------------------------------------------');
          Qr_Itens.Next;
          end
        else
          Begin
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'                                                                                                                    CONTINUA...');
          lc_I := lc_I + 2;
          lc_contador := Lc_ItensPP + 4;
          end;
        END;

      if (lc_contador < 4) then
        Begin
          for lc_J:=0 to lc_contador do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
        TextOutLC(lc_I,1,'                                                                                                                        CONTINUA...');
        lc_I := lc_I + 2;
        end
      else
        Begin
        if (lc_contador >= 6) then
          for Lc_J:=1 to (lc_contador - 4) do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
        end;
      //Imprimi o Rodape
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,'-----------------------------------------------------------------------------------------------------------------------------------');
      It_Observacao.Lines.Clear;
      //Dados da entrega
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,Copy('VENDEDOR: ' + Qr_Pedido.FieldByname('CLB_NOME').AsString,1,91));

      TextOutLC(lc_I,93,'VALOR TOTAL          : R$ ' );
      TextOutLC(lc_I,113,Padr(floattostrf(Lc_Vl_SbuTotal,ffFixed,12,2),12));
      //Dados da Garantia
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,Copy('ENTREGA  : ' + Qr_Pedido.FieldByname('PED_ENTREGA').AsString,1,91));
      TextOutLC(lc_I,93,'SUBTOTAL C/ DESCONTO : R$ ' );
      TextOutLC(lc_I,113,Padr(floattostrf(Lc_Vl_SbuTotal_CD,ffFixed,12,2),12));
      //Credito na Loja
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,Copy('GARANTIA : ' + Qr_Pedido.FieldByname('PED_GARANTIA').AsString,1,91));
      TextOutLC(lc_I,93,'CREDITO NA LOJA   (-): R$ ' );
      TextOutLC(lc_I,113,Padr(floattostrf(Qr_Pedido.FieldByname('PED_VL_CREDITO').AsCurrency,ffFixed,12,2),12));
      //Saldo Devedor
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,Copy('SALDO DEVEDOR         : ' + floattostrf(Fc_SaldoDevedorCliente(Qr_Pedido.FieldByName('PED_CODEMP').AsInteger),ffFixed,12,2),1,91));
      TextOutLC(lc_I,93,'OUTRAS DESPESAS   (+): R$ ' );

      TextOutLC(lc_I,113,Padr(floattostrf(Qr_Pedido.FieldByname('PED_VL_ODESPESA').AsCurrency,ffFixed,12,2),12));
      //Boletos a Vencer
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,Copy('BOLETOS VENCER      : ' + floattostrf(Fc_SaldoPorFormaPagamento('BOLETO',Qr_Pedido.FieldByName('PED_CODEMP').AsInteger),ffFixed,12,2),1,91));
      TextOutLC(lc_I,93,'FRETE             (+): R$ ' );
      TextOutLC(lc_I,113,Padr(floattostrf(Qr_Pedido.FieldByname('PED_VL_FRETE').AsCurrency,ffFixed,12,2),12));
      //Cheques Pre-Datados
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,Copy('CHEQUES PRE - DATADOS : ' + floattostrf(Fc_SaldoChequePreDatado(Qr_Pedido.FieldByName('PED_CODEMP').AsInteger),ffFixed,12,2),1,91));
      TextOutLC(lc_I,93,'VALOR TOTAL DO PEDIDO: R$ ' );
      TextOutLC(lc_I,113,Padr(floattostrf(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency- Qr_Pedido.FieldByname('PED_VL_CREDITO').AsCurrency,ffFixed,12,2),12));
      //Barra de Separação
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,'-----------------------------------------------------------------------------------------------------------------------------------');


      //Parcelamento - Vai ser inserido no campo Memo
      Pc_AbreDadosParcelamento;
      lc_I := lc_I + 1 ;
      IF Qr_Parcelamento.RecordCount > 0 then
        Begin          // 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
        TextOutLC(lc_I,1,'VENCIMENTO     VALOR  FORMA DE PAGAMENTO');//| VENCIMENTO     VALOR  FORMA DE PAGAMENTO  | VENCIMENTO     VALOR  FORMA DE PAGAMENTO ');
        Lc_Nr_Parcelamento :=  Qr_Parcelamento.RecordCount;
        Lc_Nr_Parcelamento := Trunc(Lc_Nr_Parcelamento / 3);
        while not Qr_Parcelamento.Eof do
          Begin
          lc_I := lc_I + 1 ;
          //Primeiro Registro da mesma linha
          TextOutLC(lc_I,1,Qr_Parcelamento.fieldByName('PAR_DATA').AsString);
          TextOutLC(lc_I,12,Padr(floattostrf(Qr_Parcelamento.FieldByname('PAR_VALOR').AsCurrency,ffFixed,9,2),9));
          TextOutLC(lc_I,23,Copy(Qr_Parcelamento.fieldByName('FPT_DESCRICAO').AsString,1,17));
          {
          //Segundo Registro da mesma linha
          Qr_Parcelamento.Next;
          if not Qr_Parcelamento.Eof then
            Begin
            TextOutLC(lc_I,43,'| ' + Qr_Parcelamento.fieldByName('PAR_DATA').AsString);
            TextOutLC(lc_I,56,Padr(floattostrf(Qr_Parcelamento.FieldByname('PAR_VALOR').AsCurrency,ffFixed,9,2),9));
            TextOutLC(lc_I,67,Copy(Qr_Parcelamento.fieldByName('FPT_DESCRICAO').AsString,1,17));
            Qr_Parcelamento.Next;
            end;
          //Terceiro Registro da mesma linha
          if not Qr_Parcelamento.Eof then
            Begin
            TextOutLC(lc_I,87,'| ' + Qr_Parcelamento.fieldByName('PAR_DATA').AsString);
            TextOutLC(lc_I,100,Padr(floattostrf(Qr_Parcelamento.FieldByname('PAR_VALOR').AsCurrency,ffFixed,9,2),9));
            TextOutLC(lc_I,111,Copy(Qr_Parcelamento.fieldByName('FPT_DESCRICAO').AsString,1,17));
            end;
          }
          Qr_Parcelamento.Next;
          end;
        //Barra de Separação
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'-----------------------------------------------------------------------------------------------------------------------------------');
        end
      else
        Begin
        TextOutLC(lc_I,1,'VENCIMENTO     VALOR  FORMA DE PAGAMENTO  | VENCIMENTO     VALOR  FORMA DE PAGAMENTO  | VENCIMENTO     VALOR  FORMA DE PAGAMENTO ');
        lc_I := lc_I + 1 ;
        //Primeiro Registro da mesma linha
        TextOutLC(lc_I,1,Qr_Pedido.fieldByName('DATA').AsString);
        TextOutLC(lc_I,12,Padr(floattostrf(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency- Qr_Pedido.FieldByname('PED_VL_CREDITO').AsCurrency,ffFixed,9,2),9));
        TextOutLC(lc_I,23,Copy(Qr_Pedido.fieldByName('FPT_DESCRICAO').AsString,1,17));
        //Barra de Separação
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'-----------------------------------------------------------------------------------------------------------------------------------');
        end;

      //Observação
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,'OBSERVACOES');
      LC_Observacao.Lines.Clear;
      Lc_Texto := TMemoryStream.Create;
      Lc_Texto.LoadFromStream(Qr_Pedido.CreateBlobStream(Qr_Pedido.FieldByName('PED_OBS'), bmRead));
      LC_Observacao.Lines.LoadFromStream(lC_Texto);
      FreeAndNil(Lc_Texto);
      for Lc_II := 0 to LC_Observacao.Lines.Count do
        Begin
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,Lc_Observacao.Lines.Strings[Lc_II]);
        end;

      end;
      If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
        begin
        Lc_Prin.Eject;
        end
      else
        begin
        For Lc_II := 1 to (StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),2)+1) do
          Begin
          Inc(Lc_I);
          Lc_Prin.TextOutLC(Lc_I,1,'');
          end;
        end;
      Lc_Prin.Finalize;
      FreeAndNil(Lc_Prin);
      FreeAndNil(Lc_Observacao);
  except
      If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
        Lc_Prin.Eject;
      Lc_Prin.Finalize;
      FreeAndNil(Lc_Prin);
      Exit;
  end;
END;

procedure TImpModImpressao.Pc_Imp_Vda_Matricial_Vda_7;
Var
  Lc_TExto : String;
  Lc_ItensPP : Integer;
  lc_contador : Integer;
  lc_I, Lc_II, lc_J : Integer;
  Lc_Prin : TPrin;
  LcLote : String;
  LcDescricao:String;
  Lc_ObsTexto: TMemoryStream;
  Lc_Observacao : TMemo;
  Lc_Peso : REal;
Begin
  try
    Lc_Observacao:= TMemo.Create(self);
    Lc_Observacao.Parent:= Fr_principal;
    Lc_Observacao.Visible:=FALSE;
    Lc_Observacao.WordWrap := True;
    Lc_Observacao.Width := 640;
    Lc_Observacao.Height := 90;
    Lc_Observacao.Top := 0;
    Lc_Observacao.Left := 0;
    Lc_Observacao.Font.Name := 'Courier';
    Lc_Observacao.Lines.Clear;

    //Monta o pedido
    Pc_AbreDadosPedido;


    Lc_ItensPP := StrToIntDEF(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_ITENS_FOLHA','16'),16);
    lc_contador := Lc_ItensPP + 4;
    Lc_Prin:=TPrin.Create(self);
    With Lc_Prin Do
    begin
      Porta := It_Porta;
      Initialize(It_Porta);
      lc_I := 1;

      Pc_AtivaEstabelecimento;
      textoutLc(lc_I,1,Copy(DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString,1,57));
      Lc_TExto := concat('FONE : ', fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString));
      textoutLc(lc_I,58,Padr(Lc_TExto ,22));

      lc_I := lc_I + 1;
      Lc_TExto := concat('E-MAIL : ', DM.Qr_Estabelecimento.FieldByname('EMP_EMAIL').AsString,' - ',
                         'WEBSITE : ', DM.Qr_Estabelecimento.FieldByname('EMP_SITE').AsString);
      textoutLc(lc_I,1,Lc_TExto);

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'PEDIDO: ');
      textoutLc(lc_I,9,Padr(Qr_Pedido.FieldByname('PED_NUMERO').AsString,8));
      TextOutLC(lc_I,57,'DATA :');
      Lc_TExto := Qr_Pedido.FieldByname('DATA').AsString + ' ' + TimeToStr(Now);

      textoutLc(lc_I,64,Padr(Lc_TExto ,16));
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
      Condensa(True);
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'NOME DO CLIENTE: ');
      TextOutLC(lc_I,18,Qr_Pedido.FieldByname('EMP_CODIGO').AsString + ' -  '+ Qr_Pedido.FieldByname('EMP_FANTASIA').AsString + ' - ' + Qr_Pedido.FieldByname('EMP_NOME').AsString);

      IF Qr_Pedido.FieldByname('EMP_PESSOA').AsString = 'F' then
        Begin
        TextOutLC(lc_I,106,'C.P.F: ');
        TextOutLC(lc_I,110,Padr(fc_MascaraCPF(Qr_Pedido.FieldByname('EMP_CNPJ').AsString),18));
        end
      else
        Begin
        TextOutLC(lc_I,106,'C.N.P.J: ');
        TextOutLC(lc_I,110,Padr(fc_MascaraCNPJ(Qr_Pedido.FieldByname('EMP_CNPJ').AsString),18));
        end;
      lc_I := lc_I +1;
      TextOutLC(lc_I,1,'ENDERECO: ' + Qr_Pedido.FieldByname('END_ENDER').AsString + ', ' + Qr_Pedido.FieldByname('END_NUMERO').AsString +'  -  '+
                     ' BAIRRO: ' + Qr_Pedido.FieldByname('END_BAIRRO').AsString +'  -  '+
                     ' CEP: '    + Qr_Pedido.FieldByname('END_CEP').AsString    +'  -  '+
                     'CIDADE: '+Qr_Pedido.FieldByname('CDD_DESCRICAO').AsString +'  -  '+
                     'UF: ' + Qr_Pedido.FieldByname('UFE_SIGLA').AsString);

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'FONE: '+fc_MascaraFone(Qr_Pedido.FieldByname('END_FONE').AsString)+'  -  ');
      TextOutLC(lc_I,22,'CONTATO: '+Qr_Pedido.FieldByname('END_CONTATO').AsString);

       IF Qr_Pedido.FieldByname('EMP_PESSOA').AsString = 'F' then
        Begin
        TextOutLC(lc_I,106,'R.G: ');
        TextOutLC(lc_I,110,Padr(Qr_Pedido.FieldByname('EMP_INSC_EST').AsString,18));
        end
      else
        Begin
        TextOutLC(lc_I,106,'INSC. E: ');
        TextOutLC(lc_I,110,Padr(Qr_Pedido.FieldByname('EMP_INSC_EST').AsString,18));
        end;

      Condensa(FAlse);
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'DESCRICAO DOS PRODUTOS');
      LcLote := Fc_BuscaLote(Qr_Itens.FieldByName('ITF_CODIGO').AsInteger);
      TextOutLC(lc_I,46,'LOTE');
      TextOutLC(lc_I,53,'QTDE');
      TextOutLC(lc_I,62,'PRECO');
      TextOutLC(lc_I,71,'SUBTOTAL');
      Qr_Itens.First;
      While not Qr_Itens.EOF do
      BEGIN
        if (lc_contador > 0) then
        Begin
          lc_I := lc_I + 1;
          lc_contador := lc_contador - 1;
          LcLote := Fc_BuscaLote(Qr_Itens.FieldByName('ITF_CODIGO').AsInteger);
          if ( Length(LcLote) >0 ) then
          Begin
            LcDescricao := Copy(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString + '-' + Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,1,42);
            TextOutLC(lc_I,1,LcDescricao);
            TextOutLC(lc_I,44,LcLote);
            TextOutLC(lc_I,50,Padr(Qr_Itens.FieldByname('ITF_QTDE').AsString,6));
            TextOutLC(lc_I,57,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),9));
            TextOutLC(lc_I,67,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));

          End
          else
          Begin
            LcDescricao := Copy(Qr_Itens.FieldByname('PRO_CODIGOFAB').AsString + '-' + Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,1,50);
            TextOutLC(lc_I,1,LcDescricao);
            TextOutLC(lc_I,52,Padr(Qr_Itens.FieldByname('ITF_QTDE').AsString,6));
            TextOutLC(lc_I,59,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_UNIT').AsCurrency),ffFixed,16,2)),9));
            TextOutLC(lc_I,69,Padr((floattostrf((Qr_Itens.FieldByname('ITF_VL_SUBTOTAL').AsCurrency),ffFixed,16,2)),11));
          End;
          Qr_Itens.Next;
        end
        else
        Begin
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'                                                                    CONTINUA...');
          lc_I := lc_I + 2;
          lc_contador := Lc_ItensPP + 4;
        end;
      END;

      if (lc_contador < 4) then
        Begin
          for lc_J:=0 to lc_contador do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
        TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'                                                                    CONTINUA...');
        lc_I := lc_I + 2;
        end
      else
        Begin
        if (lc_contador >= 6) then
          for Lc_J:=1 to (lc_contador - 4) do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
        end;
      //Imprimi o Rodape
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');

      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'COND. PAGTO: ');
      TextOutLC(lc_I,14,Qr_Pedido.FieldByname('FPT_DESCRICAO').AsString  + ' | ' + Fc_Parcelamento('I'));

      //====================== MONTAR Observação==================================================
      LC_Observacao.Lines.Clear;
      if Length(Trim(Qr_Pedido.FieldByname('PED_OBS').AsString))>0 then
      Begin
        try
          Lc_ObsTexto := TMemoryStream.Create;
          Lc_ObsTexto.LoadFromStream(Qr_Pedido.CreateBlobStream(Qr_Pedido.FieldByName('PED_OBS'), bmRead));
          LC_Observacao.Lines.LoadFromStream(Lc_ObsTexto);
        finally
          FreeAndNil(Lc_ObsTexto);
        end;
      End;

      Lc_Peso := Fc_MostraPesoPedido(Qr_Pedido.FieldByname('PED_CODIGO').AsInteger);
      if Lc_Peso > 0 then
        Lc_Observacao.Lines.Add(CONCAT('Peso total dos produtos: ',FloatToStrF(Lc_Peso,ffFixed,10,2)));

      //Cheque Devolvido
      if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_DEV','') = 'S') then
      Begin
        LC_Observacao.Lines.Add(Fc_HistoricoFinanceiro(1,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger));
      end;

      //Cheque Pre-Datado
      if (Fc_Tb_Geral('L','FIN_G_INF_CHQ_PRE','') = 'S') then
      Begin
        LC_Observacao.Lines.Add(Fc_HistoricoFinanceiro(2,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger));
      end;

      //Saldo Devedor
      if (Fc_Tb_Geral('L','FIN_G_INF_SALDO_DEV','') = 'S') then
      Begin
        LC_Observacao.Lines.Add(Fc_HistoricoFinanceiro(3,Qr_Pedido.FieldByname('PED_CODEMP').AsInteger));
      end;

      //=========================================================================================

      TextOutLC(lc_I,49,'TOTAL DOS PRODUTOS:');
      TextOutLC(lc_I,69, Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PRODUTO').AsCurrency,ffFixed,10,2),11));

      if (Fc_Tb_Geral('L','VDA_G_MOSTRA_VENDEDOR','S') ='S') then
      begin
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,concat('NOME DO VENDEDOR:',
                                Copy(Qr_Pedido.FieldByname('CLB_NOME').AsString,1,24)
        ));
      end;
      lc_I := lc_I + 1;
      TextOutLC(lc_I,49,'QTD. PRODUTOS:');
      TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_QT_PRODUTO').AsFloat,ffFixed,10,2),11));

      lc_I := lc_I + 1;
      if Lc_Observacao.Lines.Count > 0 then
      Begin
        TextOutLC(lc_I,1,'OBSERVACOES:');
      End;

      TextOutLC(lc_I,49,'VALOR DO FRETE    :');
      TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_FRETE').AsCurrency,ffFixed,10,2),11));

      lc_I := lc_I + 1;
      if Lc_Observacao.Lines.Count >= 0 then
      Begin
        TextOutLC(lc_I,1,copy( Lc_Observacao.Lines[0],1,47));
      End;

      TextOutLC(lc_I,49,'DESCONTO          :');
      TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_DESCONTO').AsCurrency,ffFixed,10,2),11));

      lc_I := lc_I + 1;
      if Lc_Observacao.Lines.Count >= 1 then
      Begin
        TextOutLC(lc_I,1,copy( Lc_Observacao.Lines[1],1,47));
      End;

      TextOutLC(lc_I,49,'TOTAL DO PEDIDO   :');
      TextOutLC(lc_I,69,Padr(FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsCurrency,ffFixed,10,2),11));

      For lc_J := 2 to Lc_Observacao.Lines.Count - 1 do
      Begin
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,copy( Lc_Observacao.Lines[lc_J],1,47));
      End;
    end;

    If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
    begin
      Lc_Prin.Eject;
    end
    else
    begin
      For Lc_II := 1 to (StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),2)+1) do
      Begin
        Inc(Lc_I);
        Lc_Prin.TextOutLC(Lc_I,1,'');
      end;
    end;
    Lc_Prin.Finalize;
    FreeAndNil(Lc_Prin);
    FreeAndNil(Lc_Observacao);
  except
    If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
      Lc_Prin.Eject;
    Lc_Prin.Finalize;
    FreeAndNil(Lc_Prin);
    FreeAndNil(Lc_Observacao);
    Exit;
  end;


end;

procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_sRV_5;
BEGIN
  Pc_Imp_Vda_Matricial_Vda_5;
END;

procedure  TimpModImpressao.Pc_Imp_Vda_Matricial_sRV_6;
BEGIN
  Pc_Imp_Vda_Matricial_Vda_6;
END;

procedure TImpModImpressao.Pc_Imp_Vda_Matricial_Srv_7;
begin
  Pc_Imp_Vda_Matricial_Vda_7;
end;

procedure  TimpModImpressao.Pc_Rodape_RdPrint;
var
  Lc_Salto: Integer;
begin
  It_Linha := 25;
  {with Fr_Principal.RdPrint_DP do
    begin
    Imp   (It_Linha,01, Fc_CentralizaTexto('-',130, '-'));
    Inc(It_Linha);
    ImpF  (It_Linha,01, '| Vlr. Bruto.:',[]);
    ImpVal(It_Linha,16, '###,###,##0.00', Qr_Pedido.FieldByName('PED_VL_PRODUTO').Value,[]);
    ImpF  (It_Linha,53, 'Desconto de.:',[]);
    ImpVal(It_Linha,67, '###,###,##0.00', Qr_Pedido.FieldByName('PED_VL_DESCONTO').Value,[]);
    ImpF  (It_Linha,100,'Vlr. Liquido.:',[]);
    ImpVal(It_Linha,115,'###,###,##0.00', Qr_Pedido.FieldByName('PED_VL_PEDIDO').Value,[]);
    ImpF  (It_Linha,130,'|',[]);
    Inc(It_Linha);
    if (Length(Qr_Pedido.FieldByName('PED_OBS').AsString) > 105) then
      begin
      ImpF  (It_Linha,02,'OBSERVAÇÕES: '+(Copy(Qr_Pedido.FieldByName('PED_OBS').AsString,1,105)),[]);
      Inc(It_Linha);
      ImpF  (It_Linha,02,'             '+(Copy(Qr_Pedido.FieldByName('PED_OBS').AsString,106,105)),[]);
      end
    else
      begin
      ImpF  (It_Linha,02,'OBSERVAÇÕES: '+Qr_Pedido.FieldByName('PED_OBS').AsString,[]);
      end;
    Inc(It_Linha);
    ImpF  (It_Linha,14,'Visto: _____/_____/______   ________________________________',[]);
    ImpF  (It_Linha,81,'Atendido por: '+Qr_Pedido.FieldByName('CLB_NOME').AsString,[]);
    Inc(It_Linha);
    ImpF  (It_Linha,81,'Vendedor....: '+Qr_Vendedor.FieldByName('CLB_NOME').AsString,[]);
    Inc(It_Linha);
    ImpF  (It_Linha,02,'ATENÇÃO !!!!!   Troca e/ou Devolução de Mercadoria até 07 dias e SOMENTE com a apresentação do comprovante da compra.',[]);
    end;}
end;

procedure TImpModImpressao.Pc_Save_Tipo(Pc_TipoPed, Pc_cd_Pedido,
  Pc_cd_Nota: integer);
begin
  //
end;

procedure  TimpModImpressao.Pc_AbreDadosPedido;
Begin
  with Qr_Pedido do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add(' SELECT '+
            ' PED_CODIGO, '+
            ' EMP_FANTASIA, '+
            ' EMP_CODIGO, '+
            ' EMP_PESSOA, '+
            ' EMP_CNPJ, '+
            ' EMP_INSC_EST, '+
            ' EMP_NOME, '+
            ' PED_CODEMP, '+
            ' PED_NUMERO, '+
            ' EMP_TIPO, '+
            ' PED_DATA DATA, '+
            ' PED_QT_PRODUTO, '+
            ' PED_OBS, '+
            ' PED_VL_FRETE, '+
            ' PED_VL_DESCONTO, '+
            ' PED_VL_PEDIDO, '+
            ' PED_PRAZO, '+
            ' PED_VL_PRODUTO, '+
            ' PED_VL_ODESPESA, '+
            ' PED_VL_ST, '+
            ' CLB_NOME, '+
            ' FPT_DESCRICAO, '+
            ' EMP_CODVDOR, '+
            ' END_ENDER, '+
            ' END_NUMERO, '+
            ' END_COMPLEM, '+
            ' END_BAIRRO, '+
            ' CDD_DESCRICAO, '+
            ' UFE_SIGLA, '+
            ' END_CEP, '+
            ' END_FONE, '+
            ' END_FAX, '+
            ' END_CONTATO, '+
            ' END_CELULAR, '+
            ' EMP_EMAIL, '+
            ' PED_ENTREGA, '+
            ' PED_GARANTIA, '+
            ' PED_VL_CREDITO, '+
            ' PED_DT_ALTERA, '+
            ' PED_VL_SERVICO, '+
            ' PED_TIPO, '+
            ' VALUE_RECIVED, '+
            ' VALUE_CHANGE, '+
            ' PED_INDPRES '+
            ' FROM TB_PEDIDO tb_pedido '+
            '   INNER JOIN TB_EMPRESA tb_empresa ON '+
            '   tb_empresa.EMP_CODIGO = tb_pedido.PED_CODEMP '+
            '   INNER JOIN TB_ENDERECO tb_endereco '+
            '   on (tb_endereco.END_CODIGO = tb_pedido.PED_CODEND) '+
            '   INNER JOIN TB_CIDADE tb_cidade ON '+
            '   (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '+
            '   INNER JOIN TB_UF tb_uf '+
            '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
            '   LEFT OUTER JOIN TB_FORMAPAGTO tb_formapagto ON '+
            '   (tb_formapagto.FPT_CODIGO = tb_pedido.PED_CODFPG) '+
            '   LEFT OUTER JOIN TB_COLABORADOR tb_colaborador ON '+
            '   (tb_colaborador.CLB_CODIGO = tb_pedido.PED_CODVDO) '+
            '   LEFT OUTER JOIN TB_COTACAO tb_cotacao ON '+
            '   (tb_cotacao.CTC_CODPED = tb_pedido.PED_CODIGO) '+
            '   left outer join TB_RESTAURANTE '+
            '   ON (TB_PEDIDO_ID = PED_CODIGO)'+
            ' WHERE(PED_CODIGO =:PED_CODIGO) ');
    ParamByName('PED_CODIGO').AsInteger := FCodigoPedido;
    Active := True;
    FetchAll;
    First;
  end;

  with Qr_Itens do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add(concat(
              'SELECT ITF_CODIGO, ITF_CODPED, ITF_CODNFL, ITF_CODPRO, PRO_CODIGOFAB,PRO_CODIGO, PRO_DESCRICAO, ',
              'ITF_QTDE, ITF_VL_CUSTO, PRO_SUB_TRIB, ITF_VL_UNIT, ITF_AQ_COM, MED_ABREVIATURA,MRC_DESCRICAO, ',
              'PRO_CODIGOFOR, ITF_VL_DESC, (ITF_QTDE * ITF_VL_UNIT) ITF_VL_SUBTOTAL, ',
              '((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) ITF_VL_SUBTOTAL_CD,PRO_LOCAL,ita.iav_descricao ',
              'FROM  TB_ITENS_NFL it ',
              '  INNER JOIN TB_PRODUTO pr ',
              '  ON pr.PRO_CODIGO = it.ITF_CODPRO ',
              '  INNER JOIN TB_MEDIDA me   ',
              '  ON  (me.MED_CODIGO = pr.PRO_CODMED) ',
              '  INNER JOIN TB_MARCA_PRODUTO ma   ',
              '  ON  (ma.MRC_CODIGO = pr.PRO_CODMRC) ',
              '  LEFT OUTER JOIN tb_itens_avl ita ',
              '  on ita.iav_coditf = it.itf_codigo ',
              'WHERE it.ITF_CODPED =:PED_CODIGO ',
              '  AND pr.PRO_TIPO <> ''S'' '
    ));
    case Qr_Pedido.FieldByName('PED_TIPO').AsInteger of
      1:SQL.Add('  AND (ITF_OPER = ''V'') ');
      2:SQL.Add('  AND (ITF_OPER = ''C'') ');
      3:SQL.Add('  AND (ITF_OPER = ''A'') ');
      4:SQL.Add('  AND (ITF_OPER = ''V'') ');
    end;

    IF Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_MOD_MATRICIAL', '') = '2' then
      SQL.Add('ORDER BY PRO_CODIGOFAB')
    else
      SQL.Add('ORDER BY PRO_DESCRICAO,PRO_CODIGOFAB ');
    ParamByName('PED_CODIGO').AsInteger := FCodigoPedido;
    Active := True;
    FetchAll;
    First;
  end;

  with Qr_lote do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT CLT_NUMERO, CLT_DT_VENCIMENTO '+
            'FROM tb_ctrl_lote '+
            '  INNER JOIN tb_movimento_lote '+
            '  ON (CLT_CODIGO = MLT_CODCLT) '+
            'WHERE MLT_CODVCL =:ITF_CODIGO AND (MLT_TIPO LIKE ''VENDA%'')');
  end;


  with Qr_ItensSrv do
  Begin
    Active := false;
    sql.clear;
    sql.add(' SELECT PRO_CODIGO,ITF_CODIGO,ITF_CODPED,ITF_CODNFL, ITF_CODPRO, PRO_DESCRICAO, '+
            ' ITF_QTDE, ITF_VL_CUSTO, ITF_VL_UNIT, ITF_AQ_COM, MED_ABREVIATURA, '+
            '(ITF_QTDE * ITF_VL_UNIT) ITF_VL_SUBTOTAL  '+
            ' FROM TB_ITENS_NFL Tb_itens_nfl '+
            ' INNER JOIN TB_PEDIDO Tb_pedido ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO) '+
            ' INNER JOIN TB_PRODUTO Tb_produto ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO) '+
            ' INNER JOIN TB_MEDIDA tb_medida  ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED) '+
            ' wHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO = ''S'') '+
            'ORDER BY PRO_DESCRICAO ');
    ParamByName('PED_CODIGO').asinteger:=FCodigoPedido;
    active:=true;
    FetchAll;
    First;
  end;

  with Qr_Vendedor do
  Begin
    Active:=false;
    SQL.Clear;
    SQL.Add(' SELECT CLB_NOME FROM TB_COLABORADOR CLB '+
            ' WHERE(CLB_CODIGO =:EMP_CODVDOR)        ');
    ParamByName('EMP_CODVDOR').AsInteger:= Qr_Pedido.FieldByName('EMP_CODVDOR').AsInteger;
    Active:=True;
  end;
end;

procedure  TimpModImpressao.Pc_AbreDadosParcelamento;
Begin
  with Qr_Parcelamento do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT PAR_PARCELA,PAR_VALOR,PAR_DATA, FPT_DESCRICAO '+
            'FROM TB_PARCELAMENTO '+
            '  INNER JOIN TB_FORMAPAGTO '+
            '  ON (FPT_CODIGO = PAR_CODFPT) '+
            ' WHERE PAR_CODPED=:PAR_CODPED '+
            ' ORDER BY PAR_PARCELA ');
    ParamByName('PAR_CODPED').AsInteger := FCodigoPedido;
    Active := True;
    FetchAll;
    if (recordcount = 0) then
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT FIN_NR_PARCELA PAR_PARCELA,FIN_VL_PARCELA PAR_VALOR, FIN_DT_VENCIMENTO PAR_DATA, FPT_DESCRICAO '+
              'FROM TB_FINANCEIRO '+
              '  INNER JOIN tb_formapagto '+
              '  ON ( TB_FINANCEIRO.fin_codfpg = tb_formapagto.fpt_codigo) '+
              'WHERE FIN_CODPED=:FIN_CODPED '+
              'ORDER BY FIN_NR_PARCELA');
      ParamByName('FIN_CODPED').AsInteger := FCodigoPedido;
      Active := True;
      FetchAll;
    end;
    First;
  end;
end;

procedure TimpModImpressao.Pc_AbreDadosFinanceiro;
Begin
  with Qr_Financeiro do
  Begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT FIN_CODIGO, FIN_VL_PARCELA, FPT_DESCRICAO '+
            'FROM TB_FINANCEIRO '+
            '  INNER JOIN TB_FORMAPAGTO '+
            '  ON (FPT_CODIGO = FIN_CODFPG) '+
            ' WHERE FIN_CODPED=:FIN_CODPED '+
            ' ORDER BY FIN_NR_PARCELA ');
    ParamByName('FIN_CODPED').AsInteger := FCodigoPedido;
    Active := True;
    FetchAll;
    First;
  end;
End;


procedure TImpModImpressao.Pc_AbreDadosOrdem(Tipo:String);
begin
  with Qr_Ordem do
  Begin
    Active := False;
    SQL.Clear;
    if Tipo = 'PEDIDO' then
    Begin
      SQL.Add(' SELECT PED_DATA DATA,TPV_DESCRICAO,MRC_DESCRICAO,MOD_DESCRICAO,VEI_PLACA,VEI_KM, '+
              ' OBS,VEI_FROTA, tb_color.description COR_DESCRICAO,EXIT_DATE '+
              ' FROM TB_VEHICLE_SO OS '+
              '  INNER JOIN TB_PEDIDO ON (PED_CODIGO = TB_ORDER_ID ) '+
              ' INNER JOIN TB_VEICULO tb_veiculo ON (tb_veiculo.VEI_PLACA = OS.TB_VEHICLE_ID) '+
              ' INNER JOIN TB_MARCA_VEICULO tb_marca ON (tb_marca.MRC_CODIGO = tb_veiculo.VEI_CODMRC) '+
              ' INNER JOIN TB_MODELO tb_modelo ON (tb_modelo.MOD_CODIGO = tb_veiculo.VEI_CODMOD) '+
              ' INNER JOIN TB_TP_VEICULO tb_tp_veiculo ON (tb_tp_veiculo.TPV_CODIGO = tb_veiculo.VEI_CODTPV) '+
              ' LEFT OUTER JOIN TB_COLOR tb_color ON (tb_color.id = tb_veiculo.VEI_CODCOR) '+
              ' WHERE TB_ORDER_ID =:PED_CODIGO ');
      ParamByName('PED_CODIGO').AsInteger:= FCodigoPedido;
      Active := True;
      FetchAll;
    End
    else
    Begin
      SQL.Add('SELECT CTC_DATA DATA , TPV_DESCRICAO,MRC_DESCRICAO,MOD_DESCRICAO,VEI_PLACA,VEI_KM, '+
              ' OBS,VEI_FROTA, tb_color.description COR_DESCRICAO,EXIT_DATE, '+
              'CTC_VL_SERVICO,CTC_VL_PRODUTO, CTC_VL_COTACAO '+
              'FROM TB_VEHICLE_SO OS '+
              '  INNER JOIN TB_COTACAO ON (CTC_CODPED = TB_ORDER_ID ) '+
              '  INNER JOIN TB_VEICULO tb_veiculo ON (tb_veiculo.VEI_PLACA = OS.TB_VEHICLE_ID) '+
              '  INNER JOIN TB_MARCA_VEICULO tb_marca ON (tb_marca.MRC_CODIGO = tb_veiculo.VEI_CODMRC) '+
              '  INNER JOIN TB_MODELO tb_modelo ON (tb_modelo.MOD_CODIGO = tb_veiculo.VEI_CODMOD) '+
              '  INNER JOIN TB_TP_VEICULO tb_tp_veiculo ON (tb_tp_veiculo.TPV_CODIGO = tb_veiculo.VEI_CODTPV) '+
              '  LEFT OUTER JOIN TB_COLOR tb_color ON (tb_color.id = tb_veiculo.VEI_CODCOR) '+
              'WHERE TB_ORDER_ID =:PED_CODIGO ');
      ParamByName('PED_CODIGO').AsInteger:= FCodigoPedido;
      Active := True;
      FetchAll;
      if recordcount = 0 then
      Begin
        exit;
      End;
    End;
  End;
end;

procedure  TimpModImpressao.Pc_OrcamentoBobina;
Var
  Lc_Entrada:Integer;
  Lc_Device : PChar;
  Lc_Driver : Pchar;
  Lc_Porta : Pchar;
  Lc_HdeviceMode: Thandle;
  Lc_ImpAtual:integer;
  Lc_I, Lc_J : Integer;
  Lc_Linha : Integer;
  Lc_Prin : TPrin;
Label
  Desvio;
Begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Imprimir Cupom para o Cliente.'+EOLN+EOLN+
                     'Confirmar a Impressão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  begin
    Try
      Qr_Cotacao.Active:=false;
      Qr_Cotacao.Sql.clear;
      Qr_Cotacao.Sql.Add(' SELECT CTC_NUMERO,CTC_CODEMP,CTC_DATA DATA,CTC_VL_COTACAO,CTC_VL_DESCONTO,CTC_ALIQ_DESCONTO,   ');
      Qr_Cotacao.Sql.Add(' CTC_VL_FRETE,CTC_VL_PRODUTO,CTC_OBS,CTC_CODIGO,clb_nome,CTC_FANTASIA           ');
      Qr_Cotacao.Sql.Add(', END_FONE ');
      Qr_Cotacao.Sql.Add(' FROM TB_COTACAO tb_cotacao                                                                ');
      Qr_Cotacao.Sql.Add(' LEFT OUTER JOIN TB_EMPRESA tb_empresa  ON (tb_empresa.EMP_CODIGO = tb_cotacao.CTC_CODEMP) ');
      Qr_Cotacao.Sql.Add(' LEFT OUTER JOIN TB_ENDERECO ed  ON (tb_empresa.EMP_CODIGO = ed.END_CODEMP) ');
      Qr_Cotacao.Sql.Add(' LEFT OUTER JOIN tb_colaborador tb_colaborador  ON                                         ');
      Qr_Cotacao.Sql.Add('                               (tb_colaborador.clb_codigo = tb_cotacao.ctc_codvdo)         ');
      Qr_Cotacao.Sql.Add(' WHERE(CTC_CODPED =:CTC_CODPED)                                                            ');
      Qr_Cotacao.ParamByName('CTC_CODPED').AsInteger:=FCodigoPedido;
      Qr_Cotacao.Active:=True;
      Qr_Cotacao.FetchAll;
      Qr_Cotacao.First;

      Qr_Conserto.Active:=FALSE;
      Qr_Conserto.SQL.Clear;
      Qr_Conserto.SQL.Add(' SELECT CST_APARELHO,CST_MARCA,CST_MODELO,CST_NUMERO,CST_ACESSORIO,                        ');
      Qr_Conserto.SQL.Add(' CST_RELATADO,CST_CONSTATADO,CST_DT_CONSERTO,CST_DT_ENTREGA,                               ');
      Qr_Conserto.SQL.Add(' SIT_DESCRICAO                                                                             ');
      Qr_Conserto.SQL.Add(' FROM TB_CONSERTO tb_conserto                                                              ');
      Qr_Conserto.SQL.Add(' LEFT OUTER JOIN TB_EMPRESA tb_empresa ON (tb_empresa.EMP_CODIGO = tb_conserto.CST_CODFOR) ');
      Qr_Conserto.SQL.Add(' INNER JOIN TB_SITUACAO tb_situacao ON (tb_situacao.SIT_CODIGO = tb_conserto.CST_CODSIT)   ');
      Qr_Conserto.SQL.Add(' WHERE                                                                                     ');
      Qr_Conserto.SQL.Add('(CST_CODPED=:PED_CODIGO)                                                                   ');
      Qr_Conserto.ParamByName('PED_CODIGO').AsInteger:=FCodigoPedido;
      Qr_Conserto.Active:=True;
      Qr_Conserto.First;


      Lc_Linha := 0;
      It_Porta := Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_PORTA','LPT1');
      Lc_Prin := TPrin.Create(self);
      Lc_Prin.Porta := It_Porta;
      Lc_Prin.Initialize(It_Porta);
      Lc_prin.Condensa(True);
      With Lc_Prin Do
      begin
        Pc_AtivaEstabelecimento;

        Expandido(true);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString);
        Expandido(false);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ', '+ DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString + ' ' + DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString + ' ' +  DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'Fone: '+ fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString) + ' FAX: ' + fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FAX').AsString));
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'site: ' + DM.Qr_Estabelecimento.FieldByname('EMP_SITE').AsString);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'e-mail: '+DM.Qr_Estabelecimento.FieldByname('EMP_EMAIL').AsString);

        Expandido(true);
        Inc(Lc_Linha);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,Qr_Cotacao.fieldbyname('CTC_NUMERO').AsString);
        Expandido(false);
        textoutLc(Lc_Linha,23,Padr(It_data,19));

        Inc(Lc_Linha);
        if Assigned(fr_pedido_vda) then
        Begin
          Negrito(True);
          TextOutLC(Lc_Linha,1,'CLIENTE: ');
          Negrito(False);
          TextOutLC(Lc_Linha,10,copy(Qr_Cotacao.FieldByName('CTC_FANTASIA').AsString,1,49));
        end;
        if Qr_Cotacao.FieldByName('CTC_CODEMP').AsInteger >0 then
        Begin
          DM.Qr_Empresas.Active := True;
          DM.Qr_Empresas.First;
          DM.Qr_Empresas.Locate('EMP_CODIGO',Qr_Cotacao.FieldByName('CTC_CODEMP').AsInteger,[]);

          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'FONE: '+fc_MascaraFone(Qr_Cotacao.FieldByname('END_FONE').AsString));
          Inc(Lc_Linha);
          IF Length(DM.Qr_Empresas.FieldByName('EMP_CNPJ').AsString) > 11 THEN
            TextOutLC(Lc_Linha,1,'CNPJ: ' + fc_MascaraCNPJ(DM.Qr_Empresas.FieldByName('EMP_CNPJ').AsString))
          else
            TextOutLC(Lc_Linha,1,'CPF: ' + fc_MascaraCPF(DM.Qr_Empresas.FieldByName('EMP_CNPJ').AsString));
        end
        else
        Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'FONE: '+Qr_Cotacao.FieldByName('CTC_CONTATO').AsString);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'CNPJ: ');
        end;

        if Qr_Conserto.RecordCount > 0 then
        Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'=====================================================');
          Negrito(true);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'ENCERRAMENTO DE CONSERTO ');
          Negrito(false);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'APARELHO : ' + Qr_Conserto.FieldByName('CST_APARELHO').AsString);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'MARCA : ' + Qr_Conserto.FieldByName('CST_MARCA').AsString);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'MODELO : ' + Qr_Conserto.FieldByName('CST_MODELO').AsString);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'N. SERIE : ' + Qr_Conserto.FieldByName('CST_NUMERO').AsString);
          //Acessorios
          It_Observacao.Lines.Clear;
          It_Observacao.Text := Qr_Conserto.FieldByName('CST_ACESSORIO').Text;
          For Lc_I:=0 to (It_Observacao.Lines.Count - 1) do
          Begin
            if Lc_I = 0 then
            Begin
              Inc(Lc_Linha);
              TextOutLC(Lc_Linha,1,'ACESSORIOS : ' + It_Observacao.Lines[lc_I])
            end
            else
            Begin
              Inc(Lc_Linha);
              TextOutLC(Lc_Linha,1,'           ' + It_Observacao.Lines[lc_I]);
            end;
          end;
          //Defeito Reclamado
          Negrito(true);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'DEFEITO RECLAMADO: ');
          Negrito(false);
          It_Observacao.Clear;
          It_Observacao.Text := Qr_Conserto.FieldByName('CST_RELATADO').Text;
          For Lc_I:=0 to (It_Observacao.Lines.Count - 1) do
          Begin
            Inc(Lc_Linha);
            TextOutLC(Lc_Linha,1,It_Observacao.Lines[lc_I])
          end;
          //Defeito Constatado
          Negrito(true);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'DEFEITO CONSTATADO: ');
          Negrito(false);
          It_Observacao.Clear;
          It_Observacao.Text := Qr_Conserto.FieldByName('CST_CONSTATADO').Text;
          For Lc_I:=0 to (It_Observacao.Lines.Count - 1) do
          Begin
            Inc(Lc_Linha);
            TextOutLC(Lc_Linha,1,It_Observacao.Lines[lc_I])
          end;
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'Data Entrada : ' + Qr_Cotacao.FieldByName('DATA').AsString);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'Data Conserto : ' + Qr_Conserto.FieldByName('CST_DT_CONSERTO').AsString);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'Data Saida : ' + Qr_Conserto.FieldByName('CST_DT_ENTREGA').AsString);
          Negrito(true);
          Inc(Lc_Linha,2);
          Negrito(True);
          TextOutLC(Lc_Linha,1,'SITUACAO : ');
          Negrito(False);
          TextOutLC(Lc_Linha,12,Qr_Conserto.FieldByName('SIT_DESCRICAO').AsString);
          Negrito(False);
          Inc(Lc_Linha,2);
          TextOutLC(Lc_Linha,1,'USUARIO: ' + GB_Nm_Usuario);
        END; //FINAL DO CONSERTO

        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'================ D E C L A R A C A O ================');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'DECLARO ESTAR RECEBENDO O EQUIPAMENTO DESCRITO NESTE');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'RECIBO, CONFORME A SITUAÇÃO DIAGNOSTICADA');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'GARANTIA DE TRES MESES REFERENTE SERVICOS EXECUTADOS');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'========== NAO SERVE COMO CUPOM FISCAL ==============');
        Inc(Lc_Linha,3);
        TextOutLC(Lc_Linha,1,'____________________________________________________');
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,copy(Qr_Cotacao.FieldByName('CTC_FANTASIA').AsString,1,49));

        For Lc_I:= 1 to (StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),2)) do
        Begin
          inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'');
        end;
        Reset;
        Finalize;
      END;
    Finally
      FreeAndNil(Lc_Prin);
    End;
  end;
end;


procedure  TimpModImpressao.Pc_Imp_Cupom_Dsp_Despachados(Pc_SqlCriterio:String);
Var
  Lc_Linha, Lc_I : Integer;
  Lc_Qr_Entregue : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Prin : TPrin;
Begin
  Try
    Lc_Qr_Entregue := TSTQuery.Create(nil);
    Lc_Qr_Entregue.Database := DM.IBD_Gestao;
    WITH Lc_Qr_Entregue do
    Begin
      Transaction := DM.IB_Transacao;
      ForcedRefresh := true;

      Lc_SqlTxt := 'SELECT distinct PED_NUMERO, CLB_NOME PED_VENDEDOR, DSP.DSP_QTDE, PRO_CODIGO, PRO_DESCRICAO '+
                   'FROM TB_ITENS_NFL ITF '+
                   '  inner JOIN TB_DESPACHO DSP '+
                   '  ON (DSP.DSP_CODITF = ITF.ITF_CODIGO) '+
                   '  INNER JOIN TB_PRODUTO PRO '+
                   '  ON (ITF.ITF_CODPRO = PRO.PRO_CODIGO) '+
                   '  INNER JOIN TB_PEDIDO PED '+
                   '  ON (PED.PED_CODIGO = ITF.ITF_CODPED) '+
                   '  INNER JOIN TB_COLABORADOR VEN '+
                   '  ON (VEN.CLB_CODIGO = PED.PED_CODVDO) '+
                   'WHERE (DSP_SITUACAO = ''S'') and (PRO_TIPO <> ''S'') '+
                   'AND ( DSP.DSP_CODIGO IN (' + Pc_SqlCriterio + ')) '+
                   'order by PRO_DESCRICAO ';

      SQL.Add(Lc_SqlTxt);
      Active := True;
      FetchAll;
      First;
      Lc_Linha :=0;

      It_Porta := Fc_Aq_Geral('L','CONTROLE DE DESPACHO','DSP_P_PORTA','');
      Lc_Prin := TPrin.Create(self);
      Lc_Prin.Porta := It_Porta;
      Lc_Prin.Initialize(It_Porta);
      Lc_prin.Condensa(True);
      With Lc_Prin Do
        begin
        Expandido(false);
        Expandido(true);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'PEDIDO N.: ' + fieldbyname('PED_NUMERO').AsString);
        Expandido(false);
        if RecordCount >0 then
        Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'=====================================================');
          //                    CODIGO    QTDE  DESCRICAO DO PRODUTO
          //                    C1C4-1    0001  ABRACADEIRA DE NYLON 10CM PRETA C/1
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'CODIGO');
          TextOutLC(Lc_Linha,11,'QTDE');
          TextOutLC(Lc_Linha,19,'DESCRICAO DO PRODUTO');
          while not Eof do
          Begin
            Inc(Lc_Linha);
            TextOutLC(Lc_Linha,1,Copy(FieldByName('PRO_CODIGO').AsString,1,19));
            TextOutLC(Lc_Linha,11,PADR(FloatToStrF(FieldByName('DSP_QTDE').AsFloat,ffFixed,10,3),4));
            TextOutLC(Lc_Linha,19,Copy(FieldByName('PRO_DESCRICAO').AsString,1,35));
            Next;
          end;
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'=====================================================');
          Inc(Lc_Linha);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'_____________________________________________________');
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'Nome: ' + Copy(FieldByName('PED_VENDEDOR').AsString,1,37));
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'Data da Entrega: ' + DateToStr(Date) + ' - '+  TimeToStr(now));

          For Lc_I:= 1 to StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE DESPACHO','DSP_P_SALTO','1'),1) do
          bEGIN
            Inc(Lc_Linha);
            TextOutLC(6+Lc_I,1,'');
          end;
          Finalize;
        END;
      end;
    end;
  Finally
    FreeAndNil(Lc_Prin);
    Lc_Qr_Entregue.close;
    FreeAndNil(Lc_Qr_Entregue);
  End;
END;

procedure  TimpModImpressao.Pc_Imp_Cupom_Dsp_Separacao(Pc_Cd_Pedido:Integer);
Var
  Lc_Linha, Lc_I : Integer;
  Lc_Qr_Separacao : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Prin : TPrin;
Begin
  try
    Lc_Qr_Separacao := TSTQuery.Create(nil);
    with Lc_Qr_Separacao do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := true;

      Lc_SqlTxt := 'SELECT distinct PED_NUMERO, CLB_NOME PED_VENDEDOR, PRO_LOCAL, DSP.DSP_QTDE, PRO_DESCRICAO '+
                   'FROM TB_ITENS_NFL ITF '+
                   '  inner JOIN TB_DESPACHO DSP '+
                   '  ON (DSP.DSP_CODITF = ITF.ITF_CODIGO) '+
                   '  INNER JOIN TB_PRODUTO PRO '+
                   '  ON (ITF.ITF_CODPRO = PRO.PRO_CODIGO) '+
                   '  INNER JOIN TB_PEDIDO PED '+
                   '  ON (PED.PED_CODIGO = ITF.ITF_CODPED) '+
                   '  INNER JOIN TB_COLABORADOR VEN '+
                   '  ON (VEN.CLB_CODIGO = PED.PED_CODVDO) '+
                   'WHERE PED_CODIGO =:PED_CODIGO AND (DSP_SITUACAO = ''P'') and (PRO_TIPO <> ''S'') '+
                   'order by PRO_LOCAL,  PRO_DESCRICAO ';

      SQL.Add(Lc_SqlTxt);
      ParamByName('PED_CODIGO').AsInteger := pc_Cd_Pedido;
      Active := True;
      FetchAll;
      First;
      Lc_Linha :=0;

      It_Porta := Fc_Aq_Geral('L','CONTROLE DE DESPACHO','DSP_P_PORTA','');
      Lc_Prin := TPrin.Create(self);
      Lc_Prin.Porta := It_Porta;
      Lc_Prin.Initialize(It_Porta);
      Lc_prin.Condensa(True);
      With Lc_Prin Do
      begin
        Expandido(false);
        Expandido(true);
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'PEDIDO N.: ' + fieldbyname('PED_NUMERO').AsString);
        Expandido(false);
        if RecordCount >0 then
        Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'=====================================================');
          //                    LOCAL      QTDE SEPA DESCRICAO DO PRODUTO
          //                    C1C4-1000  0001 ____ ABRACADEIRA DE NYLON 10CM PRETA C
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'LOCAL');
          TextOutLC(Lc_Linha,12,'QTDE');
          TextOutLC(Lc_Linha,17,'SEPA');
          TextOutLC(Lc_Linha,22,'DESCRICAO DO PRODUTO');
          while not Lc_Qr_Separacao.Eof do
          Begin
            Inc(Lc_Linha);
            TextOutLC(Lc_Linha,1,Copy(FieldByName('PRO_LOCAL').AsString,1,10));
            TextOutLC(Lc_Linha,12,PADR(FloatToStrF(FieldByName('DSP_QTDE').AsFloat,ffFixed,10,3),4));
            TextOutLC(Lc_Linha,17,'____');
            TextOutLC(Lc_Linha,22,Copy(FieldByName('PRO_DESCRICAO').AsString,1,32));
            Next;
          end;
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'=====================================================');
          For Lc_I:= 1 to StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE DESPACHO','DSP_P_SALTO','1'),1) do
          bEGIN
            Inc(Lc_Linha);
            TextOutLC(6+Lc_I,1,'');
          end;
          Finalize;
        END;
      end;
    End;
  finally
    Lc_Qr_Separacao.close;
    FreeAndNil(Lc_Qr_Separacao);
    FreeAndNil(Lc_Prin);
  end;
END;



procedure  TimpModImpressao.Pc_Imp_Cupom_Dsp_Devolucao(Pc_SqlCriterio:String);
Var
  Lc_Linha, Lc_I : Integer;
  Lc_Qr_Separacao : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Prin : TPrin;
Begin
  Try
    Lc_Qr_Separacao := TSTQuery.Create(nil);
    with Lc_Qr_Separacao do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := true;

      Lc_SqlTxt := 'SELECT distinct PED_NUMERO, DSP.DSP_QTDE, PRO_DESCRICAO '+
                 'FROM TB_DESPACHO DSP '+
                 '  INNER JOIN TB_PRODUTO PRO '+
                 '  ON (DSP.DSP_CODPRO = PRO.PRO_CODIGO) '+
                 '  INNER JOIN TB_PEDIDO PED '+
                 '  ON (DSP.DSP_CODPED = PED.PED_CODIGO) '+
                 'WHERE (DSP_SITUACAO = ''D'') and (PRO_TIPO <> ''S'') '+
                 'AND ( DSP.DSP_CODIGO IN (' + Pc_SqlCriterio + '))';
      SQL.Add(Lc_SqlTxt);
      Active := True;
      FetchAll;
      First;
      Lc_Linha :=0;
      It_Porta := Fc_Aq_Geral('L','CONTROLE DE DESPACHO','DSP_P_PORTA','');
      Lc_Prin := TPrin.Create(self);
      Lc_Prin.Porta := It_Porta;
      Lc_Prin.Initialize(It_Porta);
      Lc_prin.Condensa(True);
      Lc_prin.Expandido(false);
      Lc_prin.Expandido(true);
      With Lc_Prin Do
      begin
        Inc(Lc_Linha);
        TextOutLC(Lc_Linha,1,'RECIBO DE DEVOLUÇÃO DE MERCADORIA');
        Expandido(false);
        if Lc_Qr_Separacao.RecordCount >0 then
        Begin
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'=====================================================');
          //                    PEDIDO     QTDE  DESCRICAO DO PRODUTO
          //                    999999     0001  ABRACADEIRA DE NYLON 10CM PRETA C/10
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'PEDIDO');
          TextOutLC(Lc_Linha,12,'QTDE');
          TextOutLC(Lc_Linha,17,'DESCRICAO DO PRODUTO');
          while not Lc_Qr_Separacao.Eof do
          Begin
            Inc(Lc_Linha);
            TextOutLC(Lc_Linha,1,Copy(Lc_Qr_Separacao.FieldByName('PED_NUMERO').AsString,1,19));
            TextOutLC(Lc_Linha,12,PADR(FloatToStrF(Lc_Qr_Separacao.FieldByName('DSP_QTDE').AsFloat,ffFixed,10,3),4));
            TextOutLC(Lc_Linha,18,Copy(Lc_Qr_Separacao.FieldByName('PRO_DESCRICAO').AsString,1,36));
            Lc_Qr_Separacao.Next;
          end;
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'=====================================================');
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'Declaro ter recebido os itens descritos acima.');
          Inc(Lc_Linha);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'_____________________________________________________');
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'Nome: ' + GB_Nm_Usuario);
          Inc(Lc_Linha);
          TextOutLC(Lc_Linha,1,'Data da Entrega: ' + DateToStr(Date) + ' - '+  TimeToStr(now));

          For Lc_I:= 1 to StrtoIntDef(Fc_Aq_Geral('L','CONTROLE DE DESPACHO','DSP_P_SALTO','1'),1) do
            bEGIN
              Inc(Lc_Linha);
              TextOutLC(6+Lc_I,1,'');
            end;
          Finalize;
        end;
      END;
    end;
  Finally
    Lc_Qr_Separacao.Close;
    FreeAndNil(Lc_Qr_Separacao);
    FreeAndNil(Lc_Prin);
  End;

END;


procedure  TimpModImpressao.Pc_Imp_Conferencia(Pc_Cd_Pedido:Integer);
begin
  It_Porta := Fc_Aq_Geral('L','CONTROLE DE DESPACHO','DSP_P_PORTA','');
  if (Trim(It_Porta) = '') then
    if not fc_ChamaImpressora then exit;
  FCodigoPedido:=Pc_cd_Pedido;
  Pc_Imp_Conf_Matricial_1;
  Printer.PrinterIndex := It_Imp_Atual ;
end;

procedure  TimpModImpressao.Pc_Imp_Conf_Matricial_1;
Var
  Lc_TExto : String;
  Lc_ItensPP : Integer;
  lc_contador : Integer;
  lc_I, Lc_II, lc_J : Integer;
  Lc_Prin : TPrin;
  Lc_Traco : String;
  Lc_Tl_Qtde : Real;
Begin
  try
    Lc_Traco := '-----------------------------------------------------------------------------------------------------------------------------------';
    Pc_AtivaEstabelecimento;
    //Monta o pedido
    Pc_AbreDadosPedido;
    Lc_ItensPP := StrToIntDEF(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_ITENS_FOLHA','16'),16);
    lc_contador := Lc_ItensPP + 4;
    Lc_Prin:=TPrin.Create(self);
    With Lc_Prin Do
      begin
      Initialize(It_Porta);
      Condensa(True);
      lc_I := 1;
      TextOutLC(lc_I,1,DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString);
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,Lc_Traco);
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'SEPARACAO DE MERCADORIA DO PEDIDO Nro: ' + Qr_Pedido.FieldByName('PED_NUMERO').AsString);
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,Lc_Traco);
      lc_I := lc_I + 1;
      lc_I := lc_I + 1;
      Lc_Texto := Copy('Cliente..: ' + Qr_Pedido.FieldByname('EMP_CODIGO').AsString + ' -  '+ Qr_Pedido.FieldByname('EMP_FANTASIA').AsString + ' - ' + Qr_Pedido.FieldByname('EMP_NOME').AsString,1,100);
      TextOutLC(lc_I,1,Lc_Texto);
      Lc_TExto := 'DATA : ' + Qr_Pedido.FieldByname('DATA').AsString + ' - ' + Copy(TimeToStr(Now),1,5);
      textoutLc(lc_I,107,Lc_TExto);
      lc_I := lc_I + 1;
      Lc_Texto := Copy('Vendedor..: ' + Qr_Pedido.FieldByname('CLB_NOME').AsString,1,100);
      TextOutLC(lc_I,1,Lc_Texto);
      lc_I := lc_I + 1;
      lc_I := lc_I + 1;

      TextOutLC(lc_I,1,'Endereco');
      TextOutLC(lc_I,12,'Quantidade');
      TextOutLC(lc_I,23,'Lote');
      TextOutLC(lc_I,38,'Vencto');
      TextOutLC(lc_I,46,'Cod.');
      TextOutLC(lc_I,52,'Descricao das Mercadorias');
      TextOutLC(lc_I,107,'Marca');
      TextOutLC(lc_I,119,'Obs');
      //Traco Especifico
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'----------');
      TextOutLC(lc_I,12,'----------');
      TextOutLC(lc_I,23,'--------------');
      TextOutLC(lc_I,38,'-------');
      TextOutLC(lc_I,46,'-----');
      TextOutLC(lc_I,52,'------------------------------------------------------');
      TextOutLC(lc_I,107,'-----------');
      TextOutLC(lc_I,119,'-------------');

      Lc_Tl_Qtde := 0;
      Qr_Itens.First;
      While not Qr_Itens.EOF do
        BEGIN
        Lc_Tl_Qtde := Lc_Tl_Qtde + Qr_Itens.FieldByname('ITF_QTDE').AsFloat;
        if (lc_contador > 0) then
          Begin
          lc_I := lc_I + 1;
          lc_contador := lc_contador - 1;
          TextOutLC(lc_I,1,Copy(Qr_Itens.FieldByname('PRO_LOCAL').AsString,1,10));
          TextOutLC(lc_I,12,Padr( FormatFloat('#0.###', Qr_Itens.FieldByname('ITF_QTDE').Value),10));
            //Lote
            Qr_Lote.Active := False;
            Qr_Lote.ParamByName('ITF_CODIGO').AsInteger := Qr_Itens.FieldByname('ITF_CODIGO').AsInteger;
            Qr_Lote.Active := true;
          TextOutLC(lc_I,23,Copy(Qr_Lote.FieldByname('CLT_NUMERO').AsString,1,14));//LOTE
          TextOutLC(lc_I,38,Copy(Qr_Lote.FieldByname('CLT_DT_VENCIMENTO').AsString,4,7)); //VENCIMENTO
          TextOutLC(lc_I,46,Copy(Qr_Itens.FieldByname('ITF_CODPRO').AsString,1,5));
          TextOutLC(lc_I,52,Copy(Qr_Itens.FieldByname('PRO_DESCRICAO').AsString,1,53));
          TextOutLC(lc_I,107,Copy(Qr_Itens.FieldByname('MRC_DESCRICAO').AsString,1,11));
          TextOutLC(lc_I,119,'-------------');
          Qr_Itens.Next;
          end
        else
          Begin
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
          lc_I := lc_I + 1;
          TextOutLC(lc_I,1,'                                                                    CONTINUA...');
          lc_I := lc_I + 2;
          lc_contador := Lc_ItensPP + 4;
          end;
        END;

      if (lc_contador < 4) then
        Begin
          for lc_J:=0 to lc_contador do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
        TextOutLC(lc_I,1,'-------------------------------------------------------------------------------');
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,'                                                                    CONTINUA...');
        lc_I := lc_I + 2;
        end
      else
        Begin
        if (lc_contador >= 6) then
          for Lc_J:=1 to (lc_contador - 4) do
            Begin
            lc_I := lc_I + 1;
            TextOutLC(lc_I,1,'');
            end;
        end;
      //Imprimi o Rodape
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,Lc_Traco);
      lc_I := lc_I + 1 ;
      TextOutLC(lc_I,1,'Total de Itens:' + IntToStr(Qr_Itens.RecordCount));
      TextOutLC(lc_I,66,'Total de Quantidades:' + FloatToStrF(Lc_Tl_Qtde,ffFixed,10,2));
      lc_I := lc_I + 2 ;
      TextOutLC(lc_I,1,'Obs.:');
      //Verifica se tem mais observação
      IF trim(Qr_Pedido.FieldByname('PED_OBS').AsString) <> '' then
        It_Observacao.Lines.Add(Qr_Pedido.FieldByname('PED_OBS').AsString);
      for Lc_II := 5 to It_Observacao.Lines.Count -1 do
        Begin
        lc_I := lc_I + 1;
        TextOutLC(lc_I,1,Copy(It_Observacao.Lines.Strings[Lc_II],1,130));
        end;

      //Usuarios envolvidos na conferenncia
      lc_I := lc_I + 4;
      TextOutLC(lc_I,1,'--------------------------  -------------------------- --------------------------');
      lc_I := lc_I + 1;
      TextOutLC(lc_I,1,'        SEPARADOR                    CONFERENTE                EMBALADOR       '); 
      end;
      If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
        begin
        Lc_Prin.Eject;
        end
      else
        begin
        For Lc_II := 1 to (StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE VENDA','VDA_P_SALTO',''),2)+1) do
          Begin
          Inc(Lc_I);
          Lc_Prin.TextOutLC(Lc_I,1,'');
          end;
        end;

      Lc_Prin.Finalize;
      FreeAndNil(Lc_Prin);
  except
      If (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_EJECTA','S') = 'S') then
        Lc_Prin.Eject;
      Lc_Prin.Finalize;
      FreeAndNil(Lc_Prin);
      Exit;
  end;
end;

function TimpModImpressao.GeraDadosComissao(Parametros:TParamComissao):TSTQuery;
VaR
  SqlTxt:String;
  Lc_Usuario:Boolean;
Begin

  Result := TSTQuery.Create(nil);
  With Result,Parametros Do
  begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    Close;
    SQL.Clear;
    SqlTxt:='SELECT COM_CODIGO, COM_DT_VENDA, COM_CODPED,PED_NUMERO, COM_CODEMP, EMP_NOME,  COM_CODVDO, '+
            'CLB_NOME, COM_VL_DOC, COM_AQ_COM, COM_VL_COM, COM_DT_PAGTO, CLB_CODIGO '+
            'FROM TB_COMISSAO Tb_comissao '+
            '    INNER JOIN TB_EMPRESA Tb_empresa '+
            '    ON  (Tb_empresa.EMP_CODIGO = Tb_comissao.COM_CODEMP) '+
            '    INNER JOIN TB_COLABORADOR Tb_Colaborador '+
            '    ON  (Tb_Colaborador.CLB_CODIGO = Tb_comissao.COM_CODVDO) '+
            '    INNER JOIN TB_PEDIDO Tb_pedido '+
            '    ON  (Tb_pedido.PED_CODIGO = Tb_comissao.COM_CODPED) '+
            'WHERE (COM_CODIGO IS NOT NULL) AND (COM_CODMHA=:COM_CODMHA) ';

    if CodigoVendedor > 0 then
      SqlTxt := SqlTxt +'AND COM_CODVDO =:COM_CODVDO ';
    if Periodo then
      SqlTxt := SqlTxt +'AND COM_DT_VENDA BETWEEN :DATAINI AND :DATAFIM  ';

    if SituacaoComissao <> '' then
    Begin
      if SituacaoComissao ='PAGA' then
        SqlTxt := SqlTxt + 'AND COM_DT_PAGTO IS NOT NULL '
      else
        SqlTxt := SqlTxt + 'AND COM_DT_PAGTO IS NULL ';
    End;

    SqlTxt := SqlTxt + Ordenacao;

    SQL.Add(SqlTxt);

    //Passagem de Parametros
    if CodigoVendedor > 0 then
      ParamByName('COM_CODVDO').AsInteger := CodigoVendedor;

    if Periodo then
    Begin
      ParamByName('DATAINI').AsDate:= DataInicial;
      ParamByName('DATAFIM').AsDate:= DataFinal;
    End;

    ParamByName('COM_CODMHA').AsInteger := CodigoEstabelecimento;
  end;
  Result.Active := True;
  Result.FetchAll;
end;


procedure TimpModImpressao.PrintComissaoMotoboy(Parametros:TParamComissao);
Var
  Lc_Prin:TPrin;
  lc_I:Integer;
  Lc_K : Integer;
  Lc_Salto:Integer;
  Lc_Linha : Integer;
  Lc_ColunaImpressao : Integer;
  QryDados : TSTQuery;
  Lc_Valor : REal;
Begin
  try
    Lc_Prin := TPrin.Create(self);
    QryDados := GeraDadosComissao(Parametros);
    With Lc_Prin, QryDados Do
    begin
      It_Porta := Fc_Aq_Geral('L','IMPRESSAO','PORTA','LPT1');
      Initialize(It_Porta);
      Lc_Linha := 0;
      Lc_ColunaImpressao := StrToIntDef( Fc_Aq_Geral('L','CONTROLE DE CUPOM','CPM_NR_COLUNAS', ''),40);
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('RELAÇÃO DE PEDIDOS',Lc_ColunaImpressao,' '));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('',Lc_ColunaImpressao, '-'));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,copy('COLABORADOR  :' + FieldByName('CLB_NOME').AsString,1,Lc_ColunaImpressao));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,copy('DATA         :' + FieldByName('COM_DT_VENDA').AsString,1,Lc_ColunaImpressao));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('',Lc_ColunaImpressao, '-'));
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,'PEDIDO ');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 10,'VALOR');
      lc_I:=1;
      First;
      Lc_Valor := 0;
      For Lc_I:= 1 to RecordCount do
      Begin
        //Imprime item e descrição
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,copy(FieldByName('PED_NUMERO').AsString,1,Lc_ColunaImpressao - 10));
        TextOutLC(Lc_Linha,Lc_ColunaImpressao - 10,PAdr(FloatToStrF(FieldByName('COM_VL_COM').AsCurrency,ffFixed,10,2),10));
        Lc_Valor := Lc_Valor + FieldByName('COM_VL_COM').AsCurrency;
        Next;
      end;
      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,1,CentralizaTexto('',Lc_ColunaImpressao, '-'));

      Lc_Linha := Lc_Linha + 1;
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 22,'TOTAL.....:');
      TextOutLC(Lc_Linha,Lc_ColunaImpressao - 10,PAdr(FloatToStrF(Lc_Valor,ffFixed,10,2),10));

      //sALTO
      Lc_Salto := StrToIntDef(Fc_Aq_Geral('L','IMPRESSAO','SALTO','0'),3);
      For Lc_K :=1 to Lc_Salto do
      Begin
        Lc_Linha := Lc_Linha + 1;
        TextOutLC(Lc_Linha,1,'');
      end;
      Reset;
      Finalize;
    end;
  finally
    FreeAndNil(Lc_Prin);
    QryDados.Close;
    FreeAndNil(QryDados);
  end;
end;






procedure TImpModImpressao.setFCodigoConsumidor(const Value: Integer);
begin
  FCodigoConsumidor := Value;
end;

procedure TImpModImpressao.setFCodigoPedido(const Value: Integer);
begin
  FCodigoPedido := Value;
end;

procedure TImpModImpressao.setFNomePDF(const Value: String);
begin
  FNomePDF := Value;
end;

procedure TImpModImpressao.setFSalvaPDF(const Value: Boolean);
begin
  FSalvaPDF := Value;
end;

//===============================================================================
procedure TImpModImpressao.ImpModuloGarantiaEletronicos(OrderID:Integer);
Var
  Lc_Form : TFrxWarrantyTermEletcEquip;
begin
  TRY
    Lc_Form := TFrxWarrantyTermEletcEquip.create(nil);
    //Lc_Form.Parametros := getParametros;
    Lc_Form.Caption := 'TERMO DE GARANTIA';
    Lc_Form.CodigoPedido := OrderID;
    Lc_Form.buscar;
    Lc_Form.frxBase.ShowReport;
  Finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TImpModImpressao.ImpModuloOrdemEletronicos(OrderID:Integer);
Var
  Lc_Form : TFrxOrderServiceEletcEquip;
begin
  TRY
    Lc_Form := TFrxOrderServiceEletcEquip.create(nil);
    //Lc_Form.Parametros := getParametros;
    Lc_Form.Caption := 'ORDEM DE SERVICO';
    Lc_Form.CodigoPedido := OrderId;
    Lc_Form.buscar;
    Lc_Form.frxBase.ShowReport;
  Finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TImpModImpressao.ImpModuloOrdemFurniture(OrderID: Integer);
Var
  Lc_Form : TFrxOrderServiceFurniture;
begin
  TRY
    Lc_Form := TFrxOrderServiceFurniture.create(nil);
    //Lc_Form.Parametros := getParametros;
    Lc_Form.Caption := 'ORDEM DE SERVICO';
    Lc_Form.CodigoPedido := OrderId;
    Lc_Form.buscar;
    Lc_Form.frxBase.ShowReport;
  Finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TimpModImpressao.ImprimeCupom(c:TStringList);
VAR
  Print : TGeneralPrint;
  I : Integer;
  Lc_Porta : String;
  Lc_Prin : TPrin;
Begin
  Lc_Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_PORTA', '');
  if UpperCase( Lc_porta ) = 'USB' then
  Begin
    try
      Print := TPrintGeneralFactory.criarPrint('BEMATECH - MP4200');
      with  Print do
      Begin
        Porta := Lc_Porta;
        TamanhoMargem := 3;
        Iniciar;
        for I := 0 to c.Count - 1 do
          TextOutLC(I+1,1,c.Strings[I]);
        CortarPapel(0);
        Fechar;
      End;
    finally
      FreeAndNil(Print);
    end;
  End
  else
  Begin
    try
      Lc_Prin := TPrin.Create(nil);
      With Lc_Prin Do
      begin
        Porta := Lc_Porta;
        Initialize(Lc_Porta);
        for I := 0 to c.Count - 1 do
          TextOutLC(I+1,1,c.Strings[I]);
        Reset;
        Finalize;
      end;
    finally
      FreeAndNil(Lc_Prin);
    end;
  End;
END;

function TImpModImpressao.ImprimeProgramaCartaoPrePago(ColunaImpressao,
  CodigoCliente: Integer): TStringList;
var
  lCPrepago : TControllerPrePaidCard;
  Lc_SaldoPrePago : Real;
begin
  Result := TStringList.Create;
  //PROGRAMA CARTÃO PRE-PAGO
  if CodigoConsumidor <> Qr_Pedido.FieldByName('EMP_CODIGO').AsInteger then
  Begin
    Try
      lCPrepago := TControllerPrePaidCard.create(nil);
      lCPrepago.Parametros.PrePago.Estabelecimento := Gb_CodMha;
      lCPrepago.Parametros.PrePago.Numero := Qr_Pedido.FieldByname('EMP_CNPJ').AsString;
      Lc_SaldoPrePago := lCPrepago.getSaldo;
      if (Lc_SaldoPrePago > 0  ) then
      Begin
        Result.Append(Pc_AlinhaC('CARTÃO PRE-PAGO',ColunaImpressao));
        Result.Append(Pc_AlinhaC( 'Saldo de R$ '+ FloatToStrF(Lc_SaldoPrePago,ffFixed,10,2) ,ColunaImpressao));
      End;
    Finally
      FreeAndNil(lCPrepago);
    End;
  End;

end;

function TImpModImpressao.ImprimeProgramaPayBack(ColunaImpressao:Integer; CodigoCliente:Integer):TStringList;
Var
  LcPayBackTaxa: REal;
  LcPayBackMinimo : REal;
  LcPayBackAcumul : REal;
  LcPayBack : TControllerPayBack;
  LcUsouPayPack : Boolean;
  lcValorPayBAck : Real;
begin
  //PROGRAMA PAYBACK
  Result := TStringList.Create;
  if CodigoConsumidor <> Qr_Pedido.FieldByName('EMP_CODIGO').AsInteger then
  Begin
    if ( Fc_Tb_Geral('L','PAYBACK_IMP_CREDIT','S') = 'S') then
    Begin
      LcPayBackTaxa   := StrToFloatDef(Fc_Tb_Geral('L','PAYBACK_TAXA','0'),0);
      if (  LcPayBackTaxa > 0 ) then
      Begin
        try
          LcPayBack := TControllerPayBack.create(nil);
          LcPayBackMinimo := StrToFloatDef( Fc_Tb_Geral('L','PAYBACK_VL_MINIMO','0'),0);
          LcPayBack.Parametros.Periodo := False;
          LcPayBack.Parametros.PayBack.Cliente := Qr_Pedido.FieldByName('EMP_CODIGO').AsInteger;
          LcPayBack.Parametros.PayBack.estabelecimento := DM.Qr_Estabelecimento.FieldByname('EMP_CODIGO').AsInteger;
          LcPayBack.Parametros.PayBack.Ordem := 0;
          LcPayBackAcumul := LcPayBack.getSaldo;

          Result.Append(Pc_AlinhaC(Fc_Tb_Geral('L','PAYBACK_TITTLE','0'),ColunaImpressao));
          Result.Append(Pc_AlinhaC(CONCAT('A CADA COMPRA VOCE PODE GANHAR ', FloatToStrF(LcPayBackTaxa,ffFixed,10,1) ,'% DE RETORNO'),ColunaImpressao));
          Result.Append(Pc_AlinhaC(CONCAT('JUNTANDO UM VALOR MINIMO DE R$ ', FloatToStrF(LcPayBackMinimo,ffFixed,10,2)),ColunaImpressao));
          Result.Append(Pc_AlinhaC('VOCE PODE UTILIZAR COMO DESCONTO NA SUA',ColunaImpressao));
          Result.Append(Pc_AlinhaC('PROXIMA COMPRA COM A GENTE',ColunaImpressao));
          Result.Append(Pc_AlinhaC( 'Saldo de R$ '+ FloatToStrF(LcPayBackAcumul,ffFixed,10,2) ,ColunaImpressao));
        finally
          FreeAndNil(LcPayBack);
        end;
      End;
    End;
  End;
end;

function TimpModImpressao.TextoCentralizado(Fc_Texto:String; fc_Coluna:Integer;Fc_Extra:String):String;
Var
  Lc_I : Integer;
  Lc_Final : Real;
  Lc_string : String;
Begin
  //Nome a ser impresso no cupom
  Lc_string := Fc_Texto;
  Lc_Final := ((fc_coluna -Length(Lc_string))/2) - 2;
  Lc_string := '';
  For Lc_I := 1 to Floor(Lc_Final) do
    Lc_string := Lc_string + Fc_Extra;
  Lc_string := Lc_string + ' ' + Fc_Texto + ' ';
  For Lc_I := 1 to (fc_coluna-Length(Lc_string)) do
      Lc_string := Lc_string + Fc_Extra;
  Result := Lc_string;
end;

end.



