unit reg_vehicle_brand;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, ControllerVehicleBrand, ControllerVehicleModel;

type
  TRegVehicleBrand = class(TBaseRegistry)
    E_Codigo: TEdit;
    L_Descricao: TLabel;
    E_Descricao: TEdit;
    Panel2: TPanel;
    Sb_Modelos: TSpeedButton;
    grdModelos: TDBGrid;
    cds_Modelos: TClientDataSet;
    cds_ModelosCodigo: TIntegerField;
    cds_ModelosCodigoMarca: TIntegerField;
    cds_ModelosMOD_DESCRICAO: TStringField;
    ds_Modelos: TDataSource;
    procedure Sb_ModelosClick(Sender: TObject);
  private
    VehicleBrand : TControllerVehicleBrand;
    VehicleModel : TControllerVehicleModel;
    procedure carregarModelos(MOD_CODMRC: integer);
  protected
    procedure setPerfil;Override;
    procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
    procedure EditionControl;Override;
  end;

var
  RegVehicleBrand: TRegVehicleBrand;

implementation

uses     reg_vehicle_model, UN_MSG;

{$R *.dfm}

procedure TRegVehicleBrand.carregarModelos(MOD_CODMRC: integer);
var
  i: Integer;
begin
  VehicleModel.Clear;

  VehicleModel.Parametros.FieldName.CodigoMarca := MOD_CODMRC;

  VehicleModel.Search;

  if not cds_Modelos.Active then
    cds_Modelos.CreateDataSet;

  cds_Modelos.EmptyDataSet;

  cds_Modelos.DisableControls;

  for i := 0 to Pred(VehicleModel.Lista.Count) do
    cds_Modelos.AppendRecord([VehicleModel.lista[I].Codigo, VehicleModel.lista[I].CodigoMarca, VehicleModel.Lista[i].Descricao]);

  cds_Modelos.EnableControls;
end;

procedure TRegVehicleBrand.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegVehicleBrand.ClearAllFields;
begin
  inherited;
  VehicleBrand.clear;
end;

procedure TRegVehicleBrand.CriarVariaveis;
begin
  inherited;
  VehicleBrand := TControllerVehicleBrand.create(self);
  VehicleModel := TControllerVehicleModel.create(self);
end;

procedure TRegVehicleBrand.Delete;
begin
  VehicleBrand.delete;
  inherited;
end;

procedure TRegVehicleBrand.EditionControl;
begin
  inherited;
  Sb_Modelos.Enabled := ( EditionState = 'B' ) and ( CodigoRegistro > 0 ) ;
end;

procedure TRegVehicleBrand.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(VehicleBrand);
  FreeAndNil(VehicleModel);
end;

procedure TRegVehicleBrand.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    carregarModelos(Self.CodigoRegistro);
    VehicleBrand.Registro.Codigo := Self.CodigoRegistro;
    VehicleBrand.getbyId;
  End;
  inherited;
end;

procedure TRegVehicleBrand.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegVehicleBrand.Save;
begin
  with VehicleBrand do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Fabricante := 0;
    salva;
  End;
  CodigoRegistro := VehicleBrand.Registro.Codigo;
  inherited;
end;

procedure TRegVehicleBrand.ShowData;
begin
  with VehicleBrand do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegVehicleBrand.Sb_ModelosClick(Sender: TObject);
var
  Lc_form : TRegVehicleModel;
begin
  Lc_form := TRegVehicleModel.Create(self);
  Try
    Lc_form.CodigoRegistro := cds_Modelos.FieldByName('Codigo').AsInteger;
    Lc_form.CodigoMarca := VehicleBrand.Registro.Codigo;
    Lc_form.ShowModal;
  Finally
    carregarModelos(Self.CodigoRegistro);
    FreeAndNil(Lc_form);
  End;
end;

procedure TRegVehicleBrand.setPerfil;
begin
  pfMenu := 'Marcas/Modelos';
  inherited;
end;

procedure TRegVehicleBrand.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegVehicleBrand.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegVehicleBrand.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

end.

