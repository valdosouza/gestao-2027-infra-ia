unit Un_Consumidor;

interface

uses
       Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DBCtrls, ExtCtrls, Buttons, DB, StdCtrls, Mask, Grids, DBGrids, STQuery, ComCtrls, STStoredProc, QEdit_Setes, ACBrBase, ACBrValidador, xmldom, XMLIntf, msxmldom, XMLDoc, Menus, ControllerCliente;

type
   TFr_Consumidor = class(TForm)
    Panel1: TPanel;
    SB_Confirmar: TSpeedButton;
    Sb_Sair_0: TSpeedButton;
    Pnl_Cliente: TPanel;
    Lb_Nome: TLabel;
    Label7: TLabel;
    E_Nome: TEdit;
    E_Email: TEdit;
    E_CPF: TMaskEdit;
    Lb_Doc: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Sb_Cep: TSpeedButton;
    Label21: TLabel;
    Label15: TLabel;
    Label44: TLabel;
    Sb_Endereco: TSpeedButton;
    E_Complemento: TMaskEdit;
    E_Bairro: TMaskEdit;
    E_cep: TMaskEdit;
    E_Endereco: TMaskEdit;
    E_Numero: TMaskEdit;
    Qr_BuscaCliente: TSTQuery;
    Qr_BuscaEndereco: TSTQuery;
    Label3: TLabel;
    CB_TpPessoa: TComboBox;
      procedure FormKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);

      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure Sb_CepClick(Sender: TObject);
      procedure E_cepExit(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure Sb_EnderecoClick(Sender: TObject);
    procedure E_CPFExit(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure CB_TpPessoaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
   private
    { Private declarations }
   public
    { Public declarations }
      It_Descricao: string;
      Cliente : TControllerCliente;

      It_Valida_Endereco : Boolean;
      It_Confirma : Boolean;
      procedure Pc_AtivarTabelas;
      procedure Pc_ImagemBotao;

      procedure Pc_FormataTela;
      procedure Pc_IniciaVariaveis;

      function Fc_ValidaGravacao(): boolean;

      procedure Pc_GravarEmpresa;

      procedure Pc_LimparCliente;

      procedure Pc_PreencherCliente;
      procedure Pc_GravarCliente;

      procedure Pc_LimparEndereco;
      procedure Pc_PreencherEndereco;
      procedure Pc_GravarEndereco;
      procedure Pc_BuscaCep(Pc_Cep: string);
      procedure Pc_TipoPessoa;
      procedure Pc_AlternaPessoa;


   end;

var
   Fr_Consumidor: TFr_Consumidor;

implementation

uses     Un_Msg, Un_DM, Un_PesqEndereco, UN_Principal, env, Un_Sistema, Un_Regra_Negocio, Un_Funcoes, api_route_cep;
{$R *.dfm}

function TFr_Consumidor.Fc_ValidaGravacao(): boolean;
Var
  lc_nome,  Lc_aux:String;
  Lc_DocFiscal : String;
Begin
  Lc_aux:='';
  Result := TRUE;
  if ActiveControl = E_CPF then
    E_CPFExit(Self);

  if (trim(E_Nome.Text) = '' ) or (Length(trim(E_Nome.Text))< 3) then
  begin
    E_Nome.Text := 'Nome do cliente não informado'
  end;

  case CB_TpPessoa.ItemIndex of
    0:Begin
        Lc_DocFiscal := ValidDocFiscal(E_CPF.Text);
        if not ( Lc_DocFiscal = OK ) then
        begin
          MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                         Lc_DocFiscal + EOLN,
                         ['OK'], [bEscape], mpAlerta);
           Result := False;
           if E_CPF.CanFocus then E_CPF.SetFocus;
           exit;
        end;
      end;
    1:Begin
        Lc_DocFiscal := ValidDocFiscal(E_CPF.Text);
        if not ( Lc_DocFiscal = OK ) then
        begin
          MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                         Lc_DocFiscal + EOLN,
                         ['OK'], [bEscape], mpAlerta);
           Result := False;
           if E_CPF.CanFocus then E_CPF.SetFocus;
           exit;
        end;
      end;
    2:Begin
        if TRIM(E_CPF.Text) = '' then
        begin
          MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                         ' Identificação do Estrangeiro inválida' + EOLN +
                         ' Verifique e tente novamente.' + EOLN,
                         ['OK'], [bEscape], mpAlerta);
           Result := False;
           if E_CPF.CanFocus then E_CPF.SetFocus;
           exit;
        end;
        if ( trim(E_Nome.Text) = '' ) or (Length(trim(E_Nome.Text))< 3) then
        begin
          E_Nome.Text := 'Nome do estrangeiro não informado'
        end;
      end;
  end;

  if It_Valida_Endereco then
  Begin
    if Trim(E_cep.Text) = '' then
    Begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     ' Número de CEP não informado.' + EOLN +
                     ' Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
       Result := False;
       if E_cep.CanFocus then E_cep.SetFocus;
       exit;
    end;
    if Trim(E_Endereco.Text) = '' then
    Begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     ' Endereço não informado.' + EOLN +
                     ' Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
       Result := False;
       if E_Endereco.CanFocus then E_Endereco.SetFocus;
       exit;
    end;
    if Trim(E_Numero.Text) = '' then
    Begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     ' Número do endereço não informado.' + EOLN +
                     ' Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
       Result := False;
       if E_Numero.CanFocus then E_Numero.SetFocus;
       exit;
    end;
    if Trim(E_Bairro.Text) = '' then
    Begin
      MensagemPadrao(' Mensagem', ATENCAO + EOLN + EOLN +
                     ' Bairro não informado.' + EOLN +
                     ' Verifique e tente novamente.' + EOLN,
                     ['OK'], [bEscape], mpAlerta);
       Result := False;
       if E_Bairro.CanFocus then E_Bairro.SetFocus;
       exit;
    end;
  end;
end;

procedure TFr_Consumidor.Pc_BuscaCep(Pc_Cep: string);
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

procedure TFr_Consumidor.Pc_AtivarTabelas;
begin

end;

procedure TFr_Consumidor.Pc_GravarEmpresa;
Var
  Lc_Pessoa:String;
Begin
  If CB_TpPessoa.ItemIndex = 1 then
    Lc_Pessoa := 'J'
  else
    Lc_Pessoa := 'F';
  with Cliente.Empresa.Registro do
  Begin
    Tipo := 1;
    CpfCNPJ := E_CPF.Text;
    NomeRazaoSocial := E_Nome.Text;
    ApelidoFantasia := E_Nome.Text;
    Observacao := ''; //E_ObsCliente.Text + #13 + E_OBS.Text;
    TipoPessoa := Lc_Pessoa;
    Multiplicador := 1;
    Email := E_Email.Text;
    ConsumidorFinal := 'S';
    OptantePeloSimples := 'N';
    Ativa := 'S';
    Cliente.Empresa.salva;
  End;
  Cliente.Registro.Codigo := Cliente.Empresa.Registro.Codigo;
end;

procedure TFr_Consumidor.Pc_LimparCliente;
Begin
  Cliente.clear;
  E_CPF.Clear;
  E_Nome.Clear;
  E_Email.Clear;
  E_cep.Clear;
  E_Endereco.Clear;
  E_Numero.Clear;
  E_Complemento.Clear;
  E_Bairro.Clear;
end;

procedure TFr_Consumidor.Pc_PreencherCliente;
Begin
  with Cliente.Empresa.Registro do
  Begin
    E_CPF.Text := CpfCNPJ;
    E_Nome.Text := NomeRazaoSocial;
    E_Email.Text := Email;
  end;
end;

procedure TFr_Consumidor.Pc_GravarCliente;
Begin
  with Cliente do
  BEgin
    //Registro.Codigo             :=
    Registro.Ativo              := 'S';
    Registro.ObservacaoNF       := '';
    Registro.EnviarSomenteXML   := 'N';
    Registro.IndicadorIE_Dest   := '9';
    Registro.IssRetido          := 'N';
    Registro.IssExigibilidade   := 'N';
    Registro.IssIncentivoFiscal := 'N';
    Registro.IssNumeroProcesso  := '';
    Registro.ValorEntrega       := 0;
    Registro.EnviaEmailNFeAuto  := 'N';
    salva;
  End;
end;

procedure TFr_Consumidor.Pc_LimparEndereco;
begin
  E_cep.Clear;
  E_Endereco.Clear;
  E_Numero.Clear;
  E_Complemento.Clear;
  E_Bairro.Clear;
end;

procedure TFr_Consumidor.Pc_PreencherEndereco;
begin
  if Cliente.Empresa.Endereco.exist then
  Begin
    with  Cliente.Empresa.Endereco.Registro do
    begin
      E_Cep.Text := cep;
      E_Endereco.Text := Logradouro;
      E_Numero.Text := NumeroPredial;
      E_Complemento.Text := Complemento;
      E_Bairro.Text := COPY(Bairro,1,100);
    end;
  End;
end;

procedure TFr_Consumidor.Pc_GravarEndereco;
Begin
  with Cliente.Empresa.Endereco.Registro do
  Begin
    if Trim(E_Endereco.Text) <> '' then
    Begin
      Cep := E_cep.Text;
      Logradouro := E_Endereco.Text;
      NumeroPredial := e_Numero.Text;
      Complemento := E_Complemento.Text;
      Bairro := E_Bairro.Text;
      EnderecoPrincipal := 'S';
    End
    else
    Begin
      CodigoEmpresa := Cliente.Empresa.Registro.Codigo;
      Cep := '00000000';
      Logradouro := 'Não Informado';
      NumeroPredial := 'sn';
      Complemento := '';
      Bairro := 'Não informado';
      EnderecoPrincipal := 'S';
    End;
    Pc_AtivaEstabelecimento;
    with DM.Qr_Estabelecimento do
    Begin
      CodigoPais := FieldByName('END_PAIS').AsInteger;
      CodigoEstado := FieldByName('END_CODUFE').AsInteger;
      CodigoCidade := FieldByName('END_CODCDD').AsInteger;
    End;
  End;
  Cliente.Empresa.Endereco.salva;
end;
// Procedures Internas

procedure TFr_Consumidor.FormCreate(Sender: TObject);
begin
  Cliente := TControllerCliente.Create(Self);
end;

procedure TFr_Consumidor.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F2: Pc_AlternaPessoa;
      VK_F10:if SB_Confirmar.enabled then SB_ConfirmarClick(Sender);
      VK_Escape: if Sb_Sair_0.Enabled then Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TFr_Consumidor.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and not ((ActiveControl is TDBMemo) OR (ActiveControl is TMemo) )then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFr_Consumidor.Pc_FormataTela;
begin

end;

procedure TFr_Consumidor.Pc_IniciaVariaveis;
Begin

  with Cliente.Empresa.Registro do
  Begin
    if codigo > 0 then
    Begin
      Cliente.Empresa.getById;
      Pc_PreencherCliente;
      Cliente.Empresa.Endereco.Registro.CodigoEmpresa := codigo;
      Cliente.Registro.Codigo := codigo;
      Cliente.getById;
    End;
  End;

  with Cliente.Empresa.Endereco.Registro do
  Begin
    if CodigoEmpresa > 0 then
    Begin
      Cliente.Empresa.Endereco.getByEmpresa;
      Pc_PreencherEndereco;
    End;
  End;
end;


procedure TFr_Consumidor.Sb_CepClick(Sender: TObject);
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

procedure TFr_Consumidor.E_cepExit(Sender: TObject);
begin
  if ((E_cep.Text <> '') and (E_Endereco.Text = '')) then
    Sb_CepClick(Sender);
end;

procedure TFr_Consumidor.FormShow(Sender: TObject);
begin
  Pc_FormataTela;
  Pc_IniciaVariaveis;
  Pc_ImagemBotao;
  E_CPF.SetFocus;
  E_CPF.SelectAll;
end;

procedure TFr_Consumidor.Sb_EnderecoClick(Sender: TObject);
begin
  if not Assigned(Fr_PesqEndereco) then Application.CreateForm(TFr_PesqEndereco, Fr_PesqEndereco);
  if Fr_PesqEndereco.showmodal = mrOk then
  begin
    with Fr_PesqEndereco do
    Begin
      if (StrGrd_Logradouro.RowCount > 1) and (StrGrd_Logradouro.Cells[1,StrGrd_Logradouro.row]<>'') then
      Begin
        E_cep.Text := StrGrd_Logradouro.Cells[1,StrGrd_Logradouro.row];
        E_Endereco.Text := StrGrd_Logradouro.Cells[2,StrGrd_Logradouro.row];
        E_Bairro.Text := StrGrd_Logradouro.Cells[3,StrGrd_Logradouro.row];
        if E_Numero.CanFocus then E_Numero.SetFocus;
      end;
    end;
  end;
end;

procedure TFr_Consumidor.Pc_ImagemBotao;
Begin
  with fr_principal do
  Begin
    SB_Confirmar.Glyph.Assign(Fc_CarregaImagemBotao('CONFIRMAR'));
    Sb_Sair_0.Glyph.Assign(Fc_CarregaImagemBotao('SAIR'));
  END;
end;

procedure TFr_Consumidor.E_CPFExit(Sender: TObject);
Var
  Lc_Doc : String;
  Lc_Codigo : Integer;
  Lc_DocFiscal : String;
begin
  if trim(E_CPF.Text) <> '' then
  Begin
    Lc_Doc := trim(E_CPF.Text);
    Lc_Codigo := Cliente.Empresa.Registro.Codigo;
    Lc_DocFiscal := ValidDocFiscal(Lc_Doc);
    if (Lc_DocFiscal = OK) then
    Begin
      Pc_LimparCliente;
      Pc_LimparEndereco;
      Cliente.Empresa.Registro.CpfCNPJ := Lc_Doc;
      Cliente.Empresa.getByDocumento;
      if ( Cliente.Empresa.Registro.Codigo > 0 ) then
      Begin
        Pc_IniciaVariaveis;
      End
      else
      BEgin
        if (Lc_Codigo > 0) then
        Begin
          Cliente.Empresa.Registro.Codigo := Lc_Codigo;
          Cliente.Empresa.getById;
          Pc_IniciaVariaveis;
        End;
      End;
      E_CPF.Text := Lc_Doc;
    End;
  End
end;

procedure TFr_Consumidor.SB_ConfirmarClick(Sender: TObject);
begin
  if Fc_ValidaGravacao then
  BEgin
    Pc_GravarEmpresa;
    Pc_GravarCliente;
    Pc_GravarEndereco;
    It_Confirma := True;
    Close;
  end;
end;

procedure TFr_Consumidor.Sb_Sair_0Click(Sender: TObject);
begin
  It_Confirma := False;
  Close;
end;

procedure TFr_Consumidor.Pc_TipoPessoa;
begin
  case CB_TpPessoa.ItemIndex of
    0:begin
        E_CPF.EditMask := '999.999.999-99;0';
        Lb_Nome.Caption := 'Nome completo';
        Lb_Doc.Caption := 'C.P.F';
      end;
    1:begin
        E_CPF.EditMask := 'AA.AAA.AAA/AAAA-00;0;_';
        Lb_Nome.Caption := 'Razão Social';
        Lb_Doc.Caption := 'C.N.P.J';
      end;
    2:begin
        E_CPF.EditMask := '';
        Lb_Nome.Caption := 'Nome Completo';
        Lb_Doc.Caption := 'Nº Identificação';
      end;
  end;
end;

procedure TFr_Consumidor.Pc_AlternaPessoa;
Begin
  if CB_TpPessoa.ItemIndex = 2 then
  Begin
    CB_TpPessoa.ItemIndex := 0;
  end
  else
  Begin
    CB_TpPessoa.ItemIndex := CB_TpPessoa.ItemIndex + 1;
  end;
  Pc_TipoPessoa;
end;

procedure TFr_Consumidor.CB_TpPessoaChange(Sender: TObject);
begin
  Pc_TipoPessoa;
end;

end.
