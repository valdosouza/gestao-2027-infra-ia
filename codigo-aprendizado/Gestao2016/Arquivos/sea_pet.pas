unit sea_pet;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerPEt, Un_Fm_ListaClientes, Un_Fm_ListaEmpresas, STQuery;

type
  TSeaPet = class(TBaseSearch)
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
    Label4: TLabel;
    Cb_attendance: TComboBox;
    cds_searchID: TIntegerField;
    cds_searchDT_RECORD: TDateField;
    cds_searchNAME: TWideStringField;
    cds_searchAGE: TIntegerField;
    cds_searchRACE: TWideStringField;
    cds_searchHAIR: TWideStringField;
    cds_searchCOLOR: TWideStringField;
    cds_searchGENDER: TWideStringField;
    cds_searchTB_CUSTOMER_ID: TIntegerField;
    cds_searchCASTRATED: TWideStringField;
    cds_searchATTENDANCE: TWideStringField;
    cds_searchEMP_FANTASIA: TWideStringField;
    Fm_ListaClientes: TFm_ListaClientes;
  private
    FCliente: Integer;
    procedure setFCliente(const Value: Integer);

  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySql;Override;
    procedure GroupBySql;Override;
    procedure SetParameters(Param: TSTQuery);Override;
    procedure GetView;Override;
    procedure Search;Override;
    procedure SetRegister;Override;
    procedure returnRegister;Override;
  public
    Pet : TControllerPEt;
    property Cliente : Integer read FCliente write setFCliente;
  end;

var
  SeaPet: TSeaPet;

implementation

{$R *.dfm}

uses     Un_DM, cad_pet;
procedure TSeaPet.CriarVariaveis;
begin
  inherited;
  FCliente := 0;
end;

procedure TSeaPet.GetView;
Var
  LcForm : TCadPet;
begin
  try
    LcForm := TCadPet.Create(nil);
    LcForm.Cliente := Self.FCliente;
    LcForm.CodigoRegistro := cds_searchID.AsInteger;
    LcForm.pet.Registro.Codigo := cds_searchID.AsInteger;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;

end;

procedure TSeaPet.GroupBySql;
begin
  inherited;

end;

procedure TSeaPet.IniciaVariaveis;
begin
  inherited;
  Pet := TControllerPet.Create(Self);
  Fm_ListaClientes.Pc_AtivaEmpresa(1);
  if (FCliente > 0 ) then
  Begin
    Fm_ListaClientes.E_Cd_Empresa.Text := FCliente.ToString();
    Fm_ListaClientes.DBLCB_Empresa.KeyValue := FCliente;
    Fm_ListaClientes.Enabled := False;
  End
  else
    Fm_ListaClientes.Enabled := True;
  Pet.ComboRace(CB_Race);
  Pet.ComboHair(CB_Hair);
  Pet.ComboColor(Cb_Color);
  Pet.ComboAttendance(Cb_attendance);
end;

procedure TSeaPet.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
                  '  inner join TB_EMPRESA ep ',
                  '  on (ep.EMP_CODIGO = pe.TB_CUSTOMER_ID ) '
                );
end;

procedure TSeaPet.OrderBySql;
begin
  inherited;

end;

procedure TSeaPet.returnRegister;
begin
  inherited;

end;

procedure TSeaPet.Search;
begin
  inherited;

end;

procedure TSeaPet.SelectSql;
begin
  inherited;
  SelectTxt := concat(
              'select pe.*, ep.emp_fantasia ',
              'from TB_PET pe '
            );

end;

procedure TSeaPet.setFCliente(const Value: Integer);
begin
  FCliente := Value;
end;

procedure TSeaPet.SetParameters(Param: TSTQuery);
begin
  with Param do
  Begin
    if E_name.Text <> '' then
      ParamByName('NAME').AsString := concat('%',E_name.Text,'%');

    if E_Age.Text <> '' then
      ParamByName('AGE').AsString := E_Age.Text;

    if Cb_race.Text <> '' then
      ParamByName('RACE').AsString := concat('%',CB_race.Text,'%');

    if Cb_Hair.Text <> '' then
      ParamByName('HAIR').AsString := concat('%',Cb_Hair.Text,'%');

    if Cb_color.Text <> '' then
      ParamByName('COLOR').AsString := concat('%',Cb_color.Text,'%');

    if Cb_attendance.Text <> '' then
      ParamByName('attendance').AsString := concat('%',Cb_attendance.Text,'%');

    if Fm_ListaClientes.DBLCB_Empresa.Text <> '' then
      ParamByName('TB_CUSTOMER_ID').Value := Fm_ListaClientes.DBLCB_Empresa.KeyValue;
  End;

end;

procedure TSeaPet.SetRegister;
Var
  LcForm : TCadPet;
begin
  try
    LcForm := TCadPet.Create(nil);
    LcForm.Cliente := Self.FCliente;
    LcForm.CodigoRegistro := 0;
    LcForm.pet.Registro.Codigo := 0;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TSeaPet.WhereSql;
begin
  inherited;
  WhereTxt := concat(
             'WHERE (ID IS NOT NULL)   '
              );
    //incrementa SQL
  if E_name.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (pe.name LIKE :name) '
                );

  if StrToIntDef(E_Age.Text,0) > 0 then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (pe.age =:age) '
                );

  case rg_sexo.itemindex of
    0: WhereTxt := concat(WhereTxt,' and (pe.GENDER = ''M'') ');
    1: WhereTxt := concat(WhereTxt,' and (pe.GENDER = ''F'') ');
  end;

  if cB_race.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  'and (pe.race  LIKE :race)'
                );

  if Cb_Hair.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (pe.hair LIKE :hair)'
                );

  if Cb_color.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (pe.color like :color) '
                );

  if Cb_attendance.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (pe.attendance like :attendance) '
                );


  if Fm_ListaClientes.DBLCB_Empresa.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (pe.TB_CUSTOMER_ID =:TB_CUSTOMER_ID) '
                );



end;

end.
