unit tas_delivery;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, QEdit_Setes, Vcl.Mask, Vcl.StdCtrls, ControllerCliente, ControllerPedido;

type
  TTasDelivery = class(TBaseRegistry)
    Lb_bairro: TLabel;
    Lb_Telefone: TLabel;
    Lb_Cliente: TLabel;
    Lb_Cep: TLabel;
    Lb_endereco: TLabel;
    Lb_compl: TLabel;
    Lb_numero: TLabel;
    Lb_ObsCliente: TLabel;
    Sb_Cep: TSpeedButton;
    Sb_Cliente: TSpeedButton;
    Sb_Endereco: TSpeedButton;
    E_Nome: TEdit;
    E_Endereco: TEdit;
    E_Compl: TEdit;
    E_Bairro: TEdit;
    E_CEP: TMaskEdit;
    E_Numero: TEdit;
    E_Telefone: TEdit_Setes;
    E_Obs: TMemo;
    Label2: TLabel;
    E_Vl_Entrega: TEdit_Setes;
    procedure Sb_ClienteClick(Sender: TObject);
    procedure Sb_CepClick(Sender: TObject);
    procedure E_CEPExit(Sender: TObject);
    procedure E_TelefoneEnter(Sender: TObject);
    procedure E_TelefoneExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    PermiteReducaoValorEntrega : Boolean;
    procedure Pc_BuscaCep(Pc_Cep: string);
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ShowData;Override;
    procedure ShowNoData;Override;
    procedure ClearAllFields;Override;
    procedure EditionControl;Override;
    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

  public
    { Public declarations }
    Cliente : TControllerCliente;
  end;

var
  TasDelivery: TTasDelivery;

implementation

{$R *.dfm}

uses     api_route_cep, Un_Funcoes, Un_Msg, RN_Empresa, Un_Regra_Negocio, Un_DM, UN_Sistema, env;

procedure TTasDelivery.Cancel;
begin
  inherited;

end;

procedure TTasDelivery.Change;
begin
  inherited;

end;

procedure TTasDelivery.ClearAllFields;
begin
  inherited;

end;

procedure TTasDelivery.CriarVariaveis;
begin
  inherited;
  Cliente := TControllerCliente.create(Self);
end;

procedure TTasDelivery.Delete;
begin
  cliente.Registro.Codigo := 0;
  CodigoRegistro := 0;
  Close;
end;

procedure TTasDelivery.EditionControl;
begin
  inherited;
  pnl_fundo.Enabled := ( EditionState = 'I' ) or ( EditionState = 'E' );
end;

procedure TTasDelivery.E_CEPExit(Sender: TObject);
begin
  inherited;
  if (EditionState = 'I') and (E_cep.Text <> '') then
    Sb_CepClick(Sender);
end;

procedure TTasDelivery.E_TelefoneEnter(Sender: TObject);
begin
  inherited;
  E_Telefone.SelectAll;
end;

procedure TTasDelivery.E_TelefoneExit(Sender: TObject);
begin
  if (trim(E_Telefone.text) <>'') AND (EditionState = 'I') then
  Begin
    with Cliente.Empresa do
    Begin
      Endereco.Registro.Fone := Fc_RemoveCaracterInformado(E_Telefone.Text, ['(',')','-',' ']);
      Endereco.getIdByFone;
      if ( Endereco.Registro.Codigo > 0 ) then
      Begin
        Cliente.Registro.Codigo := Endereco.Registro.CodigoEmpresa;
        Cliente.getById;
        Cliente.Empresa.Registro.Codigo := Endereco.Registro.CodigoEmpresa;
        Cliente.Empresa.getById;
        ShowData;
      End
      else
      Begin
        ShowNoData;
      End;
    End;
  End;
end;

procedure TTasDelivery.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) and not (ActiveControl is TMemo) then
   Begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TTasDelivery.IniciaVariaveis;
begin
  PermiteReducaoValorEntrega := (Fc_Tb_Geral('L','PIZ_REDUZ_VL_ENTREGA','') = 'S');
  if CodigoRegistro > 0 then
  Begin
    Cliente.Registro.Codigo := CodigoRegistro;
    Cliente.getallByKey;
  End;
  inherited;
end;

procedure TTasDelivery.Insert;
begin
  ClearAllFields;
  Cliente.clear;
  E_Telefone.SetFocus;
  ShowNoData;

end;

procedure TTasDelivery.Pc_BuscaCep(Pc_Cep: string);
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

procedure TTasDelivery.Save;
begin
  With Cliente do
  Begin
    Empresa.Endereco.Registro.Fone := Fc_RemoveCaracterInformado(E_Telefone.Text, ['(',')','-',' ']);
    Empresa.Endereco.getIdByFone;
    with Empresa.Registro do
    Begin
      Codigo := Empresa.Endereco.Registro.CodigoEmpresa;
      Tipo := 1;
      NomeRazaoSocial := E_Nome.Text;
      ApelidoFantasia := E_Nome.Text;
      Observacao      := E_Obs.Text;
      TipoPessoa := 'F';
      Multiplicador := 1;
      ConsumidorFinal := 'S';
      OptantePeloSimples := 'N';
      IndicadorInscricaoEstadual := '2';
      Ativa := 'N';
    End;
    Empresa.salva;

    with Empresa.Endereco.Registro do
    Begin
      CodigoEmpresa := Empresa.Registro.Codigo;
      Fone := Fc_RemoveCaracterInformado(E_Telefone.Text, ['(',')','-',' ']);
      Cep := E_CEP.Text;
      Logradouro := E_Endereco.Text;
      NumeroPredial := E_Numero.Text;
      Complemento := E_Compl.Text;
      Bairro := E_Bairro.Text;
      EnderecoPrincipal := 'S';
      Tipo := 'ENTREGA';
      Pc_AtivaEstabelecimento;
      CodigoPais    :=   DM.Qr_Estabelecimento.FieldByName('END_PAIS').AsInteger;
      CodigoEstado := DM.Qr_Estabelecimento.FieldByName('END_CODUFE').AsInteger;
      CodigoCidade := DM.Qr_Estabelecimento.FieldByName('END_CODCDD').AsInteger;
      Empresa.Endereco.salva;
    End;
    Empresa.Endereco.salva;

    with Registro do
    Begin
      Codigo := Empresa.Registro.Codigo;
      Cliente.getById;
      Ativo := 'S';
      ObservacaoNF := '';
      EnviarSomenteXML := 'N';
      IndicadorIE_Dest := '2';
      IssRetido := 'N';
      IssExigibilidade := 'N';
      IssIncentivoFiscal := 'N';
      IssNumeroProcesso := '';
      if PermiteReducaoValorEntrega then
      Begin
        ValorEntrega := StrToFloatDef(E_Vl_Entrega.Text,0);
      End
      else
      Begin
      if ( StrToFloatDef(E_Vl_Entrega.Text,0) > ValorEntrega)  then
        ValorEntrega := StrToFloatDef(E_Vl_Entrega.Text,0);
      End;
      IndicadorIE_Dest := '2';
    End;
    Cliente.salva;
  End;
  CodigoRegistro := Cliente.Registro.Codigo;
end;

procedure TTasDelivery.Sb_CepClick(Sender: TObject);
Begin
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

procedure TTasDelivery.Sb_ClienteClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    cliente.Registro.Codigo := StrToIntDef( Lc_Retorno.It_Dados[1,0] ,0);
    cliente.getallByKey;
    ShowData;
  end;
end;

procedure TTasDelivery.ShowData;
Var
  strLinha: String;
  Lc_I : Integer;
begin
  inherited;
  with Cliente do
  Begin
    if (Empresa.Registro.Codigo > 0) then
    Begin
      E_Nome.text := Empresa.Registro.NomeRazaoSocial;
      E_Obs.Text := Empresa.Registro.Observacao;
    End;

    with Empresa do
    Begin
      if ( Endereco.Registro.CodigoEmpresa > 0 ) then
      Begin
        E_Telefone.text := Endereco.Registro.Fone;
        E_CEP.text := Endereco.Registro.cep;
        E_Endereco.text := Endereco.Registro.Logradouro;
        E_Numero.text := Endereco.Registro.NumeroPredial;
        E_Compl.text := Endereco.Registro.Complemento;
        E_Bairro.text := Endereco.Registro.Bairro;
      End;
    End;
    E_Vl_Entrega.Text := FloatToStrF(Registro.ValorEntrega,ffFixed,10,2);
  End;
end;

procedure TTasDelivery.ShowNoData;
begin
  inherited;
  Cliente.clear;
  Cliente.Empresa.clear;
  E_Nome.Text:='';
  E_Nome.Text:='';
  E_CEP.Text:='';
  E_Endereco.Text:='';
  E_Numero.Text:='';
  E_Compl.Text:='';
  E_Bairro.Text:='';
  E_Obs.Text:='';

end;

function TTasDelivery.ValidaInsert: boolean;
begin
  REsult := True;
end;

function TTasDelivery.ValidateCancel: boolean;
begin

end;

function TTasDelivery.ValidateChange: boolean;
begin
  REsult := True;
end;

function TTasDelivery.ValidateDelete: boolean;
begin
  REsult := True;
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Excluir '+ E_Nome.Text +' de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao2) then
  begin
    REsult := False;
  end;
end;

function TTasDelivery.ValidateSave: boolean;
begin
  Result := True;
  //valida se o telfone do Cliente foi Preenchido
  if Trim(E_Telefone.Text) = '' then
  Begin
    MensagemPadrao(MENSAGEM,ATENCAO+EOLN+EOLN+
                   'Por favor informe o telefone do Cliente.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpAlerta);
    IF (E_Telefone.CanFocus) then E_Telefone.SetFocus;
    Result := False;
    exit;
  end;


  //valida se o nome do Cliente foi Preenchido
  if Trim(E_Nome.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor informe o nome do Cliente.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpErro);
    if E_Nome.CanFocus then E_Nome.SetFocus;
    Result := False;
    exit;
    end;

  //valida se o Ednereço do Cliente foi Preenchido
  if Trim(E_Endereco.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor informe o endereço do Cliente.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpErro);
    if E_Endereco.CanFocus then E_Endereco.SetFocus;
    Result := False;
    exit;
    end;

  //valida se o Ednereço do Cliente foi Preenchido
  if Trim(E_Numero.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor informe o número da residência do Cliente.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpErro);
    if E_Numero.CanFocus then E_Numero.SetFocus;
    Result := False;
    exit;
    end;

  //valida se o Bairro do Cliente foi Preenchido
  if Trim(E_Bairro.Text) = '' then
    Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Por favor informe o bairro do Cliente.'+EOLN+
                   'Verifique antes de continuar.'+EOLN,
                  ['Voltar'],[bEscape],mpErro);
    if E_Bairro.CanFocus then E_Bairro.SetFocus;
    Result := False;
    exit;
    end;

end;

end.
