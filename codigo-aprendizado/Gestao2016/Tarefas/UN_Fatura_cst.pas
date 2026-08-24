unit UN_Fatura_Cst;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, DB, STStoredProc, StdCtrls, DBCtrls, Mask, ExtCtrls, STQuery, Printers, ComCtrls, Grids, System.Math, QEdit_Setes, STDatabase, Un_Fm_CentroCusto, ControllerPedido, ControllerNotaFiscal, ControllerFinanceiro, STTransaction;

type
   TFr_Fatura_Cst = class(TForm)
      Qr_Acao: TSTQuery;
      PrintDialog1: TPrintDialog;
      QR_Duplicata: TSTQuery;
      Panel2: TPanel;
      Label9: TLabel;
      Panel3: TPanel;
      Lb_TipoParcelamento: TLabel;
      StGrd_Prazo: TStringGrid;
      Tpk_Prazo: TDateTimePicker;
      GroupBox1: TGroupBox;
      Label6: TLabel;
      E_Dt_Saida: TDateTimePicker;
      E_Dt_Emissao: TDateTimePicker;
      GroupBox5: TGroupBox;
      Sb_Transportadora: TSpeedButton;
      DBLCB_Transportadora: TDBLookupComboBox;
      E_Obs: TMemo;
      Panel1: TPanel;
    SB_Sair_0: TSpeedButton;
      Qr_Orcamento: TSTQuery;
    Qr_Conserto_: TSTQuery;
      Qr_Pedido: TSTQuery;
      E_M_Nota: TMemo;
      E_M_Fisco: TMemo;
      Qr_Endereco: TSTQuery;
    Label8: TLabel;
    Lb_VL_Total: TLabel;
    ChBx_Duplicata: TCheckBox;
    Panel4: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    Dblcb_Modal_Frete: TDBLookupComboBox;
    Ds_Moral_Frete: TDataSource;
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
    lb_Vl_desconto: TPanel;
    TabSheet2: TTabSheet;
    GroupBox8: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Lb_VL_Troco: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    E_VL_Dinheiro: TEdit_Setes;
    E_VL_Cheque: TEdit_Setes;
    E_Vl_Cartao: TEdit_Setes;
    E_Vl_Credito: TEdit_Setes;
    SB_Confirmar: TSpeedButton;
    Label7: TLabel;
    Lb_Vl_Devolucao: TLabel;
    chbx_data_saida: TCheckBox;
    E_Uf_Veiculo: TDBLookupComboBox;
    Qr_Parcelamento: TSTQuery;
    Fm_CentroCusto: TFm_CentroCusto;
    IBT_Faturamento: TSTTransaction;
      procedure SB_ConfirmarClick(Sender: TObject);
      procedure SB_Sair_0Click(Sender: TObject);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure DBLCB_TransportadoraKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure StGrd_PrazoClick(Sender: TObject);
      procedure Tpk_PrazoChange(Sender: TObject);
      procedure Sb_TransportadoraClick(Sender: TObject);
      procedure StGrd_PrazoDrawCell(Sender: TObject; ACol, ARow: Integer;
         Rect: TRect; State: TGridDrawState);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure StGrd_PrazoSetEditText(Sender: TObject; ACol, ARow: Integer;
         const Value: string);
      procedure FormShow(Sender: TObject);
      procedure StGrd_PrazoSelectCell(Sender: TObject; ACol, ARow: Integer;
         var CanSelect: Boolean);
      procedure E_Dt_EmissaoExit(Sender: TObject);
      procedure E_VL_DinheiroChange(Sender: TObject);
      procedure E_VL_ChequeChange(Sender: TObject);
      procedure E_VL_DinheiroExit(Sender: TObject);
      procedure E_VL_ChequeExit(Sender: TObject);
      procedure E_VL_DinheiroEnter(Sender: TObject);
      procedure E_VL_ChequeEnter(Sender: TObject);
      procedure E_Vl_CartaoChange(Sender: TObject);
      procedure E_Vl_CartaoEnter(Sender: TObject);
      procedure E_Vl_CartaoExit(Sender: TObject);
      procedure E_Vl_CreditoEnter(Sender: TObject);
      procedure E_Vl_CreditoExit(Sender: TObject);
      procedure E_Vl_CreditoChange(Sender: TObject);
    procedure chbx_data_saidaClick(Sender: TObject);
    procedure StGrd_PrazoKeyPress(Sender: TObject; var Key: Char);
    procedure E_Qt_ProdutoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);

   private
    { Private declarations }
    //Variveis para Controle do Emissor da nota
    It_Uf_Emissor : Integer;
    //codigo do Regime Tributario
    It_Cd_CRT : Integer;
    //Verifica se é usuario de Nfe

    Financeiro:TControllerFinanceiro;



    //Totalizadores
    It_VL_TL_Produtos: Currency;
    It_Vl_TL_Frete: Currency;
    It_Vl_TL_Seguro: Currency;
    It_Vl_TL_Outras: Currency;
    It_VL_TL_IPI: Currency;
    It_Vl_TL_Pedido: Currency;
    It_VL_TL_Servicos: Currency;
    It_VL_Tl_Desconto: Currency;
    It_Vl_TL_NotaFiscal: Currency;

    //Calculo do Caixa e Financeiro
    It_Vl_total: Currency;
    It_Vl_Cheque: Currency;
    It_Vl_Dinheiro: Currency;

    It_vl_restante:Currency;

    It_Vl_Cartao: Currency;
    It_Vl_Parcelamento: Currency;
    It_Cd_Qtc_Dinheiro : Integer;
    It_Cd_Qtc_Cheque : Integer;
    NotaFiscal : TControllerNotaFiscal;
   public
    { Public declarations }
    Pedido : TControllerPedido;
     //Variveis para Controle da nota Instanciada
    It_Cd_Nota  : Integer;
    it_fatura_ok : Boolean;
    It_uso_beneficio: CHAR;
    It_Nr_Nota: Integer;
    It_cd_empresa: Integer;
    It_Cd_Natureza : Integer;
    It_Cd_Pedido: Integer;
    It_Conserto : boolean;
    It_Cd_Conserto: Integer;
    It_Nr_Pedido: Integer;
    It_Nr_Duplicata: Integer;
    It_Dt_Pedido : String;
    It_Dt_Entrega : TDate;
    It_Cliente : String;
    It_Etapa_Faturamento : Integer;
    It_Vl_Devolucao: Currency;
    It_Vl_Credito: Currency;
    It_UsarCredito : Boolean;
      procedure Pc_FormataTela;
      procedure Pc_GravaUltimasConfiguracoes;
      procedure Pc_AtivarTabela;


      procedure Pc_Faturar_Conserto;
      function Fc_Faturar_Conserto():Boolean;
      procedure Pc_Gera_NotaFiscal;
      procedure Pc_Obs_NotaFiscal;
      procedure Pc_Obs_Financeira;
      procedure Pc_Obs_Manual;
      procedure Pc_GeraFinanceiro_Normal;
      procedure Pc_Lanca_Caixa;



//================================================

      function Fc_ValidaFaturamento(): Boolean;
      function Fc_Valida_Valor_Parcela():Boolean;

      procedure Pc_ImprimeCupom;
      procedure Pc_Totalizador;
      procedure Pc_Parcelamento;

      procedure Pc_MontaGrade;
      procedure Pc_MontaPrazo(Pc_Qt_Parcela: Integer; Pc_Valor: Real; Pc_Data: Tdate);
      procedure Pc_TotalizaFinanceiro;

      function Fc_ConfirmaValores(): boolean;

      procedure Pc_Inicia_Variaveis;


      procedure Pc_RollBack_Faturamento;

      Function Fc_Validar_Valores_recebimento(Pc_Beneficio:char):Boolean;
      function Fc_ValidaTroco():Boolean;
      Procedure Pc_GeraFinanceiro_SemTroco;
      Procedure Pc_GeraFinanceiro_ComTroco;
      PROCEDURE Pc_GeraFinanceiro_Credito;
      procedure Pc_BaixaCredito(Pc_Codigo: Integer;Pc_Vl_Credito: Real);
      procedure Pc_InseriCredito(Pc_Cd_pedido,   Pc_cd_Nota: Integer; Pc_Nr_pedido: STRING);

      Procedure Pc_gera_parcelamento_restante;
      procedure Pc_GeraFinanceiro_Devolucao;

      procedure Pc_ImagemBotao;
   end;

var
   Fr_Fatura_Cst: TFr_Fatura_Cst;

implementation


uses
Un_DM, Un_Msg, Un_Funcoes, UN_NF, UN_Sistema, Un_Clta_Csto, Un_MinhaEmpresa, un_Padrao, UN_RL_Duplicata, Un_Fc_Comissao, Un_Fc_Sored_Procedures, UN_Pedido_Vda, Un_Imp_Mod_Impressao, Un_Regra_Negocio, Un_Transportadora, Un_Liberacao, RN_Cliente, RN_NotaFiscal, UN_Principal, env, RN_Inventario, RN_Estoque, RN_PlanoContas, RN_Financeiro, Un_WebService, RN_Transportadora, RN_FormaPagto, RN_BoletoEletronico, RN_Permissao, RN_Pedido, UN_TabelasEmListas, RN_Empresa, RI_MovimentoFinanceiro;

{$R *.dfm}

procedure TFr_Fatura_Cst.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;

procedure TFr_Fatura_Cst.Pc_RollBack_Faturamento;
Begin

  //Inicia o processo de retorno
  IBT_Faturamento.Active := True;
  if IBT_Faturamento.InTransaction then IBT_Faturamento.Commit;
  if not IBT_Faturamento.InTransaction then IBT_Faturamento.StartTransaction;

  NotaFiscal.Registro.Codigo := It_Cd_Nota;
  NotaFiscal.ApagarImpostos;


  Pc_ApagaObservacao(It_Cd_Nota);
  Pc_ApagaComissaoFaturamento(It_cd_Pedido);
  Pc_ApagaVendedor(It_Cd_Nota);
  Financeiro.Clear;
  Financeiro.Registro.CodigoNota := It_Cd_Nota;
  Financeiro.deleteByNota;


  Pc_Apaga_conserto(It_cd_Pedido);
  Pc_ApagaRetornoNFE(It_Cd_Nota);

  NotaFiscal.Registro.Codigo := It_Cd_Nota;
  NotaFiscal.delete;

  if IBT_Faturamento.InTransaction then IBT_Faturamento.Commit;
end;

procedure TFr_Fatura_Cst.Pc_FormataTela;
Begin
  lb_Vl_desconto.ParentColor := False;
  lb_Vl_desconto.Color := clRed;
  StGrd_Prazo.Cells[1, 0] := 'Vencimento';
  StGrd_Prazo.Cells[2, 0] := 'Valor';
  StGrd_Prazo.ColWidths[0] := 17;
  StGrd_Prazo.ColWidths[1] := 90;
  StGrd_Prazo.ColWidths[2] := 75;
end;

procedure TFr_Fatura_Cst.Pc_GravaUltimasConfiguracoes;
Begin
  If Trim(Dblcb_Modal_Frete.Text) <> '' then
    Fc_Tb_Geral('G', 'FAT_TIPOFRETE', IntToStr(Dblcb_Modal_Frete.KeyValue))
  else
    Fc_Tb_Geral('G', 'FAT_TIPOFRETE', '0');
end;


procedure TFr_Fatura_Cst.Pc_AtivarTabela;
begin
  DM.Qr_UF.Active := true;
  DM_ListaConsultas.Pc_ListaTranportadoras('EMP_NOME');
  DM.Qr_Modal_Frete.Active := true;
  Fm_CentroCusto.Pc_ListaParaUsar;
end;


procedure TFr_Fatura_Cst.Pc_Faturar_Conserto;
Begin
  It_Nr_Pedido := Qr_Pedido.FieldByName('PED_NUMERO').AsInteger;
  it_fatura_ok := Fc_Faturar_Conserto;
  if it_fatura_ok then
  Begin
    //Encerra o pedido
    //Posiciona para o Cadastro da minha Empresa
    Pc_AtivaEstabelecimento;
    Pc_ImprimeCupom;
    if ChBx_Duplicata.Checked then Pc_Imprime_Duplicata(It_Cd_Nota);
    It_Cd_Pedido := 0;
    Self.Close;
    Self.It_Fatura_Ok := True;
  end
  else
  Begin
    Self.It_Fatura_Ok := False;
    self.Close;
  end;
end;

function TFr_Fatura_Cst.Fc_Faturar_Conserto():Boolean;
begin
  Result := True;
  It_Etapa_Faturamento := 0;
  //Inicia o Faturamento
  try
    //Inicia a Transação
    IBT_Faturamento.Active := True;
    if IBT_Faturamento.InTransaction then IBT_Faturamento.Commit;
    if not IBT_Faturamento.InTransaction then IBT_Faturamento.StartTransaction;
    //Seleciona o Pedido
    Qr_Pedido.Active := False;
    Qr_Pedido.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
    Qr_Pedido.Active := True;
    Qr_Pedido.FetchAll;
    Qr_Pedido.First;

    //codigo da Nota para criar os indexações
    It_Cd_Nota:= Fc_Generator('GN_NOTA_FISCAL','','NFL_CODIGO');

    It_Etapa_Faturamento := 2;
    Pc_Gera_NotaFiscal;
    It_Etapa_Faturamento := 3;
    Pc_Obs_NotaFiscal;

    //Processo Geração do Financeiro
    It_Etapa_Faturamento := 4;
    if ((Fc_Tb_Geral('L','FIN_G_ATIVAR','') = 'S')) then Pc_GeraFinanceiro_Normal;
    Pc_Lanca_Caixa;

    if IBT_Faturamento.InTransaction then IBT_Faturamento.Commit;
    NotaFiscal.Pedido.Registro.Codigo := It_Cd_Pedido;
    NotaFiscal.Pedido.Registro.Faturado := 'S';
    NotaFiscal.Pedido.alteraStatus;
    MensagemPadrao(MENSAGEM, TITULO_CONFIRMACAO + EOLN + EOLN +
                   'Faturamento realizado com Sucesso.' + EOLN,
                   ['OK'], [bEscape], mpConfirmacao);

  except
    if IBT_Faturamento.InTransaction then IBT_Faturamento.Rollback;
    Pc_RollBack_Faturamento;
    Result := False;
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Erro ao gerar Faturamento.' + EOLN +
                   'Verifique os dados do pedido.' + EOLN,
                   ['OK'], [bEscape], mpErro);

  end;
end;

procedure TFr_Fatura_Cst.Pc_Gera_NotaFiscal;
var
  Lc_SerieNF: Integer;
  Lc_TpAmbiente: Integer;
  Lc_Transportadora : Integer;
  Lc_Data : String;
begin
  Lc_SerieNF := 1;
  //Define a Transportadora
  if Trim(DBLCB_Transportadora.text) <> '' then
    Lc_Transportadora := DBLCB_Transportadora.KeyValue
  else
    Lc_Transportadora:= 0;

 //Define Numero da Nota
  It_Nr_Nota  := 0;

  if chbx_data_saida.Checked then
    Lc_Data := DatetoStr(E_Dt_Saida.Date)
  else
    Lc_Data := '';

  //Gerar Nota Fiscal
  Pc_NotaFiscal(IBT_Faturamento,
                It_Cd_Nota,
                'SI',
                1,
                StrZero(It_Nr_Nota, 6,0),
                Lc_SerieNF,
                It_Cd_Natureza,
                IT_CD_Pedido,
                It_cd_Empresa,
                E_Dt_Emissao.Date,
                Lc_Data,
                time,
                StrToFloatDef(E_VL_Bs_ICMS.Text,0),
                StrToFloatDef(E_VL_ICMS.Text,0),
                StrToFloatDef(E_Vl_Bs_Icms_St.Text,0),
                StrToFloatDef(E_Vl_Icms_St.Text,0),
                StrToFloatDef(E_VL_Produto.Caption,0),
                StrToFloatDef(E_VL_Frete.Text,0),
                StrToFloatDef(E_Vl_Seguro.Text,0),
                StrToFloatDef(E_Vl_Outras.Text,0),
                StrToFloatDef(E_VL_IPI.Text,0),
                StrToFloatDef(E_VL_Nota.Caption,0),
                Lc_Transportadora,
                Dblcb_Modal_Frete.KeyValue,
                StrToFloatDef(E_Qt_Produto.Text,0),
                E_Especie.Text,
                E_Marca.Text,
                E_PesoBruto.Text,
                E_PesoLiq.Text,
                'N',
                '',
                'F',
                It_VL_TL_Servicos,
                (It_VL_TL_Servicos * 0.05),
                E_vol_Numero.Text,
                E_PlacaVeiculo.Text,
                E_Uf_Veiculo.Text,
                E_RNTC.Text,
                Gb_CodMha);
   if IBT_Faturamento.InTransaction then   IBT_Faturamento.CommitRetaining;
end;

procedure TFr_Fatura_Cst.Pc_Obs_NotaFiscal;
Begin
  Qr_Acao.Active := False;
  Qr_Acao.Transaction := IBT_Faturamento;
  if (fc_Tb_Geral('L','VDA_OBS_FINANCEIRA','S') ='S') then
    Pc_Obs_Financeira;
  Fc_Obs_ImpostoAproximado(IBT_Faturamento,It_Cd_Nota);
  Pc_Obs_Manual;
  if IBT_Faturamento.InTransaction then     IBT_Faturamento.CommitRetaining;
end;

procedure TFr_Fatura_Cst.Pc_Obs_Financeira;
var
   Lc_I: Integer;
   Lc_Fim: Integer;
   lc_texto: string;
   Lc_Par: Boolean;
begin
  E_M_Nota.Clear;
  Lc_Fim := StGrd_Prazo.RowCount - 1;
  Lc_Par := (Lc_Fim / 2) = 0;
  Lc_I := 1;
  while (Lc_I <= Lc_Fim) do
    begin
    if Lc_Par then
      begin
      lc_texto := StGrd_Prazo.Cells[1, lc_I] + ' - ' + StGrd_Prazo.Cells[2, lc_I];
      lc_texto := lc_texto + ' / ' + StGrd_Prazo.Cells[1, lc_I + 1] + ' - ' + StGrd_Prazo.Cells[2, lc_I + 1];
      Lc_I := Lc_I + 2;
      E_M_Nota.Lines.Add(lc_texto);
      lc_texto := '';
      end
    else
      begin
      if (Lc_I < Lc_Fim) and (Lc_Fim >= 2) then
        begin
        lc_texto := StGrd_Prazo.Cells[1, lc_I] + ' - ' + StGrd_Prazo.Cells[2, lc_I];
        lc_texto := lc_texto + ' / ' + StGrd_Prazo.Cells[1, lc_I + 1] + ' - ' + StGrd_Prazo.Cells[2, lc_I + 1];
        Lc_I := Lc_I + 2;
        E_M_Nota.Lines.Add(lc_texto);
        lc_texto := '';
        end
      else
        begin
        if (Lc_I = Lc_Fim) then
          lc_texto := lc_texto + StGrd_Prazo.Cells[1, lc_I] + ' - ' + StGrd_Prazo.Cells[2, lc_I]
        else
          lc_texto := lc_texto + ' / ' + StGrd_Prazo.Cells[1, lc_I] + ' - ' + StGrd_Prazo.Cells[2, lc_I];
        Lc_I := Lc_I + 1;
        E_M_Nota.Lines.Add(lc_texto);
        end;
      end;
    end;
  if Length(E_M_Nota.Text) > 0 then
    Begin
    Pc_Observacao(IBT_Faturamento,
                  'I',
                   0,
                   0,
                   It_Cd_Nota,
                   'A',
                   E_M_Nota.Text);
    end;
end;

Procedure TFr_Fatura_Cst.Pc_Obs_Manual;
Begin
  Pc_InfoRevendaVeiculos(E_Obs,It_Cd_Pedido);
  if Length(E_Obs.Text) > 0 then
    Begin
    Pc_Observacao(IBT_Faturamento,
                  'I',
                   0,
                   0,
                   It_Cd_Nota,
                  'M',
                  E_Obs.Text);
    end;
end;




//==============================================================================================================



procedure TFr_Fatura_Cst.Pc_Inicia_Variaveis;
Begin

  Pg_Resumo.ActivePageIndex := 0;
  Qr_Pedido.Active := False;
  Qr_Pedido.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
  Qr_Pedido.Active := True;
  Qr_Pedido.FetchAll;
  Qr_Pedido.First;


  //Frete
  Dblcb_Modal_Frete.KeyValue := DM.Qr_Modal_Frete.FieldByName('MDF_CODIGO').AsInteger;
  //Observação do Cliente
  E_Obs.Text := '';
  E_Obs.Lines.Add(Fc_ObsEmpresaNotaFiscal(Qr_Pedido.FieldByName('PED_CODEMP').asInteger));
  //Observação do Veiculo
  if (Fc_Tb_Geral('L','OSR_G_OBS_VEICULO_NF','S') = 'S') then
  E_Obs.Lines.Add(Fc_ObsVeiculoNotaFiscal(Qr_Pedido.FieldByName('PED_CODIGO').asInteger));

  It_Cd_Natureza := 0;
  It_Vl_Dinheiro := 0;
  It_Vl_Cheque := 0;
  //Define o Estado Emissor
  Pc_AtivaEstabelecimento;
  It_Uf_Emissor := DM.Qr_Estabelecimento.FieldByname('UFE_CODIGO').AsInteger;
  //codigo Regime Tributario
  It_Cd_CRT := StrToIntDef(DM.Qr_Estabelecimento.FieldByname('EMP_CRT').AsString,3);


  //Outros Contraladores
  Lb_TipoParcelamento.Caption := 'Parcelamento em ' + Qr_Pedido.FieldByName('FPT_DESCRICAO').AsString;
  It_cd_empresa := Qr_Pedido.FieldByName('PED_CODEMP').AsInteger;
  It_Dt_Pedido := Qr_Pedido.FieldByName('PED_DATA').AsString;
  It_Dt_Entrega := Qr_Pedido.FieldByName('PED_DATA').AsDateTime;
  It_Cliente := Qr_Pedido.FieldByName('EMP_NOME').AsString;
  It_VL_TL_Frete   := Qr_Pedido.FieldByName('PED_VL_FRETE').AsCurrency;
  E_VL_Frete.Text  := FloatToStrF(It_Vl_TL_Frete,ffFixed,10,2);
  It_Vl_TL_Outras  := Qr_Pedido.FieldByName('PED_VL_ODESPESA').AsCurrency;
  E_Vl_Outras.Text := FloatToStrF(It_Vl_TL_Outras,ffFixed,10,2);
  It_VL_Tl_Desconto      := Qr_Pedido.FieldByName('PED_VL_DESCONTO').AsCurrency;
  lb_Vl_desconto.Caption := FloatToStrF(It_VL_Tl_Desconto,ffFixed,10,2);

  It_VL_TL_Produtos    := Qr_Pedido.FieldByName('PED_VL_PRODUTO').AsCurrency;
  E_VL_Produto.Caption := FloatToStrF(It_VL_TL_Produtos,ffFixed,10,2);

  It_VL_TL_Servicos    := Qr_Pedido.FieldByName('PED_VL_SERVICO').AsCurrency;
  E_VL_Servico.Caption := FloatToStrF(It_VL_TL_Servicos ,ffFixed,10,2);

  It_Vl_total         := Qr_Pedido.FieldByName('PED_VL_PEDIDO').AsCurrency;
  Lb_VL_Total.Caption := FloatToStrF(It_Vl_total,ffFixed,10,2);
  It_Vl_TL_Pedido     := It_Vl_total;
  E_VL_Nota.Caption   := FloatToStrF(It_Vl_total,ffFixed,10,2);
  It_Vl_TL_NotaFiscal := It_Vl_total;
  
  It_Vl_Credito := It_vl_Credito;
  E_Vl_Credito.Text := FloatToStrF(It_Vl_Credito,ffFixed,10,2);
  E_Especie.Text:='VOLUME';

  E_Dt_Emissao.Date := Date;
  E_Dt_Saida.Date := Date;


end;





procedure TFr_Fatura_Cst.Pc_Parcelamento;
Begin
  It_Vl_Parcelamento := It_Vl_total - It_Vl_Cheque - It_Vl_Dinheiro - It_Vl_Cartao - It_Vl_Credito - It_Vl_Devolucao;
end;

procedure TFr_Fatura_Cst.Pc_TotalizaFinanceiro;
begin
  IF  NOT It_UsarCredito THEN
    It_Vl_Credito:= 0;
  Lb_Vl_Devolucao.Caption := FloatToStrF(It_Vl_Devolucao,ffFixed,10,2);
  Lb_VL_Total.Caption := FloatToStrF(It_Vl_TL_Pedido,ffFixed,10,2);
  if (It_Vl_Dinheiro + It_Vl_Cheque + It_Vl_Cartao +It_Vl_Credito)  > (StrToFloatDef(Lb_VL_Total.Caption,0)-It_Vl_Devolucao) then
    Lb_VL_Troco.Caption := FloatToStrF(It_Vl_Dinheiro + It_Vl_Cheque +It_Vl_Credito+ It_Vl_Cartao - (StrToFloatDef(Lb_VL_Total.Caption,0)-It_Vl_Devolucao),ffFixed,10,2)
  else
    Lb_VL_Troco.Caption :='0,00';
end;

procedure TFr_Fatura_Cst.Pc_GeraFinanceiro_Normal;
Var
  Lc_Cd_FormaPagto : Integer;
begin
  if It_uso_beneficio = 'D' then
    Begin
    Pc_GeraFinanceiro_DEVOLUCAO;
    end
  else
    Begin
    if StrToFloatDef(Lb_VL_Troco.Caption,0) > 0 then
      Pc_GeraFinanceiro_ComTroco
    else
      Pc_GeraFinanceiro_SemTroco; //AQUI OS VALORES Q FORAM DIGITADO NO CAMPOS VAI NO FINANCEIRO

    IF It_uso_beneficio = 'C' THEN
      pc_gerafinanceiro_credito;
    end;

  if (Fc_Tb_Geral('L','VDA_G_EMITE_BOLETO', 'N') = 'S') AND
     (Lc_Cd_FormaPagto = Fc_PegaFormaPgto('BOLETO')) then
    Begin
    Pc_GeraContasReceber(IBT_Faturamento,
                         E_Dt_Emissao.Date,
                         it_Cd_Pedido,
                         IntToStr(It_Nr_Pedido),
                         It_Cd_Nota,
                         StrZero(It_Nr_Nota,6,0),
                         It_cd_Empresa,
                         Qr_Pedido.FieldByName('PED_CODFPG').AsInteger,
                         StrToIntDef(Copy(Qr_Pedido.FieldByName('PED_PRAZO').AsString,1,3),1),
                         Qr_Pedido.FieldByName('PED_PRAZO').AsString,
                         StrToFloatDef(E_VL_Nota.Caption,0));
    end
  else
    Begin
    Pc_gera_parcelamento_restante
    end;

end;

procedure TFr_Fatura_Cst.Pc_Lanca_Caixa;
var
   Lc_Vl_Dinheiro,  Lc_Vl_Cheque,  Lc_Vl_Troco: Real;
begin
  Lc_Vl_Dinheiro := StrToFloatDef(E_VL_Dinheiro.Text, 0);
  Lc_Vl_Cheque := StrToFloatDef(E_VL_Cheque.Text, 0);
  Lc_Vl_Troco := StrToFloatDef(Lb_VL_Troco.Caption, 0);
  if Lc_Vl_Dinheiro > 0 then
    begin
    Pc_Movim_Financeiro(IBT_Faturamento,
                        'I',
                        0,
                        0,
                        Gb_DataCaixa,
                        0,
                        0,
                        0,
                        (Lc_Vl_Dinheiro - Lc_Vl_Troco),
                        0,
                        'PEDIDO Nº ' + IntToStr(It_Nr_Pedido),
                        'C',
                        It_Cd_Qtc_Dinheiro,
                        Gb_Cd_Usuario,
                        0,
                        Gb_DataCaixa,
                        '',
                        'N',
                        'S',
                        Gb_CodMha,
                        Fc_PegaParteFormaPgto('DINHEIRO'));
    Lc_Vl_Troco := Lc_Vl_Troco - Lc_Vl_Dinheiro;
    IF (Lc_Vl_Troco < 0) THEN Lc_Vl_Troco := 0;
  end;

  if Lc_Vl_Cheque > 0 then
    begin
    Pc_Movim_Financeiro(IBT_Faturamento,
                        'I',
                        0,
                        0,
                        gb_DataCaixa,
                        0,
                        Fm_CentroCusto.DBLCB_Plano.KeyValue,
                        Fm_CentroCusto.DBLCB_Plano.KeyValue,
                        (Lc_Vl_Cheque),
                        0,
                        'PEDIDO Nº ' + IntToStr(It_Nr_Pedido),
                        'C',
                        It_Cd_Qtc_Cheque,
                        Gb_Cd_Usuario,
                        0,
                        Gb_DataCaixa,
                        IntToStr(It_Nr_Pedido),
                        'N',
                        'S',
                        Gb_CodMha,
                        Fc_PegaFormaPgto('CHEQUE'));
    Lc_Vl_Troco := Lc_Vl_Troco - Lc_Vl_Cheque;
    IF (Lc_Vl_Troco < 0) THEN Lc_Vl_Troco := 0;
    END;

  IF (Lc_Vl_Troco > 0)  then
    Begin
    Pc_Movim_Financeiro(IBT_Faturamento,
                        'I',
                        0,
                        0,
                        Gb_DataCAixa,
                        0,
                        Fm_CentroCusto.DBLCB_Plano.KeyValue,
                        Fm_CentroCusto.DBLCB_Plano.KeyValue,
                        0,
                        (Lc_Vl_Troco),
                        'TROCO DO PEDIDO Nº ' + IntToStr(It_Nr_Pedido),
                        'D',
                        It_Cd_Qtc_Dinheiro,
                        Gb_Cd_Usuario,
                        0,
                        Gb_DataCAixa,
                        IntToStr(It_Nr_Pedido),
                        'N',
                        'S',
                        Gb_CodMha,
                        Fc_PegaParteFormaPgto('DINHEIRO'));
    end;
end;

//==============================================================================================================

procedure TFr_Fatura_Cst.Pc_Totalizador;
var
   Lc_Qr_Acao: TSTQuery;
begin
  Lc_Qr_Acao := TSTQuery.Create(Self);
  with Lc_Qr_Acao do
  Begin
    Active := False;
    Database := DM.IBD_Gestao;
    Transaction := IBT_Faturamento;
    ForcedRefresh := True;

    It_VL_TL_Produtos := 0;
    It_VL_TL_IPI := 0;
    It_Vl_TL_Seguro := 0;
    //Valor dos produtos
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT CAST(COALESCE(SUM((ITF_QTDE * ITF_VL_UNIT)), 0) AS NUMERIC(18, 2)) AS ITF_SUBTOTAL ' +
                     'FROM TB_ITENS_NFL tb_itens_nfl' +
                     '  INNER JOIN TB_PRODUTO tb_produto ' +
                     '  ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) ' +
                     'WHERE (PRO_TIPO <> ''S'') AND (ITF_CODPED=:ITF_CODPED) '+
                     'AND (ITF_OPER = ''V'') ');
    ParamByName('ITF_CODPED').AsInteger := It_Cd_Pedido;
    Active := True;
    It_VL_TL_Produtos := FieldByName('ITF_SUBTOTAL').AsCurrency;
    E_VL_Produto.Caption := FloatToStrF(It_VL_TL_Produtos , ffFixed, 10, 2);

    It_Vl_TL_NotaFiscal := (It_VL_TL_Produtos + It_VL_TL_Servicos + It_VL_TL_IPI) - It_VL_Tl_Desconto + It_Vl_TL_Frete + It_Vl_TL_Seguro + It_Vl_TL_Outras;
    E_VL_Nota.Caption := FloatToStrF(It_Vl_TL_NotaFiscal, ffFixed, 10, 2);
  End;
  Lc_Qr_Acao.Close;
  FreeAndNil(Lc_Qr_Acao);
end;

procedure TFr_Fatura_Cst.Pc_MontaGrade;
var
   Lc_I: integer;
   Lc_Valor: real;
begin
  StGrd_Prazo.RowCount := Qr_Parcelamento.RecordCount + 1;
  Lc_Valor := 0;
  Qr_Parcelamento.First;
  Tpk_Prazo.Date := Qr_Parcelamento.FieldByName('PAR_DATA').AsDateTime;
  for Lc_I := 1 to Qr_Parcelamento.RecordCount do
    begin
    StGrd_Prazo.Cells[0, Lc_I] := Qr_Parcelamento.FieldByName('PAR_PARCELA').AsString;
    StGrd_Prazo.Cells[1, Lc_I] := Qr_Parcelamento.FieldByName('PAR_DATA').AsString;
    StGrd_Prazo.Cells[2, Lc_I] := FloatToStrF(Qr_Parcelamento.FieldByName('PAR_VALOR').AsCurrency, ffFixed, 10, 2);
    Lc_Valor := Lc_Valor + Qr_Parcelamento.FieldByName('PAR_VALOR').AsCurrency;
    Qr_Parcelamento.Next;
    end;
end;

procedure TFr_Fatura_Cst.Pc_MontaPrazo(Pc_Qt_Parcela: Integer; Pc_Valor: Real; Pc_Data: Tdate);
var
   Lc_St_Parcela: string;
   Lc_Vl_Parcela: Real;
   Lc_I, Lc_J: Integer;
   Lc_Prazo: string;
   Lc_Vl_total : real;
begin
  for Lc_I := 1 to StGrd_Prazo.RowCount do
    for Lc_J := 1 to StGrd_Prazo.ColCount do
      StGrd_Prazo.Cells[Lc_j, Lc_I] := '';
  StGrd_Prazo.RowCount := 2;

  Qr_Pedido.Close;
  Qr_Pedido.ParamByName('PED_CODIGO').AsInteger:= It_Cd_Pedido;
  Qr_Pedido.Open;
  Qr_Pedido.RecordCount;

  if Pc_Valor > 0 then
    begin
    if Pc_Qt_Parcela = 0 then Pc_Qt_Parcela := 1;

    Pc_Define_FormatoRegional;
    //Resolvemos o problema da Divisão e dizima periodica
    Lc_Vl_total := It_Vl_total-It_Vl_Credito-It_Vl_Dinheiro-It_Vl_Cartao-It_Vl_Cheque;
    Lc_Vl_Parcela := Lc_Vl_total / Pc_Qt_Parcela;
    Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela, ffFixed, 10, 2);
    Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
    for Lc_I := 0 to (Pc_Qt_Parcela - 1) do
      begin
      StGrd_Prazo.RowCount := Pc_Qt_Parcela + 1;
      StGrd_Prazo.Cells[0, Lc_I + 1] := IntToStr(Lc_I);
      Lc_Prazo := Copy(Qr_Pedido.FieldByName('PED_PRAZO').AsString, ((Lc_I * 4) + 7), 3);
      IF (Lc_I = (Pc_Qt_Parcela - 1)) THEN
        Begin
        Lc_Vl_Parcela := Lc_Vl_total -  (Lc_Vl_Parcela * (Pc_Qt_Parcela - 1));
        Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
        StGrd_Prazo.Cells[2, Lc_I + 1] := Lc_St_Parcela;
        end
      else
        Begin
        StGrd_Prazo.Cells[2, Lc_I + 1] := Lc_St_Parcela;
        end;
      StGrd_Prazo.Cells[1, Lc_I + 1] := DateToStr(Pc_Data + StrToIntDef(Lc_Prazo, 0));
      end;
    Tpk_Prazo.Date := StrToDate(StGrd_Prazo.Cells[1, 1]);
    end
  else
    begin
    Tpk_Prazo.Date := E_Dt_Emissao.Date;
    StGrd_Prazo.Cells[1, 1] := DateToStr(Tpk_Prazo.Date);
    StGrd_Prazo.Cells[2, 1] := '0,00';
    end;
end;




function TFr_Fatura_Cst.fc_ValidaFaturamento(): Boolean;
Var
  Lc_Aux : String;
begin
  Result:=true;
  //Verifica Inventario
  if not Fc_ValidaDataPedido(E_Dt_Emissao.Date) then
  Begin
    Result := FAlse;
    E_Dt_Emissao.SetFocus;
    E_Dt_Emissao.Date := Date;
    Exit;
  end;


  if (StrToFloatDef(E_VL_Dinheiro.Text,0) > 0) or (StrToFloatDef(E_VL_Cheque.Text,0) > 0) then
  Begin
    if not Fc_VErificaCaixaAberto(False) then
    Begin
      MensagemPadrao('Mensagem ', ATENCAO + EOLN + EOLN +
                    ' Não existe um caixa aberto para este Usuário.' + EOLN +
                     'E a forma de pagamento Dinheiro/Cheque não é permitida.' + EOLN+
                     'Altere e forma de pagamento para continuar.'+ EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := False;
      exit;
    End;
  End;


  Qr_Pedido.Active := False;
  Qr_Pedido.ParamByName('PED_CODIGO').AsInteger := It_Cd_Pedido;
  Qr_Pedido.Active := True;
  Qr_Pedido.FetchAll;
  Qr_Pedido.First;

  if (StrToFloatDef(Lb_VL_troco.Caption,0) < 0) then
  begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' O Valor do troco não pode ser menor do que zero.' + EOLN +
                   ' Verifique os valores.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  It_vl_restante:= It_Vl_total - It_Vl_Credito - It_Vl_Devolucao;
  if not Fc_Validar_Valores_recebimento(It_uso_beneficio) then
  begin
      Result:=false;
      exit;
  end;

  if (It_vl_restante > It_Vl_TL_Pedido)  then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Valor do Pedido e Valores parcelados não coincidem.' + EOLN +
                   'Verifique os valores do parcelamento.' + EOLN,
                   ['OK'], [bEscape], mpErro);
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

  if not Fc_Valida_Valor_Parcela then
  begin
    Result := False;
    exit;
  end;

  if not Fc_ValidaTroco then
  begin
    Result := False;
    exit;
  end;

  //Faz auditoria no pedido para garantir que os itens estão na movimentação do estoque
  Fc_AuditoriaEstoquePedido(It_Cd_Pedido,'N');


end;



procedure TFr_Fatura_Cst.Pc_ImprimeCupom;
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
      FreeandNil(Lc_Imp);
    end;
  end;
end;

procedure TFr_Fatura_Cst.SB_ConfirmarClick(Sender: TObject);
begin
  SB_Confirmar.Enabled := False;
  SB_Confirmar.Enabled := False;
  if fc_ValidaFaturamento then
  Begin
    Pc_Faturar_Conserto;
  end
  else
  Begin
    SB_Confirmar.Enabled := True;
  end;
end;

procedure TFr_Fatura_Cst.SB_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Fatura_Cst.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Fatura_Cst.DBLCB_TransportadoraKeyDown(Sender: TObject;
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

procedure TFr_Fatura_Cst.StGrd_PrazoClick(Sender: TObject);
begin
   Tpk_Prazo.Top := StGrd_Prazo.Top + 21 + (21 * (StGrd_Prazo.Row - 1));
   Tpk_Prazo.DateTime := StrToDateDef(StGrd_Prazo.Cells[1, (StGrd_Prazo.Row)], Date);
   Tpk_Prazo.Visible := tRUE;

end;

procedure TFr_Fatura_Cst.Tpk_PrazoChange(Sender: TObject);
begin
   StGrd_Prazo.Cells[1, (StGrd_Prazo.Row)] := DateToStr(Tpk_Prazo.DateTime);

end;

procedure TFr_Fatura_Cst.Sb_TransportadoraClick(Sender: TObject);
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

procedure TFr_Fatura_Cst.StGrd_PrazoDrawCell(Sender: TObject; ACol,
   ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   LarguraTexto, AlturaTexto, X, Y: integer;
   Texto: string;
begin
   if (arow > 0) and (acol > 0) then // testa se não é a primeira linha (fixa)
   begin
      StGrd_Prazo.Canvas.Font.Color := clBlack;
      StGrd_Prazo.Canvas.Brush.Color := clMoneyGreen;
   end;
   StGrd_Prazo.Canvas.FillRect(Rect); // redesenha a celula
   StGrd_Prazo.Canvas.TextOut(Rect.Left + 2, Rect.Top, StGrd_Prazo.Cells[acol, arow]); // reimprime o texto.

  { Pega o texto da célula }
   Texto := StGrd_Prazo.Cells[acol, ARow];
  if (ACol = 2) and (ARow > 0) then Texto := FloatToStrF(StrToFloatDef(Texto,0),ffFixed,10,2);
  { Calcura largura e altura (em pontos) do texto }
   LarguraTexto := StGrd_Prazo.Canvas.TextWidth(Texto);
   AlturaTexto := StGrd_Prazo.Canvas.TextHeight(Texto);

  { Calcula a posição horizontal do início do texto }
   if (ACol = 1) then { esquerda }
      X := Rect.Left + 2
   else if (ACol = 5) then { Centro }
      X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
         LarguraTexto div 2
   else { Direita }
      X := Rect.Right - LarguraTexto - 2;


  { Calcula a posição vertical do início do texto para
    que seja impresso no centro (verticalmente) da célula }
   Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 -
      AlturaTexto div 2;

  { Pinta o texto }
   StGrd_Prazo.Canvas.TextRect(Rect, X, Y, Texto);

end;

procedure TFr_Fatura_Cst.FormCreate(Sender: TObject);
begin
  NotaFiscal := TControllerNotaFiscal.create(Self);
  Financeiro  := TControllerFinanceiro.Create(self);
end;

procedure TFr_Fatura_Cst.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFr_Fatura_Cst.StGrd_PrazoSetEditText(Sender: TObject; ACol,
   ARow: Integer; const Value: string);
var
   lc_I: Integer;
begin
   if ACol = 2 then
   begin
      It_Vl_Parcelamento := 0;
      for LC_I := 1 to StGrd_Prazo.RowCount - 1 do
         It_Vl_Parcelamento := It_Vl_Parcelamento + StrToFloatDef(StGrd_Prazo.Cells[2, LC_I], 0);

      Pc_TotalizaFinanceiro;
   end;
end;

procedure TFr_Fatura_Cst.FormShow(Sender: TObject);
var
  CanSelect: boolean;
begin
  Pc_AtivarTabela;
  Pc_Inicia_Variaveis;
  Pc_FormataTela;
  Pc_ImagemBotao;

  E_VL_Frete.Text:= FormatFloat('0.00',It_Vl_TL_Frete);

  StGrd_PrazoSelectCell(Sender, 1, 1, CanSelect);
  Qr_Parcelamento.Active := false;
  Qr_Parcelamento.ParamByName('PAR_CODPED').AsInteger := It_Cd_Pedido;
  Qr_Parcelamento.Active := true;
  Qr_Parcelamento.FetchAll;
  if Qr_Parcelamento.RecordCount = 0 then
    begin
    It_Vl_Parcelamento := It_Vl_total - It_Vl_Cheque - It_Vl_Dinheiro - It_Vl_Cartao - It_Vl_Credito;
    Pc_TotalizaFinanceiro;
    Pc_MontaPrazo(StrToIntDef(Copy(Qr_Pedido.FieldByName('PED_PRAZO').AsString,1,3),1), It_Vl_Parcelamento, E_Dt_Emissao.dATE);
    end
  else
    begin
    Pc_MontaGrade;
    end;
  Lb_VL_Total.Caption := FloatToStrF(It_Vl_TL_Pedido,ffFixed,10,2);
  Pc_AtivarTabela;
  Dblcb_Modal_Frete.KeyValue := StrToIntDef(Fc_Tb_Geral('L', 'FAT_TIPOFRETE', '0'),0);

  if (Fc_Tb_Geral('L','VDA_G_CTRL_PARCELA','') <> 'A') then
    begin
    StGrd_Prazo.Enabled := False;
    Tpk_Prazo.Enabled := False;
    end;

  Pc_AtivaEstabelecimento;
  DBLCB_Transportadora.KeyValue := Fc_Preenche_Transportadora(It_cd_empresa);

  E_Vl_Credito.Enabled:=false;
  if (It_UsarCredito) and (It_Vl_Credito > 0) then
    E_Vl_Credito.Text:=  FloattoStrf(it_Vl_Credito,ffFixed,10,2)
  ELSE
     E_Vl_Credito.Text:='0,00';
end;

procedure TFr_Fatura_Cst.StGrd_PrazoSelectCell(Sender: TObject; ACol,
   ARow: Integer; var CanSelect: Boolean);
var
   R: TRect;
begin
   if ((ACol = 1) and (ARow <> 0)) then
   begin
      R := StGrd_Prazo.CellRect(ACol, ARow);
      R.Left := R.Left + StGrd_Prazo.Left;
      R.Right := R.Right + StGrd_Prazo.Left;
      R.Top := R.Top + StGrd_Prazo.Top;
      R.Bottom := R.Bottom + StGrd_Prazo.Top;
      Tpk_Prazo.Left := R.Left + 1;
      Tpk_Prazo.Top := R.Top + 1;
      Tpk_Prazo.Width := (R.Right + 1) - R.Left;
      Tpk_Prazo.Height := (R.Bottom + 1) - R.Top;
      Tpk_Prazo.Visible := True;
      Tpk_Prazo.SetFocus;
   end;
   CanSelect := True;
end;

procedure TFr_Fatura_Cst.E_Dt_EmissaoExit(Sender: TObject);
begin
   It_Vl_Parcelamento := It_Vl_total - It_Vl_Dinheiro - It_Vl_Cheque;
   It_Vl_Parcelamento := It_Vl_total - It_Vl_Cheque - It_Vl_Dinheiro - It_Vl_Cartao - It_Vl_Credito;
   Pc_MontaPrazo(StrToIntDef(Copy(Qr_Pedido.FieldByName('PED_PRAZO').AsString,1,3),1), It_Vl_Parcelamento, E_Dt_Emissao.dATE);
end;

procedure TFr_Fatura_Cst.E_VL_DinheiroChange(Sender: TObject);
begin
  It_Vl_Dinheiro := StrToFloatDef(E_VL_Dinheiro.Text,0);
  Pc_Parcelamento;
  Pc_TotalizaFinanceiro;
  Pc_MontaPrazo(StrToIntDef(Copy(Qr_Pedido.FieldByName('PED_PRAZO').AsString,1,3),1),It_Vl_Parcelamento,E_Dt_Emissao.dATE);
end;

procedure TFr_Fatura_Cst.E_VL_ChequeChange(Sender: TObject);
begin
  It_Vl_Cheque := StrToFloatDef(E_VL_Cheque.Text,0);
  Pc_Parcelamento;
  Pc_TotalizaFinanceiro;
  Pc_MontaPrazo(StrToIntDef(Copy(Qr_Pedido.FieldByName('PED_PRAZO').AsString,1,3),1),It_Vl_Parcelamento,E_Dt_Emissao.dATE);
end;

procedure TFr_Fatura_Cst.E_VL_DinheiroExit(Sender: TObject);
begin;
   E_VL_Dinheiro.Text := FloatToStrF(It_Vl_Dinheiro, ffFixed, 10, 2);
end;

procedure TFr_Fatura_Cst.E_VL_ChequeExit(Sender: TObject);
begin
   E_VL_Cheque.Text := FloatToStrF(It_Vl_Cheque, ffFixed, 10, 2);
end;

procedure TFr_Fatura_Cst.E_VL_DinheiroEnter(Sender: TObject);
begin
   E_VL_Dinheiro.SelectAll;
end;

procedure TFr_Fatura_Cst.E_VL_ChequeEnter(Sender: TObject);
begin
   E_VL_Cheque.SelectAll;
end;

procedure TFr_Fatura_Cst.E_Vl_CartaoChange(Sender: TObject);
begin
  It_Vl_Cartao := StrToFloatDef(E_Vl_Cartao.Text,0);
  Pc_Parcelamento;
  Pc_TotalizaFinanceiro;
  Pc_MontaPrazo(StrToIntDef(Copy(Qr_Pedido.FieldByName('PED_PRAZO').AsString,1,3),1),It_Vl_Parcelamento,E_Dt_Emissao.dATE);
end;

procedure TFr_Fatura_Cst.E_Vl_CartaoEnter(Sender: TObject);
begin
   E_Vl_Cartao.SelectAll;
end;

procedure TFr_Fatura_Cst.E_Vl_CartaoExit(Sender: TObject);
begin
   E_Vl_Cartao.Text := FloatToStrF(It_Vl_Cartao, ffFixed, 10, 2);
end;

procedure TFr_Fatura_Cst.E_Vl_CreditoEnter(Sender: TObject);
begin
   E_Vl_Credito.SelectAll;
end;

procedure TFr_Fatura_Cst.E_Vl_CreditoExit(Sender: TObject);
begin
   E_Vl_Credito.Text := FloatToStrF(It_Vl_Credito, ffFixed, 10, 2);
end;

procedure TFr_Fatura_Cst.E_Vl_CreditoChange(Sender: TObject);
var
   Lc_Vl_Cred_1: Real;
   Lc_Vl_Cred_2: Real;
begin
   Lc_Vl_Cred_1 := StrToFloatDef(E_Vl_Credito.Text, 0);
   Lc_Vl_Cred_2 := It_Vl_Credito;
   if (Lc_Vl_Cred_1 <= Lc_Vl_Cred_2) then
   begin
      It_Vl_Credito := Lc_Vl_Cred_1;
      Pc_Parcelamento;
      Pc_TotalizaFinanceiro;
      Pc_MontaPrazo(StrToIntDef(Copy(Qr_Pedido.FieldByName('PED_PRAZO').AsString,1,3),1), It_Vl_Parcelamento, E_Dt_Emissao.dATE);
   end
   else
   begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
         'O Valor de Crédito informado maior do que o ' + EOLN +
         'disponível no sistema. Verifique.' + EOLN,
         ['OK'], [bEscape], mpErro);
   end;
end;


function TFr_Fatura_Cst.Fc_ConfirmaValores(): boolean;
begin
  If Pg_Resumo.ActivePageIndex <> 0 then Pg_Resumo.ActivePageIndex := 0;

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






Procedure TFr_Fatura_Cst.chbx_data_saidaClick(Sender: TObject);
begin
  E_Dt_Saida.Enabled := chbx_data_saida.Checked;
end;

function TFr_Fatura_Cst.Fc_Validar_Valores_recebimento(Pc_Beneficio:char): Boolean;
VAR
lc_vl_pedido,lc_valor_tl_pagamento:double;
begin
  result:=true;
  if Pc_Beneficio = 'D' then// regras somente quando pedido tive devolucao
  begin
  lc_valor_tl_pagamento:=it_Vl_Dinheiro +It_Vl_Cartao+It_Vl_Cheque;
  lc_vl_pedido:=It_Vl_total-It_Vl_Devolucao;
    if ( (It_Vl_Dinheiro>0) or(It_Vl_Cheque>0)   or (It_Vl_Cartao>0) )
    and ( (FloatToStrF(lc_valor_tl_pagamento,ffFixed,10,2)) <> (FloatToStrF(lc_vl_pedido,ffFixed,10,2)) )then
    begin
    MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                   ' Pedido com devoluíao.Não pode ter valores parcial.' + EOLN +
                   ' Verifique os valores e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
    end;
  end
  ELSE
  BEGIN
    if (It_Vl_Cartao > It_vl_restante)  and ((It_Vl_Dinheiro>0) or (It_Vl_Cheque>0)) then
    begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Valor do Cartão maior que o valor do pedido.' + EOLN +
                   'Não é necessário valores com dinheiro ou cheque.' + EOLN ,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
    end;

    if (It_Vl_Cheque > It_vl_restante)  and ((It_Vl_Dinheiro>0) or (It_Vl_Cartao>0)) then
    begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Valor do Cheque é maior que o valor do pedido.' + EOLN +
                   'Não é necessário valores com dinheiro ou cartão.' + EOLN ,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
    end;

    if Pc_Beneficio = 'C' then// regras somente quando pedido tive USANDO  credito
    begin
      If (It_UsarCredito) AND (It_Vl_Credito >=  It_Vl_TL_Pedido) AND
       (((StrToFloatDef(E_VL_Dinheiro.Text,0) >0)  or (StrToFloatDef(E_VL_Cheque.Text,0) >0))
       or (StrToFloatDef(E_Vl_Cartao.Text,0) >0)) then
       begin
       MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                      ' Seu Crédito maior que o Valor do Pedido.' + EOLN +
                      ' Não é necessário pagamento de dinheiro, cheque ou cartão.' + EOLN ,
                     ['OK'], [bEscape], mpErro);
       Result := False;
       exit;
       end;
    end;
  end;  
end;

function TFr_Fatura_Cst.Fc_ValidaTroco():Boolean;
Var
  Lc_Vl_troco : Real;
  Lc_Vl_Dinheiro : Real;
  Lc_Form : TFr_Liberacao;
Begin
  Result := true;
  //O valor do troco deve ser maior do que zero
  Lc_Vl_troco := StrtoFloatDef(Lb_VL_Troco.Caption,0);
  Lc_Vl_Dinheiro := StrtoFloatDef(E_VL_Dinheiro.Text,0);
  if (Lc_Vl_troco > 0) then
  Begin
    if (Lc_Vl_troco > Lc_Vl_Dinheiro) and not GB_Liberado then
      Begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         ' O valor do troco não pode ser maior do que' + EOLN +
                         ' o valor informado em dinheiro.' + EOLN +
                         'Deseja solicitar autorização? ?',
                         [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
        Begin
        Lc_Form := TFr_Liberacao.Create(nil);
        Lc_Form.ShowModal;
        if not GB_Liberado then
        Begin
          FreeAndNil(Lc_Form);
          Result := False;
          exit;
        end;
      end
      else
      Begin
        Result := False;
        exit;
      end;
    end;
  end;
end;

procedure TFr_Fatura_Cst.Pc_GeraFinanceiro_SemTroco;
begin

  //Verifica se o campo dinheiro foi preencido
  if StrToFloatDef(E_VL_Dinheiro.Text,0) > 0 then
    begin
    It_Cd_Qtc_Dinheiro := Fc_GeraCod_BAixa;
    Pc_Financeiro(IBT_Faturamento,'I', 0, It_cd_empresa, Date, It_Cd_Pedido, It_Cd_Nota, Fc_PegaParteFormaPgto('DINHEIRO'), '000 - VISTA', Date, InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
                (StrToFloatDef(E_VL_Dinheiro.Text,0)), 0, 0, 0, (StrToFloatDef(E_VL_Dinheiro.Text,0)), Date, Date, 'S', 1, 'RA', 'D', It_Cd_Qtc_Dinheiro, 'C', 'P',0);
    end;

  //Verifica se o campo cheque foi preenchido
  if StrToFloatDef(E_VL_Cheque.Text,0) > 0 then
    begin
    It_Cd_Qtc_Cheque := Fc_GeraCod_BAixa;
    Pc_Financeiro(IBT_Faturamento,'I', 0, It_cd_empresa, Date, It_Cd_Pedido, It_Cd_Nota, Fc_PegaFormaPgto('CHEQUE'), '000 - VISTA', Date, InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
                (StrToFloatDef(E_VL_Cheque.Text,0)), 0, 0, 0, StrToFloatDef(E_VL_Cheque.Text,0), Date, Date, 'N', 1, 'RA', 'D', It_Cd_Qtc_Cheque, 'C', 'P',0);

    end;

  //Verifica se o campo Cartão foi Preenchido
  if StrToFloatDef(E_Vl_Cartao.Text,0) > 0 then
    begin
    Pc_Financeiro(IBT_Faturamento,'I', 0, It_cd_empresa, Date, It_Cd_Pedido, It_Cd_Nota, Fc_PegaFormaPgto('CARTAO'), '000 - VISTA', Date, InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
         (StrToFloatDef(E_Vl_Cartao.Text,0)), 0, 0, 0, (StrToFloatDef(E_Vl_Cartao.Text,0)), Date, Date, 'N', 1, 'RA', 'N', 0, 'C', 'P',0);
     end;
end;

procedure TFr_Fatura_Cst.Pc_GeraFinanceiro_ComTroco;
var
  LC_saldo: real;
  LC_VALOR_baixado:Real;
begin
  //Verifica se o campo cheque foi preenchido
  if StrToFloatDef(E_VL_Cheque.Text,0) > 0 then
    begin
      LC_saldo:= (It_Vl_TL_Pedido - (It_Vl_Devolucao+It_Vl_Credito+It_Vl_Cartao+It_Vl_Dinheiro));
     IF (It_Vl_Cartao >0) OR (It_Vl_Dinheiro >0) then
       LC_VALOR_baixado:= It_Vl_Cheque   // aqui se refere q o valor q vai ser baixado vai ser do cartao mesmo, geroou troco por causa do dinheiro ou do cheque
     else
       LC_VALOR_baixado:= LC_saldo;//aqui se refere q digite o valor no cartao maior q o pedido, gero um troco e baixo o valor total do pedido.

    It_Cd_Qtc_Cheque := Fc_GeraCod_BAixa;
    Pc_Financeiro(IBT_Faturamento,'I', 0, It_cd_empresa, Date, It_Cd_Pedido, It_Cd_Nota, Fc_PegaFormaPgto('CHEQUE'), '000 - VISTA', Date, InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
                (LC_VALOR_baixado), 0, 0, 0, LC_VALOR_baixado, Date, Date, 'N', 1, 'RA', 'D', It_Cd_Qtc_Cheque, 'C', 'P',0);

    end;

  //Verifica se o campo Cartão foi Preenchido
  if StrToFloatDef(E_Vl_Cartao.Text,0) > 0 then
    begin
    LC_saldo:= (It_Vl_TL_Pedido - (It_Vl_Devolucao+It_Vl_Credito+It_Vl_Cheque+It_Vl_Dinheiro));    
    IF (It_Vl_Cheque >0) OR (It_Vl_Dinheiro >0) then
       LC_VALOR_baixado:= It_Vl_Cartao   // aqui se refere q o valor q vai ser baixado vai ser do cartao mesmo, geroou troco por causa do dinheiro ou do cheque
     else
       LC_VALOR_baixado:= LC_saldo;//aqui se refere q digite o valor no cartao maior q o pedido, gero um troco e baixo o valor total do pedido.
        
    Pc_Financeiro(IBT_Faturamento,'I', 0, It_cd_empresa, Date, It_Cd_Pedido, It_Cd_Nota, Fc_PegaFormaPgto('CARTAO'), '000 - VISTA', Date, InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
         LC_VALOR_baixado, 0, 0, 0, LC_VALOR_baixado, Date, Date, 'N', 1, 'RA', 'N', 0, 'C', 'P',0);
     end;

  //Verifica se o campo dinheiro foi preencido
  if StrToFloatDef(E_VL_Dinheiro.Text,0) > 0 then
    begin
    LC_saldo:= (It_Vl_TL_Pedido - (It_Vl_Devolucao+It_Vl_Credito+It_Vl_Cheque+It_Vl_Cartao));    
    It_Cd_Qtc_Dinheiro := Fc_GeraCod_BAixa;
    Pc_Financeiro(IBT_Faturamento,'I', 0, It_cd_empresa, Date, It_Cd_Pedido, It_Cd_Nota, Fc_PegaParteFormaPgto('DINHEIRO'), '000 - VISTA', Date, InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
                (LC_saldo), 0, 0, 0, (LC_saldo), Date, Date, 'S', 1, 'RA', 'D', It_Cd_Qtc_Dinheiro, 'C', 'P',0);
    end;

end;

procedure TFr_Fatura_Cst.Pc_gera_parcelamento_restante;
var
  Lc_I: Integer;
  Lc_Qt_Parcelas: Integer;
  Lc_Nr_Duplicata : String;
begin
  Lc_Qt_Parcelas := (StGrd_Prazo.RowCount - 1);

//  LC_saldo:= (It_Vl_TL_Pedido - It_Vl_Credito - (It_Vl_Dinheiro+It_Vl_Cheque+It_Vl_Cartao))/Lc_Qt_Parcelas;
//aqui geras os parcelamentos q falta
    if It_Nr_Nota > 0 then It_Nr_Duplicata := It_Nr_Nota;
    for Lc_I := 1 to Lc_Qt_Parcelas do
      begin
      if (StrToFloatDef(StGrd_Prazo.Cells[2, Lc_I],0) > 0) then
        begin
        if It_Nr_Duplicata > 0 then
          Lc_Nr_Duplicata := IntToStr(It_Nr_Pedido) + '/' + IntToStr(It_Nr_Duplicata) + '/' + IntToStr(Lc_I) + '-' + IntToStr(Lc_Qt_Parcelas)
        else
          Lc_Nr_Duplicata := IntToStr(It_Nr_Pedido) + '/' + IntToStr(Lc_I) + '-' + IntToStr(Lc_Qt_Parcelas);
        Pc_Financeiro(IBT_Faturamento,
                      'I',
                       0,
                       Qr_Pedido.FieldByName('PED_CODEMP').AsInteger,
                       E_Dt_Emissao.Date,
                       Qr_Pedido.FieldByName('PED_CODIGO').AsInteger,
                       It_Cd_Nota,
                       Qr_Pedido.FieldByName('PED_CODFPG').AsInteger,
                       Qr_Pedido.FieldByName('PED_PRAZO').AsString,
                       StrToDate(StGrd_Prazo.Cells[1, Lc_I]),
                       Lc_Nr_Duplicata,
                       StrToFloatDef(StGrd_Prazo.Cells[2, Lc_I],0),
                       0,
                       0,
                       0,
                       0,
                       Date,
                       Date,
                       'N',
                       Lc_I,
                       'RA',
                       'N',
                       0,
                       'C',
                       'N' ,
                       0);
        if IBT_Faturamento.InTransaction then IBT_Faturamento.CommitRetaining;
        end;
      end;
end;

procedure TFr_Fatura_Cst.Pc_BaixaCredito(Pc_Codigo: Integer;
  Pc_Vl_Credito: Real);
var
  Lc_Qry: TSTQuery;
  Lc_Sql: String;
begin
  Lc_Qry := TSTQuery.Create(Self);
  Lc_Qry.Database := DM.IBD_Gestao;
  Lc_Qry.Transaction := IBT_Faturamento;
  Lc_Qry.Active := False;
  Lc_Qry.SQL.Clear;
  Lc_Sql := 'SELECT                                             '+
            '   FIN_CODIGO,                                     '+
            '   FIN_CODEMP,                                     '+
            '   FIN_CODPED,                                     '+
            '   FIN_CODNFL,                                     '+
            '   FIN_VL_PARCELA,                                 '+
            '   FIN_NUMERO,                                     '+
            '   PED_NUMERO,                                     '+
            '   FIN_DT_VENCIMENTO                               '+
            ' FROM TB_FINANCEIRO FIN                            '+
            ' LEFT JOIN TB_PEDIDO TB_PEDIDO ON                  '+
            ' TB_PEDIDO.PED_CODIGO = FIN.FIN_CODPED             '+
            'WHERE (FIN_BAIXA = ''N'')                          '+
            '  AND (FIN_CODEMP=:FIN_CODEMP)                     '+
            '  AND ((FIN_TIPO = ''RA'') OR (FIN_TIPO = ''RM'')) '+
            '  AND (FIN_OPERACAO = ''D'')                       ';
  Lc_Qry.SQL.Add(Lc_Sql);

  Lc_Qry.ParamByName('FIN_CODEMP').AsInteger := Pc_Codigo;
  Lc_Qry.Active := True;

  Lc_Qry.First;
  while not Lc_Qry.Eof do
  begin
    Pc_Financeiro(IBT_Faturamento, 'B',Lc_Qry.FieldByName('FIN_CODIGO').AsInteger ,
                  Lc_Qry.FieldByName('FIN_CODEMP').AsInteger, Date,
                  Lc_Qry.FieldByName('FIN_CODPED').AsInteger,
                  Lc_Qry.FieldByName('FIN_CODNFL').AsInteger,
                  Fc_PegaFormaPgto('CARTEIRA'),
                  '000 - VISTA', Date, Lc_Qry.FieldByName('FIN_NUMERO').AsString, Lc_Qry.FieldByName('FIN_VL_PARCELA').AsCurrency,
                  0, 0, 0, Lc_Qry.FieldByName('FIN_VL_PARCELA').AsCurrency,
                  Date, Date, 'S', 1, 'RA', 'N', 0, 'C', 'P', 0);
    Lc_Qry.Next;
  end;
  if It_Vl_Credito > StrToFloatDef(Lb_VL_Total.Caption,0) THEN
  // ELE SO VAI INSERI O SALDO COM O SALDO ATUAL SE O CREDITO FOR MAIOR Q O PEDIDO  
  Pc_InseriCredito(Lc_Qry.FieldByName('FIN_CODPED').AsInteger,
                   Lc_Qry.FieldByName('FIN_CODNFL').AsInteger,
                   Lc_Qry.FieldByName('PED_NUMERO').AsString);
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure TFr_Fatura_Cst.Pc_InseriCredito(Pc_Cd_pedido,
  Pc_cd_Nota: Integer; Pc_Nr_pedido: STRING);
var
lc_valor_credito:double;
begin
  lc_valor_credito:= It_Vl_Credito -StrToFloatDef(Lb_VL_Total.Caption,0);

  //GERA no financeiro uma credito pra o cliente como haver
  Pc_Financeiro(IBT_Faturamento,'I', 0, It_cd_empresa, Date, It_Cd_pedido,
                It_cd_Nota, Fc_PegaFormaPgto('CARTEIRA'), '000 - VISTA', Date,
                IntToStr(It_Nr_pedido) + '/' + IntToStr(It_Nr_pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
               (lc_valor_credito), 0, 0, 0, (lc_valor_credito), Date, Date, 'N', 1, 'RA', 'N', 0,'D','P', 0);
end;

procedure TFr_Fatura_Cst.Pc_GeraFinanceiro_Credito;
begin
  Pc_BaixaCredito(It_Cd_Empresa, it_Vl_Credito);
  IF It_Vl_Credito > It_Vl_total THEN
    BEGIN // AQUI EU GERO VALOR BAIXADO, COM O VALOR DO PEDIDO TOTAL POIS O CREDITOE MAIOR Q O TOTAL COMO DEBITO BAIXADO
    Pc_Financeiro(IBT_Faturamento,'I', 0, It_cd_empresa, Date, It_Cd_Pedido, It_Cd_Nota, Fc_PegaParteFormaPgto('DINHEIRO'), '000 - VISTA', Date, InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
                 (It_Vl_total), 0, 0, 0, (It_Vl_total), Date, Date, 'S', 1, 'RA', 'D', It_Cd_Qtc_Dinheiro, 'C', 'P',0);
    END
  ELSE
    BEGIN// AQUI EU GERO VALOR BAIXADO, COM O VALOR DO CREDITO O VALOR DA COMPRA E MAIOR Q O CREDITO  COMO CREDITO BAIXADO
    Pc_Financeiro(IBT_Faturamento,'I', 0, It_cd_empresa, Date, It_Cd_Pedido, It_Cd_Nota, Fc_PegaParteFormaPgto('DINHEIRO'), '000 - VISTA', Date, InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
                 (It_Vl_Credito), 0, 0, 0, (It_Vl_Credito), Date, Date, 'S', 1, 'RA', 'D', It_Cd_Qtc_Dinheiro, 'C', 'P',0);
    END;

end;


procedure TFr_Fatura_Cst.Pc_GeraFinanceiro_Devolucao;
var
  lc_baixa:String;
  LC_SITUACAo:String;
begin
  lc_baixa:= 'N';
  if (It_Vl_Dinheiro<>0) or (It_Vl_Cartao<>0)  or (It_Vl_Cheque<>0) then
  begin
    lc_baixa:='S';//vai como baixado
    //Verifica se o campo dinheiro foi preencido
    if StrToFloatDef(E_VL_Dinheiro.Text,0) > 0 then
    begin
      It_Cd_Qtc_Dinheiro := Fc_GeraCod_BAixa;
      Pc_Financeiro(IBT_Faturamento,
                   'I',
                   0,
                   It_cd_empresa,
                   Date,
                   It_Cd_Pedido,
                   It_Cd_Nota,
                   Fc_PegaParteFormaPgto('DINHEIRO'),
                   '000 - VISTA',
                   Date,
                   InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
                   (StrToFloatDef(E_VL_Dinheiro.Text,0)),
                   0,
                   0,
                   0,
                   (StrToFloatDef(E_VL_Dinheiro.Text,0)),
                   Date,
                   Date,
                   'S',
                   1,
                   'RA',
                   'D',
                   It_Cd_Qtc_Dinheiro,
                   'C',
                   'N',
                   0);
    END;

  //Verifica se o campo cheque foi preenchido
         if StrToFloatDef(E_VL_Cheque.Text,0) > 0 then
         begin
          It_Cd_Qtc_Cheque := Fc_GeraCod_BAixa;
          Pc_Financeiro(IBT_Faturamento,'I', 0, It_cd_empresa, Date, It_Cd_Pedido, It_Cd_Nota, Fc_PegaFormaPgto('CHEQUE'), '000 - VISTA', Date, InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
         (StrToFloatDef(E_VL_Cheque.Text,0)), 0, 0, 0, StrToFloatDef(E_VL_Cheque.Text,0), Date, Date, 'S', 1, 'RA', 'D', It_Cd_Qtc_Cheque, 'C', 'P',0);
         end;

   //Verifica se o campo Cartão foi Preenchido
    if StrToFloatDef(E_Vl_Cartao.Text,0) > 0 then
      begin
       Pc_Financeiro(IBT_Faturamento,'I', 0, It_cd_empresa, Date, It_Cd_Pedido, It_Cd_Nota, Fc_PegaFormaPgto('CARTAO'), '000 - VISTA', Date, InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' + IntToStr(1) + '-' + IntToStr(1),
      (StrToFloatDef(E_Vl_Cartao.Text,0)), 0, 0, 0, (StrToFloatDef(E_VL_Dinheiro.Text,0)), Date, Date, 'S', 1, 'RA', 'D', 0, 'C', 'N',0);
     end;
  end;

  LC_SITUACAo:='N';
  if lc_baixa = 'S' then //aqui diz q foi quitado toda devolucao entao gero um debito pra quita   a devolucao credito
  begin
   //Gera o Debito do Cliente para a contrapartida da Parcela de Credito Gerada  como baixad - (Fin_Operação "C" no Contas a Receber, Ja Baixado
    Pc_Financeiro(IBT_Faturamento, 'I', 0, It_cd_empresa, Date, It_Cd_Pedido, It_Cd_Nota, Fc_PegaFormaPgto('CARTEIRA'), '000 - VISTA', Date, InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' +IntToStr(1) + '-' + IntToStr(1),
    (StrToFloatDef(Lb_Vl_Devolucao.Caption,0)), 0,0,0,0   ,  Date, Date, lc_baixa, 1, 'RA','N', 0,'C','P',0);
    LC_SITUACAo:='D';
  end;

    //Gera Credito normal para o Cliente (Fin_Operação "D" no Contas a Receber
     Pc_Financeiro(IBT_Faturamento,
                    'I',
                    0,
                    It_cd_empresa,
                    Date,
                    It_Cd_Pedido,
                    It_Cd_Nota,
                    Fc_PegaFormaPgto('CARTEIRA'),
                    '000 - VISTA',
                    Date,
                    InttoStr(It_Nr_Pedido) + '/' + InttoStr(It_Nr_Pedido) + '/' +IntToStr(1) + '-' + IntToStr(1),
                    (StrToFloatDef(Lb_Vl_Devolucao.Caption,0)),
                    0,
                    0,
                    0,
                    (StrToFloatDef(Lb_Vl_Devolucao.Caption,0)),
                    Date,
                    Date,
                    lc_baixa,
                    1,
                    'RA',
                    LC_SITUACAo,
                    0,
                    'D',
                    'P'
                    ,0)
end;
function TFr_Fatura_Cst.Fc_Valida_Valor_Parcela(): Boolean;
var
  Lc_valor : Real;
  Lc_Vl_Troco : Real;
  Lc_Texto : String;
  LC_I : Integer;
begin
  result := true;
  Lc_valor := 0;
  for LC_I := 1 to StGrd_Prazo.RowCount - 1 do
    Lc_valor := Lc_valor  + StrToFloatDef(StGrd_Prazo.Cells[2, LC_I], 0);
  Lc_Vl_Troco := StrToFloatDef(Lb_VL_Troco.Caption,0);
  Lc_valor := Lc_valor + It_Vl_Dinheiro + It_Vl_Cheque + It_Vl_Cartao + It_Vl_Credito - Lc_Vl_Troco;
  Lc_Texto := FloatToStrF(Lc_valor,ffFixed,10,2);
  IF (E_VL_Nota.caption <> Lc_Texto) then
    Begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Verifique os valores do parcelamento' + EOLN ,
                  ['OK'], [bEscape], mpErro);
    result := false;
    end
end;

procedure TFr_Fatura_Cst.StGrd_PrazoKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (Key in['0'..'9',Chr(8),',']) then Key:= #0;
end;



procedure TFr_Fatura_Cst.E_Qt_ProdutoChange(Sender: TObject);
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



