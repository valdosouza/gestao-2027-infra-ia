unit Un_Cliente;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Empresa, Data.DB, STQuery, Vcl.Menus, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.StdCtrls, QEdit_Setes, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_ListaColaboradores, ControllerCliente, System.StrUtils, Un_Fm_ListaTabelaPreco, STDataSet,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFr_Cliente = class(TFr_Empresa)
    TabSheet2: TTabSheet;
    Pnl_Parametro: TPanel;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label31: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    E_VL_Credito: TEdit;
    Cb_mala_direta: TComboBox;
    DBLCB_Transportadora: TDBLookupComboBox;
    E_Agencia: TEdit;
    E_ContaBanc: TEdit;
    E_Multiplicador: TEdit;
    DBLCB_Banco: TDBLookupComboBox;
    E_Red_Ctro: TEdit;
    bb_status: TBitBtn;
    gp_carteira: TGroupBox;
    rdb_Hab_Cart0: TRadioButton;
    rdb_Hab_Cart1: TRadioButton;
    Rg_Lojista: TRadioGroup;
    TabSheet5: TTabSheet;
    Pnl_Ficha: TPanel;
    Sb_Exc_FichaCadastral: TSpeedButton;
    Sb_Alt_FichaCadastral: TSpeedButton;
    Sb_Ins_FichaCadastral: TSpeedButton;
    Sb_Imp_FichaCadastral: TSpeedButton;
    Dbg_FichaCadastral: TDBGrid;
    Qr_FichaCadastral: TSTQuery;
    Ds_FichaCadastral: TDataSource;
    Qr_Cliente: TSTQuery;
    chbx_Just_Xml: TCheckBox;
    Label67: TLabel;
    Label59: TLabel;
    RG_ISS_RET: TRadioGroup;
    E_ISS_Nr_Processo: TEdit;
    Cb_ISS_EXIGIB: TComboBox;
    Rg_ISS_IND_INC_FISCAL: TRadioGroup;
    FichaFinanceira1: TMenuItem;
    ChBx_ClienteAtivo: TCheckBox;
    chbx_send_email_auto: TCheckBox;
    tbs_obs_nota: TTabSheet;
    Panel5: TPanel;
    Obs_Nota: TMemo;
    Fm_ListaTabelaPreco: TFm_ListaTabelaPreco;
    Contratos1: TMenuItem;
    rocabrech1: TMenuItem;
    procedure bb_statusClick(Sender: TObject);
    procedure Sb_Ins_FichaCadastralClick(Sender: TObject);
    procedure Sb_Alt_FichaCadastralClick(Sender: TObject);
    procedure Sb_Exc_FichaCadastralClick(Sender: TObject);
    procedure Sb_Imp_FichaCadastralClick(Sender: TObject);
    procedure Ds_EmpresaStateChange(Sender: TObject);
    procedure Tb_EmpresaAfterOpen(DataSet: TDataSet);
    procedure TabSheet5Show(Sender: TObject);
    procedure FichaFinanceira1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rocabrech1Click(Sender: TObject);
  private
    { Private declarations }
    Cliente : TControllerCliente;
    procedure Pc_AbreDadosClientes;

    procedure Pc_AbreDadosFichaCadastral;

  protected
    procedure Pc_AtivarTabelas;override;
    function ClienteConsumidor:Boolean;
    function validaAlterar:Boolean;override;
    procedure Pc_Alterar;Override;
    procedure Pc_Gravar;Override;
    procedure Pc_GravarCliente;
    procedure Pc_Deletar; Override;
    function ValidaDeletar:Boolean;Override;
    procedure Pc_PreencheSemDados; Override;
    procedure Pc_PreencheComDados;Override;
    procedure Pc_ImagemBotao; Override;
    procedure Pc_Inserir;override;
  public
    { Public declarations }
  end;

var
  Fr_Cliente: TFr_Cliente;

implementation

{$R *.dfm}

uses     Un_Ficha_Cadastral, Un_RL_Ficha_Cadastro, RN_Cliente, UN_TabelasEmListas, UN_Principal, env, Un_DM, UN_Sistema, RN_Crud, Un_Msg, RN_Permissao, Un_Regra_Negocio, Un_Fich_Fin_Cli, RN_FormaPagto,
  RN_Empresa, un_frx_ctt_troca_brecho;
procedure TFr_Cliente.bb_statusClick(Sender: TObject);
begin
  // Verifica o status do campo
  if Empresa.Registro.SituacaoCredito  = 'L' then
    Empresa.Registro.SituacaoCredito :='B'
  else
    Empresa.Registro.SituacaoCredito :='L';

  if Empresa.Registro.SituacaoCredito = 'L' then
   bb_status.Caption := 'Liberado'
  else
    bb_status.Caption := 'Bloqueado';
  // Fim verifica o status do campo
end;

function TFr_Cliente.ClienteConsumidor: Boolean;
Var
  LcCliente : Integer;
begin
  Result := false;
  LcCliente := StrToIntdef(Fc_Tb_Geral('L','VDA_G_CODCONS','0'),0);
  if  Empresa.Registro.Codigo = LcCliente then
  Begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Este cadastro não pode ser editado.' + EOLN +
                   'Ele é utilizado para vendas não identificadas.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := True;
    exit;
  End;
end;

procedure TFr_Cliente.Ds_EmpresaStateChange(Sender: TObject);
begin
  inherited;

  Pnl_Parametro.Enabled := ( ( EditionState = 'I' ) or ( EditionState = 'E' ));


  if Fc_Tb_Geral('L','FIN_G_BLOQ_LIMITE','') = 'S' then
  begin
    bb_status.Enabled :=((EditionState = 'I') or (EditionState = 'E')) AND (Gb_Nivel = 1);
    E_VL_Credito.Enabled := ((EditionState = 'I') or (EditionState = 'E')) AND (Gb_Nivel = 1);
    gp_carteira.Enabled := ((EditionState = 'I') or (EditionState = 'E')) AND (Gb_Nivel = 1);
  end
  else
  begin
    bb_status.Enabled :=((EditionState = 'I') or (EditionState = 'E'));
    E_VL_Credito.Enabled := ((EditionState = 'I') or (EditionState = 'E'));
    gp_carteira.Enabled :=  ((EditionState = 'I') or (EditionState = 'E'));
  end;


  //BOTOES FICHA CADASTRAL
  Sb_Ins_FichaCadastral.Enabled := ((EditionState = 'I') or (EditionState = 'E')) ;
  Sb_Alt_FichaCadastral.Enabled := (((EditionState = 'I') or (EditionState = 'E')) and ( Empresa.Registro.Codigo >0 ) and (Qr_FichaCadastral.RecordCount>0));
  Sb_Exc_FichaCadastral.Enabled := (((EditionState = 'I') or (EditionState = 'E')) and ( Empresa.Registro.Codigo >0 ) and (Qr_FichaCadastral.RecordCount>0));
  Sb_Imp_FichaCadastral.Enabled := (((EditionState = 'I') or (EditionState = 'E')) and ( Empresa.Registro.Codigo >0 ) and (Qr_FichaCadastral.RecordCount>0));


end;

procedure TFr_Cliente.FichaFinanceira1Click(Sender: TObject);
Var
  Lc_Form : TFr_Fich_Fin_Cli;
begin
  if Fc_VerificaPermissao('Fr_Fich_Fin_Cli','Ficha Financeira Cliente','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    if Empresa.Registro.Codigo > 0 then
    Begin
      Try
        Lc_Form := TFr_Fich_Fin_Cli.Create(nil);
        Lc_Form.It_Cd_Cliente := Empresa.Registro.Codigo;
        Lc_Form.It_Nm_Cliente := Empresa.Registro.NomeRazaoSocial;
        Lc_Form.ShowModal;
      Finally
        FreeAndNil(Lc_Form);
      End;
    end;
  end;

end;

procedure TFr_Cliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Cliente);
  inherited;

end;

procedure TFr_Cliente.FormCreate(Sender: TObject);
begin
  inherited;
  Cliente := TControllerCliente.Create(Self);
end;

procedure TFr_Cliente.Pc_Alterar;
begin
  inherited;

end;

procedure TFr_Cliente.Pc_AtivarTabelas;
begin
  inherited;
  DM_ListaConsultas.Pc_ListaTranportadoras('EMP_NOME');
  DM_ListaConsultas.Pc_ListaBanco();
  Fm_ListaTabelaPreco.Listar(0);
end;

procedure TFr_Cliente.Pc_Deletar;
begin
  inherited;
  Cliente.Registro.Ativo := 'N';
  Cliente.salva;
end;

procedure TFr_Cliente.Pc_Gravar;
Begin
  inherited;
  Pc_GravarCliente
end;

procedure TFr_Cliente.Pc_GravarCliente;
begin
  //Parametros
  inherited;
  if bb_status.Caption = 'Liberado' then
    Empresa.Registro.SituacaoCredito := 'L'
  else
    Empresa.Registro.SituacaoCredito := 'B';
  Empresa.Registro.ValorCredito := StrToFloatDef(E_VL_Credito.Text,0);
  Empresa.Registro.UtilizarMalaDireta := Copy(Cb_mala_direta.Text,1,1);
  if DBLCB_Transportadora.Text <> '' then
    Empresa.Registro.CodigoTransportadora := DBLCB_Transportadora.KeyValue
  else
    Empresa.Registro.CodigoTransportadora := 0;

  if DBLCB_Banco.Text <> '' then
    Empresa.Registro.CodigoBancoUtilizadoPeloCliente := DBLCB_Banco.KeyValue
  else
    Empresa.Registro.CodigoBancoUtilizadoPeloCliente := '';
  Empresa.Registro.AgenciaUtilizadaPeloCliente := E_Agencia.Text;
  Empresa.Registro.ContaCorrenteUtilizadaPeloCliente := E_ContaBanc.Text;
  Empresa.Registro.Multiplicador := StrToFloatDef(E_Multiplicador.Text,0);
  Empresa.Registro.ReducaoContrato := StrToFloatDef(E_Red_Ctro.Text,0);

 if rdb_Hab_Cart0.Checked then
    Empresa.Registro.VendaEmCarteira :=0
  else
    Empresa.Registro.VendaEmCarteira := Fc_PegaFormaPgto('CARTEIRA');

  case Rg_Lojista.ItemIndex of
    0:Empresa.Registro.Lojista := 'S';
    1:Empresa.Registro.Lojista := 'N';
    2:Empresa.Registro.Lojista := 'A';
  end;
  //Tributação
  case Cb_Ind_IE_Dest.ItemIndex of
    0: Empresa.Registro.IndicadorInscricaoEstadual := '1';
    1: Empresa.Registro.IndicadorInscricaoEstadual := '2';
    2: Empresa.Registro.IndicadorInscricaoEstadual := '9';
  end;
  Empresa.Update;

  with Cliente.Registro do
  Begin
    Codigo  := Empresa.REgistro.Codigo;
    if ChBx_ClienteAtivo.Checked then
      Ativo := 'S'
    else
      Ativo := 'N';



    ObservacaoNF := Obs_Nota.Text;
    if chbx_Just_Xml.Checked then
      EnviarSomenteXML := 'S'
    else
      EnviarSomenteXML := 'N';
    case Cb_Ind_IE_Dest.ItemIndex of
      0: IndicadorIE_Dest  := '1';
      1: IndicadorIE_Dest  := '2';
      2: IndicadorIE_Dest  := '9';
    end;

    if RG_ISS_RET.ItemIndex = 1 then
      IssRetido  := 'S'
    else
      IssRetido  := 'N';
    IssExigibilidade := IntToStr(Cb_ISS_EXIGIB.ItemIndex);
    if Rg_ISS_IND_INC_FISCAL.ItemIndex = 1 then
      IssIncentivoFiscal := 'S'
    else
      IssIncentivoFiscal := 'N';
    IssNumeroProcesso := E_ISS_Nr_Processo.Text;
    ValorEntrega := 0;
    if chbx_send_email_auto.Checked then
      EnviaEmailNFeAuto := 'S'
    else
      EnviaEmailNFeAuto := 'N';
    if Fm_ListaTabelaPreco.Dblcb_Lista.Text <> '' then
      TabelaPreco := Fm_ListaTabelaPreco.Dblcb_Lista.KeyValue
    else
      TabelaPreco := 0;
  End;
  Cliente.salva;
end;

procedure TFr_Cliente.Pc_ImagemBotao;
begin
  inherited;
  with fr_principal do
  Begin
    //Ficha
    CarregaImagemBotao(Sb_Ins_FichaCadastral,'INSERIR');
    CarregaImagemBotao(Sb_Alt_FichaCadastral,'ALTERAR');
    CarregaImagemBotao(Sb_Exc_FichaCadastral,'EXCLUIR');
  END;
end;

procedure TFr_Cliente.Pc_Inserir;
begin
  inherited;
  E_VL_Credito.Text := '0,00';
  E_Multiplicador.Text := '1';
  E_Red_Ctro.Text := '0,00';
  Cb_mala_direta.ItemIndex := 1;
  rdb_Hab_Cart0.Checked := TRue;
  Fm_ListaTabelaPreco.Dblcb_Lista.KeyValue := Null;
end;

procedure TFr_Cliente.Sb_Alt_FichaCadastralClick(Sender: TObject);
Var
  Lc_Form : TFr_Ficha_Cadastral;
begin
  TRy
    Lc_Form := TFr_Ficha_Cadastral.Create(nil);
    with Lc_Form do
    Begin
      It_Cd_Empresa := Empresa.Registro.codigo;
      It_cd_ficha := Qr_FichaCadastral.FieldByName('FCT_CODIGO').AsInteger;
      ShowModal;
    end;
    Qr_FichaCadastral.Active:=false;
    Qr_FichaCadastral.Active:=True;
    Ds_EmpresaStateChange(Self);
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_Cliente.Sb_Exc_FichaCadastralClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                      'Excluir ' + Qr_FichaCadastral.FieldByName('EMP_NOME').AsString + ' de seus arquivos.' + EOLN + EOLN +
                      'Confirmar a exclusão ?',
                      [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
    begin
    try
      Pc_ApagaFichaCadastral(Qr_FichaCadastral.FieldByName('FCT_CODIGO').AsInteger);
      Qr_FichaCadastral.Active := False;
      Qr_FichaCadastral.Active := True;
      Ds_EmpresaStateChange(Self);
    except
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                      'Um erro impossibilitou a exclusão dos dados.' + EOLN +
                      'Entre em contato com o suporte técnico.' + EOLN,
                      ['OK'], [bEscape], mpErro);
    end;
    end;

end;

procedure TFr_Cliente.Sb_Imp_FichaCadastralClick(Sender: TObject);
begin
  try
    if not Assigned(RL_Ficha_Cadastro) then (Application.CreateForm(TRL_Ficha_Cadastro, RL_Ficha_Cadastro));
    RL_Ficha_Cadastro.It_Cd_Ficha := Qr_FichaCadastral.FieldByName('FCT_CODIGO').AsInteger;
    RL_Ficha_Cadastro.Qrpt.Preview;
  finally
    RL_Ficha_Cadastro.Close;
  end;

end;

procedure TFr_Cliente.Sb_Ins_FichaCadastralClick(Sender: TObject);
Var
  Lc_Form : TFr_Ficha_Cadastral;
begin
  if ( Empresa.Registro.Codigo = 0) then
    begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Para registrar um Ficha Cadastral,' + EOLN +
                   '   Registre um Cliente.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    exit;
    end;
  try
    Lc_Form := TFr_Ficha_Cadastral.Create(nil);
    with Lc_Form do
    Begin
      It_Cd_Empresa := Empresa.Registro.Codigo;
      It_cd_ficha := 0;
      ShowModal;
    end;
  finally
    FreeAndNil(Lc_Form);
    Qr_FichaCadastral.Active:=false;
    Qr_FichaCadastral.Active:=True;
    Ds_EmpresaStateChange(Self);
  end;
end;



procedure TFr_Cliente.Pc_PreencheSemDados;
begin
  inherited;
  bb_status.Caption:='Liberado';
  ChBx_ClienteAtivo.Checked := True;
end;

procedure TFr_Cliente.rocabrech1Click(Sender: TObject);
Var
  Lc_Form : TFrxCttTrocaBrecho;
  Lc_escolha : Integer;
begin
  Try
    Lc_Form := TFrxCttTrocaBrecho.create(self);
    Lc_Form.CodigoCliente := Empresa.Registro.Codigo;
    Lc_Form.frxBase.ShowReport;
  Finally
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Cliente.Pc_PreencheComDados;
Begin
  inherited;
  Pc_AbreDadosClientes;
End;


procedure TFr_Cliente.Pc_AbreDadosClientes;
Var
  I : Integer;
begin
 //Parametros
  if Empresa.Registro.SituacaoCredito = 'L' then
    bb_status.Caption := 'Liberado'
  else
    bb_status.Caption := 'Bloqueado';

  E_VL_Credito.Text := FloatToStrf(Empresa.Registro.ValorCredito,ffFixed,10,2);
  if (Empresa.Registro.UtilizarMalaDireta = 'S') then
    Cb_mala_direta.ItemIndex := 0
  else
    Cb_mala_direta.ItemIndex := 1;

  DBLCB_Transportadora.KeyValue := Empresa.Registro.CodigoTransportadora;
  DBLCB_Banco.KeyValue :=   Empresa.Registro.CodigoBancoUtilizadoPeloCliente;
  E_Agencia.Text := Empresa.Registro.AgenciaUtilizadaPeloCliente;
  E_ContaBanc.Text := Empresa.Registro.ContaCorrenteUtilizadaPeloCliente;
  E_Multiplicador.Text := FloatToSTrF(Empresa.Registro.Multiplicador,ffFixed,10,2);
  E_Red_Ctro.Text := FloatToSTrF(Empresa.Registro.ReducaoContrato,ffFixed,10,2);

  rdb_Hab_Cart0.Checked := (Empresa.Registro.VendaEmCarteira = 0 );
  rdb_Hab_Cart1.Checked := (Empresa.Registro.VendaEmCarteira > 0 );

  Rg_Lojista.ItemIndex := AnsiIndexStr(UpperCase(Empresa.Registro.Lojista), ['S', 'N','A']);

  //Tributação
  Cb_Ind_IE_Dest.ItemIndex := AnsiIndexStr(Empresa.Registro.IndicadorInscricaoEstadual, ['1','2','9']);

  with Cliente.Registro do
  Begin
    Codigo := Empresa.Registro.Codigo;
    Cliente.getById;
    if Cliente.exist then
    Begin
      ChBx_ClienteAtivo.Checked := (Ativo = 'S' );
      Codigo  := Empresa.Registro.Codigo;
      Obs_Nota.Text := ObservacaoNF;
      chbx_Just_Xml.Checked := ( EnviarSomenteXML = 'S' );
      if ( IssRetido = 'S') then
        RG_ISS_RET.ItemIndex := 1
      else
        RG_ISS_RET.ItemIndex := 0;
      Cb_ISS_EXIGIB.ItemIndex := StrToIntDef( IssExigibilidade,0);
      if ( IssIncentivoFiscal = 'S') then
        Rg_ISS_IND_INC_FISCAL.ItemIndex := 1
      else
        Rg_ISS_IND_INC_FISCAL.ItemIndex := 0;

      E_ISS_Nr_Processo.Text := IssNumeroProcesso ;
      chbx_send_email_auto.Checked := (EnviaEmailNFeAuto = 'S');

     Fm_ListaTabelaPreco.Dblcb_Lista.KeyValue := TabelaPreco;

    End;
  End;
end;


procedure TFr_Cliente.Pc_AbreDadosFichaCadastral;
begin
  With Qr_FichaCadastral do
  Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := Empresa.Registro.Codigo;
    Active := True;
  End;
end;


procedure TFr_Cliente.TabSheet5Show(Sender: TObject);
begin
  Pc_AbreDadosFichaCadastral
end;

procedure TFr_Cliente.Tb_EmpresaAfterOpen(DataSet: TDataSet);
begin
  //Herda
  inherited;
end;

function TFr_Cliente.validaAlterar: Boolean;
begin
  Result := True;
  if ClienteConsumidor then
  Begin
    Result := False;
    exit;
  End;
end;

function TFr_Cliente.ValidaDeletar: Boolean;
begin
  Result := True;
  inherited;
  if ClienteConsumidor then
  Begin
    Result := False;
    exit;
  End;
end;

end.
