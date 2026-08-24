unit UN_Lanca_Pagto;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, DB, StdCtrls, DBCtrls, Mask, ExtCtrls, STQuery, Printers, ComCtrls, Grids, QEdit_Setes, Un_Fm_CentroCusto, Un_Fm_FormaPagto, ControllerNotaFiscal, un_base, ControllerFinanceiro, Vcl.Menus, base_frame_list, un_fm_lista_cfop;

type

  TFr_Lanca_Pagto = class(TFr_Base)
    Panel1: TPanel;
    Panel2: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Fechar: TSpeedButton;
    Qr_Acao: TSTQuery;
    Panel3: TPanel;
    StGrd_Prazo: TStringGrid;
    Tpk_Prazo: TDateTimePicker;
    Ds_Fornecedor: TDataSource;
    Grb_Empresa: TGroupBox;
    Sb_Fornecedores: TSpeedButton;
    DBLCB_Empresa: TDBLookupComboBox;
    E_Cod_For: TMaskEdit;
    Qr_Endereco: TSTQuery;
    Qr_Empresa: TSTQuery;
    GroupBox6: TGroupBox;
    E_Nr_PArcelas: TMaskEdit;
    E_Prazo: TMaskEdit;
    Sb_Prazo: TSpeedButton;
    Label3: TLabel;
    E_Nr_Doc: TEdit;
    Label5: TLabel;
    E_VL_Doc: TEdit_Setes;
    Label9: TLabel;
    E_Obs: TMemo;
    Label8: TLabel;
    Lb_VL_Total: TLabel;
    E_Dt_Emissao: TDateTimePicker;
    Chbx_Credito: TCheckBox;
    GroupBox1: TGroupBox;
    Fm_CentroCusto: TFm_CentroCusto;
    Fm_FormaPagto: TFm_FormaPagto;
    Label1: TLabel;
    E_Nr_Modelo: TEdit;
    E_Nr_Serie: TEdit;
    Label2: TLabel;
    Fm_lista_cfop: TFm_lista_cfop;
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure SB_FecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLCB_TransportadoraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StGrd_PrazoClick(Sender: TObject);
    procedure Tpk_PrazoChange(Sender: TObject);
    procedure Sb_FornecedoresClick(Sender: TObject);
    procedure E_Cod_ForExit(Sender: TObject);
    procedure DBLCB_EmpresaExit(Sender: TObject);
    procedure Sb_PrazoClick(Sender: TObject);
    procedure E_Nr_PArcelasExit(Sender: TObject);
    procedure E_PrazoExit(Sender: TObject);
    procedure E_VL_DocExit(Sender: TObject);
    procedure DBLCB_EmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StGrd_PrazoSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure StGrd_PrazoSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StGrd_PrazoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure Chbx_CreditoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }

    //Valores das Notas
    It_Vl_NotaFiscal: Currency;
    It_VL_Duplicatas: Currency;
    It_VL_Desconto: Currency;

    It_Qt_Parcelas : Integer;

    //Controle de Sequencias
    It_Cd_Nota : Integer;
    It_Dup_Numero : Integer;

  public
    { Public declarations }
    It_Tipo_Fin : String;
    It_Operacao : String;
    NotaFiscal : TControllerNotaFiscal;
    Financeiro : TControllerFinanceiro;
    PROCEDURE Pc_IniciaVariaveis;
    procedure Pc_FormataTela;
    procedure Pc_AtivarTabela;
    procedure Pc_Faturar;
    procedure Pc_Gera_NotaFiscal;
    procedure Pc_GeraFinanceiro;
    function Fc_Valida_faturamento():boolean;
    Procedure Pc_MontaPrazo(Pc_Qt_Parcela : Integer ; Pc_Valor :Real ; Pc_Data : Tdate);
    procedure Pc_AbreTelaCliente;
    procedure Pc_AbreTelaFornecedor;

  end;

var
  Fr_Lanca_Pagto: TFr_Lanca_Pagto;

implementation


uses     Un_DM, Un_Msg, Un_Funcoes, sea_dead_line, UN_NF, UN_Sistema, Un_Fc_Sored_Procedures, UN_FormaPagto, RN_Permissao, UN_Principal, env, sea_cfop, RN_PlanoContas, RN_FormaPagto, RN_Financeiro, Un_Fornecedor, UN_TabelasEmListas, Un_Cliente, RN_Cliente, RN_Fornecedor;
{$R *.dfm}

PROCEDURE TFr_Lanca_Pagto.Pc_IniciaVariaveis;
BEgin
  Tpk_Prazo.Date := Date;
  E_Dt_Emissao.Date := Date;
  E_Obs.Clear;
  if It_Tipo_Fin = 'PM' then
    DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaFornecedor
  else
    DBLCB_Empresa.ListSource := DM_ListaConsultas.Ds_ListaCliente;
  Pc_Define_FormatoRegional;
  E_Dt_Emissao.Date := Date;
  Pc_MontaPrazo(1,0,Date);
end;

procedure TFr_Lanca_Pagto.Pc_FormataTela;
BEgin
  with StGrd_Prazo do
  Begin
    Cells[1,0]:='Vencimento';
    Cells[2,0]:='Valor';
    ColWidths[0]:=17;
    ColWidths[1]:=90;
    ColWidths[2]:=75;
  End;

End;

procedure TFr_Lanca_Pagto.FormCreate(Sender: TObject);
begin
  NotaFiscal := TControllerNotaFiscal.Create(Self);
  Financeiro := TControllerFinanceiro.Create(Self);
end;

procedure TFr_Lanca_Pagto.Pc_AtivarTabela;
var
  Lc_SentidoCFop : String;
Begin

  Fm_FormaPagto.Pc_Listar(3,False,0);
  Fm_CentroCusto.Pc_ListaParaUsar;
  if It_Tipo_Fin = 'PM' then
  Begin
    Pc_AbreListaFornecedor('EMP_NOME');
    Lc_SentidoCFop := 'E';
  End
  ELSE
  Begin
    Pc_AbreListaCliente('EMP_NOME');
    Lc_SentidoCFop := 'S';
  End;
  Fm_lista_cfop.Sentido := Lc_SentidoCFop;
  Fm_lista_cfop.Alcada  := '';
  Fm_lista_cfop.Listar;
end;

procedure TFr_Lanca_Pagto.Pc_Faturar;
Begin
  //Inicia o Faturamento
  Try
    Pc_Gera_NotaFiscal;
    Pc_GeraFinanceiro;
    MensagemPadrao(MENSAGEM,TITULO_CONFIRMACAO+EOLN+EOLN+
                   'Lançamento realizado com Sucesso.'+EOLN,
                   ['OK'],[bEscape],mpConfirmacao);
    IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
    Close;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Erro ao gerar Lançamento.'+EOLN+
                   'Verifique os dados do Lançamento.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    DM.IB_Transacao.RollbackRetaining;
  end;
end;


procedure TFr_Lanca_Pagto.Pc_Gera_NotaFiscal;
Var
  Lc_cd_CFOP : Integer;

begin
  //Gerar Nota Fiscal
  It_Cd_Nota:= Fc_Generator('GN_NOTA_FISCAL','','NFL_CODIGO');
  if Fm_lista_cfop.Dblcb_Lista.Text <> '' then
    Lc_cd_CFOP := Fm_lista_cfop.Dblcb_Lista.KeyValue
  else
    Lc_cd_CFOP := 0;
  WITH NotaFiscal.Registro DO
  Begin
    Codigo := It_Cd_Nota;
    CodigoEstabelecimento := Gb_CodMha;
    Tipo :=  'EM';
    Finalidade := '1';
    Numero := E_Nr_Doc.Text;
    if Trim(E_Nr_Serie.Text) = '' then
      Serie :=  '1'
    else
      Serie :=  Trim(Copy(E_Nr_Serie.Text,1,10));
    CodigoCFOP := Lc_cd_CFOP;
    CodigoPedido := 0;
    CodigoEmpresa :=  StrToIntDef(E_Cod_For.text,0);
    DataEmissao := E_Dt_Emissao.Date;
    DataSaida := E_Dt_Emissao.Date;
    HoraSaida := Now;
    ValorNota := StrToFloatDef(E_VL_Doc.Text,0);
    ContaFrete := 0;
    ControlaRetorno := 'N';
    Situacao := 'F';
    CFOP := Fm_lista_cfop.Qr_Lista.FieldByName('NAT_CFOP').asString;
    if Trim(E_Nr_modelo.Text) = '' then
      Modelo := '00'
    else
      Modelo := Copy(E_Nr_Modelo.Text,1,2);
  End;
  NotaFiscal.salva;
  if Length(E_Obs.Text) > 0 then
  Begin
    Pc_Observacao(DM.IB_Transacao,
                  'I',
                  0,
                  0,
                   It_Cd_Nota,
                  'M',
                  E_Obs.Text);
  end;
end;


procedure TFr_Lanca_Pagto.Pc_GeraFinanceiro;
Var
  Lc_I : Integer;
  Lc_CentroCusto : Integer;
  Lc_Ctrl_Autorizacao : Boolean;
  Lc_Supervisor : Boolean;
Begin
  Lc_CentroCusto := 0;
  if Fm_CentroCusto.DBLCB_Plano.Text <> '' then
    Lc_CentroCusto := Fm_CentroCusto.DBLCB_Plano.KeyValue;
  Lc_Ctrl_Autorizacao := ( Fc_Tb_Geral('L','FIN_CP_AUTO_BAIXA','N') = 'S');
  if It_Tipo_Fin = 'PM' then
    Lc_Supervisor := Fc_VerificaPermissao('Fr_Lanca_Pagto_Pagar','Lançamento Contas a Pagar','SUPERVISOR',GB_Cd_Usuario,'N')
  else
    Lc_Supervisor := Fc_VerificaPermissao('Fr_Lanca_Pagto_Receber','Lançamento Contas a Receber','SUPERVISOR',GB_Cd_Usuario,'N');

  with Financeiro.Registro, StGrd_Prazo do
  Begin
    For Lc_I:= 1 to (RowCount - 1) do
    Begin
      Codigo := 0;
      CodigoEmpresa       := StrToIntDef(E_Cod_For.TEXT,0);
      DataFinanceiro      := E_Dt_Emissao.Date;
      CodigoPedido        :=  0;
      CodigoNota          := It_Cd_Nota;
      FormaPagamento      := Fm_FormaPagto.DBLCB_FormaPagto.KeyValue;
      PrazoPagamento      := E_Nr_PArcelas.Text + ' - ' + E_Prazo.Text;
      DataVencimento      := StrToDate(StGrd_Prazo.Cells[1,Lc_I]);
      NumeroDuplicata     := IntToStr(It_Cd_Nota) + '/' +IntToStr(Lc_I) + '-' + IntToStr(It_Qt_Parcelas);
      ValorParcela        := StrToFloatDef(StGrd_Prazo.Cells[2,Lc_I],0);
      NumeroParcela       := Lc_I;
      DocumentoBaixado    := 'N';
      CentroCusto         := Lc_CentroCusto;
      TipoFinanceiro      := It_Tipo_Fin;
      SituacaoFinanceiro  := 'N';
      OperacaoFinanceiro  := It_Operacao;
      EtapaFinaceiro      := 'N';
      Estabelecimento     := Gb_CodMha;
      Autorizado        := 'S';
      if (Lc_Ctrl_Autorizacao) then
      Begin
        if (Gb_Nivel = 0) and (not Lc_Supervisor) then
          Autorizado        := 'N';
      End;
      Financeiro.salva;
    End;
  end;
end;

function TFr_Lanca_Pagto.Fc_Valida_faturamento():boolean;
Var
  Lc_Texto : String;
Begin
  Result := true;
  If (TRIM(Fm_FormaPagto.DBLCB_FormaPagto.Text) ='') then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Preenchimento do Campo Forma de pagamento é obrigatório.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Fm_FormaPagto.DBLCB_FormaPagto.SetFocus;
    Result := False;
    exit;
  end;

  if (StrToFloatDef(E_VL_Doc.Text,0) =0) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Valor do Lançamento não pode ser igual a zero.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_VL_Doc.SetFocus;
    Result := False;
    exit;
  end;

  if (StrToFloatDef(E_VL_Doc.Text,0)) <> (StrToFloatDef(Lb_VL_Total.Caption,0)) then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Valor do Lançamento e Valores parcelados não coincidem.'+EOLN+
                   'Verifique os valores do parcelamento.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_VL_Doc.SetFocus;
    Result := False;
    exit;
  end;

  If (TRIM(E_Nr_PArcelas.Text) ='') then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Número de Parcelas é obrigatório.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_Nr_PArcelas.SetFocus;
    Result := False;
    exit;
  end;
  //valida o numero de parcelas
  Lc_Texto :=  StringReplace(E_Prazo.Text,'/','',[rfReplaceAll, rfIgnoreCase]);
  If (TRIM(Lc_Texto) ='') then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Prazo/Parcelamento é obrigatório.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_Prazo.SetFocus;
    Result := False;
    exit;
  end;

  If (TRIM(DBLCB_Empresa.Text) ='') then
  Begin
    if It_Tipo_Fin = 'RM' then Lc_Texto := 'Cliente' else Lc_Texto := 'Fornecedor';
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Preenchimento do Campo ' + Lc_Texto + ' é obrigatório.'+EOLN+
                   'Verifique e tente novamente'+EOLN,
                  ['OK'],[bEscape],mpErro);
    DBLCB_Empresa.SetFocus;
    Result := False;
    exit;
  end;
  DBLCB_EmpresaExit(Self);
end;

procedure TFr_Lanca_Pagto.SB_ConfirmarClick(Sender: TObject);
begin
  if Fc_Valida_faturamento then
  Begin
    Pc_Faturar;
  end;
end;


procedure TFr_Lanca_Pagto.SB_FecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Lanca_Pagto.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;

end;

procedure TFr_Lanca_Pagto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    begin
    case Key of
      VK_F10  : if SB_Confirmar.Enabled then SB_ConfirmarClick(Sender);
      VK_ESCAPE : If SB_Fechar.Enabled then SB_FecharClick(Sender);
    end;
    end;
end;

procedure TFr_Lanca_Pagto.DBLCB_TransportadoraKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_DELETE : DBLCB_Empresa.KeyValue := 0;
    end;
  end;
end;

Procedure TFr_Lanca_Pagto.Pc_MontaPrazo(Pc_Qt_Parcela : Integer; Pc_Valor :Real; Pc_Data : Tdate);
Var
  Lc_St_Parcela : String;
  Lc_Vl_Parcela : Real;
  Lc_I, Lc_J : Integer;
  Lc_Prazo : String;
  Lc_Tamanho:Integer;
  Lc_Data : TDate;
  Lc_Str_Data : String;
Begin
  For Lc_I := 1  to StGrd_Prazo.RowCount do
    For Lc_J := 1  to StGrd_Prazo.ColCount do
      StGrd_Prazo.Cells[Lc_j,Lc_I]:= '';
  StGrd_Prazo.RowCount := 2;
  if Pc_Qt_Parcela = 0 then Pc_Qt_Parcela := 1;
  It_Qt_Parcelas := Pc_Qt_Parcela;
  It_VL_Duplicatas := Pc_Valor;
  if Pc_Qt_Parcela > 6 then
  Begin
    Lc_Str_Data := '';
    InputQuery('Parcelamentos acima de 6 Perãodos', 'Informe o Primeiro Vencimento - Formato(dd/mm/aaaa) ', Lc_Str_Data);
    if Lc_Str_Data = '' then
    Begin
      E_Nr_PArcelas.SetFocus;
      E_Nr_PArcelas.SelectAll;
      Exit;
    End;

    Lc_Data := StrToDateDef(Lc_Str_Data,Date);
  End;
  //Resolvemos o problema da Divisão e dizima periodica
  Lc_St_Parcela := FloatToStrF((It_VL_Duplicatas / It_Qt_Parcelas),ffFixed,10,2);
  Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);

  For Lc_I := 0 to (It_Qt_Parcelas - 1) do
  begin
    StGrd_Prazo.RowCount := It_Qt_Parcelas + 1;
    //Numero do parcelamentos
    StGrd_Prazo.Cells[0,Lc_I+1]:=IntToStr(Lc_I + 1);
    if Pc_Qt_Parcela <= 6 then
      Lc_Prazo :=  Copy(E_Prazo.Text,((Lc_I * 4)+1),3);

    if not (Lc_I = (It_Qt_Parcelas-1)) then
      StGrd_Prazo.Cells[2,Lc_I+1]:=(Lc_St_Parcela)
    else
      StGrd_Prazo.Cells[2,Lc_I+1]:= FloatToStrF((It_VL_Duplicatas -(Lc_Vl_Parcela * (It_Qt_Parcelas-1))),ffFixed,10,2);
    if Pc_Qt_Parcela <= 6 then
    Begin
      StGrd_Prazo.Cells[1,Lc_I+1]:=  DateToStr(Pc_Data + StrToIntDef(Lc_Prazo,0));
      if Lc_I = 0 then Tpk_Prazo.Date := Pc_Data + StrToIntDef(Lc_Prazo,0);
    end
    else
    Begin
      StGrd_Prazo.Cells[1,Lc_I+1]:=  DateToStr(Lc_Data);
      if Lc_I = 0 then Tpk_Prazo.Date := Lc_Data;
      //Depois de atribuir o primeiro vencimento vamos acrescetando 30 dias
      Lc_Data := Lc_Data + 30;
    end;
  end;
end;

procedure TFr_Lanca_Pagto.StGrd_PrazoClick(Sender: TObject);
begin
  Tpk_Prazo.Visible:=tRUE;
  Tpk_Prazo.DateTime:=StrToDateDef(StGrd_Prazo.Cells[1,(StGrd_Prazo.Row)],Date);
end;

procedure TFr_Lanca_Pagto.Tpk_PrazoChange(Sender: TObject);
begin
  StGrd_Prazo.Cells[1,(StGrd_Prazo.Row)]:=DateToStr(Tpk_Prazo.DateTime);
  Tpk_Prazo.Visible:=False;
end;

procedure TFr_Lanca_Pagto.Pc_AbreTelaCliente;
Var
  Lc_Form : TFr_Cliente;
begin
  Try
    Lc_Form := TFr_Cliente.Create(nil);
    If trim(DBLCB_Empresa.Text) <> '' then
      Lc_Form.Empresa.Registro.Codigo := DBLCB_Empresa.KeyValue;
    Lc_Form.ShowModal;
    Pc_AbreListaCliente('EMP_NOME');
    DBLCB_Empresa.KeyValue := Lc_Form.Empresa.Registro.Codigo;
    E_Cod_For.Text := Lc_Form.Empresa.Registro.Codigo.toString;
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Lanca_Pagto.Pc_AbreTelaFornecedor;
Var
  Lc_Form : TFr_Fornecedor;
begin
  try
    Lc_Form := TFr_Fornecedor.Create(nil);
    Lc_Form.Empresa.Registro.Codigo := 0;
    If trim(DBLCB_Empresa.Text) <> '' then
      Lc_Form.Empresa.Registro.Codigo := DBLCB_Empresa.KeyValue;
    Lc_Form.ShowModal;
  finally
    Pc_AbreListaFornecedor('EMP_NOME');
    DBLCB_Empresa.KeyValue := Lc_Form.Empresa.Registro.Codigo;
    E_Cod_For.Text := Lc_Form.Empresa.Registro.Codigo.ToString;
    FreeAndNil(Lc_Form);
  end;

end;

procedure TFr_Lanca_Pagto.Sb_FornecedoresClick(Sender: TObject);
begin
  if It_Tipo_Fin = 'RM' then
    Pc_AbreTelaCliente
  else
    Pc_AbreTelaFornecedor;
end;

procedure TFr_Lanca_Pagto.E_Cod_ForExit(Sender: TObject);
begin
  DBLCB_Empresa.KeyValue := StrToIntDef(E_Cod_For.Text,0);
end;

procedure TFr_Lanca_Pagto.DBLCB_EmpresaExit(Sender: TObject);
begin
  if DBLCB_Empresa.Text <> '' then 
    E_Cod_For.Text := DBLCB_Empresa.KeyValue
  else
    E_Cod_For.Clear;
end;

procedure TFr_Lanca_Pagto.Sb_PrazoClick(Sender: TObject);
VAr
  Lc_Form : TSeaDeadLine;
begin
  Lc_Form := TSeaDeadLine.create(self);
  try
    Lc_Form.show;
  finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Lanca_Pagto.E_Nr_PArcelasExit(Sender: TObject);
begin
  E_Prazo.ReadOnly := False;
  if StrToIntDef(E_Nr_Parcelas.Text,0)> 0 then
  Begin
    E_Prazo.Clear;
    if StrToIntDef(E_Nr_Parcelas.Text,0)> 6 then
    Begin
      E_Prazo.EditMask := '';
      E_Prazo.ReadOnly := True;
      E_Prazo.Text := 'PARCELAS COM INTERVALO DE 30 DIAS';
    End
    else
    Begin
      E_Prazo.EditMask := Fc_MascaraPrazo(StrToIntDef(E_Nr_Parcelas.Text,1));
    End;
  end
  else
  Begin
    E_Prazo.EditMask := '';
    E_Nr_Parcelas.Text := '000';
    E_Prazo.Text := Fc_MascaraPrazo(StrToIntDef(E_Nr_Parcelas.Text,0));
    E_PrazoExit(Self);
  end;
end;

procedure TFr_Lanca_Pagto.E_PrazoExit(Sender: TObject);
begin
  Pc_MontaPrazo(StrToIntDef(E_Nr_PArcelas.Text,0),StrToFloatDef(E_VL_Doc.Text,0),E_Dt_Emissao.date);
end;

procedure TFr_Lanca_Pagto.E_VL_DocExit(Sender: TObject);
begin
  E_VL_Doc.Text := FloatToStrF(StrToFloatDef(E_VL_Doc.Text,0),ffFixed,10,2);
  Lb_VL_Total.Caption := FloatToStrF(StrToFloatDef(E_VL_Doc.Text,0),ffFixed,10,2);
end;

procedure TFr_Lanca_Pagto.DBLCB_EmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
      DBLCB_Empresa.KeyValue:=Null;
    end;
  end;
end;

procedure TFr_Lanca_Pagto.StGrd_PrazoSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
Var
  lc_TL : Real;
  LC_I : Integer;
begin
  if ACol = 2 then
    Begin
    lc_TL:=0;
    for LC_I := 1 to StGrd_Prazo.RowCount - 1 do
      lc_TL := lc_TL + StrToFloatDef(StGrd_Prazo.Cells[2,LC_I],0);
    Lb_VL_Total.Caption := FloatToStrF(lc_TL,ffFixed,10,2);
    end;

end;

procedure TFr_Lanca_Pagto.StGrd_PrazoSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin
  if ((ACol = 1) AND (ARow <> 0)) then
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

procedure TFr_Lanca_Pagto.StGrd_PrazoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string; 
begin
  If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
    begin
    StGrd_Prazo.Canvas.Font.Color:= clBlack;
    StGrd_Prazo.Canvas.Brush.Color:= clMoneyGreen;
    end;
  StGrd_Prazo.Canvas.FillRect(Rect); // redesenha a celula
  StGrd_Prazo.Canvas.TextOut(Rect.Left+2,Rect.Top,StGrd_Prazo.Cells[acol,arow]); // reimprime o texto.


  { Pega o texto da célula }
  Texto := StGrd_Prazo.Cells[acol, ARow];

  { Calcura largura e altura (em pontos) do texto }
  LarguraTexto := StGrd_Prazo.Canvas.TextWidth(Texto);
  AlturaTexto := StGrd_Prazo.Canvas.TextHeight(Texto);

  { Calcula a posição horizontal do início do texto }
  if  (ACol = 1) then { esquerda }
    X := Rect.Left + 2
  else if  (ACol = 5) then { Centro }
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

procedure TFr_Lanca_Pagto.FormShow(Sender: TObject);
begin
  Pc_IniciaVariaveis;
  Pc_FormataTela;
  Pc_AtivarTabela;
end;

procedure TFr_Lanca_Pagto.Chbx_CreditoClick(Sender: TObject);
begin
  if It_Operacao = 'C' then It_Operacao := 'D' else It_Operacao := 'C';


end;

end.

