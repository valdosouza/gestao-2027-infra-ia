unit tas_conserto;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_ListaSituacao, Vcl.StdCtrls, QEdit_Setes, Un_Fm_ListaColaboradores, Un_Fm_FormaPagto, Vcl.DBCtrls, Vcl.Mask, Vcl.ComCtrls, Data.DB, STQuery, System.Actions, Vcl.ActnList, Un_Fm_ListaEmpresas, Un_Fm_ListaClientes, ControllerCotacao, ControllerConserto, ControllerPedido, ControllerCliente;

type
  TTasConserto = class(TBaseRegistry)
    Sb_Encerrar: TSpeedButton;
    SB_Imprimir: TSpeedButton;
    Pnl_Cabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    Lb_Numero: TLabel;
    Label6: TLabel;
    Sb_Parcelamento: TSpeedButton;
    Label10: TLabel;
    E_Contato: TEdit;
    E_Data: TDateTimePicker;
    E_Nr_Parcelas: TMaskEdit;
    E_Prazo: TMaskEdit;
    E_email: TEdit;
    DBLCB_Prazo: TDBLookupComboBox;
    Fm_FormaPagto: TFm_FormaPagto;
    Fm_VendedorPedido: TFm_ListaColaboradores;
    Pnl_Conserto: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label38: TLabel;
    Label45: TLabel;
    Label47: TLabel;
    Label3: TLabel;
    Label15: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label5: TLabel;
    Lb_Final_Data: TLabel;
    MM_Relatado: TMemo;
    MM_Constatado: TMemo;
    E_VL_MObra: TEdit_Setes;
    E_VL_Peca: TEdit_Setes;
    E_VL_Custo: TEdit_Setes;
    E_NumSerie: TEdit;
    E_Aparelho: TEdit;
    E_Marca: TEdit;
    E_Modelo: TEdit;
    MM_Acessorios: TMemo;
    GroupBox1: TGroupBox;
    Sb_EnviaEmail: TSpeedButton;
    Sb_Ctas_Pagar: TSpeedButton;
    Label17: TLabel;
    lbl_ult_atualizacao: TLabel;
    Label44: TLabel;
    DBLCB_Fornecedor: TDBLookupComboBox;
    Fm_ListaSituacao: TFm_ListaSituacao;
    E_Dt_Conserto: TMaskEdit;
    Pnl_Encerra: TPanel;
    Label11: TLabel;
    Label46: TLabel;
    Sb_confirma: TSpeedButton;
    Lb_Tipo: TLabel;
    Lb_Valor: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Sb_Voltar: TSpeedButton;
    DBLCB_Sit_encerra: TDBLookupComboBox;
    E_DataEntrega: TDateTimePicker;
    Pnl_Totalizador: TPanel;
    Label12: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label26: TLabel;
    E_VL_Desconto: TEdit_Setes;
    E_Aliq_Desconto: TEdit_Setes;
    E_VL_Frete: TEdit_Setes;
    qr_prazo_controlado: TSTQuery;
    Qr_Ord_Max: TSTQuery;
    Qr_Acao: TSTQuery;
    Qr_Ins_Ordem: TSTQuery;
    Qr_Sit_Encerra: TSTQuery;
    Ds_Sit_Encerra: TDataSource;
    dts_PrazoControlado: TDataSource;
    Ds_Fornecedor: TDataSource;
    Qr_Fornecedor: TSTQuery;
    Qr_Ordem: TSTQuery;
    E_VL_Cotacao: TPanel;
    ActionList1: TActionList;
    Action1: TAction;
    Fm_ListaClientes: TFm_ListaClientes;
    procedure Qr_FornecedorAfterOpen(DataSet: TDataSet);
    procedure Sb_EnviaEmailClick(Sender: TObject);
    procedure Sb_Ctas_PagarClick(Sender: TObject);
    procedure Sb_confirmaClick(Sender: TObject);
    procedure Sb_VoltarClick(Sender: TObject);
    procedure DBLCB_FornecedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure E_VL_CustoEnter(Sender: TObject);
    procedure E_VL_PecaEnter(Sender: TObject);
    procedure E_VL_MObraEnter(Sender: TObject);
    procedure E_VL_MObraExit(Sender: TObject);
    procedure E_VL_PecaExit(Sender: TObject);
    procedure E_VL_CustoExit(Sender: TObject);
    procedure E_VL_FreteExit(Sender: TObject);
    procedure E_Aliq_DescontoExit(Sender: TObject);
    procedure E_VL_DescontoExit(Sender: TObject);
    procedure Sb_ParcelamentoClick(Sender: TObject);
    procedure E_Nr_ParcelasExit(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Fm_ListaClientesDBLCB_EmpresaExit(Sender: TObject);
    procedure Sb_EncerrarClick(Sender: TObject);
    procedure SB_ImprimirClick(Sender: TObject);
    procedure Fm_ListaSituacaoDBLCB_SituacaoClick(Sender: TObject);
    procedure Fm_ListaSituacaoDBLCB_SituacaoExit(Sender: TObject);
    procedure Fm_FormaPagtoDBLCB_FormaPagtoClick(Sender: TObject);
    procedure Qr_Sit_EncerraAfterOpen(DataSet: TDataSet);
    procedure Label18Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCotacao : TControllerCotacao;
    FConserto : TControllerConserto;
    FPedido : TControllerPedido;
    FCliente : TControllerCliente;
    FVl_Frete: Real;
    FVl_Desconto: Real;
    FVl_Cotacao: Real;
    FInserir : Boolean;
    FAlterar : Boolean;
    FExcluir : Boolean;
    FEncerrar : Boolean;
    FImprimir : Boolean;
    FEmail_Cliente: boolean;
    FEmail_tecnico: boolean;
    FContas_pagar: boolean;
    FDesativado: boolean;
    FOperacao: string;
    FCodCli: Integer;
    FAliq_Comissao: real;
    FStateChange: Integer;
    FCd_Repres: Integer;
    FNm_Repres: String;
    Fbloqueio : Boolean;

    procedure Totalizador;
    function ValidaFaturamento(): Boolean;
    procedure GeraNumero;
    function GeraEmail_Conserto(): String;
    function GeraEmailTecnico(): String;
    function Historico(pc_Tipo: Char): string;
    function Desconto(fc_Tipo: Char): boolean;
    procedure ContasPagar;
    function VerificaContaPagar(): boolean;
    procedure Sel_FormPagto(Pc_Bloquea_Pagto: Boolean);
    procedure DinheiroFormaPgt;
    procedure Sel_PrazoPagto(Pc_Bloquea_Pagto: Boolean);
    procedure Gerar_Pedido;
    procedure FaturaConserto;
    Procedure ImprimeCupom;
    procedure DefineLista;
    procedure Situacao_Conserto(CodigoSituacao:Integer);
    procedure Valida_Info_cliente(Pc_Cd_Cliente : Integer);
    procedure Encerrar(Pc_Situacao: Integer; Pc_Codigo: integer; Pc_Data: TDate);
    procedure Pc_PreencheDadosCliente;

  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure ImagemBotao;Override;
    procedure FormataTela;Override;
    procedure setPerfil;Override;
    procedure AtivaTabelas;override;
    //Teclas de atalhos
    procedure execShorCutKeyF10;Override;
    procedure execShorCutKeyF11;Override;

    procedure ShowData;Override;
    procedure ShowDataOrcamento;
    procedure ShowDataConserto;

    procedure ShowNoData;Override;
    procedure ShowNoDataOrcamento;
    procedure ShowNoDataConserto;


    procedure ClearAllFields;Override;
    //Editar
    function ValidateChange:boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    procedure GravaOrcamento;
    procedure GravaPedido;
    procedure GravaConserto;

    procedure EditionControl;Override;
  public

  end;

var
  TasConserto: TTasConserto;

implementation

uses     Un_DM, Un_Pesq_Produto, Un_Funcoes, Un_Imp_Mod_Impressao, UN_Sistema, UN_MSG, UN_RL_Cotacao, UN_RL_OrcaCst_Entg, UN_RL_OrcaConserto, QRCtrls, UN_Pedido_Vda, Un_Clta_Csto, Un_Liberacao, DateUtils, Un_Parcelamento, Un_Tecnicos, Un_Fc_Sored_Procedures, un_Padrao, UN_Fatura_Cst, Un_envia_email, Un_Regra_Negocio, UN_Principal, env, RN_Financeiro, RN_FormaPagto, RN_Cliente, RN_Pedido, UN_TabelasEmListas, Un_Cliente, RN_Empresa, UN_Lanca_Pagto;
{$R *.dfm}

{ TTasConserto }

procedure TTasConserto.Action1Execute(Sender: TObject);
Var
  Lc_Form :TFr_Liberacao;
Begin
  Lc_Form := TFr_Liberacao.Create(nil);
  Lc_Form.Liberado := False;
  Lc_Form.It_Interface := 'Fr_Conserto';
  Lc_Form.It_Nome_Menu := 'Consulta Conserto';
  Lc_Form.It_Privilegio := 'AUTORIZAR';
  try
    Lc_Form.ShowModal;
  finally
    FreeAndNil(Lc_Form);
  end;
end;


procedure TTasConserto.AtivaTabelas;
begin
  Fm_VendedorPedido.ListaVendedor;
  Qr_Fornecedor.Active := True;
  Fm_ListaSituacao.Etapa := 2;
  Fm_ListaSituacao.Listar;
  Fm_ListaClientes.ListaClientes('EMP_NOME');
  Sel_FormPagto(Fbloqueio);
end;


procedure TTasConserto.Change;
begin
  inherited;
  E_Data.SetFocus;
end;

procedure TTasConserto.ClearAllFields;
begin
  inherited;
  FOperacao:='';
end;

procedure TTasConserto.ContasPagar;
var
  Lc_VL_MaoObra: Real;
  Lc_VL_Peca: Real;
  Lc_form :TFr_Lanca_Pagto;
begin
  Lc_VL_MaoObra := StrToFloatDef(E_VL_MObra.Text, 0);
  Lc_VL_Peca    := StrToFloatDef(E_VL_Peca.Text, 0);

  if ( Fc_Tb_Geral('L','CST_VAL_MAO_OBRA', 'N') = 'S' ) then
  Begin
    if (Lc_VL_MaoObra = 0) then
     begin
        MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
           'O valor de Mão de Obra não pode ser Zero.' + EOLN +
           'Verifique e tente novamente.' + EOLN,
           ['OK'], [bEscape], mpErro);
        exit;
     end;
  End;

   if Trim(DBLCB_Fornecedor.Text) = '' then
   begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
         'Por Favor Informe o Nome do fornecedor.' + EOLN +
         'Verifique e tente novamente.' + EOLN,
         ['OK'], [bEscape], mpErro);
      exit;
   end;
   try
      GeraNumero;
      Qr_Acao.Close;
      Qr_Acao.SQL.Clear;
      Qr_Acao.SQL.Add('SELECT FIN_CODIGO ' +
         'FROM TB_FINANCEIRO tb_financeiro ' +
         '  INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal ' +
         '  ON (tb_nota_fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) ' +
         'WHERE (NFL_NUMERO =:NFL_NUMERO) ');

      Qr_Acao.ParamByName('NFL_NUMERO').AsString := Copy(FCotacao.Registro.Numero, 7, Length(FCotacao.Registro.Numero) - 6);
      Qr_Acao.Active := True;
      Qr_Acao.FetchAll;
      if Qr_Acao.RecordCount = 0 then
      begin
         Lc_form := TFr_Lanca_Pagto.create(Self);
         Lc_form.E_Dt_Emissao.Date := Date;
         Lc_form.E_Nr_Doc.Text := Copy( FCotacao.Registro.Numero, 7, Length( FCotacao.Registro.Numero) - 6);
         Lc_form.E_VL_Doc.Text := FloatToStrF(Lc_VL_MaoObra + Lc_VL_Peca, ffFixed, 10, 2);
         Lc_form.Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := 4;
         Lc_form.E_Nr_PArcelas.Text := '000';
         Lc_form.E_Nr_PArcelasExit(self);
         Lc_form.E_PrazoExit(self);
         Lc_form.DBLCB_Empresa.KeyValue := DBLCB_Fornecedor.KeyValue;
         Lc_form.E_Cod_For.Text := IntToStr(DBLCB_Fornecedor.KeyValue);
         Lc_form.it_Tipo_Fin := 'PA';
         Lc_form.It_Operacao := 'D';
         Lc_form.Pc_AtivarTabela;
         Try
           Lc_form.Pc_Faturar;
         Finally
           Lc_form.Close;
           FreeAndNil(Lc_form);
         End;
      end
      else
      begin
         MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
            'Já existe um contas a pagar para este Conserto.' + EOLN +
            'Verifique com o Financeiro.' + EOLN,
            ['OK'], [bEscape], mpErro);
      end;
   except
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
         'Problemas ao gerar Contas à Pagar.' + EOLN +
         'Entre em Contato com o suporte Técnico.' + EOLN,
         ['OK'], [bEscape], mpErro);
   end;

end;

procedure TTasConserto.CriarVariaveis;
begin
  inherited;
  FCotacao := TControllerCotacao.create(self);
  FConserto := TControllerConserto.create(self);
  FPedido := TControllerPedido.create(self);
end;

procedure TTasConserto.DBLCB_FornecedorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:begin
                  DBLCB_Fornecedor.KeyValue := Null;
                  FConserto.Registro.Codigo := 0;
                end;
    end;
end;

procedure TTasConserto.DefineLista;
Var
  Lc_Sqltxt : String;
Begin
  Qr_Sit_Encerra.Active := False;
  Qr_Sit_Encerra.SQL.Clear;
  if StrToFloatDef(E_VL_Cotacao.Caption,0) = 0 then
  Begin
    Lc_Sqltxt := 'SELECT * '+
                 'FROM TB_SITUACAO '+
                 'WHERE (SIT_FLAG02 <>'''') AND (SIT_CODIGO <> 10) '+
                 'ORDER BY SIT_FLAG02 ';
  end
  else
  Begin
    Lc_Sqltxt := 'SELECT * '+
                 'FROM TB_SITUACAO '+
                 'WHERE (SIT_FLAG02 <>'''') AND (SIT_CODIGO = 10) '+
                 'ORDER BY SIT_FLAG02 ';
  end;
  Qr_Sit_Encerra.SQL.Add(Lc_Sqltxt);
  Qr_Sit_Encerra.Active := True;
  Qr_Sit_Encerra.First;
end;

procedure TTasConserto.Delete;
begin
  FConserto.delete;
  FCotacao.delete;
end;

function TTasConserto.Desconto(fc_Tipo: Char): boolean;
var
   Lc_Aliq_Perm: real;
   Lc_Aliq_Desc: Real;
   Lc_Valor: real;
begin
  Result := true;
   Lc_Valor :=  StrToFloatDef(E_VL_Custo.Text,0) + StrToFloatDef(E_VL_Peca.Text,0) + StrToFloatDef(E_VL_MObra.Text,0);
   Lc_Aliq_Perm := StrToFloatDef(Fc_Tb_Geral('L', 'VDA_G_DESC_MAX_GERAL', ''),0);
   Lc_Aliq_Desc := 0;
   case fc_Tipo of
      'A':
         begin
            Lc_Aliq_Desc := StrToFloatDef(E_Aliq_Desconto.Text, 0);
            if (Lc_Aliq_Perm >= Lc_Aliq_Desc) or Gb_Liberado then
            begin
               E_VL_Desconto.Text := FloatToStrF(((Lc_Valor) * (Lc_Aliq_Desc / 100)), ffFixed, 10, 2);
               FVl_Desconto := StrToFloatDef(E_VL_Desconto.Text,0);
               if Lc_Valor > 0 then
                  Lc_Aliq_Desc := (FVl_Desconto / Lc_Valor) * 100;
               E_Aliq_Desconto.Text := FloatToStrF(Lc_Aliq_Desc, ffFixed, 10, 2);
               if Gb_Nivel = 0 then
                  Gb_Liberado := False;
               Result := True; ;
            end
            else
            begin
               MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                  'Percentual máximo de Desconto ' + FloatToStr(Lc_Aliq_Perm) + '%.' + EOLN +
                  'Caso Necessário Peça Autorizção.' + EOLN,
                  ['OK'], [bEscape], mpErro);
               E_VL_Desconto.Text := '0,00';
               E_Aliq_Desconto.SetFocus;
               E_Aliq_Desconto.Text := '0,00';
               E_Aliq_Desconto.SelectAll;
               result := False;
               exit;
            end;
         end;
      'V':
         begin
            FVl_Desconto := StrToFloatdef(E_VL_Desconto.Text, 0);
            if Lc_Valor > 0 then
               Lc_Aliq_Desc := (FVl_Desconto / Lc_Valor) * 100;
            if (Lc_Aliq_Perm >= Lc_Aliq_Desc) or Gb_Liberado then
            begin
               FVl_Desconto := StrToFloatDef(E_VL_Desconto.Text, 0);
               E_Aliq_Desconto.Text := FloatToStrF(Lc_Aliq_Desc, ffFixed, 10, 2);
               if Gb_Nivel = 0 then
                  Gb_Liberado := False;
               Result := True;
            end
            else
            begin
               MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                  'Percentual máximo de Desconto ' + FloatToStr(Lc_Aliq_Perm) + '%.' + EOLN +
                  'Caso Necessário Peça Autorizção.' + EOLN,
                  ['OK'], [bEscape], mpErro);
               E_Aliq_Desconto.Text := '0,00';
               E_VL_Desconto.SetFocus;
               E_VL_Desconto.Text := '0,00';
               E_VL_Desconto.SelectAll;
               result := False;
               exit;
            end;
         end;
      'G':
         begin
            Lc_Aliq_Desc := StrToFloatDef(E_Aliq_Desconto.Text, 0);
            if (Lc_Aliq_Perm >= Lc_Aliq_Desc) or (not Gb_Liberado) then
            begin
               FVl_Desconto := StrToFloatdef(E_VL_Desconto.Text, 0);
               if Lc_Valor > 0 then
                  Lc_Aliq_Desc := (FVl_Desconto / Lc_Valor) * 100;
               if (Lc_Aliq_Perm >= Lc_Aliq_Desc) or Gb_Liberado then
               begin
                  Totalizador;
                  result := True;
               end
               else
               begin
                  MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Percentual máximo de Desconto ' + FloatToStr(Lc_Aliq_Perm) + '%.' + EOLN +
                     'Caso Necessário Peça Autorizção.' + EOLN,
                     ['OK'], [bEscape], mpErro);
                  result := False;
                  exit;
               end;
            end
            else
            begin
               Totalizador;
               result := True;
            end;

         end;
   end;
   Totalizador;

end;

procedure TTasConserto.DinheiroFormaPgt;
begin
  if (Pos('DINHEIRO',Trim(Fm_FormaPagto.DBLCB_FormaPagto.Text))>0) then
  BEGIN
    IF E_Nr_Parcelas.Visible = TRUE THEN
    BEGIN
      E_Nr_Parcelas.Text:='000';
      E_Nr_ParcelasExit(Self);
      E_Nr_Parcelas.Enabled:=FALSE;
      E_Prazo.Enabled:=FALSE;
    END
    ELSE
    BEGIN
      Sel_PrazoPagto(Fbloqueio);
    END;
  END
  ELSE
  BEGIN
    Sel_PrazoPagto(Fbloqueio);
    E_Nr_Parcelas.Enabled:=TRUE;
    E_Prazo.Enabled:=TRUE;
  END;

end;

procedure TTasConserto.EditionControl;
begin
  if not FDesativado then
  begin
    inherited;
    SB_Imprimir.Enabled := ( EditionState = 'B' ) and (FImprimir);
    Sb_Encerrar.Enabled := ( EditionState = 'B' ) and FEncerrar and  ( FCotacao.exist );
    Sb_EnviaEmail.Enabled:= FEmail_tecnico;
    Sb_Ctas_Pagar.Enabled:= FContas_pagar;

    Sb_confirma.Enabled := ( EditionState = 'B' ) ;
    Sb_Voltar.Enabled := ( EditionState = 'B' ) ;

  end
  else
  begin
    SB_Excluir.Enabled := not FDesativado;
    //SB_Imprimir.Enabled := not FDesativado ;
    SB_Alterar.Enabled := not FDesativado;
    SB_Gravar.Enabled := not FDesativado;
    SB_Cancelar.Enabled := not FDesativado;
    Sb_Encerrar.Enabled := not FDesativado;
  end;
end;

procedure TTasConserto.Encerrar(Pc_Situacao: Integer; Pc_Codigo: integer;
  Pc_Data: TDate);
begin
  FConserto.Registro.Codigo := Pc_Codigo;
  FConserto.getByKey;
  FConserto.Registro.Situacao := Pc_Situacao;
  FConserto.Registro.DataEntrega := Pc_Data;
  FConserto.update;
end;

procedure TTasConserto.execShorCutKeyF10;
begin
  inherited;

end;

procedure TTasConserto.execShorCutKeyF11;
begin
  inherited;

end;

procedure TTasConserto.E_Aliq_DescontoExit(Sender: TObject);
begin
  Desconto('A');
end;

procedure TTasConserto.E_Nr_ParcelasExit(Sender: TObject);
begin
   if StrToIntDef(E_Nr_Parcelas.Text, 0) > 0 then
   begin
      E_Prazo.Clear;
      E_Prazo.EditMask := Fc_MascaraPrazo(StrToInt(E_Nr_Parcelas.Text))
   end
   else
   begin
      E_Prazo.EditMask := '';
      E_Prazo.Text := Fc_MascaraPrazo(StrToInt(E_Nr_Parcelas.Text));
   end;
end;

procedure TTasConserto.E_VL_CustoEnter(Sender: TObject);
begin
  E_VL_Custo.SelectAll;
end;

procedure TTasConserto.E_VL_CustoExit(Sender: TObject);
var
   Lc_Valor: Real;
begin
   Lc_Valor := StrToFloatDef(E_VL_Custo.Text, 0);
   E_VL_Custo.Text := FloatToStrF(Lc_Valor, ffFixed, 10, 2);
   Totalizador;
end;

procedure TTasConserto.E_VL_DescontoExit(Sender: TObject);
begin
  Desconto('V');
end;

procedure TTasConserto.E_VL_FreteExit(Sender: TObject);
begin
  Totalizador;
end;

procedure TTasConserto.E_VL_MObraEnter(Sender: TObject);
begin
  E_VL_Custo.SelectAll;
end;

procedure TTasConserto.E_VL_MObraExit(Sender: TObject);
var
   Lc_Valor: Real;
begin
   Lc_Valor := StrToFloatDef(E_VL_MObra.Text, 0);
   E_VL_MObra.Text := FloatToStrF(Lc_Valor, ffFixed, 10, 2);
   Totalizador;
end;

procedure TTasConserto.E_VL_PecaEnter(Sender: TObject);
begin
  E_VL_Custo.SelectAll;
end;

procedure TTasConserto.E_VL_PecaExit(Sender: TObject);
var
   Lc_Valor: Real;
begin
   Lc_Valor := StrToFloatDef(E_VL_Peca.Text, 0);
   E_VL_Peca.Text := FloatToStrF(Lc_Valor, ffFixed, 10, 2);
   Totalizador;
end;

procedure TTasConserto.FaturaConserto;
Var
 Lc_Form : TFr_Fatura_Cst;
Begin
  //Chama a tela de Faturamento
  Lc_Form  := TFr_Fatura_Cst.Create(Self);
  Lc_Form.It_Fatura_Ok := False;
  Lc_Form.It_Conserto := true;
  Lc_Form.It_Cd_Conserto := FCotacao.Registro.Codigo;
  Lc_Form.It_Vl_Devolucao  := 0;
  Lc_Form.It_UsarCredito := False;
  Lc_Form.It_Vl_Credito := 0;
  Lc_Form.It_Cd_Pedido := FCotacao.Registro.Codped;
  Pnl_Encerra.Visible := False;
  Try
    Lc_Form.ShowModal;
  Finally
    if not Lc_Form.It_Fatura_Ok then
    Begin
      FPEdido.Registro.Codigo := FCotacao.Registro.Codped;
      FPEdido.delete;
    end;
    FreeAndNil(Lc_Form);
  End;
end;

procedure TTasConserto.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil( FCotacao );
  FreeAndNil( FConserto);
end;

procedure TTasConserto.Fm_FormaPagtoDBLCB_FormaPagtoClick(Sender: TObject);
begin
  DinheiroFormaPgt;
end;

procedure TTasConserto.Fm_ListaClientesDBLCB_EmpresaExit(Sender: TObject);
begin
  if ( (EditionState = 'I') or (EditionState = 'E') )  then  //Inicio verifica edição
  Begin
    IF trim(Fm_ListaClientes.DBLCB_Empresa.Text) <> '' THEN
    begin
      Fbloqueio := Fc_VerificaBloqueioCliente( Fm_ListaClientes.DBLCB_Empresa.KeyValue);
      Valida_Info_cliente( Fm_ListaClientes.DBLCB_Empresa.KeyValue);
      Sel_FormPagto(Fbloqueio);
      Sel_PrazoPagto(Fbloqueio);
      Pc_Aniversario(Fm_ListaClientes.Qr_ListaEmpresa.FieldByName('EMP_DT_FUNDA').AsString);
      Pc_PreencheDadosCliente;
    end
    else
    Begin
      FCotacao.Registro.Codemp := 0;
      Fm_ListaClientes.E_Cd_Empresa.Clear;
    end;
  end;
end;

procedure TTasConserto.Pc_PreencheDadosCliente; //procedure TFr_Cotacao.Pc_PreencheDadosCliente;
begin
  fcliente.Empresa.Registro.Codigo := StrtoIntDef(Fm_ListaClientes.E_Cd_Empresa.Text,0);
  fcliente.Empresa.getById;

  e_Email.Text := Copy(fcliente.Empresa.Registro.Email ,1,60);

  fcliente.Empresa.Endereco.Registro.CodigoEmpresa  := fcliente.Empresa.Registro.Codigo;
  fcliente.Empresa.Endereco.getByEmpresa;

  if fcliente.Empresa.Endereco.Registro.Fone <> '' then
    E_Contato.Text := fc_MascaraFone(fcliente.Empresa.Endereco.Registro.Fone)
  else if fcliente.Empresa.Endereco.Registro.Celular <> '' then
    E_Contato.Text := fc_MascaraFone(fcliente.Empresa.Endereco.Registro.Celular);
end;

procedure TTasConserto.Fm_ListaSituacaoDBLCB_SituacaoClick(Sender: TObject);
begin
   if Fm_ListaSituacao.DBLCB_Situacao.Text = 'PRONTO, AVISAR CLIENTE' then
      E_Dt_Conserto.Text := DateToStr(Date);
end;

procedure TTasConserto.Fm_ListaSituacaoDBLCB_SituacaoExit(Sender: TObject);
begin
  IF Pos('PRONTO',Fm_ListaSituacao.DBLCB_Situacao.Text)>0 then
    E_Dt_Conserto.Text := DateToSTr(Date)
  else
    E_Dt_Conserto.Clear;
end;

procedure TTasConserto.FormataTela;
begin
  if (Fc_Tb_Geral('L','ORC_G_CTRL_PARCELA','A') = 'A') then
  begin
    E_Nr_Parcelas.Visible:=true;
    E_Prazo.Visible:=true;
    Sb_Parcelamento.Visible:=true;
    DBLCB_Prazo.Visible:=false;
  end
  else
  begin
    DBLCB_Prazo.Top:= E_Nr_Parcelas.Top;
    DBLCB_Prazo.Visible:=true;
    E_Nr_Parcelas.Visible:=False;
    E_Prazo.Visible:=False;
    Sb_Parcelamento.Visible:=False;
  end;
end;

procedure TTasConserto.FormCreate(Sender: TObject);
begin
  inherited;
  FCliente := TControllerCliente.create(Self);
end;

procedure TTasConserto.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FCliente);
end;

function TTasConserto.GeraEmailTecnico: String;
var
   lc_Data: string;
   Lc_Ano, Lc_mes, Lc_dia: string;
   Lc_I: Integer;
begin
   Pc_AtivaEstabelecimento;
   Lc_dia := Copy( DateToStr(FCotacao.Registro.Data), 1, 2);
   Lc_mes := Fc_DesMes(Fc_Month( FCotacao.Registro.Data ), True);
   Lc_Ano := Copy( DateToStr(FCotacao.Registro.Data) , 7, 4);

   Lc_Data := DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString +  ', ' + Lc_dia + ' de ' + Lc_mes + ' de ' + Lc_Ano;

   Result := '<table width="689" border="0" cellspacing="0" cellpadding="0"> '+
             '  <tr> '+
             '    <td><strong>' + DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsString + '</strong></td> '+
             '  </tr> '+
             '  <tr> '+
             '    <td><font size="2"">' + DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsString + ',' + DM.Qr_Estabelecimento.FieldByname('END_NUMERO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('END_BAIRRO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('CDD_DESCRICAO').AsString + ' - ' + DM.Qr_Estabelecimento.FieldByname('UFE_SIGLA').AsString + '</font></td> '+
             '  </tr> '+
             '  <tr> '+
             '  </tr> '+
             '  <tr> '+
             '    <td><font size="2"">Fone / e-mail: ' + fc_MascaraFone(DM.Qr_Estabelecimento.FieldByname('END_FONE').AsString) + ' / ' + DM.Qr_Estabelecimento.FieldByname('EMP_EMAIL').AsString + '</font></td> '+
             '  </tr> '+
             '  <tr> '+
             '    <td><font color="#000000" size="1">.</font></td> '+
             '  </tr> ';

//Camila - Ordem de Serviço Nº
   Result := Result + '  <tr> '+
                      '<table width="689" border="1" cellspacing="0" cellpadding="0"> '+
                      '  <tr bgcolor="#CCCCCC"> '+
                      '    <td width="50%"><strong><font color="#000000">Ordem de Serviço Nº</font></strong></td> '+
                      '    <td width="50%"><strong><font color="#000000">Local/Data</font></strong></td> '+
                      '  </tr> '+

                      '  <tr> '+
                      '    <td>' + Lb_Numero.Caption + '</td> '+
                      '    <td>' + Lc_data + '</td> '+
                      '  </tr> '+
                      '</table> ';
//camila - FIM

//Camila - Nome do Cliente
   Result := Result + '  <tr> '+
                      '<table width="689" border="1" cellspacing="0" cellpadding="0"> '+
                      '  <tr bgcolor="#CCCCCC"> '+
                      '    <td width="50%"><strong><font color="#000000">Nome do Cliente</font></strong></td> '+
                      '  </tr> '+

                      '  <tr> '+
                      '    <td>' + Fm_ListaClientes.DBLCB_Empresa.Text + '</td> '+
                      '  </tr> '+
                      '</table> ';
//camila - FIM

//Camila - Produto
   Result := Result + '  <tr> '+
                      '<table width="689" border="1" cellspacing="0" cellpadding="0"> '+
                      '  <tr bgcolor="#CCCCCC"> '+
                      '    <td width="50%"><strong><font color="#000000">Produto</font></strong></td> '+
                      '  </tr> '+

                      '  <tr> '+
                      '    <td>' + E_Aparelho.Text + '</td> '+
                      '  </tr> '+
                      '</table> ';
//camila - FIM

//Camila - Marca e Modelo
   Result := Result + '  <tr> '+
                      '<table width="689" border="1" cellspacing="0" cellpadding="0"> '+
                      '  <tr bgcolor="#CCCCCC"> '+
                      '    <td width="35%"><strong><font color="#000000">Marca</font></strong></td> '+
                      '    <td width="35%"><strong><font color="#000000">Modelo</font></strong></td> '+
                      '    <td width="30%"><strong><font color="#000000">Número Série/Identificção</font></strong></td> '+
                      '  </tr> '+

                      '  <tr> '+
                      '    <td>' + E_Marca.Text + '</td> '+
                      '    <td>' + E_Modelo.Text + '</td> '+
                      '    <td>' + E_NumSerie.Text + '</td> '+
                      '  </tr> '+
                      '</table> ';
//camila - FIM

//Camila - Acessórios
   Result := Result + '  <tr> '+
                      '<table width="689" border="1" cellspacing="0" cellpadding="0"> '+
                      '  <tr bgcolor="#CCCCCC"> '+
                      '    <td width="50%"><strong><font color="#000000">Acessórios</font></strong></td> '+
                      '  </tr> '+
                      '  <tr> '+
                      '    <td>';
   for Lc_I := 0 to MM_Acessorios.Lines.Count - 1 do
     begin
     Result := Result + MM_Acessorios.Lines.Strings[lc_I] + '<br>';
     end;
   Result := Result + '  </td> '+
                      '  </tr> '+
                      '</table> '+
                      '  <tr> '+
                      '    <td>' + MM_Acessorios.Lines.Strings[lc_I] + '</td> '+
                      '  </tr> '+
                      '</table> ';
//camila - FIM

//Camila - Defeito
   Result := Result + '<table width="689" border="1" cellspacing="0" cellpadding="0"> '+
                      '  <tr bgcolor="#CCCCCC"> '+
                      '    <td width="100%"><strong><font color="#000000">Defeito Relatado</font></strong></td> '+
                      '  </tr> '+
                      '  <tr> '+
                      '  <td>';
  for Lc_I := 0 to MM_Relatado.Lines.Count - 1 do
    begin
    Result := Result + MM_Relatado.Lines.Strings[lc_I] + '<br>';
    end;
  Result := Result + '  </td> '+
                     '  </tr> '+
                     '</table> ';
//Camila - FIM

//Camila - Defeito Constatado
   Result := Result + '<table width="689" border="1" cellspacing="0" cellpadding="0"> '+
                      '  <tr bgcolor="#CCCCCC"> '+
                      '    <td width="100%"><strong><font color="#000000">Defeito Constatado/Solução Apresentada</font></strong></td> '+
                      '  </tr> '+
                      '  <tr> '+
                      '    <td>';
  for Lc_I := 0 to MM_Constatado.Lines.Count - 1 do
    begin
    Result := Result + MM_Constatado.Lines.Strings[lc_I] + '<br>';
    end;
  Result := Result + '  </td> '+
                     '  </tr> '+
                     '</table> ';
//Camila - FIM

//Camila - Situção
   Result := Result + '<table width="689" border="1" cellspacing="0" cellpadding="0"> '+
                      '  <tr bgcolor="#CCCCCC"> '+
                      '    <td width="100%"><strong><font color="#000000">Situção do Conserto: </font></strong></td> '+
                      '  </tr> '+
                      '<table> '+
                      '  <tr> '+
                      '    <td>' + Fm_ListaSituacao.DBLCB_Situacao.Text + '</td> '+
                      '  </tr> '+
                      '</table> ';
//Camila - FIM

//Camila - Vendedor
   Result := Result + '<table width=689 border=0 cellspacing=0 cellpadding=0> '+
                      '  <tr> '+
                      '    <td width="261"></td> '+
                      '    <td width="86"></td> '+
                      '    <td width="334">-</td> '+
                      '  </tr> '+
                      '  <tr> '+
                      '    <td><strong>Vendedor: </strong>' + Fm_VendedorPedido.DBLCB_Vendedor.Text + '</td> '+
                      '    <td>&nbsp;</td> '+
                      '    <td><div align="center">' + '' + '</td> '+
                      '  </tr> '+
                      '</table> ';
//Camila - FIM

  //FEchamento HTML
   Result := Result + '</body> ';
   Result := Result + '</html> ';
end;

function TTasConserto.GeraEmail_Conserto: String;
begin

end;

procedure TTasConserto.GeraNumero;
var
   Lc_Codigo: Integer;
   Lc_Ordem: string;
   Lc_Ano: string;
   Lc_Ano_Numero : String;
   Lc_Alterar : boolean;
begin
  Lc_Alterar := False;
  Lc_Ano := IntToStr(Fc_Year(E_Data.Date));
  if Length( FCotacao.Registro.Numero ) > 0 then
    Begin
    Lc_Ano_Numero := Copy( FCotacao.Registro.Numero,Length( FCotacao.Registro.Numero )-1,2);
    Lc_Alterar := (Lc_Ano_Numero <> Copy(Lc_Ano,3,2));
    end;

  if (Length( FCotacao.Registro.Numero ) = 0)  or Lc_alterar then
    begin
    Lc_Ano := IntToStr(Fc_Year(dATE));
    //Proxima Ordem
    Qr_Ord_Max.Active := fALSE;
    Qr_Ord_Max.ParamByName('CTC_DATA').AsString := '01/01/' + Lc_ano;
    Qr_Ord_Max.ParamByName('CTC_TIPO').AsString := '0';
    Qr_Ord_Max.Active := True;
    Lc_Ordem := Copy(Qr_Ord_Max.FieldByName('MAX').AsString, 7, 5);
    Lc_Codigo := StrToIntDef(Lc_Ordem, 0) + 1;
    Lc_Ordem := 'ORC - ' + StrZero(Lc_Codigo, 5, 0) + '/' + Copy(Lc_Ano, 3, 2);
    Lb_Numero.Caption := Lc_Ordem;
    FCotacao.Registro.Numero := Lc_Ordem;
    FCotacao.update;
  end;

end;

procedure TTasConserto.Gerar_Pedido;
var
  Lc_Numero: Integer;
  Lc_Cd_Pedido:Integer;

begin
  with FPedido.Registro do
  Begin
    Codigo                := FCotacao.Registro.Codped;
    Tipo                  := 1;
    FormaPagto            := FCotacao.Registro.Codfpg;
    Usuario               := GB_Cd_Usuario;
    Data                  := Date;
    Vendedor              := FCotacao.Registro.Codvdo;
    Empresa               := StrToIntDef( Fm_ListaClientes.E_Cd_Empresa.Text,0);
    Prazo                 := FCotacao.Registro.Prazo;

    FPedido.Endereco.Registro.CodigoEmpresa := StrToIntDef(Fm_ListaClientes.E_Cd_Empresa.Text,0);
    FPedido.Endereco.getByEmpresa;
    if FPedido.Endereco.exist then
      Endereco              := FPedido.Endereco.Registro.Codigo
    else
      Endereco              := DM.Qr_Estabelecimento.FieldByname('END_ENDER').AsInteger;
    Faturado              := 'N';
    CodigoEstabelecimento := Gb_Codmha;
    ValorProdutos         := StrtoFloatDef(E_VL_Peca.Text,0);
    ValorServico          := StrtoFloatDef(E_VL_MObra.Text,0) + StrtoFloatDef(E_VL_Custo.Text,0);
    Aprovado              := 'S';
    ValorPedido           := StrToFloatDef(E_VL_Peca.Text, 0) + StrToFloatDef(E_VL_MObra.Text, 0) + StrtoFloatDef(E_VL_Custo.Text,0);
  End;
  FPedido.CriaPedidoOrcamento;
  FPedido.nextNumber('T');
end;

procedure TTasConserto.GravaConserto;
begin
  with FConserto do
  Begin
    Registro.Codped       := FCotacao.Registro.Codped;
    Registro.Numero       := E_NumSerie.Text;
    Registro.Aparelho     := E_Aparelho.Text;
    Registro.Marca        := E_Marca.Text;
    Registro.Modelo       := E_Modelo.Text;
    Registro.Acessorio    := MM_Acessorios.Text;
    Registro.Relatado     := MM_Relatado.Text;
    Registro.Constatado   := MM_Constatado.Text;
    if Trim(DBLCB_Fornecedor.Text) <> '' then
      Registro.Codfor     := DBLCB_Fornecedor.KeyValue
    else
      Registro.Codfor     := 0;
    //Registro.DataPrevista :=
    if E_Dt_Conserto.Text <> '  /  /    ' then
      Registro.DataConserto := StrToDateDef( E_Dt_Conserto.Text,Date)
    else
      Registro.DataConserto := 0;
    //Registro.DataEntrega  :=
    Registro.VlCusto      := StrToFloatDef(E_VL_Custo.Text,0);
    Registro.VlPecas      := StrToFloatDef(E_VL_Peca.Text,0);
    Registro.VlMobra      := StrToFloatDef(E_VL_MObra.Text,0);
    Registro.Situacao     := Fm_ListaSituacao.DBLCB_Situacao.KeyValue;
  End;
  FConserto.save;
end;

procedure TTasConserto.GravaOrcamento;
Begin
  with FCotacao do
  Begin
    Registro.Data             := E_Data.Date;
    if (Fc_Tb_Geral('L','ORC_G_CTRL_PARCELA','')  = 'A') then
      Registro.Prazo          := E_Nr_Parcelas.Text + ' - ' + E_Prazo.Text
    else
      Registro.Prazo          := DBLCB_Prazo.Text;
    Registro.Codemp           := Fm_ListaClientes.DBLCB_Empresa.KeyValue;
    Registro.Fantasia         := Fm_ListaClientes.DBLCB_Empresa.Text;
    Registro.Codfpg           := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
    Registro.Codvdo           := Fm_VendedorPedido.Dblcb_Vendedor.KeyValue;
    Registro.Codsit           := Fm_ListaSituacao.DBLCB_Situacao.KeyValue;
    Registro.Tipo             := '0';
    Registro.Codusu           := Gb_Cd_Usuario;
    Registro.Contato          := E_Contato.Text;
    Registro.EmailE           := E_email.Text;
    Registro.QtProduto        := 1;
    Registro.VlProduto        := StrToFloatDef(E_VL_Peca.Text,0);
    Registro.VlServico        := StrToFloatDef(E_VL_MObra.Text,0);
    Registro.VlFrete          := StrToFloatDef(E_VL_Frete.Text,0);
    Registro.AliqDesconto     := StrToFloatDef(E_Aliq_Desconto.Text,0);
    Registro.VlDesconto       := StrToFloatDef(E_VL_Desconto.Text,0);
    Registro.VlCotacao        := StrToFloatDef(E_VL_Cotacao.Caption,0);
    Registro.Aprovado         := 'N';
    Registro.Status           := 'N';
    Registro.Estabelecimento  := Gb_CodMha;
    IF ( Registro.Codped = 0) THEN
    Begin
      GravaPedido;
    End;
  End;
  Fcotacao.save;
end;

procedure TTasConserto.GravaPedido;
begin
  with FPedido do
  Begin
    Registro.Codigo := 0;
    Registro.Tipo := 1;
    Registro.Usuario := GB_Cd_Usuario;
    Registro.Data := E_Data.DateTime;
    if StrToIntDef( Fm_ListaClientes.E_Cd_Empresa.Text,0) > 0 then
    Begin
     Registro.Empresa := StrToIntDef(Fm_ListaClientes.E_Cd_Empresa.Text,0);
     Endereco.REgistro.CodigoEmpresa := FPedido.Registro.Empresa;
     Endereco.getByEmpresa;
     Registro.Endereco := FPedido.Endereco.Registro.Codigo;
    End
    else
    Begin
      Registro.Empresa := Gb_CodMha;
      Endereco.REgistro.CodigoEmpresa := Gb_CodMha;
      Endereco.getByEmpresa;
      Registro.Endereco := FPedido.Endereco.Registro.Codigo;
    End;
    Registro.FormaPagto := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
    Registro.Faturado := 'C';
  End;
  FPedido.insere;
  FCotacao.Registro.Codped := FPedido.Registro.Codigo;
end;

function TTasConserto.Historico(pc_Tipo: Char): string;
var
   Lc_TExto: string;
   Lc_codigo: Integer;
   Lc_Vl_Chq_DEv: Real;
   Lc_Vl_Chq_Pre: Real;
   Lc_Vl_Devedor: Real;
begin
   Lc_codigo := StrToIntdef(Fm_ListaClientes.E_Cd_Empresa.Text , 0);

  //Cheque Devedor
  Lc_Vl_Chq_DEv := Fc_SaldoChequeDevolvido(Lc_codigo);
  if Lc_Vl_Chq_DEv > 0 then
    Lc_TExto := ' Cheque(s) Devolvido(s) : ' + FloatToStrF(Lc_Vl_Chq_DEv, ffFixed, 10, 2);

  //Cheque Pre-Datado
  Lc_Vl_Chq_Pre := Fc_SaldoChequePreDatado(Lc_codigo);
  if Lc_Vl_Chq_Pre > 0 then
    Lc_TExto := Lc_TExto + ' Cheque(s) PreDatado(s) : ' + FloatToStrF(Lc_Vl_Chq_Pre, ffFixed, 10, 2);

 //Saldo Devedor
  Lc_Vl_Devedor := Fc_SaldoDevedorCliente(Lc_codigo);
  if Lc_Vl_Devedor > 0 then
    Lc_TExto := Lc_TExto + ' Saldo Devedor : ' + FloatToStrF(Lc_Vl_Devedor, ffFixed, 10, 2);

  //Observção Cadastro
  if Length(Fm_ListaClientes.Qr_ListaEmpresa.FieldByName('EMP_OBSERV').AsString) > 0 then
    Lc_TExto := Lc_TExto + Fm_ListaClientes.Qr_ListaEmpresa.FieldByName('EMP_OBSERV').AsString;

  Result := Lc_TExto;
end;

procedure TTasConserto.ImagemBotao;
begin
  inherited;
  CarregaImagemBotao(Sb_Encerrar,'ENCERRAR');
  CarregaImagemBotao(SB_Imprimir,'IMPRIMIR');
  //Encerramento
  CarregaImagemBotao(Sb_confirma,'CONFIRMAR');
  CarregaImagemBotao(Sb_Voltar,'VOLTAR');
end;

procedure TTasConserto.ImprimeCupom;
Var
  Lc_Imp: TimpModImpressao;
Begin
  if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_TP_CUPOM_FAT','') = 'S' ) then
  Begin
    Lc_Imp := TimpModImpressao.create(nil);
    Lc_Imp.CodigoPedido := FCotacao.Registro.Codped;
    Lc_Imp.It_Tp_Doc    := 'ORÇAMENTO Nº ';
    Lc_Imp.It_data      := DateToStr(E_DataEntrega.Date) + ' ' + TimeToStr(Time);
    try
      Lc_Imp.Pc_OrcamentoBobina;
    Finally
      FreeandNil(Lc_Imp);
    end;
  End;
end;

procedure TTasConserto.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    FCotacao.Registro.Codigo := CodigoRegistro;
    FCotacao.getByKey;
    FConserto.Registro.Codped := FCotacao.Registro.Codped;
    FConserto.getByPedido;
    ShowData;
    EditionState := 'B';
  End
  else
  Begin
    ShowNoData;
    EditionState := 'I';
  End;
  EditionControl;
end;

procedure TTasConserto.Label18Click(Sender: TObject);
begin

   Pnl_Encerra.Visible := False;
end;

procedure TTasConserto.Qr_FornecedorAfterOpen(DataSet: TDataSet);
begin
  Qr_Fornecedor.FetchAll;
end;


procedure TTasConserto.Qr_Sit_EncerraAfterOpen(DataSet: TDataSet);
begin
  Qr_Sit_Encerra.FetchAll;
end;

procedure TTasConserto.Save;
begin
  Totalizador;
  GravaOrcamento;
  GravaConserto;
  CodigoRegistro := FCotacao.Registro.codigo;
end;

procedure TTasConserto.Sb_confirmaClick(Sender: TObject);
Var
  Lc_cd_encerrada : Integer;
begin
  Lc_cd_encerrada := DBLCB_Sit_encerra.KeyValue;
  if  Lc_cd_encerrada = 10 then
  Begin
    Gerar_Pedido;
    FaturaConserto;
  end
  else
  Begin
    ImprimeCupom;
  end;
  Encerrar(Lc_cd_encerrada,FConserto.Registro.codigo, E_DataEntrega.date );
  AtivaTabelas;
  ShowData;
  Totalizador;
  Pnl_Encerra.Visible := False;
end;

procedure TTasConserto.Sb_Ctas_PagarClick(Sender: TObject);
begin
  ContasPagar
end;

procedure TTasConserto.Sb_EncerrarClick(Sender: TObject);
begin
  if ValidaFaturamento then
  Begin
    Lb_Tipo.Caption := ('Pedido Nº '+ Lb_Numero.Caption);
    Lb_Valor.Caption := 'R$ ' + E_VL_Cotacao.Caption;
    DefineLista;
    Pnl_Encerra.Visible := True;
    DBLCB_Sit_encerra.KeyValue := Qr_Sit_Encerra.FieldByName('SIT_CODIGO').AsInteger;
    E_DataEntrega.Date := Date;
    DBLCB_Sit_encerra.SetFocus;
  end;
end;

procedure TTasConserto.Sb_EnviaEmailClick(Sender: TObject);
var
  Lc_Anexo : TStringList;
  Lc_Destinatario : TStringList;
  LcEnviaemail : TFr_envia_email;
begin
  Lc_Anexo := TStringList.Create;
  GeraNumero;
  if MessageDlg('Enviar e-mail desta Ordem de Serviço ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Lc_Destinatario := TStringList.Create;
    Lc_Anexo      := TStringList.Create;
    Lc_Anexo.Add('Sem anexo');
    if Length(Trim(Qr_Fornecedor.FieldByName('EMP_EMAIL').AsString))> 0 then Lc_Destinatario.Add(' '+Qr_Fornecedor.FieldByName('EMP_EMAIL').AsString);
    if (Lc_Destinatario.Count > 0) then
    begin
      LcEnviaemail := TFr_envia_email.create(nil);
      try
        with LcEnviaemail do
        Begin
          It_Tipo_Envio := 'S';
          It_Assunto := 'Ordem de Serviço Nº ' + Lb_Numero.Caption;
          It_Destino := Lc_Destinatario;
          It_Corpo   := GeraEmailTecnico();
          It_Anexo   := lc_anexo;
          ShowModal;
        end;
      finally
        FreeAndNil(LcEnviaemail);
      end;
        GravaOrcamento;
        GravaConserto;
        FCotacao.Registro.DtEnvEmail := Now;
        FCotacao.update;
        IF FCotacao.Registro.DtEnvEmail = Null THEN
          lbl_ult_atualizacao.Caption:= 'Não Enviado'
        ELSE
          lbl_ult_atualizacao.Caption:= DateTimeToStr(FCotacao.Registro.DtEnvEmail);
    end
    else
    begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'e-mail do Fornecedor não informado verifique.' + EOLN + EOLN,
                     ['OK'], [bEscape], mpErro);
    end;
  end;
end;

procedure TTasConserto.SB_ImprimirClick(Sender: TObject);
var
  Lc_Escolha: Integer;
  Lc_Destinatario, Lc_Anexo: TStringlist;
  Lc_Imp: TimpModImpressao;
  LcEnviaemail : TFr_envia_email;
begin
  Lc_Escolha := (MensagemPadrao(TITULO_INFORMACAO,
                                'Deseja enviar para?',
                                ['IMPRESSORA', 'E-MAIL', 'CANCELA'], [bNormal, bNormal, bEscape], mpConfirmacao, clBtnFace));
  Lc_Imp := TimpModImpressao.create(nil);
  Try
    case Lc_Escolha of
      0:begin
          GeraNumero;
          Lc_Imp.Pc_Imp_Tipo(1, FCotacao.Registro.Codped ,0);
          end;
      1:begin
          MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                         'Em desenvolvimento.' + EOLN + EOLN,
                         ['OK'], [bEscape], mpInformacao);
          exit;
          GeraNumero;
          if MessageDlg('Enviar e-mail deste Orçamento ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          begin
            Lc_Destinatario := TStringList.Create;
            Lc_Anexo        := TStringList.Create;
            Lc_Anexo.Add('Sem anexo');
            if Length(Trim(E_email.Text)) > 0 then Lc_Destinatario.Add(' '+E_email.Text);
            if Lc_Destinatario.Count > 0 then
            begin
              LcEnviaemail := TFr_envia_email.create(nil);
              try
                with LcEnviaemail do
                Begin
                  It_Tipo_Envio := 'S';
                  It_Assunto := 'Orçamento Nº ' + Lb_Numero.Caption;
                  It_Destino := Lc_Destinatario;
                  //FCorpo   := Fc_GeraEmail_Conserto;
                  It_Anexo   := lc_anexo;
                  ShowModal;
                end;
              finally
                FreeAndNil(LcEnviaemail);
              end;
            end
            else
            begin
              MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                             'e-mail não informado verifique.' + EOLN + EOLN,
                             ['OK'], [bEscape], mpErro);
            end;
          end;
      end;
    end;
  Finally
    FreeandNil(Lc_Imp);
  End;
end;

procedure TTasConserto.Sb_ParcelamentoClick(Sender: TObject);
Var
  Lc_Form : TFr_Parcelamento;
begin
  If (StrToFloatDef(E_VL_Cotacao.Caption,0) > 0) then
  Begin
    Lc_Form := TFr_Parcelamento.Create(nil);
    Lc_Form.Top                     := Self.Top + 90 ;
    Lc_Form.Left                    := Self.Left + 331;
    Lc_Form.It_StrinPrazo             := E_Prazo.Text;
    Lc_Form.Pedido.Registro.Codigo  := FCotacao.Registro.Codped;
    Lc_Form.ValorDuplicatas         := StrToFloatdeF(E_VL_Cotacao.Caption,0);
    Lc_Form.It_Desc_FormaPagto        := Fm_FormaPagto.DBLCB_FormaPagto.Text;
    Lc_Form.It_Bloqueio               := Fbloqueio;
    Lc_Form.E_Nr_PArcelas.Text      :=  IntToStr(StrToIntDef(E_Nr_Parcelas.Text,1));
    if Lc_Form.E_Nr_PArcelas.Text = '0' then Lc_Form.E_Nr_PArcelas.Text := '1';
    Try
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
  end;
end;

procedure TTasConserto.Sb_VoltarClick(Sender: TObject);
begin
   Pnl_Encerra.Visible := False;
end;

procedure TTasConserto.Sel_FormPagto(Pc_Bloquea_Pagto: Boolean);
VAR
lc_txt:String;
Begin
  Fm_FormaPagto.Pc_Listar(3,Pc_Bloquea_Pagto,StrToIntDef( Fm_ListaClientes.E_Cd_Empresa.Text,0));
  IF StrToIntDef( Fm_ListaClientes.E_Cd_Empresa.Text,0) >0 THEN
  BEGIN
    if (Pc_Bloquea_Pagto)  then
    BEGIN
      E_Nr_Parcelas.Enabled := ( ( EditionState = 'I' ) or ( EditionState = 'E' ) ) and (not Fbloqueio);
      E_Prazo.Enabled := ( ( EditionState = 'I' ) or ( EditionState = 'E' )  )and (not Fbloqueio);
      Sb_Parcelamento.Enabled:=( ( EditionState = 'I' ) or ( EditionState = 'E' ) )and (not Fbloqueio);
    END
    else
    BEGIN
      E_Nr_Parcelas.Enabled := (NOT Fbloqueio);
      E_Prazo.Enabled := (NOT Fbloqueio);
      Sb_Parcelamento.Enabled:= (NOT Fbloqueio);
    end;
  END
  else
  BEgin
    E_Nr_Parcelas.Enabled := ( ( EditionState = 'I' ) or ( EditionState = 'E' ) ) and (not Fbloqueio);
    E_Prazo.Enabled := ( ( EditionState = 'I' ) or ( EditionState = 'E' ) )and (not Fbloqueio);
    Sb_Parcelamento.Enabled:=( ( EditionState = 'I' ) or ( EditionState = 'E' ) ) and (not Fbloqueio);
  end;
  IF ( EditionState = 'I' ) THEN
    Fm_FormaPagto.DBLCB_FormaPagto.KeyValue:= Fc_PegaFormaPgto('CARTEIRA');
end;

procedure TTasConserto.Sel_PrazoPagto(Pc_Bloquea_Pagto: Boolean);
var
  LC_TXT:string;
begin
  lc_txt:='';
  qr_prazo_controlado.Active:=false;
  qr_prazo_controlado.SQL.Clear;
  if ((Pc_Bloquea_Pagto) AND (StrToIntDef( Fm_ListaClientes.E_Cd_Empresa.Text,0)>0)) OR (Pos('DINHEIRO',Trim(Fm_FormaPagto.DBLCB_FormaPagto.Text))>0)  then
  begin
    lc_txt:= ' SELECT prz_prazo,PRZ_CODIGO FROM tb_prazo '+
             ' WHERE                                     '+
             ' prz_prazo like :prz_prazo                 ';
    qr_prazo_controlado.SQL.Add(LC_TXT);
    qr_prazo_controlado.ParamByName('prz_prazo').AsString:='%'+'VISTA'+'%';
    qr_prazo_controlado.Active:=True;
    qr_prazo_controlado.FetchAll;
    DBLCB_Prazo.KeyValue:=qr_prazo_controlado.FIELDBYNAME('PRZ_PRAZO').AsString;
  end
  else
  if (NOT Pc_Bloquea_Pagto) AND (StrToIntDef( Fm_ListaClientes.E_Cd_Empresa.Text,0)>0) then
  begin
      lc_txt:= ' SELECT prz_prazo,PRZ_CODIGO FROM tb_prazo '+
               ' where                                     '+
               ' prz_vl_minimo <= :prz_vl_minimo           ';
      qr_prazo_controlado.SQL.Add(LC_TXT);
      qr_prazo_controlado.ParamByName('prz_vl_minimo').AsCurrency :=  FVl_Cotacao;
      qr_prazo_controlado.Active:=True;
      qr_prazo_controlado.FetchAll;
      DBLCB_Prazo.KeyValue := FCotacao.Registro.Prazo;
  end;

  IF EditionState = 'I' then
    E_Nr_Parcelas.Text :=COPY( FCotacao.Registro.Prazo,1,3)
  else
    E_Nr_Parcelas.Text :='000';//aqui quer dizer q esta inserindo

  IF TRIM(E_Nr_Parcelas.Text) <> '' THEN
  BEGIN
    E_Nr_ParcelasExit(Self);
    IF EditionState = 'I' then
      E_Prazo.Text   := COPY( FCotacao.Registro.Prazo,7,Length( FCotacao.Registro.Prazo))
    ELSE
      E_Prazo.Text   :='À VISTA';
  END;
end;

procedure TTasConserto.setPerfil;
begin
  inherited;
  if Gb_Nivel = 1 then
  begin
    FEncerrar      := True;
    FImprimir      := True;
    FEmail_tecnico := True;
    FContas_pagar  := True;
  end
  else
  begin
    FEncerrar     := Fc_HabilitaPermissao(pfMenu,'ENCERRAR','S');
    FImprimir     := Fc_HabilitaPermissao(pfMenu,'IMPRIMIR','S');
    FEmail_cliente := Fc_HabilitaPermissao(pfMenu,'EMAIL CLIENTE','S');
    FEmail_tecnico := Fc_HabilitaPermissao(pfMenu,'EMAIL TECNICO','S');
    FContas_pagar := Fc_HabilitaPermissao(pfMenu,'CONTAS PAGAR','S');
  end;
end;

procedure TTasConserto.ShowData;
begin
  ShowDataOrcamento;
  ShowDataConserto;
  Situacao_Conserto( FConserto.Registro.Situacao );
end;

procedure TTasConserto.ShowDataConserto;
begin
  with FConserto do
  Begin
    E_NumSerie.Text           := Registro.Numero;
    E_Aparelho.Text           := Registro.Aparelho;
    E_Marca.Text              := Registro.Marca;
    E_Modelo.Text             := Registro.Modelo;
    MM_Acessorios.Text        := Registro.Acessorio;
    MM_Relatado.Text          := Registro.Relatado;
    MM_Constatado.Text        := Registro.Constatado;
    DBLCB_Fornecedor.KeyValue := Registro.Codfor;
    if Registro.DataConserto <> null then
      E_Dt_Conserto.Text        := DatetoStr(Registro.DataConserto)
    else
      E_Dt_Conserto.clear;
    E_VL_Custo.Text           := FloatToStrF( Registro.VlCusto,ffFixed,10,2);
    E_VL_Peca.Text            := FloatToStrF( Registro.VlPecas,ffFixed,10,2);
    E_VL_MObra.Text           := FloatToStrF( Registro.VlMobra,ffFixed,10,2);
    Fm_ListaSituacao.DBLCB_Situacao.KeyValue :=   Registro.Situacao;
    Lb_Final_Data.Caption := 'DATA ENTREGA : ' + DateToStr( Registro.DataEntrega );
  End;
end;

procedure TTasConserto.ShowDataOrcamento;
begin
  with FCotacao do
  Begin
    Lb_Numero.Caption   := Registro.Numero;
    E_Data.Date         := Registro.Data;
    E_Nr_Parcelas.Text  := Copy( Registro.Prazo, 1, 3);
    E_Prazo.Text        := Copy( Registro.Prazo, 7, Length( Registro.Prazo ));
    E_Contato.Text      := Registro.Contato;
    E_email.Text        := Registro.EmailE;

    Fm_ListaClientes.E_Cd_Empresa.Text   := Registro.Codemp.toString;;
    Fm_ListaClientes.DBLCB_Empresa.KeyValue := Registro.Codemp;
    Fm_VendedorPedido.Dblcb_Vendedor.KeyValue := Registro.Codvdo;
    Fm_FormaPagto.DBLCB_FormaPagto.KeyValue := Registro.Codfpg;
    if StrToIntDef(Fm_ListaClientes.E_Cd_Empresa.Text,0)>0 then
    Begin
      Fbloqueio := Fc_VerificaBloqueioCliente(StrToIntDef(Fm_ListaClientes.E_Cd_Empresa.Text,0));
      Sel_FormPagto(Fbloqueio);
      Sel_PrazoPagto(Fbloqueio);
    end;
    DinheiroFormaPgt;
    IF  FCotacao.Registro.DtEnvEmail = null THEN
      lbl_ult_atualizacao.Caption:= 'Não Enviado'
    ELSE
      lbl_ult_atualizacao.Caption:= DateTimeToStr( FCotacao.Registro.DtEnvEmail );
    E_VL_Frete.Text := FloatToStrF(Registro.VlFrete,ffFixed,10,2);
    E_Aliq_Desconto.Text := FloatToStrF(Registro.AliqDesconto,ffFixed,10,2);
    E_VL_Desconto.Text := FloatToStrF(Registro.VlDesconto,ffFixed,10,2);
    E_VL_Cotacao.Caption := FloatToStrF(Registro.VlCotacao,ffFixed,10,2);
  End;

end;

procedure TTasConserto.ShowNoData;
begin
  ShowNoDataOrcamento;
  ShowNoDataConserto;
  Situacao_Conserto(1);
end;

procedure TTasConserto.ShowNoDataConserto;
begin
  E_Aparelho.Clear;
  E_Marca.Clear;
  E_Modelo.Clear;
  E_NumSerie.Clear;
  MM_Acessorios.Clear;
  MM_Relatado.Clear;
  MM_Constatado.Clear;
  E_VL_Custo.Clear;
  E_VL_Peca.Clear;
  E_VL_MObra.Clear;
  E_Dt_Conserto.Clear;
  Fm_ListaSituacao.DBLCB_Situacao.KeyValue := null;
  DBLCB_Fornecedor.KeyValue := null;
end;

procedure TTasConserto.ShowNoDataOrcamento;
begin
  E_Data.Date := Date;
  E_Nr_Parcelas.Text := '000';
  E_Prazo.Text := 'À VISTA';
  E_Data.SetFocus;
  E_Aliq_Desconto.Text := '0,00';
  E_VL_Desconto.Text := '0,00';
end;

procedure TTasConserto.Situacao_Conserto(CodigoSituacao: Integer);
begin
  case CodigoSituacao of
    0:FDesativado  := False;
    4:FDesativado  := True;
    7:FDesativado  := True;
    10:FDesativado  := True;
    11:FDesativado := True;
    12:FDesativado := false;
  else
    FDesativado := False;
  End;
  if not FDesativado then
  begin
    Fm_ListaSituacao.Etapa := 2;
    Fm_ListaSituacao.Listar;
    Lb_Final_Data.Visible := False;
  end
  else
  begin
    Fm_ListaSituacao.Etapa := 1;
    Fm_ListaSituacao.Listar;
    Lb_Final_Data.Visible := True;
  end;
end;

procedure TTasConserto.Totalizador;
Var
  Lc_Valor : Real;
begin
   Lc_Valor := StrToFloatdef(E_VL_Custo.Text, 0);
   Lc_Valor := Lc_Valor + StrToFloatdef(E_VL_Peca.Text, 0);
   Lc_Valor := Lc_Valor + StrToFloatdef(E_VL_MObra.Text, 0);

   E_VL_Custo.Text := FloatToStrF(StrToFloatdef(E_VL_Custo.Text, 0), ffFixed, 10, 2);
   E_VL_Peca.Text := FloatToStrF(StrToFloatdef(E_VL_Peca.Text, 0), ffFixed, 10, 2);
   E_VL_MObra.Text := FloatToStrF(StrToFloatdef(E_VL_MObra.Text, 0), ffFixed, 10, 2);

   FVl_Frete := StrToFloatDef(E_VL_Frete.Text, 0);
   E_VL_Frete.Text := FloatToStrF(FVl_Frete, ffFixed, 10, 2);
   E_VL_Desconto.Text := FloatToStrF(FVl_Desconto, ffFixed, 10, 2);
   FVl_Cotacao := Lc_Valor + FVl_Frete - FVl_Desconto;
   E_VL_Cotacao.Caption := FloatToStrF(FVl_Cotacao, ffFixed, 10, 2);

end;

function TTasConserto.ValidaFaturamento: Boolean;
var
   Lc_Saldo: Boolean;
begin
  if ( FConserto.Registro.Situacao = 4) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Este equipamento já foi dado como Condenado' + EOLN +
                   'Não é possível encerrar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  if ( FConserto.Registro.Situacao = 7) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Este equipamento foi entregue na Garantia' + EOLN +
                   'Não é possível encerrar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  if ( FConserto.Registro.Situacao = 10) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Este equipamento foi entregue reparado' + EOLN +
                   'Não é possível encerrar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  if (FConserto.Registro.Situacao = 11) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Este equipamento foi entregue sem reparado' + EOLN +
                   'Não é possível encerrar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  if ( FConserto.Registro.Situacao = null) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por favor atualize a situção do equipamento' + EOLN +
                   'Tente encerrar apos a atualizção.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;


  Lc_Saldo := True;
  FPedido.Empresa.Registro.Codigo := StrToIntDef(Fm_ListaClientes.E_Cd_Empresa.Text,0);
  FPedido.Empresa.getById;
  if not FPedido.Empresa.exist then
  begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
         'Por Favor Cadastre o Cliente antes' + EOLN +
         '        de gerar o pedido.' + EOLN,
         ['OK'], [bEscape], mpErro);
      result:=false;
      exit;
  end;

  if trim(Fm_FormaPagto.DBLCB_FormaPagto.Text) = '' then
  begin
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                     'Forma de Pagamento não Preenchido.' + EOLN + EOLN ,
         ['OK'], [bEscape], mpErro);
      result:=false;
      exit;
  end;
  Pc_Define_FormatoRegional;
  GeraNumero;
  Result := Lc_Saldo;
end;

function TTasConserto.ValidateChange: boolean;
begin
  Result := True;
  if ( FConserto.Registro.Situacao = 4) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Este equipamento já foi dado como Condenado' + EOLN +
                   'Não é possível encerrar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  if ( FConserto.Registro.Situacao = 7) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Este equipamento foi entregue na Garantia' + EOLN +
                   'Não é possível encerrar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  if ( FConserto.Registro.Situacao = 10) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Este equipamento foi entregue reparado' + EOLN +
                   'Não é possível encerrar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;

  if ( FConserto.Registro.Situacao = 11) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Este equipamento foi entregue sem reparado' + EOLN +
                   'Não é possível encerrar.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;


  if ( FConserto.Registro.Situacao = null) then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Por favor atualize a situção do equipamento' + EOLN +
                   'Tente encerrar apos a atualizção.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    Exit;
  end;
end;

function TTasConserto.ValidateDelete: boolean;
begin
  Result := True;
  if not ValidateChange then
  Begin
    Result := False;
    exit;
  End;

  if (not TMsgSetes.Excluir) then
  Begin
    Result := False;
    exit;
  End;

end;

function TTasConserto.ValidateSave: boolean;
Var
  Lc_Ano_Numero : String;
  Lc_Ano : String;
begin
  Result:= true;
  if Length( FCotacao.Registro.Numero ) > 0 then
  Begin
    Lc_Ano := IntToStr(Fc_Year(E_Data.Date));
    Lc_Ano_Numero := Copy( FCotacao.Registro.numero,Length( FCotacao.Registro.numero)-1,2);
    if  (Lc_Ano_Numero <> Copy(Lc_Ano,3,2)) then
      FCotacao.Registro.Numero := '';
  end;

  if trim( Fm_ListaClientes.DBLCB_Empresa.Text) = '' then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Nome do Cliente não informado. ' +EOLN +
                   ' Preencha o Cliente.'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result:=false;
    if Fm_ListaClientes.DBLCB_Empresa.Enabled then Fm_ListaClientes.DBLCB_Empresa.SetFocus;
    exit;
  end;

  if trim(Fm_VendedorPedido.DBLCB_Vendedor.Text) = '' then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Vendedor não informado. ' +EOLN +
                   ' Escolha o vendedor e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result:=false;
    Fm_VendedorPedido.DBLCB_Vendedor.SetFocus;
    exit;
  end;

  if trim(Fm_FormaPagto.DBLCB_FormaPagto.Text) = '' then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   ' Forma de Pagamento não informado. ' +EOLN +
                   ' Escolha a forma de pagamento e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpErro);
    Result:=false;
    Fm_FormaPagto.DBLCB_FormaPagto.SetFocus;
    exit;
  end;

  if E_Nr_Parcelas.Visible = true then
  BEGIN
    if trim(E_Nr_Parcelas.Text) = '' then
    begin
      MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                     ' Número de Parcelas não informado. ' +EOLN +
                     ' Escolha o número de parcela tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpErro);
      Result:=false;
      E_Nr_Parcelas.SetFocus;
      exit;
    end;
  END
  else
  BEGIN
    if trim(DBLCB_Prazo.Text) = '' then
    begin
      MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                     ' Número de Parcelas não informado. ' +EOLN +
                     ' Escolha o número de parcela tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpErro);
      Result:=false;
      DBLCB_Prazo.SetFocus;
      exit;
    END;
  END;

  VerificaContaPagar;
  //Valida se o cliente foi escolhido
  if StrToIntDef( Fm_ListaClientes.E_Cd_Empresa.Text, 0) = 0 then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Para registrar um conserto o cliente' + EOLN +
                   'obrigatoriamente deve estar cadastrado.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result:=false;
    exit;
  end;
  //Valida se o numero de série foi digitado
  if Length(E_NumSerie.Text) = 0 then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Favor Preencher o numero de Série do aparelho.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    E_NumSerie.SetFocus;
    Result:=false;
    exit;
  end;

  if Trim(Fm_ListaSituacao.DBLCB_Situacao.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                   'Favor Preencher a situção do conserto.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Fm_ListaSituacao.DBLCB_Situacao.SetFocus;
    Result:=false;
    exit;
  end;
  if E_Aliq_Desconto.Focused then
  begin
    if Desconto('A') then
      E_Data.SetFocus
    else
      exit;
  end;

  if E_VL_Desconto.Focused then
  begin
    if Desconto('V') then
       E_Data.SetFocus
    else
       exit;
  end;

end;

procedure TTasConserto.Valida_Info_cliente(Pc_Cd_Cliente: Integer);
Var
  lc_MSG : String;
  lc_vl_saldo : Real;
  lc_cd_empresa : Integer;
Begin
  lc_MSG:='';
 //Posiciona o ponteiro no endereco do cliente
  if not FPedido.Endereco.exist then
  Begin
    FPedido.Endereco.Registro.CodigoEmpresa := Pc_Cd_Cliente;
    FPedido.Endereco.getByEmpresa;
    if ( ( EditionState = 'I' ) or ( EditionState = 'E' ) ) then
    begin
      IF Length(Trim(  FPedido.Endereco.Registro.Fone)) > 0 then
        lc_MSG := fc_MascaraFone(FPedido.Endereco.Registro.fone);
      IF Length(Trim( FPedido.Endereco.Registro.Celular )) > 0 then
        lc_MSG := lc_MSG + '/'+fc_MascaraFone( FPedido.Endereco.Registro.Celular  );
      FCotacao.Registro.Contato := lc_MSG;
    end;
  End;

 //Devolver verdadeiro se o cadastro estiver completo
  if Fc_Verifica_Cadastro_Cliente(Pc_Cd_Cliente) then
  Begin
    IF (EditionState = 'I' ) then
    begin
      FCotacao.Registro.EmailE :=  Fm_ListaClientes.Qr_ListaEmpresa.FieldByName('EMP_EMAIL').AsString;
      if GB_Cd_Vendedor >0 then
      Begin
        FCotacao.Registro.Codvdo := Gb_Cd_Vendedor;
        Fm_VendedorPedido.DBLCB_Vendedor.KeyValue := Gb_Cd_Vendedor;
      end
      else
      Begin
        FCotacao.Registro.Codvdo := Fm_ListaClientes.Qr_ListaEmpresa.FieldByname('EMP_CODVDOR').AsInteger;
        Fm_VendedorPedido.DBLCB_Vendedor.KeyValue := FCotacao.Registro.Codvdo
      end;
    end;
  end;
  if Fm_VendedorPedido.DBLCB_Vendedor.Enabled then Fm_VendedorPedido.DBLCB_Vendedor.SetFocus;


  //Verifica o Saldo restante do Cliente

  if (Fc_Tb_Geral('L','FIN_G_BLOQ_LIMITE','') = 'S')then
  Begin
    lc_cd_empresa := Fm_ListaClientes.DBLCB_Empresa.KeyValue;
    lc_vl_saldo:= Fc_LimitedeCredito(lc_cd_empresa);
    lc_vl_saldo:= lc_vl_saldo - Fc_SaldoCLiente(lc_cd_empresa);
    Fm_ListaClientes.DBLCB_Empresa.KeyValue := lc_cd_empresa;
    if (lc_vl_saldo<0) then
    begin
      lc_MSG:='O cliente excedeu seu limite em R$:' +FormatFloat('#,##0.00',lc_vl_saldo) ;
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     lc_MSG+EOLN,
                  ['OK'],[bEscape],mpErro);
    end;
    if (lc_vl_saldo=0) then
    begin
      lc_MSG:='O cliente esta com o limite de Crédito Zerado' ;
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     lc_MSG+EOLN,
                  ['OK'],[bEscape],mpErro);
    end;
    if (lc_vl_saldo >0) then
    begin
      lc_MSG:='O cliente tem saldo de limite de R$:' +FormatFloat('#,##0.00',lc_vl_saldo) ;
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     lc_MSG+EOLN,
                   ['OK'],[bEscape],mpInformacao);
    end;
  end;

end;

function TTasConserto.VerificaContaPagar: boolean;
var
   Lc_Valor: Real;
begin
  Result := True;
   Qr_Acao.Close;
   Qr_Acao.SQL.Clear;
   Qr_Acao.SQL.Add('SELECT FIN_CODIGO ' +
      'FROM TB_FINANCEIRO tb_financeiro ' +
      '  INNER JOIN TB_NOTA_FISCAL tb_nota_fiscal ' +
      '  ON (tb_nota_fiscal.NFL_CODIGO = tb_financeiro.FIN_CODNFL) ' +
      'WHERE (NFL_NUMERO =:NFL_NUMERO) ');
   Qr_Acao.ParamByName('NFL_NUMERO').AsString := Copy( FCotacao.Registro.Numero, 7, Length( FCotacao.Registro.Numero) - 6);
   Qr_Acao.Active := True;
   Qr_Acao.FetchAll;
   Lc_Valor := StrToFloatDef(E_VL_Peca.Text, 0) + StrToFloatDef(E_VL_MObra.Text, 0);
   if (Qr_Acao.RecordCount = 0) and (Lc_Valor > 0) then
   begin
      if (MensagemPadrao(TITULO_CONFIRMACAO,
                         'Não existe Contas a Pagar para este Conserto.' + EOLN + EOLN +
                         'Deseja gerar agora ?',
                         [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
        ContasPagar;
   end;
end;

end.

