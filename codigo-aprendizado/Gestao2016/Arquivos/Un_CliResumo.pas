unit Un_CliResumo;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, ExtCtrls, Buttons, DB, StdCtrls, Mask, STStoredProc, ComCtrls, Grids, DBGrids, STQuery, QEdit_Setes, ControllerCliente, ControllerPedido;

type
  TFr_CliResumo = class(TForm)
    Pg_Empresa: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Pnl_fundo: TPanel;
    GroupBox2: TGroupBox;
    Label28: TLabel;
    E_BuscaNome: TEdit;
    Qr_Pesquisa: TSTQuery;
    Ds_Pesquisa: TDataSource;
    Label42: TLabel;
    Lb_bairro: TLabel;
    Lb_Telefone: TLabel;
    Lb_Cliente: TLabel;
    Lb_Cep: TLabel;
    Lb_endereco: TLabel;
    Lb_compl: TLabel;
    Lb_numero: TLabel;
    Lb_ObsCliente: TLabel;
    E_Telefone: TEdit_Setes;
    E_Nome: TEdit;
    E_Endereco: TEdit;
    E_Compl: TEdit;
    E_Bairro: TEdit;
    E_CEP: TMaskEdit;
    E_Numero: TEdit;
    E_ObsCliente: TEdit;
    Panel2: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Sb_Pesquisar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Panel3: TPanel;
    Label22: TLabel;
    SB_Buscar: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    SB_Cadastrar: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    DBGrid2: TDBGrid;
    ChBx_Ativo: TCheckBox;
    E_OBS: TMemo;
    Label1: TLabel;
    E_Vl_Entrega: TEdit_Setes;
    Label2: TLabel;
    Sb_Cep: TSpeedButton;
    gp_carteira: TGroupBox;
    rdb_Hab_Cart0: TRadioButton;
    rdb_Hab_Cart1: TRadioButton;
    E_BuscaFone: TEdit_Setes;
    Label3: TLabel;
    E_BuscaEndereco: TEdit;
    Lb_Doc: TLabel;
    Label5: TLabel;
    Sb_CNPJ: TSpeedButton;
    CB_TpPessoa: TComboBox;
    E_CpfCnpj: TMaskEdit;
    E_Busca_CPF_CNPJ: TMaskEdit;
    Label4: TLabel;
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure Sb_PesquisarClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure Sb_Sair_1Click(Sender: TObject);
    procedure SB_CadastrarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure SB_InserirClick(Sender: TObject);
    procedure SB_AlterarClick(Sender: TObject);
    procedure E_TelefoneExit(Sender: TObject);
    procedure Sb_CepClick(Sender: TObject);
    procedure E_CEPExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CB_TpPessoaExit(Sender: TObject);
    procedure Sb_CNPJClick(Sender: TObject);
    procedure E_CpfCnpjExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    It_Inserir : Boolean;
    It_Alterar : Boolean;
    It_Excluir : Boolean;
    It_Visualizar : Boolean;
    It_Edicao : String;
    function validaExclusao:Boolean;
    procedure Pc_TipoPessoa(Pc_Tipo:Integer);
    function  Fc_ValidaConsultaCPFCNPJ():Boolean;
    function Fc_ValidaCPFCNPJ(): boolean;
    procedure ConsultaCnpjFederal;
    Function Pc_MostraRegistroExistente(Msg:Boolean):Boolean;
    procedure Pc_PreencheComDados;
    procedure Pc_PreencheSemDados;
    procedure Gravar;

  public
    { Public declarations }
    Cliente : TControllerCliente;
    procedure Pc_FormataTela;
    procedure Pc_EstadoEdicao;
    function Fc_ValidaGravacao(): boolean;
    procedure PC_Buscar;
    procedure Pc_Visualizar;
    procedure Pc_PermissaoBotao(Pc_Menu: string);
    procedure Pc_ImagemBotao;
    procedure Pc_BuscaCep(Pc_Cep: string);
  end;

var
  Fr_CliResumo: TFr_CliResumo;


implementation

uses     Un_DM, Un_Msg, Un_Principal, env, UN_Sistema, Un_FrenteCaixa, RN_Pedido, RN_Pizzaria, RN_Crud, Un_Regra_Negocio, RN_FormaPagto, Un_Funcoes, api_receita_ws, CnpjReceita, RN_Empresa, api_route_cep;
{$R *.dfm}

procedure TFr_CliResumo.Pc_FormataTela;
Var
 Lc_X : Integer;
begin
  For Lc_X:=1 to Pg_Empresa.PageCount do Pg_Empresa.Pages[Lc_X-1].TabVisible:=False;
  Pg_Empresa.ActivePageIndex:=1;
  Pc_PermissaoBotao('Cliente Resumo');
  CB_TpPessoa.ItemIndex := 0;
  Pc_TipoPessoa(0);
end;

procedure TFr_CliResumo.Pc_EstadoEdicao;
Begin
  Sb_Inserir.Enabled := (It_Edicao = 'B') and ( Cliente.Registro.Codigo > 0) AND It_Inserir;
  Sb_Alterar.Enabled := (It_Edicao = 'B') and ( Cliente.Registro.Codigo > 0) AND It_Alterar;
  SB_Excluir.Enabled := (It_Edicao = 'B') and ( Cliente.Registro.Codigo > 0) AND It_Alterar;
  SB_Gravar.Enabled   := (It_Edicao = 'I') OR (It_Edicao = 'E');
  SB_Cancelar.Enabled := (It_Edicao = 'I') OR (It_Edicao = 'E');
  Sb_Pesquisar.Enabled   := (It_Edicao = 'B');
  Sb_Sair_0.Enabled   := (It_Edicao = 'B');
  //Edição da ordem de serviço
  Pnl_fundo.Enabled := (It_Edicao = 'I') OR (It_Edicao = 'E');
end;

function TFr_CliResumo.Pc_MostraRegistroExistente(Msg:Boolean): Boolean;
Var
  Lc_Cd_Empresa: Integer;
Begin
  Result := True;
  Lc_Cd_Empresa := Fc_EmpresaExiste( Cliente.Empresa.Registro.Codigo.ToString ,E_CpfCnpj.Text,Msg);
  if ( Lc_Cd_Empresa > 0) then
  Begin
    if (MensagemPadrao(' Mensagem',
                     ' CPF/CNPJ já registrado.' + EOLN +
                     ' Mostar este Registro agora ?',
                     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
    begin
      Cliente.Registro.Codigo := Lc_Cd_Empresa;
      Cliente.getAllBykey;
      Pc_PreencheComDados;
      It_Edicao := 'B';
      Pc_EstadoEdicao;
      //Comentado para evitar problemas de permissão
      //SB_AlterarClick(Self);
    end
    else
    begin
      if E_CpfCnpj.CanFocus then E_CpfCnpj.SetFocus;
        E_CpfCnpj.SelectAll;
    end;
    Result := False;
  end;

end;


procedure TFr_CliResumo.Pc_PreencheComDados;
Var
  Lc_Cad_Cliente : TStringList;
  strLinha: String;
  Parte : TStringList;
  Lc_I : Integer;
begin
  with Cliente do
  BEgin
    E_Telefone.text := fc_MascaraFone( Empresa.Endereco.Registro.Fone);
    if (Empresa.Registro.TipoPessoa = 'F') then
    Begin
      CB_TpPessoa.ItemIndex := 0;
      Pc_TipoPessoa(0)
    End
    else
    Begin
      CB_TpPessoa.ItemIndex := 1;
      Pc_TipoPessoa(1);
    End;
    E_CpfCnpj.Text := Empresa.Registro.CpfCNPJ;
    E_Nome.text := Empresa.Registro.NomeRazaoSocial;
    if Empresa.Registro.VendaEmCarteira =0 then
      rdb_Hab_Cart0.Checked:=true
    else
      rdb_Hab_Cart1.Checked:=True;

    E_CEP.text      := Empresa.Endereco.Registro.Cep;
    E_Endereco.text := Empresa.Endereco.Registro.Logradouro;
    E_Numero.text   := Empresa.Endereco.Registro.NumeroPredial;
    E_Compl.text    := Empresa.Endereco.Registro.Complemento;
    E_Bairro.text   := Empresa.Endereco.Registro.Bairro;
    strLinha        := Empresa.Registro.Observacao;
    Parte := TStringList.Create;
    try
      Parte.Clear;
      ExtractStrings([#13],[], PChar(strLinha), Parte);
      if (Parte.Count > 0) then
      Begin
        E_ObsCliente.text := Parte.Strings[0];
        Parte.Delete(0);
        E_OBS.Lines.AddStrings(Parte);
      end;
    finally
      FreeAndNil(Parte);
    end;
    E_Vl_Entrega.text := FloatToStrF(Cliente.Registro.valorEntrega,ffFixed,10,2);
    ChBx_Ativo.checked := (Trim(Empresa.Registro.Ativa ) = 'S');
  End;
end;

procedure TFr_CliResumo.Pc_PreencheSemDados;
begin
  Cliente.Clear;
  E_Telefone.clear;
  E_Nome.clear;
  E_CpfCnpj.Clear;
  E_CEP.clear;
  E_Endereco.clear;
  E_Numero.clear;
  E_Compl.clear;
  E_Bairro.clear;
  E_ObsCliente.clear;
  E_OBS.Lines.clear;
  E_Vl_Entrega.clear;
  ChBx_Ativo.checked := True;
end;

procedure TFr_CliResumo.Pc_TipoPessoa(Pc_Tipo: Integer);
begin
  if (Pc_tipo = 0) then
  begin
    E_CpfCnpj.EditMask := '999.999.999-99;0';
    Lb_Doc.Caption := 'C.P.F';
  end
  else
  begin
    E_CpfCnpj.EditMask := 'AA.AAA.AAA/AAAA-00;0;_';
    Lb_Doc.Caption := 'C.N.P.J';
  end;
end;


function TFr_CliResumo.Fc_ValidaConsultaCPFCNPJ: Boolean;
begin
  Result:= True;

  if Length(TRIM(E_CpfCnpj.Text))< 12 then
  begin
    MensagemPadrao(' Mensagem', 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   ' Esta função de preenchimento automático' + EOLN +
                   ' funciona apenas com CNPJ' + EOLN +
                   ' Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;

  if not Fc_ValidaCPFCNPJ then
  Begin

  end;
end;

function TFr_CliResumo.Fc_ValidaCPFCNPJ: boolean;
Var
  Lc_DocFiscal : String;
begin
  Result := True;
  Lc_DocFiscal := ValidDocFiscal(E_CpfCnpj.Text);
  if not ( Lc_DocFiscal = OK ) then
  begin
    MensagemPadrao(' Mensagem de erro', ATENCAO + EOLN + EOLN +
                   Lc_DocFiscal + EOLN + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    if E_CpfCnpj.CanFocus then E_CpfCnpj.SetFocus;
    exit;
  end;
end;

function TFr_CliResumo.Fc_ValidaGravacao(): boolean;
Var
  lc_nome,  Lc_aux:String;
  Lc_Escolha:Integer;
Begin
  Lc_aux:='';
  Result := TRUE;

  if trim(E_Telefone.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Telefone não informado.'+EOLN+
                   'Preencha o campo antes de continuar'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if E_Telefone.CanFocus then E_Telefone.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_Nome.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Nome não informado.'+EOLN+
                   'Preencha o campo antes de continuar'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if E_Nome.CanFocus then E_Nome.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_Endereco.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Endereco não informado.'+EOLN+
                   'Preencha o campo antes de continuar'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if E_Endereco.CanFocus then E_Endereco.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_Numero.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Número não informado.'+EOLN+
                   'Preencha o campo antes de continuar'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if E_Numero.CanFocus then E_Numero.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_Bairro.Text) = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Bairro não informado.'+EOLN+
                   'Preencha o campo antes de continuar'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if E_Bairro.CanFocus then E_Bairro.SetFocus;
    Result := False;
    exit;
  end;
  if Length(tRIM(E_CpfCnpj.Text))>0 then
  bEGIN
    if not Fc_ValidaCPFCNPJ then
    Begin
      Result := False;
      exit;
    end;
  end;
end;

procedure TFr_CliResumo.PC_Buscar;
var
  Lc_Fone,Lc_Nome,Lc_Endereco, Lc_cpf_cnpj: boolean;
begin
  Screen.Cursor:=crHourGlass;
  with Qr_Pesquisa do
  Begin
    Close;
    Sql.Clear;
    Sql.add(concat(
              ' SELECT END_FONE,',
              '  EMP_NOME,',
              '  EMP_OBSERV ',
              '  FROM TB_EMPRESA tb_empresa ',
              '  INNER JOIN TB_ENDERECO tb_endereco ',
              '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO) ',
              '  WHERE (EMP_CODIGO is not null)'
    ));

    if E_BuscaFone.Text ='' then Lc_Fone:=False Else Lc_Fone:=True;
    if E_BuscaNome.Text ='' then Lc_Nome  :=  False Else Lc_Nome := True;
    if E_BuscaEndereco.Text ='' then Lc_Endereco :=  False Else Lc_Endereco := True;
    if E_Busca_CPF_CNPJ.Text ='' then Lc_cpf_cnpj :=  False Else Lc_cpf_cnpj := True;

    if Lc_Fone      then SQL.Add(' AND (END_FONE Like:END_FONE) ');
    if Lc_Nome      then SQL.Add(' AND ( (EMP_NOME LIKE :EMP_NOME) OR (EMP_FANTASIA LIKE:EMP_NOME ) ) ');
    if Lc_Endereco  then SQL.Add(' AND (END_ENDER LIKE :END_ENDER ) ');
    if Lc_cpf_cnpj  then SQL.Add(' AND (EMP_CNPJ =:EMP_CNPJ ) ');

    SQL.Add(' ORDER BY EMP_NOME');
    if Lc_Fone then
      ParamByName('END_FONE').AsString :='%' +Fc_RemoveCaracterInformado(E_BuscaFone.Text, ['(',')','-','-',' ']);
    if Lc_Nome then
      ParamByName('EMP_NOME').AsString :='%'+ E_BuscaNome.Text+'%';
    if Lc_Endereco then
      ParamByName('END_ENDER').Asstring :='%'+ E_BuscaEndereco.Text+'%';
    if Lc_cpf_cnpj then
      ParamByName('EMP_CNPJ').Asstring := E_Busca_CPF_CNPJ.Text;

    Open;
  End;
  Screen.Cursor:=crDefault;
end;

procedure TFr_CliResumo.Pc_Visualizar;
begin
  if Qr_Pesquisa.RecordCount > 0 then
  begin
    Cliente.Empresa.Endereco.Registro.Fone := Fc_RemoveCaracterInformado( Qr_Pesquisa.FieldByName('END_FONE').AsString , ['(',')','-','-',' ']);
    Cliente.Empresa.Endereco.getIdByFone;
    Cliente.Registro.Codigo := Cliente.Empresa.Endereco.Registro.CodigoEmpresa;
    Cliente.getallByKey;
    if Cliente.exist then
    Begin
      Pc_PreencheComDados;
      Pg_Empresa.ActivePageIndex := 0;
      It_Edicao := 'B';
      Pc_EstadoEdicao;
    End;
  end;
end;

procedure TFr_CliResumo.SB_ExcluirClick(Sender: TObject);
begin
  if validaExclusao then
  Begin
    Cliente.Delete;
    Cliente.Empresa.Endereco.delete;
    Cliente.Empresa.delete;
    Pc_PreencheSemDados;
    Pg_Empresa.ActivePageIndex:=1;
    PC_Buscar;
  end;
end;

procedure TFr_CliResumo.SB_GravarClick(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  if Fc_ValidaGravacao then
  Begin
    Gravar;
    It_Edicao := 'B';
    Pc_EstadoEdicao;
  End;
  Screen.Cursor := crDefault;
end;

procedure TFr_CliResumo.SB_CancelarClick(Sender: TObject);
begin
  if (It_Edicao = 'E') then
  Begin
    Pc_PreencheComDados;
  end
  else
  Begin
    Pc_PreencheSemDados;
  end;
  It_Edicao := 'B';
  Pc_EstadoEdicao;
end;

procedure TFr_CliResumo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Cliente);
end;

procedure TFr_CliResumo.FormCreate(Sender: TObject);
begin
  Cliente := TControllerCliente.Create(Self);
end;

procedure TFr_CliResumo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Pg_Empresa.ActivePageIndex of
  0:begin
    if shift = [] then
      begin
        case Key of
        VK_F2  : if SB_Inserir.Enabled then SB_InserirClick(Sender);
        VK_F3  : if SB_Alterar.Enabled then SB_AlterarClick(Sender);
        VK_F4  : if SB_Excluir.Enabled then SB_ExcluirClick(Sender);
        VK_F5  : if SB_Gravar.Enabled then SB_GravarClick(Sender);
        VK_F6  : if SB_Cancelar.Enabled then SB_CancelarClick(Sender);
        VK_F7  : if SB_Pesquisar.Enabled then SB_PesquisarClick(Sender);
        VK_Escape : if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
        end;
      end;
    end;
  else
    begin
    if shift = [] then
      begin
      case Key of
      VK_F2  : if SB_Cadastrar.Enabled then SB_CadastrarClick(Sender);
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_F8 : if SB_Visualizar.Enabled then SB_VisualizarClick(Sender);
      VK_Escape : if Sb_Sair_1.Enabled then Sb_Sair_1Click(Sender);
      end;
      end;
    end;
  end;

end;

procedure TFr_CliResumo.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and not (ActiveControl is TMemo) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFr_CliResumo.SB_VisualizarClick(Sender: TObject);
begin
  Pc_Visualizar;
end;

function TFr_CliResumo.validaExclusao: Boolean;
Var
  LcPedido : TControllerPedido;
begin
  REsult := True;
  try
    LcPedido := TControllerPedido.Create(self);
    LcPedido.Registro.Empresa := Cliente.Registro.Codigo;
    if LcPedido.getByEmpresa then
    BEgin
      MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                     'Este Cliente já possui pedidos.'+EOLN+
                     'Não é possível excluir este cadastro.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      Result := FAlse;
      exit;
    End;
  finally
    FreeAndNil(LcPedido);
  end;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir '+ E_Nome.Text +' de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
  begin
    Result := FAlse;
    exit;
  end;
end;

procedure TFr_CliResumo.Sb_PesquisarClick(Sender: TObject);
begin
  Pg_Empresa.ActivePageIndex:=1;
  Pc_PreencheSemDados;
end;

procedure TFr_CliResumo.SB_BuscarClick(Sender: TObject);
begin
  PC_Buscar;
end;

procedure TFr_CliResumo.Sb_Sair_1Click(Sender: TObject);
begin
  Close;
end;

procedure TFr_CliResumo.SB_CadastrarClick(Sender: TObject);
begin
  Pg_Empresa.ActivePageIndex := 0;
  SB_InserirClick(Sender);
end;

procedure TFr_CliResumo.Sb_Sair_0Click(Sender: TObject);
begin
  close;
end;

procedure TFr_CliResumo.CB_TpPessoaExit(Sender: TObject);
begin
  Pc_TipoPessoa(CB_TpPessoa.ItemIndex);
end;

procedure TFr_CliResumo.ConsultaCnpjFederal;
Var
  LcApi : TApiReceitaWs;
  LcReceita : TCnpjReceita;
  Lc_Aux : String;
  LcPos : Integer;
begin
  Try
    LcApi := TApiReceitaWs.Create(nil);
    LcApi.CNPJ := Fc_RemoveCaracterInformado( E_CpfCnpj.Text,['.','/','-']);
    LcReceita := LcApi.getDados;
    with LcReceita do
    Begin
      E_Nome.Text := Trim( Copy(RazaoSocial,1,100) );
      Lc_Aux := CEP;
      Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-']);
      E_cep.Text := Lc_Aux;
      E_Endereco.Text := Endereco;
      E_Numero.Text := Numero;
      E_Compl.Text := Complemento;
      E_Bairro.Text := Bairro;
      //O Telefone informado pelo Cliente
    end;
  Finally
    FreeAndNil(LcApi);
    FreeAndNil(LcReceita)
  End;

end;

procedure TFr_CliResumo.DBGrid2TitleClick(Column: TColumn);
begin
  Pc_Pintar_Grid_Ordenar(DBGrid2, Column);
end;

procedure TFr_CliResumo.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
  begin
    It_Inserir := True;
    It_Alterar := True;
    It_Excluir := True;
    It_Visualizar := True;
  end
  else
    begin
    It_Inserir    := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
  end;
  SB_Cadastrar.Visible := It_Inserir;
end;

procedure TFr_CliResumo.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    //Geral;
    CarregaImagemBotao(SB_Inserir,'INSERIR');
    CarregaImagemBotao(SB_Alterar,'ALTERAR');
    CarregaImagemBotao(SB_Excluir,'EXCLUIR');
    CarregaImagemBotao(SB_Gravar,'GRAVAR');
    CarregaImagemBotao(SB_Cancelar,'CANCELAR');
    CarregaImagemBotao(SB_Pesquisar,'PESQUISAR');
    CarregaImagemBotao(Sb_Sair_0,'SAIR');
    CarregaImagemBotao(SB_Cadastrar,'CADASTRAR');
    CarregaImagemBotao(SB_Buscar,'BUSCAR');
    CarregaImagemBotao(SB_Visualizar,'VISUALIZAR');
    CarregaImagemBotao(Sb_Sair_1,'SAIR');
  END;
end;

procedure TFr_CliResumo.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
end;

procedure TFr_CliResumo.Gravar;
Var
  Lc_Ativa : String;
  Lc_AtualCli : TStringList;
begin
  with Cliente do
  Begin
    with Empresa.Registro do
    Begin
      Tipo := 1;
      CpfCNPJ := E_CpfCnpj.Text;
      NomeRazaoSocial := E_Nome.Text;
      ApelidoFantasia := E_Nome.Text;
      Observacao := E_ObsCliente.Text + #13 + E_OBS.Text;
      if CB_TpPessoa.ItemIndex = 0 then
        TipoPessoa := 'F'
      else
        TipoPessoa := 'J';
      Multiplicador := 1;
      ConsumidorFinal := 'S';
      OptantePeloSimples := 'N';
      if ChBx_Ativo.Checked then Lc_Ativa := 'S' else Lc_Ativa := 'N';
      Ativa := Lc_Ativa;
      if rdb_Hab_Cart0.Checked then
        VendaEmCarteira :=0
      else
        VendaEmCarteira := Fc_PegaFormaPgto('CARTEIRA');
      IndicadorInscricaoEstadual := '9';
      Empresa.salva;
    End;

    with Empresa.Endereco.Registro do
    Begin
      Empresa.Endereco.Registro.CodigoEmpresa := Empresa.Registro.Codigo;
      Fone := Fc_RemoveCaracterInformado( E_Telefone.Text , ['(',')','-','-',' ']);
      Cep := E_CEP.Text;
      Logradouro := E_Endereco.Text;
      NumeroPredial := E_Numero.Text;
      Complemento := E_Compl.Text;
      Bairro := E_Bairro.Text;
      EnderecoPrincipal := Lc_Ativa;
      Pc_AtivaEstabelecimento;
      CodigoPais := DM.Qr_Estabelecimento.FieldByName('END_PAIS').AsInteger;
      CodigoEstado := DM.Qr_Estabelecimento.FieldByName('END_CODUFE').AsInteger;
      CodigoCidade := DM.Qr_Estabelecimento.FieldByName('END_CODCDD').AsInteger;Pc_AtivaEstabelecimento;
      Empresa.Endereco.salva;
    End;


    with Cliente.Registro do
    Begin
      Codigo := Empresa.Registro.Codigo;
      Ativo := Lc_Ativa;
      ObservacaoNF := '';
      EnviarSomenteXML := 'N';
      IndicadorIE_Dest := '2';
      IssRetido := 'N';
      IssExigibilidade := 'N';
      IssIncentivoFiscal := 'N';
      IssNumeroProcesso := '';
      IndicadorIE_Dest := '2';
      ValorEntrega := StrToFloatDef(E_Vl_Entrega.Text,0);
      Cliente.salva;
    End;
  end;
end;

procedure TFr_CliResumo.SB_InserirClick(Sender: TObject);
begin
  Pc_PreencheSemDados;
  It_Edicao := 'I';
  Pc_EstadoEdicao;
  E_Telefone.SetFocus;
end;

procedure TFr_CliResumo.SB_AlterarClick(Sender: TObject);
begin
  It_Edicao := 'E';
  Pc_EstadoEdicao;
  E_Nome.SetFocus;
end;

procedure TFr_CliResumo.E_TelefoneExit(Sender: TObject);
begin
  if (trim(E_Telefone.text) <>'') AND (It_Edicao <> 'B') then
  Begin
    Cliente.Empresa.Endereco.Registro.Fone := Fc_RemoveCaracterInformado( E_Telefone.text , ['(',')','-','-',' ']);
    Cliente.Empresa.Endereco.getIdByFone;
    Cliente.Registro.Codigo := Cliente.Empresa.Endereco.Registro.CodigoEmpresa;
    Cliente.getallByKey;
    if Cliente.exist then
    Begin
      Pc_PreencheComDados;
    End;
  End;
end;

procedure TFr_CliResumo.Sb_CepClick(Sender: TObject);
begin
  if (E_cep.Text = '') then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Informe o Número do Cep.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    if E_cep.CanFocus then E_cep.SetFocus;
  end
  else
  Begin
    Pc_BuscaCep(E_cep.Text);
  end;
end;

procedure TFr_CliResumo.Sb_CNPJClick(Sender: TObject);
begin
  if Fc_ValidaConsultaCPFCNPJ then
  BEgin
    ConsultaCnpjFederal;
  End;

end;

procedure TFr_CliResumo.E_CEPExit(Sender: TObject);
begin
  if (It_Edicao = 'I') and (E_cep.Text <> '') then
    Sb_CepClick(Sender);
end;

procedure TFr_CliResumo.E_CpfCnpjExit(Sender: TObject);
begin
  if Length(tRIM(E_CpfCnpj.Text))>0 then
  bEGIN
    Pc_MostraRegistroExistente(False);
  end;
end;

procedure TFr_CliResumo.Pc_BuscaCep(Pc_Cep: string);
Var
  Lc_Cep : TCependereco;
begin
  Lc_Cep := Fc_BuscaPorCep(Pc_Cep);
  if (trim(Lc_Cep.FLogradouro) <> '') then
  Begin
    E_Endereco.Text := Lc_Cep.FLogradouro;
    E_Bairro.Text := Lc_Cep.FBairro;
    if E_Numero.CanFocus then E_Numero.SetFocus;
  end;

end;

end.


