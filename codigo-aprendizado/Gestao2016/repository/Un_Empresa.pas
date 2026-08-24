unit Un_Empresa;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, ExtCtrls, Buttons, DB, StdCtrls, Mask, Grids, DBGrids, STQuery, ComCtrls, STStoredProc, QEdit_Setes, ACBrBase, ACBrValidador, xmldom, XMLIntf, msxmldom, XMLDoc, Menus, Un_Fm_ListaColaboradores, ControllerEmpresa, System.AnsiStrings,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
   TFr_Empresa = class(TForm)
    Menu: TMainMenu;
    Mnu_Tarefas: TMenuItem;
    ListasdeEmail1: TMenuItem;
    Panel2: TPanel;
    PG_Informacoes: TPageControl;
    TabSheet3: TTabSheet;
    pg_fiscal: TPageControl;
    TabSheet6: TTabSheet;
    Pnl_Observacao: TPanel;
    obs_Geral: TMemo;
    TabSheet8: TTabSheet;
    Obs_Fiscal: TMemo;
    Contato: TTabSheet;
    Pnl_Contato: TPanel;
    Sb_Exc_Contato: TSpeedButton;
    Sb_Alt_Contato: TSpeedButton;
    Sb_Ins_Contato: TSpeedButton;
    DBG_Socios: TDBGrid;
    tbs_Endereco: TTabSheet;
    Pnl_Endereco: TPanel;
    Label16: TLabel;
    Label23: TLabel;
    Label18: TLabel;
    Sb_Cep: TSpeedButton;
    Label46: TLabel;
    Label47: TLabel;
    Label21: TLabel;
    Label49: TLabel;
    Label20: TLabel;
    Label26: TLabel;
    Label13: TLabel;
    Label25: TLabel;
    SB_Cad_cidade: TSpeedButton;
    Label50: TLabel;
    Label53: TLabel;
    Label15: TLabel;
    Label30: TLabel;
    Label44: TLabel;
    Sb_Endereco: TSpeedButton;
    E_Complemento: TMaskEdit;
    E_Bairro: TMaskEdit;
    E_cep: TMaskEdit;
    Dblcb_Pais: TDBLookupComboBox;
    DBLCB_Cidade: TDBLookupComboBox;
    E_Regiao: TMaskEdit;
    E_Fax: TEdit_Setes;
    E_Celular: TEdit_Setes;
    E_Contato: TMaskEdit;
    Chb_Principal: TCheckBox;
    E_Fone_Coml: TEdit_Setes;
    E_Fone_Port: TEdit_Setes;
    E_Endereco: TMaskEdit;
    E_CNPJ: TMaskEdit;
    E_Numero: TMaskEdit;
    DBLCB_UF: TDBLookupComboBox;
    Cb_Tipo: TComboBox;
    E_Fone: TEdit_Setes;
    Pnl_Navegacao: TPanel;
    Label32: TLabel;
    SB_Ins_Ender: TSpeedButton;
    Sb_Next_end: TSpeedButton;
    Sb_Last_end: TSpeedButton;
    Sb_First_end: TSpeedButton;
    Sb_Prior_end: TSpeedButton;
    Sb_Exc_Ender: TSpeedButton;
    TabSheet1: TTabSheet;
    Pnl_Tributacao: TPanel;
    Label58: TLabel;
    Cb_Ind_IE_Dest: TComboBox;
    Panel1: TPanel;
    SB_Inserir: TSpeedButton;
    SB_Alterar: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Pnl_Cliente: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Lb_IncEstadual: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Lb_Fantasia: TLabel;
    Label1: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Lb_Ramo: TLabel;
    Lb_Data: TLabel;
    Lb_IncMunicipal: TLabel;
    Sb_CNPJ: TSpeedButton;
    E_Nome: TEdit;
    E_Fantasia: TEdit;
    E_Insc_Est: TEdit;
    E_Codigo: TEdit;
    CB_TpPessoa: TComboBox;
    E_Email: TEdit;
    E_Site: TEdit;
    E_Fundacao: TMaskEdit;
    E_Data: TDateTimePicker;
    E_Insc_Mun: TEdit;
    Dblcb_Ramo_Atividade: TDBLookupComboBox;
    Sb_RamoAtividade: TSpeedButton;
    Chbx_Whatsup: TCheckBox;
    Qr_BuscaFone: TSTQuery;
    Qr_BuscaEmail: TSTQuery;
    ChBx_Consumidor: TCheckBox;
    ChBx_MicroEmpresa: TCheckBox;

    Qr_Contato: TSTQuery;
    Ds_Contato: TDataSource;
    Qr_Endereco: TSTQuery;
    E_CpfCnpj: TMaskEdit;
    Chbx_IgnoraST: TCheckBox;
    ChBx_Ativa: TCheckBox;
    Fm_VendedorPedido: TFm_ListaColaboradores;
    pnl_regra_tributacao: TPanel;
    Lb_Tributacao_especifica: TLabel;
    SB_Impostos: TSpeedButton;
    DBG_Impostos: TDBGrid;
    Qr_Impostos: TSTQuery;
    Qr_ImpostosTRB_CODIGO: TIntegerField;
    Qr_ImpostosNAT_CFOP: TStringField;
    Qr_ImpostosUFE_SIGLA: TStringField;
    Qr_ImpostosTRB_CONSUMIDOR: TStringField;
    Qr_ImpostosTRB_MICRO: TStringField;
    Qr_ImpostosTRB_ORIGEM: TStringField;
    Qr_ImpostosTRB_CST: TStringField;
    Qr_ImpostosTRB_CSOSN: TStringField;
    Qr_ImpostosTRB_ST_ICMS: TStringField;
    Qr_ImpostosTRB_AQ_ICMS: TBCDField;
    Qr_ImpostosTRB_RD_AQ_ICMS: TBCDField;
    Qr_ImpostosTRB_RD_BS_ICMS: TBCDField;
    Qr_ImpostosOBS_DESCRICAO: TStringField;
    Ds_Impostos: TDataSource;
      procedure SB_InserirClick(Sender: TObject);
      procedure SB_ExcluirClick(Sender: TObject);
      procedure SB_GravarClick(Sender: TObject);
      procedure SB_CancelarClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure E_DataEnter(Sender: TObject);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure Sb_Sair_0Click(Sender: TObject);
      procedure Sb_First_endClick(Sender: TObject);
      procedure Sb_Next_endClick(Sender: TObject);
      procedure Sb_Prior_endClick(Sender: TObject);
      procedure Sb_Last_endClick(Sender: TObject);
      procedure SB_Ins_EnderClick(Sender: TObject);
      procedure E_NomeExit(Sender: TObject);
      procedure E_CpfCnpjExit(Sender: TObject);
      procedure Sb_Exc_EnderClick(Sender: TObject);
      procedure Sb_CepClick(Sender: TObject);
      procedure E_cepExit(Sender: TObject);
      procedure CB_TpPessoaExit(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure Sb_EnderecoClick(Sender: TObject);
    procedure SB_Cad_cidadeClick(Sender: TObject);
    procedure Sb_Ins_ContatoClick(Sender: TObject);
    procedure Sb_Alt_ContatoClick(Sender: TObject);
    procedure Sb_Exc_ContatoClick(Sender: TObject);
    procedure Pnl_EnderecoEnter(Sender: TObject);
    procedure ContatoShow(Sender: TObject);
    procedure ListasdeEmail1Click(Sender: TObject);
    procedure Sb_RamoAtividadeClick(Sender: TObject);
    procedure Dblcb_Ramo_AtividadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);


    procedure SB_AlterarClick(Sender: TObject);
    procedure Sb_CNPJClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SB_ImpostosClick(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);

   private
    { Private declarations }
    It_Inserir: Boolean;
    It_Alterar: Boolean;
    It_Excluir: Boolean;
    it_Ds_Endereco: Char;
    FNomeRazao: string;


    procedure Pc_LimparEndereco;
    procedure Pc_AbreDadosEndereco;
    procedure Pc_PreencherEndereco;

    procedure ConsultaCnpjFederal;
    procedure ConsultaCnpjEstadual;
    procedure Pc_DeletarEndereco;
    procedure EditionControl;
    procedure EditionControlContacts;
    function VerificaEmpresaCadastrada:Boolean;
    procedure AbreImposto;
    procedure setFCodigoEmpresa(const Value: Integer);
    procedure setFNomeRazao(const Value: string);
   protected
    EditionState : String;
    FCodigoEmpresa: Integer;
    procedure InitVariable;Virtual;
    procedure Pc_AtivarTabelas; Virtual;
    procedure Pc_Inserir;Virtual;
    function validaAlterar:Boolean;Virtual;
    procedure Pc_Alterar;Virtual;

    function Fc_ValidaGravacaoObrigatoria(): boolean;
    function Fc_ValidaGravacaoParcial(): boolean;
    function Fc_ValidaGravacao(): boolean;Virtual;


    procedure Pc_Gravar; Virtual;
    function ValidaDeletar:Boolean;Virtual;
    procedure Pc_Deletar; Virtual;
    procedure Pc_Cancela; Virtual;

    procedure Pc_PreencheComDados; Virtual;
    procedure Pc_PreencheSemDados; Virtual;
    procedure Pc_ImagemBotao; Virtual;
    function Fc_VerificaRegistroDuplicado():Boolean; Virtual;
    procedure Pc_PermissaoBotao(Pc_Menu: string); Virtual;


    procedure Inserir;Virtual;
    procedure Pc_GravaEmpresa;Virtual;

   public
    { Public declarations }

      It_Cd_Endereco: Integer;
      It_Menu : String;
      Empresa : TControllerEmpresa;

      procedure Pc_BuscaCep(Pc_Cep: string);
      Function Pc_MostraRegistroExistente(Msg:Boolean):Boolean;
      function Fc_EmailExiste(Fc_Email:String): boolean;
      function Fc_FoneExiste(Fc_Fone,Fc_Tipo:String): boolean;
      procedure Pc_MostraRegistro(Pc_Cd_Empresa:Integer;Pc_Campo:String);
      procedure Pc_TipoPessoa(Pc_Tipo:Integer);
      function Fc_ValidaCPFCNPJ(): boolean;

      Procedure Pc_controle_botao_endereco;
      procedure Pc_FormataTela;Virtual;
      procedure Pc_IniciaVariaveis;

      function  Fc_ValidaConsultaCPFCNPJ():Boolean;

      procedure Pc_GravaEndereco;
      procedure Pc_GravaMailing;
      procedure AbrirContato;

      property CodigoEmpresa: Integer read FCodigoEmpresa write setFCodigoEmpresa;
      property NomeRazao: string read FNomeRazao write setFNomeRazao;
   end;

var
   Fr_Empresa: TFr_Empresa;

implementation

uses     Un_Msg, Un_DM, RN_Crud, UN_TabelasEmListas, Un_PesqEndereco, sea_contacts, UN_Sistema, RN_Empresa, RN_Mailing, sea_line_business, reg_contacts, Un_Clta_CNPJ, RN_Endereco, RN_Estados, Un_Regra_Negocio, sea_city, Un_Funcoes, RN_NotaFiscalEletronica3X, RN_Permissao, un_Mailing, UN_Principal, env, api_receita_ws, CnpjReceita, sea_taxation, api_route_cep;
{$R *.dfm}

function TFr_Empresa.Fc_ValidaCPFCNPJ(): boolean;
Var
  Lc_DocFiscal :String;
begin
  Result := True;
  if (Dblcb_Pais.KeyValue <> 1058)then
  begin
    Result := True;
    exit;
  end;

  Lc_DocFiscal := ValidDocFiscal(E_CpfCnpj.Text);
  if not (Lc_DocFiscal = OK) then
  Begin
    TMsgSetes.ErroCampo('Documento Fiscal',Lc_DocFiscal);
    E_CpfCnpj.SetFocus;
    Result := False;
    Exit;
  end;
end;

function TFr_Empresa.Fc_ValidaGravacao(): boolean;
Begin
  REsult := True;
  if not Fc_ValidaGravacaoParcial then
  Begin
    Result := False;
    exit;
  End;

  if not Fc_ValidaGravacaoObrigatoria then
  Begin
    Result := False;
    exit;
  End;
end;


function TFr_Empresa.Fc_ValidaGravacaoObrigatoria: boolean;
Var
  Lc_aux:String;
  Lc_Escolha:Integer;
Begin
  Lc_aux:='';
  Result := TRUE;

  if (E_Insc_Est.Text <> '') and(Lb_IncEstadual.Caption = 'Insc. Estadual')  AND (Chb_Principal.Checked) then
  begin
    if not Fc_Valida_Insc_Estadual(E_Insc_Est.Text,DBLCB_UF.Text,'Cliente')  then
    Begin
      Result := False;
      exit;
    end;
  end;
  if not Fc_ValidaCPFCNPJ then
  Begin
    Result := False;
    exit;
  end;
  if not   Pc_MostraRegistroExistente(False) then
  Begin
    Result := False;
    exit;
  end;

  if (Fc_VErificaRegistroDuplicado) then
  BEgin
    Result := False;
    exit;
  end;

  if Trim(E_Email.Text) <> '' then
  Begin
    if not Fc_ValidaEmail(E_Email.Text) then
    BEgin
      Result := False;
      exit;
    end;
    //valida email repetido
    if (Fc_Tb_Geral('L','GRL_G_CLI_CTRL_EMAIL','N')= 'S') then
    Begin
      if Fc_EmailExiste(E_Email.Text) then
      BEgin
        Result := False;
        exit;
      end;
    end;
  end;

  if Trim(E_Site.Text) <> '' then
  Begin
    if Pos('@',E_Site.Text) > 0 then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Campo Site da Web com conteúdo inválido.'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      if E_Site.CanFocus then E_Site.SetFocus;
      Result := False;
      exit;
    End;
    if Pos('www',E_Site.Text) = 0 then
    Begin
      MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                     'Campo site da Web sem o www.'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                     ['OK'], [bEscape], mpAlerta);
      if E_Site.CanFocus then E_Site.SetFocus;
      Result := False;
      exit;
    End;

  End;


  if TRIM(Dblcb_Pais.Text)  ='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe o País.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if E_cep.CanFocus then E_cep.SetFocus;
    Result := False;
    exit;
  end;

  if trim(DBLCB_UF.Text) = '' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe o Estado.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if E_cep.CanFocus then E_cep.SetFocus;
    Result := False;
    exit;
  end;

  if trim(DBLCB_Cidade.Text) = '' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe a Cidade.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'], [bEscape], mpAlerta);
    if E_cep.CanFocus then E_cep.SetFocus;
    Result := False;
    exit;
  end;

  //Valida telefones repetidos
  if (Fc_Tb_Geral('L','GRL_G_CLI_CTRL_FONE','N')= 'S') then
  Begin
    if Fc_FoneExiste(E_Fone.Text,'Fone') then
    Begin
      Result := False;
      exit;
    end;
    if Fc_FoneExiste(E_Fax.Text,'Fax') then
    Begin
      Result := False;
      exit;
    end;
    if Fc_FoneExiste(E_Celular.Text,'Celular') then
    Begin
      Result := False;
      exit;
    end;
    if Fc_FoneExiste(E_Fone_Coml.Text,'Fone Comercial') then
    Begin
      Result := False;
      exit;
    end;
    if Fc_FoneExiste(E_Fone_Port.Text,'Fone Portaria') then
    Begin
      Result := False;
      exit;
    end;
  end;

end;

function TFr_Empresa.Fc_ValidaGravacaoParcial: boolean;
Begin
  Result := TRUE;
  if trim(E_Nome.Text) = '' then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo Nome não informado.'+EOLN+
                   'Preencha para continuar '+EOLN,
                   ['OK'], [bEscape], mpErro);
    if E_Nome.CanFocus then E_Nome.SetFocus;
    Result := False;
    exit;
  end;

  if trim(E_Fantasia.Text) = '' then
  begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Campo Fantasia não informado.'+EOLN+
                   'Preencha para continuar ' +EOLN,
                   ['OK'], [bEscape], mpErro);
    if E_Fantasia.CanFocus then E_Fantasia.SetFocus;
    Result := False;
    exit;
  end;
end;

function TFr_Empresa.Fc_VerificaRegistroDuplicado: Boolean;
Var
  Lc_Codigo : Integer;
begin
  Result := False;
  Lc_Codigo := Fc_EmpresaExiste( Empresa.Registro.Codigo.ToString() ,E_CpfCnpj.Text,True);
  if (Lc_Codigo > 0) then
  Begin
    REsult := True;
  End;
end;

procedure TFr_Empresa.Pc_BuscaCep(Pc_Cep: string);
Var
  Lc_Cep : TCependereco;
  procedure carregarDadosEndereco;
  begin
    Dblcb_Pais.KeyValue := 1058;
    DBLCB_UF.KeyValue := Lc_Cep.FCd_UF;
    DBLCB_Cidade.KeyValue := Lc_Cep.FCd_Cidade;
    E_Endereco.Text := Lc_Cep.FLogradouro;
    E_Bairro.Text := Lc_Cep.FBairro;
    if E_Numero.CanFocus then E_Numero.SetFocus;
  end;
begin
  Lc_Cep := Fc_BuscaPorCep(Pc_Cep);
  if ( (trim(Lc_Cep.FLogradouro) <> EmptyStr) or (Lc_Cep.FCd_Cidade > 0 ) ) then
  begin
    carregarDadosEndereco;
  end
  else
  begin
    Lc_Cep := TViaCEP.Fc_BuscaPorCep(Pc_Cep);
    if ( (trim(Lc_Cep.FLogradouro) <> EmptyStr) or (Lc_Cep.FCd_Cidade > 0 ) ) then
    Begin
      carregarDadosEndereco;
    end
    else
    begin
      //limpar os campos para não ficar um endereço anterior, de uma ultima pesquisa
      Pc_LimparEndereco;
    end;
  end;
end;


procedure TFr_Empresa.Pc_AbreDadosEndereco;
Begin
  with Qr_Endereco do
  Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := Empresa.Registro.Codigo;
    Active := True;
    FetchAll;
  End;
End;

procedure TFr_Empresa.Pc_Alterar;
begin
  It_Cd_Endereco := Qr_Endereco.FieldByname('END_CODIGO').AsInteger;
  EditionState := 'E';
  EditionControl;
  it_Ds_Endereco := 'U';
  if E_Data.CanFocus then E_Data.SetFocus;
end;

procedure TFr_Empresa.Pc_AtivarTabelas;
begin
  DM.Qr_Pais.Active := true;
  DM.Qr_UF.Active := true;
  DM.Qr_Cidades.Active := true;
  Fm_VendedorPedido.ListaVendedor;
  DM_ListaConsultas.Pc_ListaRamoAtividade;
end;



procedure TFr_Empresa.Pc_LimparEndereco;
begin
  It_Cd_Endereco := 0;
  it_Ds_Endereco := 'I';
  E_cep.Clear;
  Dblcb_Pais.KeyValue := 1058;
  DBLCB_UF.KeyValue := null;
  DBLCB_Cidade.KeyValue := null;
  E_Endereco.Clear;
  E_Numero.Clear;
  Cb_Tipo.ItemIndex := 0;
  E_Complemento.Clear;
  E_Bairro.Clear;
  E_Regiao.Clear;
  E_Contato.Clear;
  E_Fone.Clear;
  E_Fax.Clear;
  E_Celular.Clear;
  E_Fone_Coml.Clear;
  E_Fone_Port.Clear;
  Chb_Principal.Checked := True;
  E_CNPJ.Clear;
  Chbx_Whatsup.Checked := False;
end;


procedure TFr_Empresa.Pc_PreencheComDados;
begin
  E_Codigo.Text := Empresa.Registro.Codigo.ToString();
  if  Empresa.Registro.DataCadastro > 0 then
    E_Data.Date := Empresa.Registro.DataCadastro
  else
    E_Data.Date := Date;

  if ( Empresa.Registro.TipoPessoa = 'F') then
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
  E_Insc_Est.Text := Empresa.Registro.InscricaoEstadual;
  E_Insc_Mun.Text := Empresa.Registro.InscricaoMunicipal;
  E_Fundacao.Text := DateToStr(Empresa.Registro.DataFundacao);
  E_Nome.Text     := Empresa.Registro.NomeRazaoSocial;
  E_Fantasia.Text := Empresa.Registro.ApelidoFantasia;
  Dblcb_Ramo_Atividade.KeyValue := Empresa.Registro.CodigoRamoAtividade;
  if Empresa.Registro.DataFundacao > 0 then
    E_Fundacao.Text := DateToStr(Empresa.Registro.DataFundacao)
  else
    E_Fundacao.Clear;
  E_EMail.Text := Empresa.Registro.Email;
  E_Site.Text := Empresa.Registro.WebSite;

  Fm_VendedorPedido.Dblcb_Vendedor.KeyValue := Empresa.Registro.CodigoVendedor;

  Cb_Ind_IE_Dest.ItemIndex :=  AnsiIndexStr(Empresa.Registro.IndicadorInscricaoEstadual, ['1','2','9']);


  ChBx_Consumidor.Checked := ( Empresa.Registro.ConsumidorFinal = 'S');
  ChBx_MicroEmpresa.Checked := (Empresa.Registro.OptantePeloSimples = 'S');
  Chbx_IgnoraST.Checked := (Empresa.Registro.IgnorarCalculoST = 'S');
  ChBx_Ativa.Checked := ( Empresa.Registro.Ativa = 'S' );

  obs_Geral.Text := Empresa.Registro.Observacao;
  obs_Fiscal.Text := Empresa.Registro.ObservacaoFiscal;


  Pc_AbreDadosEndereco;
  Pc_PreencherEndereco;
  Pc_controle_botao_endereco;
end;

procedure TFr_Empresa.Pc_PreencherEndereco;
begin
  with Qr_Endereco do
  begin
    It_cd_Endereco        := FieldByname('END_CODIGO').AsInteger;
    E_CNPJ.Text           := FieldByname('END_CNPJ').AsString;
    E_Cep.Text            := FieldByname('END_CEP').AsString;
    Dblcb_Pais.KeyValue   := FieldByname('END_PAIS').AsInteger;
    DBLCB_UF.KeyValue     := FieldByname('END_CODUFE').AsInteger;
    DBLCB_Cidade.KeyValue := FieldByname('END_CODCDD').AsInteger;
    E_Endereco.Text       := FieldByname('END_ENDER').AsString;
    E_Numero.Text         := FieldByname('END_NUMERO').AsString;
    CB_Tipo.ItemIndex     := CB_Tipo.Items.IndexOf(FieldByname('END_TIPO').AsString);
    E_Complemento.Text    := FieldByname('END_COMPLEM').AsString;
    E_Bairro.Text         := COPY(FieldByname('END_BAIRRO').AsString,1,100);
    E_Regiao.Text         := FieldByname('END_REGIAO').AsString;
    E_Contato.Text        := FieldByname('END_CONTATO').AsString;
    E_Fone.Text           := fc_MascaraFone(FieldByname('END_FONE').AsString);
    E_Fax.Text            := fc_MascaraFone(FieldByname('END_FAX').AsString);
    E_Celular.Text        := fc_MascaraFone(FieldByname('END_CELULAR').AsString);
    E_Fone_Coml.Text      := fc_MascaraFone(FieldByname('END_COMERCIAL').AsString);
    E_Fone_Port.Text      := fc_MascaraFone(FieldByname('END_PORTARIA').AsString);
    Chb_Principal.Checked := (FieldByname('END_PRINCIPAL').AsString = 'S');
    Chbx_Whatsup.Checked  := (FieldByname('END_WHATSUP').AsString = 'S');
  end;
end;

procedure TFr_Empresa.Pc_PreencheSemDados;
begin
  E_Codigo.clear;
  E_Data.Date := Date;
  IF  Fc_Tb_Geral('L','GRL_G_PRED_PESSOA','') = 'F' then
  Begin
    CB_TpPessoa.ItemIndex :=0;
    //9 - Não Contribuinte, que pode ou não possuir Inscrição Estadual no Cadastro de Contribuintes do ICMS
    Cb_Ind_IE_Dest.ItemIndex := 2;
  End
  else
  Begin
    CB_TpPessoa.ItemIndex :=1;
    //1 - Contribuinte ICMS (informar a IE do destinatário)
    Cb_Ind_IE_Dest.ItemIndex := 0;
  End;
  E_CpfCnpj.clear;
  E_Insc_Est.clear;
  E_Fundacao.clear;
  E_Nome.clear;
  E_Fantasia.clear;
  Dblcb_Ramo_Atividade.KeyValue := null;
  E_Fundacao.clear;
  E_EMail.clear;
  E_Site.clear;
  Fm_VendedorPedido.Dblcb_Vendedor.KeyValue := null;
  IF  Fc_Tb_Geral('L','GRL_G_PRED_CLIENTE','') = 'C' then
  Begin
    ChBx_Consumidor.Checked := True;
    Cb_Ind_IE_Dest.ItemIndex := 2;
  End
  else
  Begin
    ChBx_Consumidor.Checked := False;
    Cb_Ind_IE_Dest.ItemIndex := 0;
  End;
  ChBx_MicroEmpresa.Checked := False;
  Chbx_IgnoraST.Checked     := False;
  ChBx_Ativa.Checked        := TRue;
  obs_geral.Lines.Clear;
  Obs_Fiscal.Lines.Clear;
  PG_Informacoes.ActivePage := tbs_Endereco;
  E_Fundacao.Clear;
  Pc_LimparEndereco;
end;

// Procedures Internas

procedure TFr_Empresa.SB_ImpostosClick(Sender: TObject);
Var
  LcForm : TSeaTaxation;
begin
  if VerificaEmpresaCadastrada then
  Begin
    LcForm := TSeaTaxation.create(nil);
    try
      LcForm.Produto := 0;
      LcForm.Empresa := Empresa.Registro.Codigo;
      LcForm.ShowModal;
    finally
      FreeAndNil(LcForm);
      Pc_PreencheComDados;
      AbreImposto;
    end;
  End;
end;

procedure TFr_Empresa.SB_InserirClick(Sender: TObject);
begin
  Pc_AtivarTabelas;
  EditionState := 'I';
  EditionControl;
  Pc_Inserir;

end;

procedure TFr_Empresa.Pc_Deletar;
Begin
  empresa.Registro.Ativa := 'N';
  empresa.salva;
end;

procedure TFr_Empresa.SB_ExcluirClick(Sender: TObject);
begin
  if validaDeletar then
  Begin
    Pc_DeletarEndereco;
    Pc_Deletar;
    Close;
  end;
end;

procedure TFr_Empresa.Pc_GravaEmpresa;
Begin
  if  Empresa.Registro.DataCadastro > 0 then
    E_Data.Date := Empresa.Registro.DataCadastro
  else
    E_Data.Date := Date;

  if CB_TpPessoa.ItemIndex = 0 then
    Empresa.Registro.TipoPessoa := 'F'
  else
    Empresa.Registro.TipoPessoa := 'J';

  Empresa.Registro.CpfCNPJ := E_CpfCnpj.Text;
  Empresa.Registro.InscricaoEstadual := E_Insc_Est.Text;
  Empresa.Registro.InscricaoMunicipal := E_Insc_Mun.Text;
  if E_Fundacao.Text <> '  /  /    ' then
    Empresa.Registro.DataFundacao := StrToDate( E_Fundacao.Text);
  Empresa.Registro.NomeRazaoSocial := E_Nome.Text;
  Empresa.Registro.ApelidoFantasia := E_Fantasia.Text;

  if (Dblcb_Ramo_Atividade.Text <> '') then
    Empresa.Registro.CodigoRamoAtividade := Dblcb_Ramo_Atividade.KeyValue
  else
    Empresa.Registro.CodigoRamoAtividade := 0;

  if Empresa.Registro.DataFundacao > 0 then
    Empresa.Registro.DataFundacao := StrToDate(E_Fundacao.Text)
  else
    Empresa.Registro.DataFundacao := 0;

  Empresa.Registro.Email := E_EMail.Text;
  Empresa.Registro.WebSite := E_Site.Text;
  if (Fm_VendedorPedido.Dblcb_Vendedor.Text <> '') then
    Empresa.Registro.CodigoVendedor := Fm_VendedorPedido.Dblcb_Vendedor.KeyValue
  else
    Empresa.Registro.CodigoVendedor := 0;

  case Cb_Ind_IE_Dest.ItemIndex of
    0: Empresa.Registro.IndicadorInscricaoEstadual := '1';
    1: Empresa.Registro.IndicadorInscricaoEstadual := '2';
    2: Empresa.Registro.IndicadorInscricaoEstadual := '9';
  end;

  if ChBx_Consumidor.Checked then
    Empresa.Registro.ConsumidorFinal := 'S'
  else
    Empresa.Registro.ConsumidorFinal := 'N';

  if ChBx_MicroEmpresa.Checked then
    Empresa.Registro.OptantePeloSimples := 'S'
  else
    Empresa.Registro.OptantePeloSimples := 'N';

  if Chbx_IgnoraST.Checked then
    Empresa.Registro.IgnorarCalculoST := 'S'
  else
    Empresa.Registro.IgnorarCalculoST := 'N';

  if ChBx_Ativa.Checked then
    Empresa.Registro.Ativa := 'S'
  else
    Empresa.Registro.Ativa := 'N';

  Empresa.Registro.Observacao := obs_Geral.Text;
  Empresa.Registro.ObservacaoFiscal := obs_Fiscal.Text;
  Empresa.salva;
  E_Codigo.Text := Empresa.Registro.Codigo.ToString();

End;

procedure TFr_Empresa.Pc_GravaEndereco;
Var
  Lc_Tipo : String;
Begin
  IF Chb_Principal.Checked then Lc_Tipo := 'S' else Lc_Tipo := 'N';
  if (Dblcb_Pais.Text = '') then
    Dblcb_Pais.KeyValue := DM.Qr_Estabelecimento.FieldByName('END_PAIS').AsString;

  if (DBLCB_UF.Text = '') then
    DBLCB_UF.KeyValue := DM.Qr_Estabelecimento.FieldByName('END_CODUFE').AsInteger;

  if (DBLCB_Cidade.Text = '') then
    DBLCB_Cidade.KeyValue := DM.Qr_Estabelecimento.FieldByName('END_CODCDD').AsInteger;

  if (Cb_Tipo.Text = '') then
    Cb_Tipo.Text := 'COMERCIAL';
  if (E_Cep.Text = '') then
    E_Cep.Text := '00000000';
  if (Trim(E_Endereco.Text) = '') then
    E_Endereco.Text := 'Não Informado';
  It_Cd_Endereco := Fc_GravaEndereco(It_Cd_Endereco,
                                     Empresa.Registro.Codigo,
                                     E_CNPJ.Text,
                                     Cb_Tipo.Text,
                                     E_Endereco.Text,
                                     E_Complemento.Text,
                                     E_Bairro.Text,
                                     E_Cep.Text,
                                     E_Contato.Text,
                                     E_Fone.Text,
                                     E_Fax.Text,
                                     E_Celular.Text,
                                     E_Fone_Coml.Text,
                                     E_Fone_Port.Text,
                                     E_Regiao.Text,
                                     E_Numero.Text,
                                     Dblcb_Pais.KeyValue,
                                     DBLCB_Cidade.KeyValue,
                                     DBLCB_UF.KeyValue,
                                     Lc_Tipo,
                                     Chbx_Whatsup.Checked);
  it_Ds_Endereco := 'N';
  Pc_AbreDadosEndereco;
  Pc_controle_botao_endereco;
end;

procedure TFr_Empresa.Pc_GravaMailing;
Begin
  if Trim(E_Email.Text) <> '' then
  Begin
    Fc_AtualizaMailing(Empresa.Registro.Codigo.ToString,
                       'PRINCIPAL',
                       E_Email.Text,
                       E_Contato.Text);
  end;
end;

procedure TFr_Empresa.Pc_Gravar;
Begin
  Pc_GravaEmpresa;
  Pc_GravaEndereco;
  Pc_GravaMailing;
End;

procedure TFr_Empresa.SB_GravarClick(Sender: TObject);
begin
  try
    Enabled := False;
    Pc_ProcesoAguarde(Self,'I');
    if Fc_validaGravacao then
    begin
      Pc_Gravar;

      EditionState := 'B';
      EditionControl;
    end;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Enabled := True;
  end;
end;
procedure TFr_Empresa.Pc_Cancela;
BEgin
  // Fim verifica o status do campo
  if (EditionState = 'I') then
  begin
    Close;
  end
  else
  BEgin
    Pc_PreencheComDados;
    it_Ds_Endereco := 'U';
    EditionState := 'B';
    EditionControl;
  end;
End;

procedure TFr_Empresa.SB_CancelarClick(Sender: TObject);
begin
  Pc_Cancela;
end;

procedure TFr_Empresa.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2:if SB_Inserir.enabled then SB_InserirClick(Sender);
      VK_F3:if SB_Alterar.enabled then SB_AlterarClick(Sender);
      VK_F4:if SB_Excluir.enabled then SB_ExcluirClick(Sender);
      VK_F5:if SB_Gravar.enabled then SB_GravarClick(Sender);
      VK_F6:if SB_Cancelar.enabled then SB_CancelarClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
      end;
  end;
end;

procedure TFr_Empresa.FormClose(Sender: TObject;
   var Action: TCloseAction);

begin
  FCodigoEmpresa := Empresa.Registro.Codigo;
  FNomeRazao  := Empresa.Registro.NomeRazaoSocial;
  if Assigned(Fr_PesqEndereco) then FreeAndNil(Fr_PesqEndereco);
  FreeAndNil(Empresa);
end;

procedure TFr_Empresa.FormCreate(Sender: TObject);
begin
  InitVariable;
end;

procedure TFr_Empresa.E_DataEnter(Sender: TObject);
begin
   if ( EditionState = 'I' ) then
      E_Data.Date := Date;
end;

procedure TFr_Empresa.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and not ((ActiveControl is TDBMemo) OR (ActiveControl is TMemo) )then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;


procedure TFr_Empresa.Pc_TipoPessoa(Pc_Tipo:Integer);
begin
  if (Pc_tipo = 0) then
  begin
    E_CpfCnpj.EditMask := '999.999.999-99;0';
    Lb_Fantasia.Caption := 'Codnome/Apelido';
    Lb_IncEstadual.Caption := 'Número da Identidade';
    Label2.Caption := 'C.P.F';
    Lb_Data.Caption := 'Data Nascimento';
    Label30.Caption := 'C.P.F';
    E_CNPJ.EditMask := '999.999.999-99;0';
    Lb_IncMunicipal.Visible := False;
    E_Insc_Mun.Visible := False;
    Cb_Ind_IE_Dest.ItemIndex := 2;
  end
  else
  begin
    E_CpfCnpj.EditMask := 'AA.AAA.AAA/AAAA-00;0;_';
    Lb_Fantasia.Caption := 'Nome Fantasia';
    Lb_IncEstadual.Caption := 'Insc. Estadual';
    Label2.Caption := 'C.N.P.J';
    Lb_Data.Caption := 'Data Fundação';
    Label30.Caption := 'C.N.P.J';
    E_CNPJ.EditMask := 'AA.AAA.AAA/AAAA-00;0;_';
    Lb_IncMunicipal.Visible := True;
    E_Insc_Mun.Visible := True;
    Cb_Ind_IE_Dest.ItemIndex := 0;
  end;
end;

procedure TFr_Empresa.Pc_FormataTela;
var
   LC_I: Integer;
begin
  PG_Informacoes.ActivePage := Tbs_endereco;
  it_Ds_Endereco := 'U';
end;

procedure TFr_Empresa.Pc_IniciaVariaveis;
Begin
  Pc_AtivarTabelas;
  EditionState := 'B';
  if (Empresa.Registro.codigo > 0) then
  Begin
    Empresa.getById;
    Pc_PreencheComDados;
  End
  else
  Begin
    Pc_PreencheSemDados;
    EditionState := 'I';
    Pc_Inserir;
  End;
  EditionControl;
end;

procedure TFr_Empresa.Pc_Inserir;
begin
  Pc_PreencheSemDados;
  Empresa.clear;
  with Empresa do
  Begin
    Registro.DataCadastro := Date;
    Registro.Multiplicador := 1;
    Registro.SituacaoCredito := 'L';
    Registro.UtilizarMalaDireta := SIM;
    Registro.VendaEmCarteira := 0;
    Registro.Ativa := 'S';
    Registro.Tipo  := -1;
    Registro.OptantePeloSimples := 'N';
  End;
  if CB_TpPessoa.CanFocus then CB_TpPessoa.SetFocus;
end;

procedure TFr_Empresa.Sb_Sair_0Click(Sender: TObject);
begin
   Close
end;

procedure TFr_Empresa.setFCodigoEmpresa(const Value: Integer);
begin
  FCodigoEmpresa := Value;
end;

procedure TFr_Empresa.setFNomeRazao(const Value: string);
begin
  FNomeRazao := Value;
end;

procedure TFr_Empresa.TabSheet1Show(Sender: TObject);
begin
  AbreImposto;
end;

procedure TFr_Empresa.Sb_First_endClick(Sender: TObject);
begin
   Qr_Endereco.First;
   Pc_PreencherEndereco;
   It_Cd_Endereco:=   Qr_Endereco.FieldByname('END_CODIGO').AsInteger;
end;

procedure TFr_Empresa.Sb_Next_endClick(Sender: TObject);
begin
   Qr_Endereco.Next;
   Pc_PreencherEndereco;
   It_Cd_Endereco:=   Qr_Endereco.FieldByname('END_CODIGO').AsInteger;
end;

procedure TFr_Empresa.Sb_Prior_endClick(Sender: TObject);
begin
   Qr_Endereco.Prior;
   Pc_PreencherEndereco;
   It_Cd_Endereco:=   Qr_Endereco.FieldByname('END_CODIGO').AsInteger;
end;

procedure TFr_Empresa.Sb_Last_endClick(Sender: TObject);
begin
   Qr_Endereco.Last;
   Pc_PreencherEndereco;
   It_Cd_Endereco:=   Qr_Endereco.FieldByname('END_CODIGO').AsInteger;
end;

procedure TFr_Empresa.SB_Ins_EnderClick(Sender: TObject);
begin
   It_Cd_Endereco := 0;
    EditionState := 'I';
    EditionControl;
   it_Ds_Endereco := 'I';

   Pc_LimparEndereco;
   //Quando clicar em endereço extra...o padrão é não principal
   Chb_Principal.Checked := False;
   if E_cep.CanFocus then E_cep.SetFocus;
   Cb_Tipo.Text:='COMERCIAL';
   E_CNPJ.Text:=  E_CpfCnpj.Text;   
end;

procedure TFr_Empresa.E_NomeExit(Sender: TObject);
begin
  if ( (EditionState = 'I') or (EditionState = 'E') ) AND (E_Fantasia.Text = '') then
  Begin
    E_Fantasia.Text := E_Nome.Text;
  End;
end;

procedure TFr_Empresa.E_CpfCnpjExit(Sender: TObject);
begin
  Pc_MostraRegistroExistente(False);
end;

procedure TFr_Empresa.Pc_DeletarEndereco;
Begin
  { - DEVIDO A SINCRONIA não excluir mais e sim desativar o cadatro}
  It_Cd_Endereco := Qr_Endereco.FieldByname('END_CODIGO').AsInteger;
  Pc_InativaEndereco(It_Cd_Endereco);
  if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
  Pc_AbreDadosEndereco;
  Pc_PreencherEndereco;
  Pc_controle_botao_endereco;

End;

procedure TFr_Empresa.Sb_Exc_EnderClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
      'Excluir ' + Qr_Endereco.FieldByname('END_ENDER').AsString + ' de seus arquivos.' + EOLN + EOLN +
      'Confirmar a exclusão ?',
      [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
  begin
    Pc_DeletarEndereco;
  end;
end;

procedure TFr_Empresa.Sb_CepClick(Sender: TObject);
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

procedure TFr_Empresa.Sb_CNPJClick(Sender: TObject);
begin
  if Fc_ValidaConsultaCPFCNPJ then
  BEgin
    ConsultaCnpjFederal;
  End;
end;

procedure TFr_Empresa.EditionControl;
begin
  inherited;
  Pnl_Cliente.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Pnl_Endereco.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Pnl_Tributacao.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Inserir.Enabled := ( EditionState = 'B' ) and It_Inserir;
  SB_Excluir.Enabled := ( EditionState = 'B' ) and It_Excluir and
    ( Empresa.Registro.codigo > 0);
  SB_Alterar.Enabled := ( EditionState = 'B' ) and It_Alterar and
     ( Empresa.Registro.codigo > 0);

  SB_Gravar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  SB_Cancelar.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Sair_0.Enabled := ( EditionState = 'B' );

  //BOTOES ENDERECOS
  Pc_controle_botao_endereco;
  SB_Cad_cidade.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );

  EditionControlContacts;

  //Menus
  Mnu_Tarefas.Enabled := ( EditionState = 'B' ) and ( Empresa.Registro.codigo > 0);

end;

procedure TFr_Empresa.EditionControlContacts;
begin
  //BOTOES CONTATOS
  Sb_Ins_Contato.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
  Sb_Alt_Contato.Enabled := ( ( EditionState = 'I' ) or ( EditionState = 'E' )) and ( Empresa.Registro.codigo >0 ) and (Qr_Contato.RecordCount>0);
  Sb_Exc_Contato.Enabled := ( ( EditionState = 'I' ) or ( EditionState = 'E' )) and ( Empresa.Registro.codigo >0 ) and (Qr_Contato.RecordCount>0);
end;

procedure TFr_Empresa.E_cepExit(Sender: TObject);
begin
   if ( ( EditionState = 'I' ) and (E_cep.Text <> '')) or
      ((it_Ds_Endereco = 'I') and (E_cep.Text <> '')) then
      Sb_CepClick(Sender);
end;

procedure TFr_Empresa.AbreImposto;
begin
  with Qr_Impostos do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    ParamByName('TRB_CODEMP').AsInteger := Empresa.Registro.Codigo;
    ParamByName('TRB_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
  End;
end;

procedure TFr_Empresa.AbrirContato;
begin
  with Qr_Contato do
  Begin
    active := False;
    ParambyName('EMP_CODIGO').asinteger := Empresa.Registro.codigo;
    active := True;
  End;
end;

procedure TFr_Empresa.CB_TpPessoaExit(Sender: TObject);
begin
  Pc_TipoPessoa(CB_TpPessoa.ItemIndex);
end;

procedure TFr_Empresa.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_ImagemBotao;
  Pc_PermissaoBotao(It_Menu);
  Pc_IniciaVariaveis;
end;

procedure TFr_Empresa.InitVariable;
begin
  Empresa := TControllerEmpresa.create(Self);
  PG_Informacoes.ActivePage := tbs_Endereco;

end;

procedure TFr_Empresa.Inserir;
begin

end;

procedure TFr_Empresa.Sb_EnderecoClick(Sender: TObject);
begin
  if not Assigned(Fr_PesqEndereco) then Application.CreateForm(TFr_PesqEndereco, Fr_PesqEndereco);
  if Fr_PesqEndereco.showmodal = mrOk then
  begin
    with Fr_PesqEndereco.StrGrd_Logradouro do
    Begin
      if (RowCount > 1) and (Cells[1,row]<>'') then
      Begin
        E_cep.Text := Fc_RemoveCaracterInformado( Cells[1,row], ['-']);
        Dblcb_Pais.KeyValue := 1058;
        DBLCB_UF.KeyValue := Fc_BuscaCodigoEstado(Cells[5,row]);
        DBLCB_Cidade.KeyValue := Fc_BuscaCodigoCidade(0,Cells[4,row],Cells[5,row]);
        E_Endereco.Text := Cells[2,row];
        E_Bairro.Text := Cells[3,row];
        if E_Numero.CanFocus then E_Numero.SetFocus;
      end;
    end;
  end;
end;

procedure TFr_Empresa.SB_Cad_cidadeClick(Sender: TObject);
Var
  Lc_Form : TSeaCity;
begin
  Lc_Form := TSeaCity.Create(Self);
  Try
    Lc_Form.ShowModal;
  Finally
    DM.Qr_Cidades.Active := False;
    DM.Qr_Cidades.Active := True;
    DM.Qr_UF.Locate('UFE_SIGLA',Lc_Form.cds_searchUF.AsString,[]);
    DBLCB_UF.KeyValue := DM.Qr_UF.FieldByname('UFE_CODIGO').AsInteger;
    DBLCB_Cidade.KeyValue := Lc_Form.cds_searchCodigo.AsInteger;
    FreeAndNil(Lc_Form);
  End;
end;

procedure TFr_Empresa.Sb_Ins_ContatoClick(Sender: TObject);
Var
  Lc_Form : TSeaContacts;
begin
  if ( Empresa.Registro.Codigo = 0) then
  begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Para registrar um contato,' + EOLN +
                   '   Registre um Cliente.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    exit;
  end;
  Lc_Form := TSeaContacts.Create( nil );
  Try
    Lc_Form.CodigoVinculo := Empresa.Registro.Codigo;
    Lc_Form.ShowModal;
  Finally
    AbrirContato;
    EditionControl;
    FreeAndNil( Lc_Form );
  End;
end;

procedure TFr_Empresa.SB_AlterarClick(Sender: TObject);
begin
  if validaAlterar then
    Pc_Alterar;
end;

procedure TFr_Empresa.Sb_Alt_ContatoClick(Sender: TObject);
Var
  Lc_Form : TRegContacts;
begin
  if ( Empresa.Registro.Codigo = 0) then
  begin
    MensagemPadrao(MENSAGEM, 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                   'Para registrar um contato,' + EOLN +
                   '   Registre um Cliente.' + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    exit;
  end;
  Lc_Form := TRegContacts.Create( nil );
  Try
    Lc_Form.CodigoRegistro := Qr_Contato.FieldByName('CTO_CODIGO').AsInteger;
    Lc_Form.CodigoVinculo := Empresa.Registro.Codigo;
    Lc_Form.ShowModal;
  finally
    AbrirContato;
    EditionControl;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TFr_Empresa.Sb_Exc_ContatoClick(Sender: TObject);
begin
   if (MensagemPadrao(TITULO_CONFIRMACAO,
      'Excluir ' + Qr_Contato.FieldByName('CTO_NOME').AsString + ' de seus arquivos.' + EOLN + EOLN +
      'Confirmar a exclusão ?',
      [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
   begin
      try
       Pc_ApagaContato(Qr_Contato.FieldByName('CTO_CODIGO').AsInteger);
       AbrirContato;
       EditionControl;
      except
         MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
            'Um erro impossibilitou a exclusão dos dados.' + EOLN +
            'Entre em contato com o suporte técnico.' + EOLN,
            ['OK'], [bEscape], mpErro);
      end;
   end;
end;



procedure TFr_Empresa.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    CarregaImagemBotao(SB_Inserir,'INSERIR');
    CarregaImagemBotao(SB_Alterar,'ALTERAR');
    CarregaImagemBotao(SB_Excluir,'EXCLUIR');
    CarregaImagemBotao(SB_Gravar,'GRAVAR');
    CarregaImagemBotao(SB_Cancelar,'CANCELAR');
    CarregaImagemBotao(Sb_Sair_0,'SAIR');
    //Contato
    CarregaImagemBotao(Sb_Ins_Contato,'INSERIR');
    CarregaImagemBotao(Sb_Alt_Contato,'ALTERAR');
    CarregaImagemBotao(Sb_Exc_Contato,'EXCLUIR');
  end;
end;

procedure TFr_Empresa.Pc_PermissaoBotao(Pc_Menu: string);
begin
  It_Inserir  := Fc_HabilitaPermissao(Pc_Menu,'INSERIR','S');
  It_Alterar  := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
  It_Excluir  := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
end;

procedure TFr_Empresa.Pnl_EnderecoEnter(Sender: TObject);
begin
  if ( EditionState = 'I' ) and (trim(E_CNPJ.Text) ='') then
    E_CNPJ.Text:=  E_CpfCnpj.Text;
end;

procedure TFr_Empresa.Pc_controle_botao_endereco;
begin
  SB_Ins_Ender.Enabled := ( EditionState = 'B' )  and It_Alterar and
     ( Empresa.Registro.Codigo > 0);

  SB_Exc_Ender.Enabled := ( EditionState = 'B' ) and (Qr_Endereco.RecordCount >0) and It_Excluir;
  Sb_First_end.Enabled := ( EditionState = 'B' ) and (Qr_Endereco.RecordCount >1);
  Sb_Next_end.Enabled :=  ( EditionState = 'B' ) and (Qr_Endereco.RecordCount >1);
  Sb_Prior_end.Enabled := ( EditionState = 'B' ) and (Qr_Endereco.RecordCount >1);
  Sb_Last_end.Enabled :=  ( EditionState = 'B' ) and (Qr_Endereco.RecordCount >1);
end;



procedure TFr_Empresa.ConsultaCnpjEstadual;
var
 UF, Documento : String;
 LcResult : boolean;
 Lc_Aux : String;
begin
  if not(InputQuery('WebServices Consulta Cadastro ', 'UF do Documento a ser Consultado:',    UF)) then
    exit;
  Documento :=  E_CpfCnpj.TEXT;

  fr_principal.nfe.WebServices.ConsultaCadastro.UF  := UF;
  if Length(Documento) > 11 then
     fr_principal.nfe.WebServices.ConsultaCadastro.CNPJ := Documento
  else
     fr_principal.nfe.WebServices.ConsultaCadastro.CPF := Documento;
  LcResult := fr_principal.nfe.WebServices.ConsultaCadastro.Executar;

  if ( LcResult ) then
  Begin
    with fr_principal.nfe.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0] do
    Begin
      E_Insc_Est.Text := IE;
      E_Fundacao.Text := DateToStr(dIniAtiv);
      Obs_Fiscal.Lines.Add('Ramo Atividade: ' + IntToStr(CNAE));
      Obs_Fiscal.Lines.Add('Situação: '+ IntToStr(fr_principal.nfe.WebServices.ConsultaCadastro.cStat ) + ' - ' + fr_principal.nfe.WebServices.ConsultaCadastro.xMotivo);
      Obs_Fiscal.Lines.Add('Regime de Apuração: ' + xRegApur);
      E_Nome.Text := Trim( Copy(xNome,1,100) );
      E_Fantasia.Text := Trim( Copy(xFant,1,100) );
      E_Fundacao.text := DateToStr(dIniAtiv);
      Lc_Aux := Fc_RemoveCaracterInformado(CEP, ['.',',','/','-']);
      E_cep.Text := Lc_Aux;
      E_Endereco.Text := xLgr;
      E_Numero.Text := '';
      E_Complemento.Text := xCpl;
      E_Bairro.Text := xBairro;
      IF Trim(DBLCB_UF.Text) = '' then
        DBLCB_UF.KeyValue := Fc_BuscaCodigoEstado(UF);
      IF Trim(DBLCB_Cidade.Text) = '' then
        DBLCB_Cidade.KeyValue := Fc_BuscaCodigoCidade(0,xMun,UF);
    end;
  end
  else
  Begin
    Obs_Fiscal.Lines.Add('Retorno: ' + fr_principal.nfe.WebServices.ConsultaCadastro.RetConsCad.xMotivo);
    PG_Informacoes.ActivePageIndex := 0;
    pg_fiscal.ActivePageIndex := 2;
  End;
end;

procedure TFr_Empresa.ConsultaCnpjFederal;
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
      E_Fantasia.Text := Trim( Copy(Fantasia,1,100) );
      E_Fundacao.text := DateToStr(Abertura);
      Lc_Aux := CEP;
      Lc_Aux := Fc_RemoveCaracterInformado(Lc_Aux, ['.',',','/','-']);
      E_cep.Text := Lc_Aux;
      E_Endereco.Text := Endereco;
      E_Numero.Text := Numero;
      E_Complemento.Text := Complemento;
      E_Bairro.Text := Bairro;
      IF Trim(DBLCB_UF.Text) = '' then
        DBLCB_UF.KeyValue := Fc_BuscaCodigoEstado(UF);
      IF Trim(DBLCB_Cidade.Text) = '' then
        DBLCB_Cidade.KeyValue := Fc_BuscaCodigoCidade(0,Cidade,UF);
      LcPos := Pos('/',Telefone);
      E_Fone.Text        := Fc_RemoveCaracterInformado( Copy(Telefone,1,LcPos-1),['/','(',')',' ','-']);
      Telefone := Copy(Telefone,LcPos+1,Length( Telefone )-LcPos);
      //Não utilizar este LcPos, pois poderemos utiliza-lo
      if Pos('/',Telefone) = 0 then
      Begin
        E_Celular.Text      := Fc_RemoveCaracterInformado( Copy(Telefone,LcPos+1,Length( Telefone )-LcPos),['/','(',')',' ','-']);
      End
      else
      Begin
        LcPos := Pos('/',Telefone);
        E_Celular.Text      := Fc_RemoveCaracterInformado( Copy(Telefone,1,LcPos-1),['/','(',')',' ','-']);

        E_Fone_Coml.Text    := Fc_RemoveCaracterInformado( Copy(Telefone,LcPos+1,Length( Telefone )-LcPos),['/','(',')',' ','-']);
      End;

      //Consulta Dados no Estado
      Pc_CarregaDadosEmitente(true);
      with Fr_Principal.Nfe do
      Begin
        if (trim(Configuracoes.Certificados.NumeroSerie) <> '') or (Configuracoes.Certificados.ArquivoPFX<> '') then
        Begin
          WebServices.ConsultaCadastro.UF  := UF;
          if Length(E_CpfCnpj.Text) > 11 then
            WebServices.ConsultaCadastro.CNPJ := E_CpfCnpj.Text
          else
            WebServices.ConsultaCadastro.CPF := E_CpfCnpj.Text;
          if Configuracoes.Certificados.VerificarValidade then
          Begin
            try
              if WebServices.ConsultaCadastro.Executar then
              Begin
                with WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0] do
                begin
                  E_Insc_Est.Text := IE;
                  E_Fundacao.Text := DateToStr(dIniAtiv);
                  Obs_Fiscal.Lines.Add('Ramo Atividade: ' + CNAE1);
                  Obs_Fiscal.Lines.Add('Situação: '+ IntToStr(WebServices.ConsultaCadastro.cStat) + ' - ' +  WebServices.ConsultaCadastro.xMotivo);
                  Obs_Fiscal.Lines.Add('Regime de Apuração: ' + xRegApur);
                end;
              End;
            Except
              Obs_Fiscal.Lines.Add('Sem certificado digital instalado não é possivel trazer I.E.');
            end;
          End;
        End;
      end;
    end;
  Finally
    FreeAndNil(LcApi);
    FreeAndNil(LcReceita)
  End;

end;

procedure TFr_Empresa.ContatoShow(Sender: TObject);
begin
  AbrirContato;
  EditionControlContacts;
end;

function  TFr_Empresa.Fc_ValidaConsultaCPFCNPJ():Boolean;
Begin
  Result:= True;
  if not Fc_ValidaCPFCNPJ then
  Begin
    Result := False;
  end;
end;

function TFr_Empresa.validaAlterar: Boolean;
begin
  Result := True;
end;

function TFr_Empresa.ValidaDeletar: Boolean;
begin
  REsult := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir ' + Empresa.Registro.NomeRazaoSocial + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     [SIM, NAO], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao2) then
  begin
    REsult := False;
    Exit;
  end;
end;

function TFr_Empresa.VerificaEmpresaCadastrada: Boolean;
begin
  Result := True;
  IF ( Empresa.Registro.Codigo = 0) then
  Begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Registro da empresa não encontrado.' + EOLN +
                   'Verifique e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Result := False;
  end;
end;

procedure TFr_Empresa.ListasdeEmail1Click(Sender: TObject);
Var
  Lc_Form : Tfr_Mailing;
begin
  if VerificaEmpresaCadastrada then
  Begin
    try
      Lc_Form := TFr_Mailing.create(nil);
      Lc_Form.It_Cd_Empresa := Empresa.Registro.Codigo;
      Lc_Form.ShowModal;
    finally
      FreeAndNil(Lc_Form);
    end;

  end;

end;

procedure TFr_Empresa.Sb_RamoAtividadeClick(Sender: TObject);
Var
  Lc_Form : TSeaLineBusiness;
begin
  Lc_Form := TSeaLineBusiness.Create(nil);
  TRy
    Lc_Form.ShowModal;
    DM_ListaConsultas.Pc_ListaRamoAtividade;
    Dblcb_Ramo_Atividade.KeyValue := Lc_Form.cds_searchcodigo.AsInteger;
    Empresa.Registro.CodigoRamoAtividade := Lc_Form.cds_searchcodigo.AsInteger;
  Finally
    FreeAndNil(Lc_Form);
  End;

end;

procedure TFr_Empresa.Dblcb_Ramo_AtividadeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Shift = []) AND ( (EditionState = 'I') or (EditionState = 'B') ) then
    case Key of
      VK_delete:
        begin
          Dblcb_Ramo_Atividade.KeyValue := Null;
        end;
    end;
end;

function TFr_Empresa.Pc_MostraRegistroExistente(Msg:Boolean):Boolean;
Var
  Lc_Cd_Empresa: Integer;
Begin
  Result := True;
  Lc_Cd_Empresa := Fc_EmpresaExiste( Empresa.Registro.Codigo.ToString() ,E_CpfCnpj.Text,Msg);
  if (Lc_Cd_Empresa > 0) then
  Begin
    if (MensagemPadrao(' Mensagem',
                     ' CPF/CNPJ já registrado.' + EOLN +
                     ' Mostar este Registro agora ?',
                     [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
    begin
      Empresa.Registro.Codigo := Lc_Cd_Empresa;
      Empresa.getById;
      Pc_PreencheComDados;
      it_Ds_Endereco := 'U';
      EditionState := 'B';
      EditionControl;
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

function TFr_Empresa.Fc_EmailExiste(Fc_Email:String): boolean;
Var
  Lc_Msg:String;
Begin
  Result := False;
  if (Length(TRim(Fc_Email)) >0) then
  Begin
    with Qr_BuscaEmail do
    bEGIN
      Active := FAlse;
      ParamByName('EMP_CODIGO').AsInteger := Empresa.Registro.Codigo;
      ParamByName('email').AsString := Fc_Email;
      Active := True;
      FetchAll;

      if (FieldByName('EMP_CODIGO').AsInteger > 0)  then
      begin
        Pc_MostraRegistro(FieldByName('EMP_CODIGO').AsInteger,'E-mail');
        Result := True;
        exit;
      end;
    end;
  end;
end;

function TFr_Empresa.Fc_FoneExiste(Fc_Fone,Fc_Tipo:String): boolean;
Var
  Lc_Msg:String;
  Lc_Fone : String;
Begin
  Result := False;
  Lc_fone := Fc_RemoveCaracterInformado(Fc_Fone, ['(',')',' ','-','-']);
  if (Length(TRim(Lc_fone)) >= 8) then
  Begin
    with Qr_BuscaFone do  //4130952158 - 41999112072 - 0800411910
    bEGIN
      {Retirado em 09-03-2017 por achar desnecessario e fazer a pesquisa com numero completo
      case Length(Lc_fone) of
        9:  Lc_fone := Copy(Lc_Fone,1,9);
        10: Lc_fone := Copy(Lc_Fone,3,8);
        11: Lc_fone := Copy(Lc_Fone,3,9);
        12: Lc_fone := Copy(Lc_Fone,3,10);
      end;
      }
      Active := FAlse;
      ParamByName('EMP_CODIGO').AsInteger := Empresa.Registro.Codigo;
      ParamByName('fone').AsString := Lc_FOne;
      Active := True;
      FetchAll;
      if (FieldByName('EMP_CODIGO').AsInteger > 0)  then
      begin
        Pc_MostraRegistro(FieldByName('EMP_CODIGO').AsInteger,Fc_tipo);
        Result := True;
        exit;
      end;
    end;
  end;
end;

procedure TFr_Empresa.Pc_MostraRegistro(Pc_Cd_Empresa:Integer;Pc_Campo:String);
BEgin
  if (MensagemPadrao(' Mensagem',
                     Pc_Campo +' já registrado.' + EOLN +
                     ' Mostar este Registro agora ?',
                      [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
  begin
    Empresa.Registro.Codigo := Pc_Cd_Empresa;
    Empresa.getById;
    Pc_PreencheComDados;
    SB_AlterarClick(Self);
  end
  else
  begin
    if Pc_Campo = 'CNPJ/CPF' then
    Begin
      if E_CpfCnpj.CanFocus then E_CpfCnpj.SetFocus;
      E_CpfCnpj.SelectAll;
    end;
  end;
end;

end.
