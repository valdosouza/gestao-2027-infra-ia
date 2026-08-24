unit Un_Bancos;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Empresa, Data.DB, STQuery, Vcl.Menus, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.StdCtrls, QEdit_Setes, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_ListaColaboradores;

type
  TFr_Bancos = class(TFr_Empresa)
    E_Nr_Banco: TEdit;
    Label4: TLabel;
  private
    { Private declarations }

    procedure Pc_Inserir;Override;
  protected
    function Fc_ValidaGravacaoBanco(): boolean;
    function Fc_ValidaGravacao(): boolean;Override;
    procedure Pc_PreencheSemDados;override;
    procedure Pc_PreencheComDados; Override;
    procedure Pc_Gravar;Override;
    procedure GravarBanco;
  public

  end;

var
  Fr_Bancos: TFr_Bancos;

implementation

{$R *.dfm}

uses     Un_Msg, RN_Mailing, UN_Sistema, env;

{ TFr_Empresa1 }

function TFr_Bancos.Fc_ValidaGravacaoBanco: boolean;
begin
  Empresa.Registro.NumeroBanco := E_Nr_Banco.Text;
  Empresa.Update;
end;

procedure TFr_Bancos.GravarBanco;
begin
  Empresa.Registro.NumeroBanco := E_Nr_Banco.Text;
  Empresa.AtualizaBanco;
end;

procedure TFr_Bancos.Pc_Gravar;
begin
  inherited;
  GravarBanco;
end;


procedure TFr_Bancos.Pc_Inserir;
begin
  inherited;
  Empresa.Registro.Tipo := 4;
  Empresa.Registro.CpfCNPJ := '';
  E_Nr_Banco.SetFocus;
end;

procedure TFr_Bancos.Pc_PreencheComDados;
begin
  inherited;
  E_Nr_Banco.Text := Empresa.Registro.NumeroBanco;
end;

procedure TFr_Bancos.Pc_PreencheSemDados;
begin
  inherited;
  CB_TpPessoa.ItemIndex := 1;
  Pc_TipoPessoa(1);
end;

function TFr_Bancos.Fc_ValidaGravacao: boolean;
Var
  Lc_aux:String;
  Lc_Escolha:Integer;
Begin
  Lc_aux:='';
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

  if Trim(E_Email.Text) <> '' then
  Begin
    if not Fc_ValidaEmail(E_Email.Text) then
    BEgin
      Result := False;
      exit;
    end;
  end;

  if TRIM(Dblcb_Pais.Text)  ='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Por favor informe o Paíso.'+EOLN+
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

  if E_Nr_Banco.Text = '' then
  begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Campo Numero do Banco não preenchido.'+EOLN+
                   'Preenchimento obrigatário' +EOLN,
                   ['OK'], [bEscape], mpErro);
    if E_Nr_Banco.CanFocus then E_Nr_Banco.SetFocus;
    Result := False;
    exit;
  end;

end;


end.
