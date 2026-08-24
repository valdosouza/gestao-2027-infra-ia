unit UN_Fatura_Vda;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ControllerBase, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, System.Math, Vcl.ExtCtrls, tributacao, AcbrBoleto, ACBrBoletoFCFortesFr, ControllerCtrlLote, Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.DBCtrls, QEdit_Setes, ControllerItensNFL, ControllerBoletoBancario;


type
   TFr_Fatura_Vda = class(TForm)
    Panel4: TPanel;
    Pg_Resumo: TPageControl;
    TabSheet1: TTabSheet;
    Panel5: TPanel;
    Label22: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label1: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label37: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label39: TLabel;
    E_Vl_Bs_Icms_St: TEdit_Setes;
    E_Vl_Icms_St: TEdit_Setes;
    E_Vl_Seguro: TEdit_Setes;
    E_Vl_Outras: TEdit_Setes;
    E_VL_Produto: TPanel;
    E_VL_ICMS: TEdit_Setes;
    E_VL_Bs_ICMS: TEdit_Setes;
    E_VL_IPI: TEdit_Setes;
    E_VL_Frete: TEdit_Setes;
    E_VL_Servico: TPanel;
    E_VL_Nota: TPanel;
    E_Qt_Produto: TEdit_Setes;
    E_Especie: TEdit;
    E_PesoLiq: TEdit_Setes;
    E_PesoBruto: TEdit_Setes;
    E_PlacaVeiculo: TMaskEdit;
    E_RNTC: TEdit;
    E_Marca: TEdit;
    E_vol_Numero: TEdit;
    E_Vl_desconto: TPanel;
    E_Uf_Veiculo: TDBLookupComboBox;
    Tbs_TpFaturamento: TTabSheet;
    Panel6: TPanel;
    Rg_Faturamento: TRadioGroup;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    E_Dt_Saida: TDateTimePicker;
    E_Dt_Emissao: TDateTimePicker;
    chbx_data_saida: TCheckBox;
    GroupBox5: TGroupBox;
    Sb_Transportadora: TSpeedButton;
    Label2: TLabel;
    Label5: TLabel;
    DBLCB_Transportadora: TDBLookupComboBox;
    Dblcb_Modal_Frete: TDBLookupComboBox;
    Panel3: TPanel;
    Label3: TLabel;
    ChBx_AutorizacaoNFE: TCheckBox;
    pnl_botao: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    PrintDialog1: TPrintDialog;
    Qr_Orcamento: TSTQuery;
    Ds_Moral_Frete: TDataSource;
    TabSheet2: TTabSheet;
    Panel7: TPanel;
    GroupBox14: TGroupBox;
    E_PortaImpressao_dsp: TEdit;
    E_SaltoImpressao_dsp: TEdit_Setes;
    Chbx_ICMS: TCheckBox;
    Chbx_SomaIPI_Bs_ICMS: TCheckBox;
    Chbx_SomaIPI_Bs_ICMS_St: TCheckBox;
    Pg_OBs: TPageControl;
    Tbs_Obs_Produto: TTabSheet;
    Tbs_Obs_Servico: TTabSheet;
    E_Obs: TMemo;
    E_Obs_Servico: TMemo;
    Sb_Pesq_Transportadora: TSpeedButton;
    chbx_Mva_Original: TCheckBox;
    ChBx_ListaNcm: TCheckBox;
    AcaoMostra: TActionList;
    Action1: TAction;
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBLCB_TransportadoraKeyDown(Sender: TObject; var Key: Word;
       Shift: TShiftState);
    procedure Sb_TransportadoraClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure chbx_data_saidaClick(Sender: TObject);
    procedure E_Qt_ProdutoChange(Sender: TObject);
    procedure Sb_Pesq_TransportadoraClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
    { Private declarations }
    //Verifica se é usuario de Nfe
    It_Usa_Nfe : Boolean;
    Tributacao : ttributacao;
    SaveLastConfig :  TThread;
    FCodigoDestinatario: Integer;
    procedure setFCodigoDestinatario(const Value: Integer);
    procedure ChamaTelaAutorizacao;
    procedure LancaDespacho;
   public
    { Public declarations }
    CtrlLote : TControllerCtrlLote;
    it_fatura_ok : Boolean;
    It_Nr_Pedido: String;
    It_Cd_Pedido: Integer;
    It_Dt_Entrega : TDate;
    It_Vl_Devolucao: Currency;
    procedure Pc_AtivarTabela;
    procedure Pc_GravaUltimasConfiguracoes;
    function Fc_Faturar_Normal():Boolean;
    procedure Pc_ImprimeCupom;
    function Fc_ConfirmaValores(): boolean;
    procedure Pc_FormataTela;

    procedure Pc_ImagemBotao;
    //Novo FAturamento
    procedure Pc_Inicia_Variaveis;
    procedure Pc_CarregaComponenteTributacao;
    function Fc_ValidaFaturamento(): Boolean;
    procedure Pc_Faturar;
    procedure Pc_Gera_Financeiro;
    procedure Pc_Gera_FinanceiroManual;
    procedure Pc_Gera_FinanceiroAutomatico;

    function ValidaGeraroBoletoAutomatico:Boolean;
    procedure GeraroBoletoAutomatico;

    procedure Pc_Atualiza_Itens_Devolucao;
    procedure Pc_Gera_Comissao;
    procedure Pc_ImpressaoAutomaticaBoleto(Pc_cd_Pedido:Integer);
    property CodigoDestinatario : Integer read FCodigoDestinatario write setFCodigoDestinatario;
   end;
var
   Fr_Fatura_Vda: TFr_Fatura_Vda;

implementation


uses
Un_DM, Un_Msg, Un_Funcoes, UN_Sistema, Un_Clta_Csto, Un_MinhaEmpresa, un_Padrao, Un_Fc_Comissao, Un_Fc_Sored_Procedures, Un_Imp_Mod_Impressao, Un_Regra_Negocio, Un_Transportadora, Un_Liberacao, RN_Cliente, RN_NotaFiscal, UN_Principal, env, RN_Inventario, RN_Estoque, RN_PlanoContas, Un_WebService, RN_Transportadora, RN_FormaPagto, RN_BoletoEletronico, RN_Permissao, Un_Fatura_Fin, RN_Pedido, RN_Financeiro, RN_NotaFiscalEletronica3X, RN_Crud, UN_TabelasEmListas, RN_NotaFiscalServico, RN_Empresa, ControllerFinanceiro, UN_NF, un_geranfe_vda, controllerDespacho;

{$R *.dfm}

procedure TFr_Fatura_Vda.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
    CarregaImagemBotao(SB_Sair_0,'SAIR');
  END;
end;


procedure TFr_Fatura_Vda.Pc_Atualiza_Itens_Devolucao;
Var
  Lc_Qry : TSTQuery;
  LcItens : TControllerItensNFl;
BEgin
  Try
    LcItens := TControllerItensNFl.Create(nil);
    Lc_Qry := LcItens.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT ITF_CODIGO, ITF_CODPRO, ITF_QTDE, ITF_VL_CUSTO, ITF_VL_UNIT, '+
              'ITF_CODEST, ITF_CODTPR                                              '+
              'FROM TB_ITENS_NFL '+
              'WHERE (ITF_CODPED=:ITF_CODPED) AND (ITF_OPER=''D'') ') ;
      ParamByName('ITF_CODPED').AsInteger := It_Cd_Pedido;
      Active := True;
      FetchAll;
      First;
      while  not Eof do
      begin
        LcItens.Registro.Codigo := FieldByName('ITF_CODIGO').AsInteger;
        LcItens.Registro.CodigoNota := Tributacao.NotaFiscal.Registro.Codigo;
        LcItens.Registro.ValorCusto := FieldByName('ITF_VL_CUSTO').AsCurrency;
        LcItens.Registro.Sentido := 'E';
        LcItens.Registro.ImpostoAproximado := 0;
        LcItens.atualizaFaturamento;
        Next;
      end;
    end;
  finally
    LcItens.FinalizaQuery(Lc_Qry);
  end;
end;

procedure TFr_Fatura_Vda.Pc_FormataTela;
Begin
  E_Vl_desconto.ParentColor := False;
  E_Vl_desconto.Color := clRed;
  Pg_OBs.ActivePage := Tbs_Obs_Produto;
  Tbs_Obs_Servico.TabVisible := (Fc_Tb_Geral('L','OSR_G_ATIVAR','S') = 'S');
end;

procedure TFr_Fatura_Vda.Pc_Inicia_Variaveis;
Begin
  //CONFIGURAÇÕES DA NFE
  It_Usa_Nfe := Fc_VerificaFormularioDisponivel('Fr_GeraNFe');
  If It_Usa_Nfe then
  Begin
    ChBx_AutorizacaoNFE.Enabled := True;
    ChBx_AutorizacaoNFE.State := cbChecked;
  end
  else
  Begin
    ChBx_AutorizacaoNFE.Enabled := False;
    ChBx_AutorizacaoNFE.State := cbUnchecked;
  end;

  Pg_Resumo.ActivePageIndex := 0;
  //Frete
  Dblcb_Modal_Frete.KeyValue := DM.Qr_Modal_Frete.FieldByName('MDF_CODIGO').AsInteger;

  //Observação do Veiculo
  if (Fc_Tb_Geral('L','OSR_G_OBS_VEICULO_NF','S') = 'S') then
    E_Obs.Lines.Add(Fc_ObsVeiculoNotaFiscal(It_Cd_Pedido));

  E_Especie.Text:='VOLUME';
  E_Dt_Emissao.Date := Date;
  E_Dt_Saida.Date := Date;
  Dblcb_Modal_Frete.KeyValue := StrToIntDef(Fc_Tb_Geral('L', 'FAT_TIPOFRETE', '0'),0);
  Rg_Faturamento.ItemIndex := DM.Qr_Estabelecimento.FieldByname('EMP_TIP_FAT').AsInteger;

  E_PortaImpressao_dsp.Text := Fc_Tb_Geral('L', 'FAT_PATHETIQUETA', 'LPT1');
  E_SaltoImpressao_dsp.Text := Fc_Tb_Geral('L', 'FAT_SALTOETIQUETA', '1');
  E_Obs_Servico.Clear;
end;

procedure TFr_Fatura_Vda.Pc_AtivarTabela;
begin
  DM.Qr_UF.Active := true;
  DM_ListaConsultas.Pc_ListaTranportadoras('EMP_NOME');
  DM.Qr_Modal_Frete.Active := true;
  Pc_AtivaEstabelecimento;
end;

function TFr_Fatura_Vda.fc_ValidaFaturamento(): Boolean;
Var
  Lc_Aux : String;
begin
  Result:=true;

  if Tributacao.NotaFiscal.Pedido.InconsistenciaFaturado(true) then
  BEgin
    Result := FAlse;
    Self.close;
  end;

  //Verifica Inventario
  if not Fc_ValidaDataPedido(E_Dt_Emissao.Date) then
  Begin
    Result := FAlse;
    E_Dt_Emissao.SetFocus;
    E_Dt_Emissao.Date := Date;
    Exit;
  end;

  If It_Usa_Nfe then
  begin
    if (Trim(Dblcb_Modal_Frete.Text) = '') then
    begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Modalidade de frete não foi preenchida.' + EOLN +
                   ' Favor preencher e tentar novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
    end;
  end;

  If It_Usa_Nfe then
  Begin
    IF NOT Tributacao.Fc_Valida then
    Begin
      Result := False;
      exit;
    end;
  end;

  if not FC_Valida_produto(Tributacao.Qr_ItensPedido) then
  Begin

    Result := False;
    exit;
  end;

  if (Fc_Tb_Geral('L','VDA_VALIDA_TRANSP_FAT','N') = 'S') then
    begin
    if (DBLCB_Transportadora.KeyValue < 0) then
      begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Transportadora não escolhido.' + EOLN +
                   'Preenchar a Transportadora.' + EOLN,
                   ['OK'], [bEscape], mpErro);
      Result := False;
      exit;
      end;
    end;

    //Faz auditoria no pedido para garantir que os itens estão na movimentação do estoque
    //Fc_AuditoriaEstoquePedido(It_Cd_Pedido,'N');

    //Grava dados da tela atual
    Pc_GravaUltimasConfiguracoes;

end;



procedure TFr_Fatura_Vda.Pc_ImprimeCupom;
Var
  Lc_Imp: TimpModImpressao;
begin
  if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_TP_CUPOM_FAT','')) = 'S' then
  Begin
    Try
      Lc_Imp := TimpModImpressao.create(nil);
      Qr_Orcamento.Active := False;
      Qr_Orcamento.ParamByName('CTC_CODPED').AsInteger := It_Cd_Pedido;
      Qr_Orcamento.Active := True;
      Qr_Orcamento.FetchAll;
      if Qr_Orcamento.RecordCount > 0 then
        Lc_Imp.It_Tp_Doc:='ORC - '
      else
        Lc_Imp.It_Tp_Doc:='PEDIDO: ';
      Lc_Imp.CodigoPedido := It_cd_Pedido;
      Lc_Imp.Pc_Imp_Cupom;
    finally
      FreeAndNil(Lc_Imp);
    end;
  end;
end;


procedure TFr_Fatura_Vda.Pc_GravaUltimasConfiguracoes;
Begin
  SaveLastConfig := TThread.CreateAnonymousThread(
    procedure
    begin
      If Trim(Dblcb_Modal_Frete.Text) <> '' then
        Fc_Tb_Geral('G', 'FAT_TIPOFRETE', IntToStr(Dblcb_Modal_Frete.KeyValue))
      else
        Fc_Tb_Geral('G', 'FAT_TIPOFRETE', '0');

      Fc_Tb_Geral('G', 'FAT_PATHETIQUETA', E_PortaImpressao_dsp.Text);
      Fc_Tb_Geral('G', 'FAT_SALTOETIQUETA', E_SaltoImpressao_dsp.Text);
      SaveLastConfig.terminate;
    end
  );
  SaveLastConfig.FreeOnTerminate := True;
  SaveLastConfig.Start;
end;


procedure TFr_Fatura_Vda.Pc_Gera_Comissao;
Begin
  Try
    //Geração de Comissão
    Pc_Construtor_Comissao(DM.IBT_Faturamento);
    Pc_Deleta_Vdo_Pedido(DM.IBT_Faturamento,It_Cd_Pedido,0,'');
    Pc_Registra_Vdo_Pedido(DM.IBT_Faturamento, It_Cd_Pedido);
    if Fc_Tb_Geral('L','TP_COMISSAO','') ='F' then
    Begin
      Pc_Gerar_Comissao_Vda_Fat(DM.IBT_Faturamento, It_Cd_Pedido);
      Pc_Gerar_Comissao_Srv_Fat(DM.IBT_Faturamento, It_Cd_Pedido);
      Pc_Gerar_Comissao_Srv_Vdo_Fat(DM.IBT_Faturamento, It_Cd_Pedido);
    end;
  Finally
    Pc_Destrutor_Comissao;
  End;
end;

procedure TFr_Fatura_Vda.Pc_Faturar;
Begin
  it_fatura_ok := true;
  Pc_Define_FormatoRegional;
  Pc_AtivaEstabelecimento;
  if Rg_Faturamento.ItemIndex = 0  then
    it_fatura_ok := Fc_Faturar_Normal;
  if it_fatura_ok then
  Begin
    //Processo de devolução
    if Rg_Faturamento.ItemIndex = 0  THEN
      if (Fc_Tb_Geral('L','GRL_G_TAR_DEVOLUCAO','S') = 'S') then Pc_Atualiza_Itens_Devolucao;
    //Processo de Comissão
    Pc_Gera_Comissao;
    //Verifica se o controle de de Despacho está ativado
    if (Fc_Tb_Geral('L','DSP_G_CTRL_DESPACHO','') = 'S')  then
    begin
      Tributacao.NotaFiscal.Pedido.Despacho.Registro.pedido := Tributacao.NotaFiscal.Pedido.Registro.Codigo;
      if not Tributacao.NotaFiscal.Pedido.Despacho.DespachoLancado then
        LancaDespacho;
    end;
    //Impressão do cupom não fiscal
    Pc_ImprimeCupom;
    //Atualiza os numeros de Serie
    Tributacao.NotaFiscal.AtualizaSeries('N',Tributacao.Qr_ItensPedido);
    //Gera Processo financeiro
    if (Fc_Tb_Geral('L','FIN_G_ATIVAR','') = 'S') then
    Begin
      Pc_Gera_Financeiro;
      if ValidaGeraroBoletoAutomatico then
      Begin
        GeraroBoletoAutomatico;
      End;

    end;
    //Chama a tela de autorização da nota fiscal eltronica
    if ChBx_AutorizacaoNFE.Checked then
      chamaTelaAutorizacao;

    It_Cd_Pedido := 0;
    Close;
  end
  else
  Begin
    Pc_GravaUltimasConfiguracoes;
    It_Fatura_Ok := False;
    //Close;
  end;
end;



procedure TFr_Fatura_Vda.Pc_Gera_Financeiro;
begin
  IF ( Fc_Tb_Geral('L','FIN_MOSTRA_FATURAMENTO','S') = 'S') then
  Begin
    Pc_Gera_FinanceiroManual;
  End
  else
  Begin
    Pc_Gera_FinanceiroAutomatico;
  End;
end;

procedure TFr_Fatura_Vda.Pc_Gera_FinanceiroManual;
var
  Lc_Form : TFr_Fatura_fin;
Begin
  Try
    Lc_Form := TFr_Fatura_fin.Create(nil);
    Lc_Form.It_Confirma := False;
    Lc_Form.It_cd_Nota := Tributacao.NotaFiscal.Registro.Codigo;
    Lc_Form.It_Tipo_Finaceiro := 'RA';
    Lc_Form.It_Oper_Financeiro := 'C';
    Lc_Form.It_Hist_Caixa := 'VENDA Nº ';
    Lc_Form.ShowModal;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_Fatura_Vda.Pc_Gera_FinanceiroAutomatico;
var
  Lc_Form : TFr_Fatura_fin;
Begin
  Try
    Lc_Form := TFr_Fatura_fin.Create(nil);
    Lc_Form.It_Confirma := False;
    Lc_Form.It_cd_Nota := Tributacao.NotaFiscal.Registro.Codigo;
    Lc_Form.It_Tipo_Finaceiro := 'RA';
    Lc_Form.It_Oper_Financeiro := 'C';
    Lc_Form.It_Hist_Caixa := 'VENDA Nº ';
    Lc_Form.Pc_AtivarTabelas;
    Lc_Form.Pc_FormataTela;
    Lc_Form.Pc_IniciaVariaveis;
    Lc_Form.Pc_MontaParcelamento;
    Lc_Form.Pc_AlinhaVerticalParcelamento;
    Lc_Form.Pc_TotalizarParcelamento;


    //Apaga o Parcelamento atual
    Lc_Form.Nota.Pedido.Parcelamento.Registro.CodigoPedido := Lc_Form.Nota.Registro.CodigoPedido;
    Lc_Form.Nota.Pedido.Parcelamento.deletebyPedido;
    //Grava os prazos na tela do pedido
    Lc_Form.Pc_GravaParcelamento;
    Lc_Form.Pc_Gera_Financeiro;
    Lc_Form.Pc_Obs_Financeira;

  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Fatura_Vda.SB_ConfirmarClick(Sender: TObject);
begin
  TRY
    Self.Enabled := False;
    Pc_ProcesoAguarde(Self,'I');
    Pc_CarregaComponenteTributacao;
    if fc_ValidaFaturamento then
    Begin
      Pc_Faturar;
    end;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Fatura_Vda.Sb_Pesq_TransportadoraClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(3,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    DBLCB_Transportadora.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
  end;
end;

procedure TFr_Fatura_Vda.SB_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Fatura_Vda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and  (not (ActiveControl is TMemo))  then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_Fatura_Vda.DBLCB_TransportadoraKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
      DBLCB_Transportadora.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Fatura_Vda.Sb_TransportadoraClick(Sender: TObject);
Var
  Lc_Form : TFr_Transportadora;
begin
  if DBLCB_Transportadora.text <> '' then
  Begin
    try
      Lc_Form := TFr_Transportadora.Create(nil);
      if (Trim(DBLCB_Transportadora.Text) <> '') then
        Lc_Form.Empresa.Registro.Codigo := DBLCB_Transportadora.KeyValue;
      Lc_Form.ShowModal;
    finally
      DM_ListaConsultas.Pc_ListaTranportadoras('EMP_NOME');
      DBLCB_Transportadora.KeyValue := Lc_Form.Empresa.Registro.Codigo;
      FreeAndNil(Lc_Form);
    end;
  End;

end;

procedure TFr_Fatura_Vda.setFCodigoDestinatario(const Value: Integer);
begin
  FCodigoDestinatario := Value;
end;

function TFr_Fatura_Vda.ValidaGeraroBoletoAutomatico: Boolean;
begin
  Result := True;
  if ( Fc_Tb_Geral('L','FIN_FAT_GER_AUTO_BOLETO','N') = 'N') then
  Begin
    Result := False;
    exit;
  End;


end;

procedure TFr_Fatura_Vda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// if Assigned(SaveLastConfig) then
//  begin
//    SaveLastConfig.Terminate;
//    SaveLastConfig.WaitFor;
//    FreeAndNil(SaveLastConfig);
//  end;
  FreeAndNil(Tributacao);
  FreeAndNil(CtrlLote);
end;

procedure TFr_Fatura_Vda.FormCreate(Sender: TObject);
begin
  Tributacao := ttributacao.create(Self);
  CtrlLote := TControllerCtrlLote.Create(Self);
end;

procedure TFr_Fatura_Vda.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if shift = [] then
   begin
      case Key of
         VK_F10: if SB_Confirmar.Enabled then
               SB_ConfirmarClick(Sender);
         VK_Escape: if SB_Sair_0.Enabled then
               SB_Sair_0Click(Sender);
      end;
   end;
end;


procedure TFr_Fatura_Vda.FormShow(Sender: TObject);
begin
  Pc_AtivarTabela;
  Pc_Inicia_Variaveis;
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_AtivarTabela;
end;



procedure TFr_Fatura_Vda.GeraroBoletoAutomatico;
Var
  Lc_Financeiro : TControllerFinanceiro;
  Lc_boleto : TControllerBoletoBancario;
  I : Integer;
begin
  Try
    Lc_Financeiro := TControllerFinanceiro.create(Self);
    Lc_Financeiro.Registro.CodigoNota := Tributacao.NotaFiscal.Registro.Codigo;
    Lc_Financeiro.getlistBoleto;
    if Lc_Financeiro.Lista.count > 0 then
    Begin
      Try
        Lc_boleto := TControllerBoletoBancario.Create(Self);
        //Depois vamos tratar para o cliente escolher qual Carteira....por hora somente o primeira conta que ele achar
        Lc_boleto.Config.getFirst;

        //Depois vamos tratar para o cliente escolher qual Conta Corrente....por hora somente o primeira conta que ele achar
        Lc_boleto.ContaCorrente.Registro.Codigo := Lc_boleto.Config.Registro.ContaCorrente;
        Lc_boleto.ContaCorrente.getById;

        for I := 0 to Lc_Financeiro.Lista.count -1 do
        Begin
          Lc_Financeiro.ClonarObj(Lc_Financeiro.Lista[I],Lc_Financeiro.Registro);
          Lc_Financeiro.Registro.CodigoQuitacao := Fc_GeraCod_BAixa;
          Lc_boleto.clear;
          with Lc_boleto.Registro do
          Begin
            Codigo := 0;
            CodigoEmpresa := Lc_Financeiro.Registro.CodigoEmpresa;
            //Numero := Lc_Financeiro.Registro.CodigoNota trocar por Numero da Nota
            //Numero := Lc_Financeiro.Registro.CodigoPedido trocar por Numero do Pedido
            Numero := Lc_Financeiro.Registro.CodigoQuitacao.toString;
            Data := Date;

            CodigoContaCorrente := Lc_boleto.ContaCorrente.Registro.Codigo;

            TaxaDesconto := Lc_boleto.Config.Registro.txDesconto;
            Baixado := 'N';
            Valor := Lc_Financeiro.Registro.ValorParcela;
            CodigoQuitacao := Lc_Financeiro.Registro.CodigoQuitacao;
            TaxaJuros := Lc_boleto.Config.Registro.TxJuros;
            TaxaMora := Lc_boleto.Config.Registro.TxMora;
            ValorMora := Lc_boleto.Config.Registro.VlMoraMin;

            if (Lc_boleto.Config.Registro.txDesconto > 0) then
            begin
              ValorDesconto := (Lc_Financeiro.Registro.ValorParcela * Lc_boleto.Config.Registro.txDesconto) / 100;
              DataDescVencimento := Lc_Financeiro.Registro.DataVencimento;
            end;
            TaxaMulta := Lc_boleto.Config.Registro.TxMulta;
            ValorTarifa := Lc_boleto.Config.Registro.VlTarifa;
            CodigoBoletoEletronica := Lc_boleto.Config.Registro.Codigo;
            DataVencimento := Lc_Financeiro.Registro.DataVencimento;
            DataProcessamento := Date;
            Aceite := Lc_boleto.Config.Registro.Aceite;
            Parcela := Lc_Financeiro.Registro.NumeroParcela.toString();
            Instrucao := Lc_boleto.Config.Registro.Instrucoes;
            CodigoRemessa := 0;
            CodigoRetorno := 0;
            Status := '0';
            NossoNumero := Lc_Financeiro.Registro.CodigoQuitacao.ToString();
            MensagemRetorno := 'Em Aberto';
            NumeroRemessa := 0;
            case StrToIntDef(Lc_boleto.Config.Registro.Protesto,0) of
              1..2 :Begin
                      DiasProtesto := Lc_boleto.Config.Registro.DiasProtesto;
                      DataProtesto := Lc_Financeiro.Registro.DataVencimento + Lc_boleto.Config.Registro.DiasProtesto;
                      case StrToIntDef(Lc_boleto.Config.Registro.Protesto,0) of
                        1:TipoDiaProtesto := 'C';
                        2:TipoDiaProtesto := 'U';
                      end;
                  end;
              else
                Begin
                  DiasProtesto := 0;
                  TipoDiaProtesto := 'N';
                End;
            end;
            if Lc_boleto.Config.Registro.Negativacao = SIM then
            Begin
              DataNegativacao := Lc_Financeiro.Registro.DataVencimento + Lc_boleto.Config.Registro.DiasNegativacao;
              DiasNegativacao := Lc_boleto.Config.Registro.DiasNegativacao;
            End
            else
            Begin
              DataNegativacao := 0;
              DiasNegativacao := 0;
            End;
          end;
          //Insere o boleto
          Lc_boleto.insere;
          //Destina no Financeiro
          Lc_Financeiro.Destinar;
         End;
      Finally
        FreeAndNil(Lc_boleto)
      End;
    End;
  Finally
    FreeAndNil(Lc_Financeiro);
  End;
end;

procedure TFr_Fatura_Vda.LancaDespacho;
Var
  Lc_Despacho : TControllerDespacho;
begin
  Lc_Despacho := TControllerDespacho.Create(Nil);
  Try
    if not Tributacao.Qr_ItensPedido.Active then Tributacao.Qr_ItensPedido.active := true;
    with Tributacao.Qr_ItensPedido do
    Begin
      First;
      while not eof do
      Begin
        Lc_Despacho.Clear;
        Lc_Despacho.Registro.Codigo       := 0;
        Lc_Despacho.Registro.ItemPedido   := FieldByName('ITF_CODIGO').asInteger;
        Lc_Despacho.Registro.DataPrevista := It_Dt_Entrega;
        Lc_Despacho.Registro.Qtde         := FieldByName('ITF_QTDE').asFloat;
        Lc_Despacho.Registro.Pedido       := FieldByName('ITF_CODPED').asInteger;
        Lc_Despacho.Registro.Produto      := FieldByName('ITF_CODPRO').asInteger;
        Lc_Despacho.Registro.Situacao     := 'P';
        Lc_Despacho.Registro.Impresso     := 'N';
        Lc_Despacho.Registro.Conferido    := 0;
        Lc_Despacho.Insert;
        Next;
      End;
    End;
  Finally
    FreeAndNil( Lc_Despacho );
  End;
end;

function TFr_Fatura_Vda.Fc_ConfirmaValores(): boolean;
begin
  Result  := True;
  If Pg_Resumo.ActivePageIndex <> 0 then Pg_Resumo.ActivePageIndex := 0;
  //Preenche os campos com os totais
  with Tributacao.It_Nfe.NotasFiscais[0].NFe do
  BEgin
    E_VL_Bs_ICMS.Text := FloatToStrF(Total.ICMSTot.vBC, ffFixed, 10, 2);
    E_VL_ICMS.Text := FloatToStrF(Total.ICMSTot.vICMS, ffFixed, 10, 2);
    E_Vl_Bs_Icms_St.Text := FloatToStrF(Total.ICMSTot.vBCST, ffFixed, 10, 2);
    E_Vl_Icms_St.Text := FloatToStrF(Total.ICMSTot.vST, ffFixed, 10, 2);
    if ( Total.ICMSTot.vST < 0 ) then
    begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     ' O valor do ICMS de Substituição Tributária' + EOLN +
                     'não pode estar negativo. Por favor Verifique!' + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      Result := False;
      Pc_AtivarTabela;
    end;
    E_VL_IPI.Text := FloatToStrF(Total.ICMSTot.vIPI, ffFixed, 10, 2);
    E_VL_FRETE.Text := FloatToStrF(Total.ICMSTot.vFrete, ffFixed, 10, 2);
    E_Vl_Seguro.Text := FloatToStrF(Total.ICMSTot.vSeg, ffFixed, 10, 2);
    E_Vl_Outras.Text := FloatToStrF(Total.ICMSTot.vOutro, ffFixed, 10, 2);
    E_VL_Produto.Caption := FloatToStrF(Total.ICMSTot.vProd , ffFixed, 10, 2);
    E_VL_Servico.Caption := FloatToStrF(Total.ISSQNtot.vServ , ffFixed, 10, 3);
    E_VL_Nota.Caption := FloatToStrF(Total.ICMSTot.vNF, ffFixed, 10, 2);
  end;
  if Result then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                        'Favor Conferir os valores totais da nota.' + EOLN + EOLN +
                        'Confirmar os Valores ?',
                        [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
    begin
      result := True;
    end
    else
    begin
      MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                     'Operação Abortada pelo Usuário.' + EOLN,
                     ['OK'], [bEscape], mpInformacao);
      Result := False;
    end;
  End;
end;

procedure TFr_Fatura_Vda.Pc_CarregaComponenteTributacao;
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
      DataEmissao := E_Dt_Emissao.Date;
      if chbx_data_saida.Checked then
        DataSaida := E_Dt_Saida.Date
      else
        DataSaida := 0;
      Finalidade := '1';
      if Trim(DBLCB_Transportadora.Text) <> '' then
        CodigoTransportadora := DBLCB_Transportadora.KeyValue
      else
        CodigoTransportadora := 0;
      if Trim(Dblcb_Modal_Frete.Text) <> '' then
        ContaFrete := Dblcb_Modal_Frete.KeyValue
      else
        ContaFrete := 0;
     End;
    It_Cd_Natureza := 0;
    It_AutorizacaoNFE := ChBx_AutorizacaoNFE.Checked;
    It_AutorizacaoNFCE := False;
    It_AutorizacaoNFSE := False;
    it_SomaIPI_Bs_ICMS := Chbx_SomaIPI_Bs_ICMS.Checked;
    It_SomaIPI_Bs_ICMS_St := Chbx_SomaIPI_Bs_ICMS_St.Checked;
    UtilizarMvaOrginal := chbx_Mva_Original.Checked;
    It_Dist_Icms_NR := False;
    It_Dist_Icms_ST := False;
    It_Dist_IPI := False;
    It_ValidaListaNCM := ChBx_ListaNcm.Checked;

    It_RevendaCarro := (Fc_Tb_Geral('L','PRO_G_LABEL_PRO','')='S');
    It_Sentido := 'S';
    It_Tipo_OPer := 'V';
    It_Aq_Cred_Icms := StrtoFloatDef(Fc_Tb_Geral('L','GRL_G_AQ_CRED_ICMS','0'),0);
    It_Decreto108352014 :=(Fc_Tb_Geral('L','GRL_G_DECRETO108352014','N') = 'S');
    Tributacao.Pc_CriaConsultas;
    Tributacao.Pc_Pedido;
    with It_Nfe.NotasFiscais[0].NFe do
    Begin
      //Valor do Base do Icms
      Total.ICMSTot.vBC := StrToFloatDef(E_VL_Bs_ICMS.Text, 0);
      //Valor do ICMS
      Total.ICMSTot.vICMS := StrToFloatDef(E_Vl_Icms.Text, 0);
      //Valor do Base do Icms ST
      Total.ICMSTot.vBCST := StrToFloatDef(E_Vl_Bs_Icms_St.Text, 0);
      //Valor do ICMS St
      Total.ICMSTot.vST := StrToFloatDef(E_Vl_Icms_St.Text, 0);
      //Valor do Produto
      Total.ICMSTot.vprod := StrToFloatDef(E_VL_Produto.Caption, 0);
      //Valor do Frete
      Total.ICMSTot.vFrete := StrToFloatDef(E_VL_Frete.Text, 0);
      //Valor do Seguro
      Total.ICMSTot.vSeg := StrToFloatDef(E_Vl_Seguro.Text, 0);
      //Valor das outras despesas
      Total.ICMSTot.vOutro := StrToFloatDef(E_Vl_Outras.Text, 0);
      //Valor do IPI
      Total.ICMSTot.vIPI := StrToFloatDef(E_VL_IPI.Text, 0);
    end;
    It_Qt_Produto := StrToFloatDef(E_Qt_Produto.Text,0);
    It_Especie := E_Especie.Text;
    It_PesoBruto := E_PesoBruto.Text;
    It_PesoLiquido := E_PesoLiq.Text;
    It_PlacaVeiculo := E_PlacaVeiculo.Text;
    It_Uf_Veiculo := E_Uf_Veiculo.Text;
    It_RNTC := E_RNTC.Text;
    It_Marca := E_Marca.Text;
    It_Volume := E_vol_Numero.Text;
    It_Despachar := Fc_Tb_Geral('L','DSP_G_CTRL_DESPACHO','N');
  end;
end;

function TFr_Fatura_Vda.Fc_Faturar_Normal():Boolean;

begin
  //Calcula os impostos
  Tributacao.Pc_Pedido;
  Tributacao.Pc_PreencheDadosDanfe;
  //  Tributacao.It_Nfe.NotasFiscais.SaveToFile(GbPathExe + '\temp\PED_' + IntToStr(It_Nr_Pedido) + 'NFE.XML');
  if Fc_ConfirmaValores then
  begin
    Tributacao.Pc_Gera_NotaFiscal;
    Tributacao.Pc_AtualizarItens;
    Tributacao.Pc_Obs_NotaFiscal(E_Obs);
    Tributacao.Pc_Obs_NF_Servico(E_Obs_Servico);


    tributacao.NotaFiscal.Pedido.Registro.Codigo := It_Cd_Pedido;
    tributacao.NotaFiscal.Pedido.Registro.Faturado := 'S';
    tributacao.NotaFiscal.Pedido.alteraStatus;

    if (Fc_Tb_Geral('L','VDA_G_LANCALOTEAUTO','S') = 'S') then
    Begin
      CtrlLote.AplicaLotePedido(It_Cd_Pedido);
    End;
    MensagemPadrao(MENSAGEM, TITULO_CONFIRMACAO + EOLN + EOLN +
                   'Faturamento realizado com Sucesso.' + EOLN+
                   'Número do Pedido : ' + It_Nr_Pedido + EOLN,
                   ['OK'], [bEscape], mpConfirmacao);
    Result := True;
  end
  else
  Begin
    Result := False;
  end;
end;



procedure TFr_Fatura_Vda.Action1Execute(Sender: TObject);
Var
  Lc_Form :TFr_Liberacao;
begin
  try
    Lc_Form := TFr_Liberacao.Create(nil);
    Lc_Form.Liberado := False;
    Lc_Form.It_Interface := 'Fr_Cotacao';
    Lc_Form.It_Nome_Menu := 'Orçamento';
    Lc_Form.It_Privilegio := 'AUTORIZAR';
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;

end;

procedure TFr_Fatura_Vda.ChamaTelaAutorizacao;
Var
  Lc_produto, Lc_Servico : boolean;
  Lc_Nf_Conjugada : Boolean;
  Lc_Form : TFr_GeraNFe_vda;
begin
  with Tributacao.Qr_ItensPedido do
  Begin
    Active := True;
    FetchAll;
    First;
     Lc_produto := False;
     Lc_Servico := False;
    while not eof  do
    Begin
      if ( FieldByname('PRO_TIPO').AsString = 'P' ) and not Lc_produto then
        Lc_produto := True;
      if ( FieldByname('PRO_TIPO').AsString = 'S' ) and not Lc_Servico then
        Lc_Servico := True;
      next;
    End;
    Lc_Nf_Conjugada := ( Fc_Tb_Geral('L','OSR_G_NFSE_CONJ','N') = 'S');
    if ( Lc_produto and ChBx_AutorizacaoNFE.Checked) or (Lc_Nf_Conjugada and ChBx_AutorizacaoNFE.Checked )  then
    Begin
      Lc_Form := TFr_GeraNFe_vda.Create(Self);
      try
        TRy
          Lc_Form.It_Cd_Pedido      := It_Cd_Pedido;
          Lc_Form.It_cd_Cliente     := Tributacao.NotaFiscal.Pedido.Registro.Empresa;
          Lc_Form.It_cd_Consumidor  := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
          Lc_Form.It_Cd_Nota        := Tributacao.NotaFiscal.Registro.Codigo;
          Lc_Form.It_Nr_Nota        := 0;
          Lc_Form.It_Nf_Terceiro    := FAlse;
          Lc_Form.ValorRecebido     := 0;
          Lc_Form.ValorTroco        := 0;

          //Operação Normal
          Pc_CarregaDadosEmitente(true);
          Lc_Form.TipoOperacao := 'NF-e';
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
    End;

    if ( Lc_Servico and ChBx_AutorizacaoNFE.Checked and not Lc_Nf_Conjugada) then
    Begin
      if Fc_NFSEletronicaAtivada then
        Fc_ChamarGeraNFSE('NFS-e',Tributacao.NotaFiscal.Registro.Codigo );
    End;
  End;

end;

Procedure TFr_Fatura_Vda.chbx_data_saidaClick(Sender: TObject);
begin
  E_Dt_Saida.Enabled := chbx_data_saida.Checked;
end;


procedure TFr_Fatura_Vda.E_Qt_ProdutoChange(Sender: TObject);
Var
  Lc_Ativa : boolean;
begin
  Lc_Ativa := (StrToFloatDef(E_Qt_Produto.Text,0) > 0);
  if Lc_Ativa then
  Begin
    E_Especie.Enabled := True;
    E_PesoBruto.Enabled := True;
    E_PesoLiq.Enabled := True;
    E_Marca.Enabled := True;
    E_Vol_Numero.Enabled := True;
    E_PesoLiq.Text := FloatToStrF(Fc_MostraPesoPedido(It_Cd_Pedido),ffFixed,10,2);
    E_PesoBruto.Text := E_PesoLiq.Text;
  end
  else
  Begin
    E_Especie.Enabled := False;
    E_PesoBruto.Enabled := False;
    E_PesoLiq.Enabled := False;
    E_Marca.Enabled := False;
    E_Vol_Numero.Enabled := False;
    // Zera os Campos
    E_PesoBruto.Clear;
    E_PesoLiq.Clear;
    E_Marca.Clear;
    E_Vol_Numero.Clear;
  end;

end;

procedure TFr_Fatura_Vda.Pc_ImpressaoAutomaticaBoleto(Pc_cd_Pedido:Integer);
var
  lc_qry:TSTQuery;
  LcBase : TControllerBase;
  sql_txt:String;
  Lc_Lista:TStringList;
  Lc_Cd_Boleto : Integer;
  Lc_Cd_Conta  : Integer;
  Lc_Imprimir : Boolean;
begin
  //Verifica se a forma de pagamento é boleto
  with Tributacao,Fr_Principal do
  Begin
    if ( NotaFiscal.Pedido.Registro.FormaPagto = Fc_PegaFormaPgto('BOLETO')) then
    Begin
      Lc_Lista := TStringList.Create;
      Lc_Lista := Fc_VerificaCarteiraCobranca;
      Lc_Cd_Boleto := StrToIntDef(Lc_Lista.Strings[0],0);
      Lc_Cd_Conta := StrToIntDef(Lc_Lista.Strings[1],0);
      if Lc_Cd_Boleto > 0 then
      Begin
        Try
          LcBase := TControllerBase.create(nil);
          Lc_Qry := LcBase.GeraQuery;
          with Lc_Qry do
          Begin
            sql_txt:= ' select PED_NUMERO,FIN_NR_PARCELA,FIN_VL_PARCELA,FIN_CODQTC,FIN_DT_VENCIMENTO '+
                      ' FROM TB_FINANCEIRO '+
                      ' INNER JOIN TB_PEDIDO '+
                      ' ON (PED_CODIGO = FIN_CODPED) '+
                      ' WHERE FIN_CODPED =:PED_CODIGO '+
                      'ORDER BY FIN_NUMERO ';
            SQL.Add(sql_txt);
            ParamByName('PED_CODIGO').AsInteger:= Pc_Cd_Pedido;
            Open;
            FetchAll;
            First;
            //Grava o Boleto;
            while not eof do
            Begin
              Pc_GravaBoleto(0,
                             NotaFiscal.Pedido.Registro.Empresa,
                             FieldByName('PED_NUMERO').AsString + FieldByName('FIN_NR_PARCELA').AsString,
                             Date,
                             Lc_Cd_Conta,//               Pc_CODCTB
                             'N',//               Pc_DESCONTO
                             0,//               Pc_TX_DESCONTO
                             'N',
                             FieldByName('FIN_VL_PARCELA').AsCurrency,
                             FieldByName('FIN_CODQTC').AsInteger,
                             0,//               Pc_VL_TARIFA:Real;
                             0,//               Pc_TX_MORA:Real;
                             Lc_Cd_Boleto, //   Pc_CODBLE
                             FieldByName('FIN_DT_VENCIMENTO').AsDateTime);
              Next;
            end;
            //Imprime o Boleto
            Lc_Imprimir := False;
            Boleto.ListadeBoletos.Clear;
            if not DirectoryExists(GbPathExe + 'imagem\') then
              CreateDir(GbPathExe + 'imagem\');
            Boleto.ACBrBoletoFC.DirLogo := GbPathExe + '\imagem\';
            Boleto.ACBrBoletoFC.Filtro := fiNenhum;
            Boleto.ACBrBoletoFC.NomeArquivo := '';
            if not FileExists(GbPathExe + 'imagem\'+StrZero(Boleto.Banco.Numero,3,0)+'.bmp') then
              Pc_BaixarLogoBanco(StrZero(Boleto.Banco.Numero,3,0));
            First;
            while not eof do
            Begin
              Lc_Imprimir := Fc_Gerar_Boleto_Sem_Registro(FieldByName('FIN_CODQTC').AsInteger);
              Next;
            end;
            if Lc_Imprimir then Fr_Principal.Boleto.Imprimir;
          end;
        Finally
          LcBase.FinalizaQuery(Lc_Qry);
          FreeAndNil(LcBase);
        End;
      end;
    end;
  end;
end;
end.


