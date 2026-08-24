unit Un_Fatura_Srv;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, DB, STStoredProc, StdCtrls, DBCtrls, System.Math, Mask, ExtCtrls, STQuery, Printers, ComCtrls, Grids, QEdit_Setes, STDatabase, tributacao, AcbrBoleto, ACBrBoletoFCFortesFr;

type
   TFr_Fatura_Srv = class(TForm)
    Panel2: TPanel;
    Label9: TLabel;
    E_Obs: TMemo;
    Panel1: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    PrintDialog1: TPrintDialog;
    Label6: TLabel;
    E_Dt_Emissao: TDateTimePicker;
    ChBx_AutorizacaoNFSe: TCheckBox;
    Label1: TLabel;
    E_VL_Nota: TPanel;
    Label22: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    E_Vl_ISS_retido: TEdit_Setes;
    E_VL_ISS: TEdit_Setes;
    E_VL_Bs_ISS: TEdit_Setes;
    Label2: TLabel;
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
   private
    { Private declarations }
    //Verifica se é usuario de NfCe
    It_Usa_NFCe : Boolean;
      Tributacao : ttributacao;
   public
    { Public declarations }
    it_fatura_ok : Boolean;
    It_Nr_Pedido: String;
    It_Cd_Pedido: Integer;
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
    procedure Pc_Faturar_Servico;
    procedure Pc_Gera_Financeiro;
    procedure Pc_Gera_Comissao;

    procedure Pc_ImpressaoAutomaticaBoleto(Pc_cd_Pedido:Integer);

   end;
var
   Fr_Fatura_Srv: TFr_Fatura_Srv;

implementation


uses
Un_DM, Un_Msg, Un_Funcoes, UN_Sistema, Un_Clta_Csto, Un_MinhaEmpresa, un_Padrao, UN_NF, Un_Fc_Comissao, Un_Fc_Sored_Procedures, Un_Imp_Mod_Impressao, Un_Regra_Negocio, Un_Transportadora, Un_Liberacao, RN_Cliente, RN_NotaFiscal, UN_Principal, env, RN_Inventario, RN_Estoque, RN_PlanoContas, Un_WebService, RN_Transportadora, RN_FormaPagto, RN_BoletoEletronico, RN_Permissao, Un_Fatura_Fin, RN_Pedido, RN_Financeiro, RN_NotaFiscalEletronica3X, RN_Crud;

{$R *.dfm}

procedure TFr_Fatura_Srv.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    SB_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
    END;
end;



procedure TFr_Fatura_Srv.Pc_FormataTela;
Begin

end;

procedure TFr_Fatura_Srv.Pc_Inicia_Variaveis;
Begin
  //CONFIGURAÇÕES DA NFCe
  E_Dt_Emissao.Date := Date;
end;

procedure TFr_Fatura_Srv.Pc_AtivarTabela;
begin

end;

function TFr_Fatura_Srv.fc_ValidaFaturamento(): Boolean;
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

  If It_Usa_NFCe then
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

end;



procedure TFr_Fatura_Srv.Pc_ImprimeCupom;
Var
  Lc_Imp: TimpModImpressao;
begin
  if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_TP_CUPOM_FAT','')) = 'S' then
  Begin
    Try
      Lc_Imp := TimpModImpressao.create(nil);
      Lc_Imp.It_Tp_Doc:='PEDIDO: ';
      Lc_Imp.CodigoPedido := It_cd_Pedido;
      Lc_Imp.Pc_Imp_Cupom;
    finally
      FreeandNil(Lc_Imp);
    end;
  end;
end;




procedure TFr_Fatura_Srv.Pc_GravaUltimasConfiguracoes;
Begin

end;

procedure TFr_Fatura_Srv.Pc_Gera_Comissao;
Begin
  //Geração de Comissão
  Pc_Construtor_Comissao(DM.IBT_Faturamento);
  Pc_Deleta_Vdo_Pedido(DM.IBT_Faturamento,It_Cd_Pedido,0,'');
  Pc_Registra_Vdo_Pedido(DM.IBT_Faturamento, It_Cd_Pedido);
  if Fc_Tb_Geral('L','TP_COMISSAO','') ='F' then
    Begin
    Pc_Gerar_Comissao_Srv_Fat(DM.IBT_Faturamento, It_Cd_Pedido);
    Pc_Gerar_Comissao_Srv_Vdo_Fat(DM.IBT_Faturamento, It_Cd_Pedido);
    end;
  Pc_Destrutor_Comissao;
end;


procedure TFr_Fatura_Srv.Pc_Faturar_Servico;
Begin
  it_fatura_ok := true;
  Pc_Define_FormatoRegional;
  it_fatura_ok := Fc_Faturar_Normal;
  if it_fatura_ok then
  Begin
    //Processo de Comissão
    Pc_Gera_Comissao;
    //Impressão do cupom não fiscal
    Pc_ImprimeCupom;
    //Grava dados da tela atual
    Pc_GravaUltimasConfiguracoes;
    //Gera Processo financeiro
    if (Fc_Tb_Geral('L','FIN_G_ATIVAR','') = 'S') then
      Pc_Gera_Financeiro;
    //Chama a tela de autorização da nota fiscal eltronica
    if ChBx_AutorizacaoNFSe.Checked then
    begin
     ShowMessage('Em Desenvolvimento');
    end;
    It_Cd_Pedido := 0;
    Close;
    end
  else
  Begin
    Pc_GravaUltimasConfiguracoes;
    It_Fatura_Ok := False;
    Close;
  end;
end;



procedure TFr_Fatura_Srv.Pc_Gera_Financeiro;
var
   Lc_I: Integer;
   Lc_Qt_Parcelas: Integer;
   Lc_Nr_Duplicata : String;
  Lc_Form : TFr_Fatura_fin;
begin
  Lc_Form := TFr_Fatura_fin.Create(Fr_Fatura_Srv);
  Lc_Form.It_Confirma := False;
  Lc_Form.It_cd_Nota := Tributacao.NotaFiscal.Registro.Codigo;
  Lc_Form.It_Tipo_Finaceiro := 'RA';
  Lc_Form.It_Oper_Financeiro := 'C';
  Lc_Form.It_Hist_Caixa := 'SERVIÇO Nº ';
  Lc_Form.PegaContaGerencialAuto := True;
  Lc_Form.TelaVenda := True;
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
end;

procedure TFr_Fatura_Srv.SB_ConfirmarClick(Sender: TObject);
begin
  TRY
    Self.Enabled := False;
    Pc_ProcesoAguarde(Self,'I');
    Pc_CarregaComponenteTributacao;
    if fc_ValidaFaturamento then
    Begin
      Pc_Faturar_Servico;
    end;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := True;
  end;
end;

procedure TFr_Fatura_Srv.SB_Sair_0Click(Sender: TObject);
begin
   Close;
end;

procedure TFr_Fatura_Srv.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not (ActiveControl is TMemo) then
    begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFr_Fatura_Srv.FormCreate(Sender: TObject);
begin
  Tributacao := ttributacao.create(Self);
end;

procedure TFr_Fatura_Srv.FormKeyDown(Sender: TObject; var Key: Word;
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


procedure TFr_Fatura_Srv.FormShow(Sender: TObject);
var
  CanSelect: boolean;
begin
  Pc_AtivarTabela;
  Pc_Inicia_Variaveis;
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_AtivarTabela;
end;



function TFr_Fatura_Srv.Fc_ConfirmaValores(): boolean;
begin
  //Preenche os campos com os totais
  with Tributacao.It_Nfe.NotasFiscais[0].NFe do
  BEgin
    E_VL_Bs_ISS.Text := FloatToStrF(Total.ISSQNtot.vBC, ffFixed, 10, 2);
    E_VL_ISS.Text := FloatToStrF(Total.ISSQNtot.vISS, ffFixed, 10, 2);
    E_Vl_ISS_retido.Text := FloatToStrF(Total.ISSQNtot.vISSRet, ffFixed, 10, 2);
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





procedure TFr_Fatura_Srv.Pc_CarregaComponenteTributacao;
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
      DataSaida := null;
      Finalidade := '1';
      CodigoTransportadora := 0;
      ContaFrete := 0;
     End;
    it_ECF := False;
    It_AutorizacaoNFE := False;
    It_AutorizacaoNFCE := False;
    It_AutorizacaoNFSE := ChBx_AutorizacaoNFSe.Checked;
    it_SomaIPI_Bs_ICMS := False;
    It_SomaIPI_Bs_ICMS_St := False;
    It_Dist_Icms_NR := False;
    It_Dist_Icms_ST := False;
    It_Dist_IPI := False;
    It_Sentido := 'S';
    It_Tipo_OPer := 'S';
    Tributacao.Pc_CriaConsultas;
    Tributacao.Pc_Pedido;
    with It_Nfe.NotasFiscais[0].NFe do
    Begin
      //Valor do Base do ISS
      Total.ISSQNtot.vBC := StrToFloatDef(E_VL_Bs_ISS.Text, 0);
      //Valor do ISS
      Total.ISSQNtot.vISS := StrToFloatDef(E_VL_ISS.Text, 0);
      //Valor do ISS Retido
      Total.ISSQNtot.vISSRet := StrToFloatDef(E_Vl_ISS_retido.Text, 0);
    end;
    It_Qt_Produto := 0;
    It_Especie := 'SERVIÇO';
    It_PesoBruto := '0,00';
    It_PesoLiquido := '0,00';
    It_PlacaVeiculo := '';
    It_Uf_Veiculo := '';
    It_RNTC := '';
    It_Marca := '';
    It_Volume := '';
    It_Despachar := 'N';
  end;
end;

function TFr_Fatura_Srv.Fc_Faturar_Normal():Boolean;
begin
  //Calcula os impostos
  Tributacao.Pc_PreencheDadosDanfe;
//  Tributacao.It_Nfe.NotasFiscais.SaveToFile(GbPathExe + '\temp\PED_' + IntToStr(It_Nr_Pedido) + 'NFE.XML');
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



procedure TFr_Fatura_Srv.Pc_ImpressaoAutomaticaBoleto(Pc_cd_Pedido:Integer);
var
  lc_qry:TSTQuery;
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
        lc_qry := TSTQuery.Create(Self);
        with lc_qry do
        Begin
          Database:= DM.IBD_Gestao;
          Transaction:= DM.IB_Transacao;
          SQL.Clear;
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
      end;
    end;
  end;
end;
end.


