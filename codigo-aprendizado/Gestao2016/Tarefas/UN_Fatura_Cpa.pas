unit UN_Fatura_Cpa;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, DB, STStoredProc, StdCtrls, DBCtrls, Mask, ExtCtrls, STQuery, Printers, ComCtrls, Grids, System.Math, QEdit_Setes, STDatabase, tributacao, ControllerCtrlEstoque;

type
   TFr_Fatura_Cpa = class(TForm)
      E_M_Nota: TMemo;
      E_M_Fisco: TMemo;
    Ds_Moral_Frete: TDataSource;
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
    Label34: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    Label39: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label37: TLabel;
    Label4: TLabel;
    E_Vl_Bs_Icms_St: TEdit_Setes;
    E_Vl_Icms_St: TEdit_Setes;
    E_Vl_Seguro: TEdit_Setes;
    E_Vl_Outras: TEdit_Setes;
    E_VL_Produto: TPanel;
    E_VL_ICMS: TEdit_Setes;
    E_VL_Bs_ICMS: TEdit_Setes;
    E_VL_IPI: TEdit_Setes;
    E_VL_Frete: TEdit_Setes;
    E_Qt_Produto: TEdit_Setes;
    E_RNTC: TEdit;
    E_Marca: TEdit;
    E_Vol_Numero: TEdit;
    E_VL_Nota: TPanel;
    E_Vl_desconto: TPanel;
    E_Especie: TEdit;
    E_PesoLiq: TEdit_Setes;
    E_PesoBruto: TEdit_Setes;
    E_Uf_Veiculo: TDBLookupComboBox;
    E_PlacaVeiculo: TMaskEdit;
    Panel1: TPanel;
    SB_Sair_0: TSpeedButton;
    SB_Confirmar: TSpeedButton;
    Panel2: TPanel;
    Label9: TLabel;
    Panel3: TPanel;
    Label2: TLabel;
    ChBx_AutorizacaoNFE: TCheckBox;
    Chbx_Frete: TCheckBox;
    ChBx_SomaICMS: TCheckBox;
    ChBx_Nota_Manual: TCheckBox;
    Chbx_SomaIPI_Bs_ICMS: TCheckBox;
    Chbx_SomaIPI_Bs_ICMS_St: TCheckBox;
    ChBx_Distribuir_ICMS: TCheckBox;
    ChBx_Distribuir_ICMS_ST: TCheckBox;
    ChBx_Distribuir_IPI: TCheckBox;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    E_Dt_Saida: TDateTimePicker;
    E_Dt_Emissao: TDateTimePicker;
    chbx_data_saida: TCheckBox;
    E_Obs: TMemo;
    GroupBox5: TGroupBox;
    Sb_Transportadora: TSpeedButton;
    Label7: TLabel;
    Label33: TLabel;
    DBLCB_Transportadora: TDBLookupComboBox;
    Dblcb_Modal_Frete: TDBLookupComboBox;
    Label3: TLabel;
    E_ConsCustoNF: TEdit_Setes;
      procedure SB_ConfirmarClick(Sender: TObject);
      procedure SB_Sair_0Click(Sender: TObject);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure DBLCB_TransportadoraKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure Sb_TransportadoraClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure TabSheet3Show(Sender: TObject);
    procedure E_Qt_ProdutoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);

   private
    { Private declarations }
      //Verifica se é usuario de Nfe
      It_Usa_Nfe : Boolean;

      //Tarifa Siscomex
      It_AQ_SISCOMEX : real;
      //Tarifa AFRMM
      It_AQ_AFRMM : Real;
    Tributacao : ttributacao;
   public
    { Public declarations }
     //Variveis para Controle da nota Instanciada
      it_fatura_ok : Boolean;
      it_tp_produto:String;
      It_Cd_Pedido: Integer;
      It_Nr_Pedido: String;
      It_Nr_Duplicata: Integer;
      It_Dt_Pedido : String;
      procedure Pc_AtivarTabela;
      procedure Pc_Gera_Financeiro;
      procedure Pc_ImprimeCupom;
      procedure Pc_Inicia_Variaveis;
      procedure Pc_FormataTela;
      procedure Pc_Verifica_Nota_Fiscal_E;
      procedure Pc_Atualiza_Preco_Venda;

      function Fc_ConfirmaValores(): boolean;
      procedure Pc_CarregaComponenteTributacao;
      Function Fc_Faturar():Boolean;

      function fc_ValidaFaturamento(): Boolean;

      function Fc_ValidaPreenchimentoDI(Fc_Cd_Item:Integer):Boolean;
      procedure Pc_AtualizaFornecedorProduto;
      Procedure Pc_Estoque(Pc_Itens:TSTQuery);
      procedure Pc_Faturar_Compra;
      procedure Pc_ImagemBotao;
      procedure AbreValoresImportacao;
      Function ValoresImportacao(Tipo:String;Qry:TSTQuery):Real;
      Function Obs_DI(Qry:TSTQuery):String;
      Function ValoresImpObsevacao(Tipo:String;Qry:TSTQuery):Real;
   end;

var
   Fr_Fatura_Cpa: TFr_Fatura_Cpa;

implementation


uses     Un_DM, Un_Msg, Un_Funcoes, UN_Sistema, UN_NF, Un_Fc_Sored_Procedures, un_Padrao, Un_Imp_Mod_Impressao, Un_Regra_Negocio, Un_Transportadora, Un_MostraRegraTributacao, UN_Principal, env, RN_Inventario, RN_Estoque, RN_PlanoContas, RN_Compras, RN_Produto, RN_Transportadora, RN_FormaPagto, Un_Fatura_Fin, RN_Financeiro, RN_Permissao, RN_Pedido, RN_NotaFiscalEletronica3X, RN_Crud, UN_TabelasEmListas, un_geranfe_cpa;
{$R *.dfm}

procedure TFr_Fatura_Cpa.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;



procedure TFr_Fatura_Cpa.Pc_AtualizaFornecedorProduto;
Begin
  with Tributacao do
  Begin
    Qr_ItensPedido.First;
    while not Qr_ItensPedido.Eof do
    Begin
      Application.ProcessMessages;
      Pc_VincularCodigoProdutoFornecedor(Qr_ItensPedido.FieldByName('ITF_CODPRO').AsString,
                                         NotaFiscal.Pedido.Empresa.Registro.Codigo.ToString,
                                        '');
      Qr_ItensPedido.Next;
    end;
  end;
end;

Procedure TFr_Fatura_Cpa.Pc_Estoque(Pc_Itens:TSTQuery);
Var
  LcCtrlEstoque : TControllerCtrlEstoque;
Begin
  Try
    LcCtrlEstoque := TControllerCtrlEstoque.create(nil);
    with Pc_Itens do
    Begin
      First;
      while not Eof do
      Begin
        Application.ProcessMessages;
        if (FieldByName('ITF_ESTOQUE').AsString = 'S') then
          Begin
            with LcCtrlEstoque.Registro do
            Begin
              Codigo      := 0;
              Terminal    := Gb_Terminal;
              Vinculo     := 'P';
              Ordem       := It_Cd_Pedido;
              Item        := FieldByname('ITF_CODIGO').AsInteger;
              Estoque     := FieldByname('ITF_CODEST').AsInteger;
              operacao    := 'E';
              Produto     := FieldByname('ITF_CODPRO').AsInteger;
              Quantidade  := FieldByname('ITF_QTDE').AsFloat;
              Data        := E_Dt_Emissao.Date;
              Tipo        := 'Compra';
              UpdateAt    := Now;
            End;
            LcCtrlEstoque.Registra;
          end;
        Next;
      end;
    end;
  Finally
    FreeAndNil(LcCtrlEstoque);
  End;
end;

function TFr_Fatura_Cpa.Fc_ConfirmaValores(): boolean;
begin
  with Tributacao.It_Nfe.NotasFiscais[0].NFe do
  BEgin
    E_VL_Bs_ICMS.Text := FloatToStrF(Total.ICMSTot.vBC, ffFixed, 10, 2);
    E_VL_ICMS.Text := FloatToStrF(Total.ICMSTot.vICMS, ffFixed, 10, 2);
    E_Vl_Bs_Icms_St.Text := FloatToStrF(Total.ICMSTot.vBCST, ffFixed, 10, 2);
    E_Vl_Icms_St.Text := FloatToStrF(Total.ICMSTot.vST, ffFixed, 10, 2);
    E_VL_IPI.Text := FloatToStrF(Total.ICMSTot.vIPI, ffFixed, 10, 2);
    E_VL_FRETE.Text := FloatToStrF(Total.ICMSTot.vFrete, ffFixed, 10, 2);
    E_Vl_Seguro.Text := FloatToStrF(Total.ICMSTot.vSeg, ffFixed, 10, 2);
    E_Vl_Outras.Text := FloatToStrF(Total.ICMSTot.vOutro, ffFixed, 10, 2);
    E_VL_Produto.Caption := FloatToStrF(Total.ICMSTot.vProd , ffFixed, 10, 2);
    if Tributacao.It_SomaICMSNaNota then
      E_VL_Nota.Caption := FloatToStrF(Total.ICMSTot.vNF + Total.ICMSTot.vICMS , ffFixed, 10, 2)
    else
      E_VL_Nota.Caption := FloatToStrF(Total.ICMSTot.vNF, ffFixed, 10, 2);
  end;
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
end;
//------------------------------------------------------------

procedure TFr_Fatura_Cpa.Pc_ImprimeCupom;
Var
  Lc_Imp : TimpModImpressao;
begin
  if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_TP_CUPOM_FAT','')) = 'S' then
  Begin
    Try
      Lc_Imp := TimpModImpressao.create(nil);
      Lc_Imp.It_Tp_Doc:='COMPRA : ';
      Lc_Imp.CodigoPedido := It_Cd_Pedido;
      Lc_Imp.Pc_Imp_Cupom;
    finally
      FreeandNil(Lc_Imp);
    end;
  end;
end;


function TFr_Fatura_Cpa.Fc_ValidaPreenchimentoDI(Fc_Cd_Item:Integer):Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := TSTQuery.Create(Fr_Fatura_Cpa);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IBT_Faturamento;
    Active := False;
    SQL.Clear;
    SQL.Add('Select DIM_CODIGO, ADC_CODIGO '+
            'from TB_DEC_IMP '+
            '  INNER JOIN TB_ADIC_IMP '+
            '  ON (TB_ADIC_IMP.ADC_CODDIM = TB_DEC_IMP.DIM_CODIGO) '+
            'where DIM_CODITF = :DIM_CODITF ');
    ParamByName('DIM_CODITF').AsInteger := Fc_Cd_Item;
    Active := True;
    FetchAll;
    Result := (RecordCount > 0);
  end;
end;


function TFr_Fatura_Cpa.fc_ValidaFaturamento(): Boolean;
Var
  Lc_Aux : String;
  Lc_Nr_Nota: Integer;
  Lc_Tipo_Nota : String;
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

  if ChBx_Nota_Manual.Checked then
  Begin
    if not(InputQuery('Informar o Número da Nota Fiscal ', 'Número', Lc_Aux)) then
    Begin
      Result := False;
      exit;
    end;
    If trim(Lc_Aux) = '' then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O número da nota não foi informado !'+EOLN+
                     'Se escolheu informar manualmente digite um número'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;
    if ChBx_AutorizacaoNFE.Checked then Lc_Tipo_Nota := 'P' else Lc_Tipo_Nota := 'T';
    if Fc_VerificaNumeroNota(Lc_Tipo_Nota,Tributacao.NotaFiscal.Pedido.Registro.Empresa,Lc_Aux) then
    Begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'O número de nota Informada já existe !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      exit;
    end;
    Lc_Aux     := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-',' ']);
    Tributacao.NotaFiscal.Registro.Numero := Lc_Aux;
  end;

  If (ChBx_AutorizacaoNFE.Checked) or ((ChBx_Nota_Manual.Checked) and It_Usa_Nfe ) then
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
    IF NOT Tributacao.Fc_Valida then
    Begin
      Result := False;
      exit;
    end;
  end;
end;



procedure TFr_Fatura_Cpa.Pc_AtivarTabela;
begin
  DM.Qr_UF.Active := true;
  DM.Qr_Modal_Frete.Active := true;
  DM_ListaConsultas.Pc_ListaTranportadoras('EMP_NOME');
end;


Function TFr_Fatura_Cpa.Fc_Faturar():boolean;
begin
  //Calcula os impostos
  Tributacao.Pc_PreencheDadosDanfe;
  if Fc_ConfirmaValores then
  begin
    Tributacao.Pc_Pedido;
    Tributacao.Pc_Gera_NotaFiscal;

    Tributacao.Pc_AtualizarItens;

    Tributacao.Pc_Obs_NotaFiscal(E_Obs);

    if DM.IBT_Faturamento.InTransaction then DM.IBT_Faturamento.Commit;
    tributacao.NotaFiscal.Pedido.Registro.Codigo := It_Cd_Pedido;
    tributacao.NotaFiscal.Pedido.Registro.Faturado := 'S';
    tributacao.NotaFiscal.Pedido.alteraStatus;

    if ChBx_Nota_Manual.Checked then
    Begin
      MensagemPadrao(MENSAGEM, TITULO_CONFIRMACAO + EOLN + EOLN +
                           'Faturamento realizado com Sucesso.' + EOLN+
                           'Número do Pedido : ' + It_Nr_Pedido + EOLN+
                           'Número da Nota   : ' + Tributacao.NotaFiscal.Registro.Numero + EOLN,
                           ['OK'], [bEscape], mpConfirmacao);
    end
    else
    Begin
      MensagemPadrao(MENSAGEM, TITULO_CONFIRMACAO + EOLN + EOLN +
                     'Faturamento realizado com Sucesso.' + EOLN+
                     'Número do Pedido : ' + It_Nr_Pedido + EOLN,
                     ['OK'], [bEscape], mpConfirmacao);
    end;
    Result := True;
  end
  else
  Begin
    Result := False;
  end;
end;




procedure TFr_Fatura_Cpa.Pc_Gera_Financeiro;
var
  Lc_Form : TFr_Fatura_fin;
begin
  try
    Lc_Form := TFr_Fatura_fin.Create(nil);
    Lc_Form.It_Confirma := False;
    Lc_Form.It_cd_Nota := Tributacao.NotaFiscal.Registro.Codigo;
    Lc_Form.It_Tipo_Finaceiro := 'PA';
    Lc_Form.It_Oper_Financeiro := 'D';
    Lc_Form.It_Hist_Caixa := 'COMPRA Nº ';
    Lc_Form.PegaContaGerencialAuto := False;
    Lc_Form.TelaVenda := False;
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;

end;

procedure TFr_Fatura_Cpa.SB_ConfirmarClick(Sender: TObject);
begin
  TRY
    Self.Enabled := False;
    Pc_ProcesoAguarde(Self,'I');

    Pc_CarregaComponenteTributacao;
    if fc_ValidaFaturamento then
    Begin
      Pc_Faturar_Compra;
    end;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Fatura_Cpa.Pc_CarregaComponenteTributacao;
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

    It_AutorizacaoNFCE := False;
    It_AutorizacaoNFSE := False;
    It_AutorizacaoNFE := ChBx_AutorizacaoNFE.Checked;
    It_SomaICMSNaNota := ChBx_SomaICMS.Checked;
    it_SomaIPI_Bs_ICMS := Chbx_SomaIPI_Bs_ICMS.Checked;
    It_SomaIPI_Bs_ICMS_St := Chbx_SomaIPI_Bs_ICMS_St.Checked;
    It_Dist_Icms_NR := ChBx_Distribuir_ICMS.Checked;
    It_Dist_Icms_ST := ChBx_Distribuir_ICMS_ST.Checked;
    It_Dist_IPI := ChBx_Distribuir_IPI.Checked;
    It_RevendaCarro := (Fc_Tb_Geral('L','PRO_G_LABEL_PRO','')='S');
    It_Sentido := 'E';
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

procedure TFr_Fatura_Cpa.Pc_Faturar_Compra;
var
  Lc_Form : TFr_geranfe_cpa;
begin
  Pc_Define_FormatoRegional;
  it_fatura_ok := Fc_Faturar;
  if it_fatura_ok then
  Begin
    //Gera Processo financeiro
    if ((Fc_Tb_Geral('L','FIN_G_ATIVAR','') = 'S')) then
    begin
      Pc_Gera_Financeiro;
    end;
    //Registra movimentação do Estoque
    Pc_Estoque(Tributacao.Qr_ItensPedido);
    //Atualiza os numeros de Serie
    Tributacao.NotaFiscal.AtualizaSeries('S',Tributacao.Qr_ItensPedido);
    //Atualiza os fornecedores nos produtos
    Pc_AtualizaFornecedorProduto;
    //Calculo do Custo medio
    Pc_AtualizaCustosProdutos(It_Cd_Pedido,E_ConsCustoNF.Text,false);
    Pc_Atualiza_Preco_Venda;
    //Ativa os produtos que receberam saldo e estavam inativos
    Pc_Ativa_Produtos_Saldo(It_Cd_Pedido);

    Pc_ImprimeCupom;
    if ChBx_AutorizacaoNFE.Checked then
    begin
      Lc_Form := TFr_geranfe_cpa.Create(Self);
      try
        TRy
          Lc_Form.It_Cd_Pedido      := Tributacao.NotaFiscal.Pedido.Registro.Codigo;
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
    end;
    It_Cd_Pedido := 0;
    Close;    
  end
  else
  Begin
    It_Fatura_Ok := False;
    Close;
  end;
end;

procedure TFr_Fatura_Cpa.Pc_Atualiza_Preco_Venda;
Var
  Lc_Atualiza : String;
Begin
  Lc_Atualiza := FC_Tb_Geral('L', 'PRO_G_ATUAL_PRECO_COMPRA', '') ;
  if ( Lc_Atualiza = 'A' ) then
    Pc_AtualizarPreco(Tributacao.NotaFiscal.Registro.Codigo)
  else
  if ( Lc_Atualiza = 'M' ) then
    Pc_AtualizarPrecoManual(It_Cd_Pedido);
end;



procedure TFr_Fatura_Cpa.SB_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Fatura_Cpa.FormCreate(Sender: TObject);
begin
  Tributacao := ttributacao.create(Self);
end;

procedure TFr_Fatura_Cpa.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and not (ActiveControl is TMemo) then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;

end;

procedure TFr_Fatura_Cpa.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F10: if SB_Confirmar.Enabled then SB_ConfirmarClick(Sender);
      VK_Escape: if SB_Sair_0.Enabled then SB_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Fatura_Cpa.DBLCB_TransportadoraKeyDown(Sender: TObject;
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

procedure TFr_Fatura_Cpa.Pc_Inicia_Variaveis;
Begin
  Pc_Verifica_Nota_Fiscal_E;
  E_Dt_Emissao.Date := Date;
  E_Dt_Saida.Date := Date;
  E_Dt_Saida.SetFocus;
  E_Especie.Text:='VOLUME';
  Dblcb_Modal_Frete.KeyValue := DM.Qr_Modal_Frete.FieldByName('MDF_CODIGO').AsInteger;
  E_PesoLiq.Text := FloatToStrF(Fc_MostraPesoPedido(It_Cd_Pedido),ffFixed,10,2);
  E_PesoBruto.Text := E_PesoLiq.Text;
  AbreValoresImportacao;
end;

procedure TFr_Fatura_Cpa.Pc_FormataTela;
Begin

end;

procedure TFr_Fatura_Cpa.Pc_Verifica_Nota_Fiscal_E;
Begin
  ChBx_AutorizacaoNFE.Checked := False;
  ChBx_AutorizacaoNFE.Enabled := False;
  It_Usa_Nfe := Fc_VerificaFormularioDisponivel('Fr_GeraNFe');
  if It_Usa_Nfe then
  Begin
    if (Fc_Tb_Geral('L','CPA_G_OPER_COMPRA_NFE','S') = 'S') then
    begin
      ChBx_AutorizacaoNFE.Checked := True;
      ChBx_AutorizacaoNFE.Enabled := true;
    end
  end;
end;

procedure TFr_Fatura_Cpa.Sb_TransportadoraClick(Sender: TObject);
begin
  if not Assigned(Fr_Transportadora)then (Application.CreateForm(TFr_Transportadora, Fr_Transportadora));
  Fr_Transportadora.ShowModal;
end;

procedure TFr_Fatura_Cpa.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_AtivarTabela;
  Pc_Inicia_Variaveis;
  Pc_ImagemBotao;
end;



function TFr_Fatura_Cpa.Obs_DI(Qry: TSTQuery): String;
Var
  LcDI : String;
Begin
  with Qry do
  Begin
    Active := False;
    sql.Clear;
    sql.add(concat(
            'Select CI.* ',
            'from TB_DEC_IMP ci ',
            '  inner join tb_itens_nfl i ',
            '  on (i.itf_codigo = ci.dim_coditf) ',
            'where i.itf_codped =:ped_codigo '
    ));
    //acrescenta SQL para somar individualmente
    ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
    Active := True;
    FetchAll;                 //2171908839
    E_Obs.Lines.Add('LOCAL DE ARMAZENAMENTO '+FieldByName('DIM_LOCAL_DESEMB').AsString);
    LcDI := Concat('DI',Copy(FieldByName('DIM_NUMERO').AsString,2,2),'/',
                   Copy(FieldByName('DIM_NUMERO').AsString,4,7),
                   FieldByName('DIM_DIV').AsString, ' ',
                   FieldByName('DIM_DATA').AsString
            );
    E_Obs.Lines.Add(LcDI);
  End;
end;

procedure TFr_Fatura_Cpa.TabSheet3Show(Sender: TObject);
begin
   E_Dt_Saida.SetFocus;
end;

function TFr_Fatura_Cpa.ValoresImpObsevacao(Tipo: String; Qry: TSTQuery): Real;
begin
  with Qry do
  Begin
    Active := False;
    sql.Clear;
    sql.add(concat(
            'SELECT CAST(COALESCE(SUM(CTP_VL_REAL), 0) AS NUMERIC(18, 2)) valor ',
            'FROM TB_CUSTO_PEDIDO ',
            'WHERE ( CTP_CODPED =:PED_CODIGO ) ',
            ' and ( CTP_DESCRICAO LIKE :CTP_DESCRICAO )',
            ' AND ( CTP_NF =''',SIM,''' )'
    ));
    //acrescenta SQL para somar individualmente
    ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
    ParamByName('CTP_DESCRICAO').AsString := concat('%',Tipo,'%');
    Active := True;
    FetchAll;
    REsult := FieldByName('valor').AsCurrency;
  End;
end;

Function TFr_Fatura_Cpa.ValoresImportacao(Tipo:String;Qry:TSTQuery):Real;
begin
  with Qry do
  Begin
    Active := False;
    sql.Clear;
    sql.add(concat(
            'SELECT CAST(COALESCE(SUM(CTP_VL_REAL), 0) AS NUMERIC(18, 2)) valor ',
            'FROM TB_CUSTO_PEDIDO ',
            'WHERE ( CTP_CODPED =:PED_CODIGO ) ',
            ' and ( CTP_DESCRICAO LIKE :CTP_DESCRICAO )',
            ' AND ( CTP_NF =''',SIM,''' )'
    ));
    //acrescenta SQL para somar individualmente
    ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
    ParamByName('CTP_DESCRICAO').AsString := concat(Tipo,'%');
    Active := True;
    FetchAll;
    REsult := FieldByName('valor').AsCurrency;
  End;
end;

procedure TFr_Fatura_Cpa.AbreValoresImportacao;
Var
  LcQry : TSTQuery;
begin
  if ChBx_AutorizacaoNFE.Checked then
  Begin
    try
      LcQry := TSTQuery.Create(self);
      with LcQry do
      Begin
        Active := False;
        Database := DM.IBD_Gestao;
        Transaction := DM.IB_Transacao;
        sql.Clear;
        sql.add(concat(
                'SELECT CAST(COALESCE(SUM(CTP_VL_REAL), 0) AS NUMERIC(18, 2)) valor ',
                'FROM TB_CUSTO_PEDIDO ',
                'WHERE CTP_CODPED =:PED_CODIGO '
        ));
        ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
        Active := True;
        FetchAll;
        if ( RecordCount > 0 ) and (fieldByName('valor').AsCurrency > 0) then
        Begin
          //Verificação do checkbox
          ChBx_SomaICMS.checked := True;
          ChBx_Distribuir_ICMS.checked := True;
          ChBx_Distribuir_IPI.checked := True;
          //Observações da DI.
          Obs_DI(LcQry);
          //IMPOSTO NA OBS
          E_Obs.Lines.Add('I.I - ' + FloatToStrF(ValoresImpObsevacao('II',LcQry),ffFixed,10,2));
          E_Obs.Lines.Add('IPI - ' + FloatToStrF(ValoresImpObsevacao('IPI',LcQry),ffFixed,10,2));
          E_Obs.Lines.Add('PIS - ' + FloatToStrF(ValoresImpObsevacao('PIS',LcQry),ffFixed,10,2));
          E_Obs.Lines.Add('COFINS - ' + FloatToStrF(ValoresImpObsevacao('COFINS',LcQry),ffFixed,10,2));
          //BASE ICMS
          E_VL_Bs_ICMS.Text := FloatToStrF(ValoresImportacao('BASE ICMS',LcQry),ffFixed,10,2);
          //ICMS
          E_VL_ICMS.Text := FloatToStrF(ValoresImportacao('ICMS',LcQry),ffFixed,10,2);
          //FRETE
          E_VL_Frete.Text := FloatToStrF(ValoresImportacao('FRETE',LcQry),ffFixed,10,2);
          //IPI
          E_VL_IPI.Text := FloatToStrF(ValoresImportacao('IPI',LcQry),ffFixed,10,2);
          //SEGURO
          E_Vl_Seguro.Text := FloatToStrF(ValoresImportacao('SEGURO',LcQry),ffFixed,10,2);
          //OUTRAS
          E_Vl_Outras.Text := FloatToStrF(ValoresImportacao('OUTRAS',LcQry),ffFixed,10,2);
        End;

      End;
    finally
      LcQry.Close;
      FReeAndNil(LcQry);
    end;
  End;
end;

procedure TFr_Fatura_Cpa.E_Qt_ProdutoChange(Sender: TObject);
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

end.

