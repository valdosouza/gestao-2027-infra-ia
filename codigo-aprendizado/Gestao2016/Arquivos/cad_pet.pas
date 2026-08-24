unit cad_pet;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, ControllerPet, System.StrUtils, Un_Fm_ListaEmpresas, Un_Fm_ListaClientes;

type
  TCadPet = class(TBaseRegistry)
    Label1: TLabel;
    E_Name: TEdit;
    Label29: TLabel;
    Label26: TLabel;
    CB_Race: TComboBox;
    CB_Hair: TComboBox;
    Label2: TLabel;
    E_Age: TEdit;
    Rg_Sexo: TRadioGroup;
    Label3: TLabel;
    Cb_Color: TComboBox;
    Rg_castrated: TRadioGroup;
    Label4: TLabel;
    Cb_attendance: TComboBox;
    Label5: TLabel;
    E_Data: TDateTimePicker;
    Fm_ListaClientes: TFm_ListaClientes;
    ProcedimentosPeridicos1: TMenuItem;
    Contatos1: TMenuItem;
    procedure ProcedimentosPeridicos1Click(Sender: TObject);
    procedure Contatos1Click(Sender: TObject);
  private
    FCliente: Integer;
    procedure LimpaCampos;
    procedure setFCliente(const Value: Integer);
    function ValidaOpenDeadLine:Boolean;
    procedure OpenDeadLine;
    function ValidaOpenContact:Boolean;
    procedure OpenContact;

  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure ShowData;Override;

    procedure Insert;Override;

    function ValidateChange:Boolean;Override;
    procedure Change;Override;

    function ValidateDelete():boolean;Override;
    procedure Delete;Override;

    function ValidateSave:Boolean;Override;
    procedure Save;Override;

    function ValidateCancel:Boolean;Override;
    procedure Cancel;Override;

  public
    { Public declarations }
    Pet : TControllerPEt;
    property Cliente : Integer read FCliente write setFCliente;
  end;

var
  CadPet: TCadPet;

implementation

{$R *.dfm}

uses     Un_Msg, cad_pet_deadline, cad_pet_contact, env;

{ TBaseRegistry1 }

procedure TCadPet.Cancel;
begin
  inherited;

end;

procedure TCadPet.Change;
begin
  inherited;
  if (FCliente = 0) then
    Fm_ListaClientes.E_Cd_Empresa.SetFocus
  else
    E_Name.SetFocus
end;

procedure TCadPet.Contatos1Click(Sender: TObject);
begin
  if ValidaOpenContact then
    OpenContact;
end;

procedure TCadPet.CriarVariaveis;
begin
  inherited;
  FCliente := 0;
  Pet := TControllerPet.Create(Self);
  Fm_ListaClientes.Pc_AtivaEmpresa(1);
  Pet.ComboRace(CB_Race);
  Pet.ComboHair(CB_Hair);
  Pet.ComboColor(Cb_Color);
  Pet.ComboAttendance(Cb_attendance);
end;

procedure TCadPet.Delete;
begin
  inherited;
  pet.delete;
  close;
end;


procedure TCadPet.IniciaVariaveis;
begin
  if (FCliente > 0 ) then
  Begin
    Fm_ListaClientes.E_Cd_Empresa.Text := FCliente.ToString();
    Fm_ListaClientes.DBLCB_Empresa.KeyValue := FCliente;
    Fm_ListaClientes.Enabled := False;
  End
  else
    Fm_ListaClientes.Enabled := True;

  if Self.CodigoRegistro > 0 then
  Begin
    pet.Registro.Codigo := Self.CodigoRegistro;
    pet.getbyId;
  End;
  inherited;

end;

procedure TCadPet.Insert;
begin
  inherited;
  LimpaCampos;
  if (FCliente = 0) then
    Fm_ListaClientes.E_Cd_Empresa.SetFocus
  else
    E_Name.SetFocus
end;



procedure TCadPet.LimpaCampos;
begin
  Pet.ComboRace(CB_Race);
  Pet.ComboHair(CB_Hair);
  Pet.ComboColor(Cb_Color);
  Pet.ComboAttendance(Cb_attendance);
  if FCliente = 0 then
  Begin
    Fm_ListaClientes.E_Cd_Empresa.Clear;
    Fm_ListaClientes.DBLCB_Empresa.KeyValue := null;
  End;
  E_Name.Clear;
  E_Age.Clear;
  CB_Race.Text := '';
  CB_Hair.Text := '';
  Cb_Color.Text := '';
  Cb_attendance.Text := '';
  E_Data.Date := Date;
end;

procedure TCadPet.OpenContact;
Var
  Lc_Form : TCadPetContact;
Begin
  Try
    Lc_Form := TCadPetContact.Create(nil);
    Lc_Form.CodigoRegistro := pet.Registro.Codigo;
    Lc_Form.ShowModal
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TCadPet.OpenDeadLine;
Var
  Lc_Form : TCadPetDeadline;
Begin
  Try
    Lc_Form := TCadPetDeadline.Create(nil);
    Lc_Form.CodigoRegistro := pet.Registro.Codigo;
    Lc_Form.ShowModal
  Finally
    FreeAndNil(Lc_Form);
  End;
end;

procedure TCadPet.ProcedimentosPeridicos1Click(Sender: TObject);
Begin
  if ValidaOpenDeadLine then
    OpenDeadLine;
end;

procedure TCadPet.Save;
begin
  with Pet do
  Begin
    Registro.Cliente    := Fm_ListaClientes.DBLCB_Empresa.KeyValue;
    Registro.Nome       := E_Name.Text ;
    Registro.Idade      := StrToIntDef(E_Age.Text,0);
    if Rg_Sexo.ItemIndex = 0 then
      Pet.Registro.sexo := 'M'
    else
      Pet.Registro.sexo := 'F';
    if Rg_castrated.ItemIndex = 0 then
      Pet.Registro.Castrado := 'S'
    else
      Pet.Registro.Castrado := 'n';
    Registro.Raca       := CB_Race.Text;
    Registro.Pelagem    := CB_Hair.Text;
    Registro.Cor        := Cb_Color.Text ;
    Registro.Frequencia := Cb_attendance.Text;
    Registro.Data       := E_Data.Date;
    salva;
  End;
  CodigoRegistro := Pet.Registro.Codigo;
  EditionState := 'B';
  EditionControl;

end;

procedure TCadPet.setFCliente(const Value: Integer);
begin
  FCliente := Value;
end;

procedure TCadPet.ShowData;
begin
  with Pet do
  Begin
    Fm_ListaClientes.DBLCB_Empresa.KeyValue := Registro.Cliente;
    Fm_ListaClientes.E_Cd_Empresa.Text := Registro.Cliente.ToString();
    E_Name.Text             := Registro.Nome;
    E_Age.Text              := Registro.Idade.ToString();
    Rg_Sexo.ItemIndex       := AnsiIndexStr(UpperCase(Pet.Registro.sexo), ['M', 'F']);
    Rg_castrated.ItemIndex  := AnsiIndexStr(UpperCase(Pet.Registro.sexo), ['S', 'N']);
    CB_Race.Text            := Registro.Raca;
    CB_Hair.Text            := Registro.Raca;
    Cb_Color.Text           := Registro.Cor;
    Cb_attendance.Text      := Registro.Frequencia;
    E_Data.Date             := Registro.Data;
  End;
end;

function TCadPet.ValidaOpenContact: Boolean;
begin
  Result := True;
  if Pet.Registro.Codigo = 0 then
  begin
    MensagemPadrao('Mensagem ',ATENCAO +EOLN+EOLN+
                   'Pet ainda não registrado.'+EOLN+
                   'Registre  para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    Exit;
  end;

end;

function TCadPet.ValidaOpenDeadLine: Boolean;
begin
  Result := True;
  if Pet.Registro.Codigo = 0 then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Pet ainda não registrado.'+EOLN+
                   'Registre  para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    Exit;
  end;

end;

function TCadPet.ValidateCancel: Boolean;
begin
  REsult := True;
end;

function TCadPet.ValidateChange: Boolean;
begin
  Result := True;
end;

function TCadPet.ValidateDelete: boolean;
begin
  Result := True;
  //quando a pergunta esta dentro da validação verifica-se o botão da negativa
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Deseja delete este item?'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                      [NAO, SIM],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;

end;


function TCadPet.ValidateSave: Boolean;
begin
  REsult := True;
  if Trim( Fm_ListaClientes.DBLCB_Empresa.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nome do cliente não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if Fm_ListaClientes.DBLCB_Empresa.CanFocus then Fm_ListaClientes.DBLCB_Empresa.SetFocus;
    Exit;
  end;

  if Trim(E_Name.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nome do Pet não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if E_Name.CanFocus then E_Name.SetFocus;
    Exit;
  end;

  if StrToIntDef(E_Age.Text,0)=0 then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Idade do Pet não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if E_Age.CanFocus then E_Age.SetFocus;
    Exit;
  end;

  if Trim(CB_Race.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Razão não informada.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if CB_Race.CanFocus then CB_Race.SetFocus;
    Exit;
  end;

  if Trim(CB_Hair.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Tipo de Pelagem não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if CB_Hair.CanFocus then CB_Hair.SetFocus;
    Exit;
  end;


end;

end.
