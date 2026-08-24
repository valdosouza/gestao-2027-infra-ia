unit cad_pet_contact;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Datasnap.Provider, ControllerPetContact, System.StrUtils;

type
  TCadPetContact = class(TBaseRegistry)
    Dbg_ListAnnotation: TDBGrid;
    Cds_contacts: TClientDataSet;
    Ds_contacts: TDataSource;
    Label1: TLabel;
    E_Name: TEdit;
    Label2: TLabel;
    E_Address: TEdit;
    Label20: TLabel;
    E_Fone: TEdit_Setes;
    Rg_emergency: TRadioGroup;
    Cds_contactsID: TIntegerField;
    Cds_contactsTB_PET_ID: TIntegerField;
    Cds_contactsNAME: TWideStringField;
    Cds_contactsADDRESS: TWideStringField;
    Cds_contactsPHONE: TWideStringField;
    Cds_contactsEMERGENCY: TWideStringField;
    procedure Dbg_ListAnnotationDblClick(Sender: TObject);
  private
    procedure LimpaCampos;
    procedure ShowDataAltera;
  protected
    procedure CriarVariaveis;Override;
    procedure ShowData;Override;
    procedure IniciaVariaveis;Override;

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
    Contato : TControllerPetContact;
  end;

var
  CadPetContact: TCadPetContact;

implementation

{$R *.dfm}

uses     Un_Msg, env;


{ TCadPetContact }

procedure TCadPetContact.Cancel;
begin
  inherited;
  LimpaCampos;
end;

procedure TCadPetContact.Change;
begin
  inherited;
  E_Name.SetFocus;
end;

procedure TCadPetContact.CriarVariaveis;
begin
  inherited;
  Contato := TControllerPetContact.Create(self);
end;

procedure TCadPetContact.Dbg_ListAnnotationDblClick(Sender: TObject);
begin
  ShowDataAltera;
end;

procedure TCadPetContact.Delete;
begin
  inherited;
  Contato.Registro.Codigo := Cds_contactsID.AsInteger;
  Contato.delete;
  Cds_contacts.Delete;
end;

procedure TCadPetContact.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    Contato.Registro.pet := CodigoRegistro;
    Contato.getList;
  End;
  inherited;
end;

procedure TCadPetContact.Insert;
begin
  inherited;
  LimpaCampos;
  E_Name.SetFocus;
end;

procedure TCadPetContact.LimpaCampos;
begin
  Contato.clear;
  E_Name.Clear;
  E_Fone.Clear;
  E_Address.Clear;
  Rg_emergency.ItemIndex := 1;

end;

procedure TCadPetContact.Save;
begin
  //salva dados no Banco
  Contato.Registro.Pet      := CodigoRegistro;
  Contato.Registro.Nome     := E_Name.Text;
  Contato.Registro.Fone     := E_Fone.Text;
  Contato.Registro.Endereco := E_Address.Text;
  if Rg_emergency.ItemIndex = 0 then
    Contato.Registro.Emergencia := 'S'
  else
    Contato.Registro.Emergencia := 'N';
  if (Contato.Registro.Codigo > 0) then
  Begin
    Contato.update;
    Cds_contacts.Edit;
  End
  else
  Begin
    Contato.Registro.Codigo := 0;
    Contato.insert;
    Cds_contacts.Append;
  End;
  Cds_contactsID.AsInteger        := Contato.Registro.Codigo;
  Cds_contactsTB_PET_ID.AsInteger := Contato.Registro.Pet;
  Cds_contactsNAME.AsString       := Contato.Registro.Nome;
  Cds_contactsADDRESS.AsString    := Contato.Registro.Endereco;
  Cds_contactsPHONE.AsString      := Contato.Registro.Fone;
  Cds_contactsEMERGENCY.AsString  := Contato.Registro.Emergencia;
  Cds_contacts.Post;


end;

procedure TCadPetContact.ShowData;
Var
  I : Integer;
begin
  if not Cds_contacts.Active then Cds_contacts.CreateDataSet;
  Cds_contacts.EmptyDataSet;
  for I := 0 to Contato.Lista.Count-1 do
  Begin
    Cds_contacts.Append;
    Cds_contactsID.AsInteger        := Contato.Lista[I].Codigo;
    Cds_contactsTB_PET_ID.AsInteger := Contato.Lista[I].Pet;
    Cds_contactsNAME.AsString       := Contato.Lista[I].Nome;
    Cds_contactsADDRESS.AsString    := Contato.Lista[I].Endereco;
    Cds_contactsPHONE.AsString      := Contato.Lista[I].Fone;
    Cds_contactsEMERGENCY.AsString  := Contato.Lista[I].Emergencia;
    Cds_contacts.Post;
  End;
end;

procedure TCadPetContact.ShowDataAltera;
begin
  if Cds_contacts.Active then
  Begin
    if Cds_contactsID.AsInteger > 0 then
    Begin
      Contato.Registro.Codigo := Cds_contactsID.AsInteger;
      Contato.getbyId;
      E_Name.Text := Contato.Registro.Nome;
      E_Fone.Text := Contato.Registro.fone;
      Rg_emergency.ItemIndex       := AnsiIndexStr(UpperCase(Contato.Registro.Emergencia), ['S', 'N']);
      E_Address.Text := Contato.Registro.Endereco;
    End;
  End;

end;

function TCadPetContact.ValidateCancel: Boolean;
begin
  Result := True;
end;

function TCadPetContact.ValidateChange: Boolean;
begin
  Result := True;
end;

function TCadPetContact.ValidateDelete: boolean;
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

function TCadPetContact.ValidateSave: Boolean;
begin
  REsult := True;
  if Trim( E_Name.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Nome do contato  não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if E_Name.CanFocus then E_Name.SetFocus;
    Exit;
  end;

  if Trim( E_Fone.Text)='' then
  begin
    MensagemPadrao('Mensagem ',ATENCAO+EOLN+EOLN+
                   'Telefone do contato  não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    if E_Fone.CanFocus then E_Fone.SetFocus;
    Exit;
  end;
end;

end.
