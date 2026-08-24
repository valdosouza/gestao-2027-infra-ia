unit ControllerDistNfe;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, tblDistNfe, STQuery, System.Generics.Collections;

type
  TListaDistNfe = TObjectList<TDistNfe>;

  TControllerDistNfe = class(TControllerBase)
  private

  public
    Registro: TDistNfe;
    Lista: TListaDistNfe;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear;

    function Insert: Boolean;
    function Update: Boolean;
    function Save: Boolean;
    function Delete: Boolean;

  end;

implementation

{ TControllerDistNfe }

procedure TControllerDistNfe.Clear;
begin
  FreeAndNil(Registro);
  Registro := TDistNfe.Create;
end;

constructor TControllerDistNfe.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDistNfe.Create;
  Lista    := TListaDistNfe.Create;
end;

function TControllerDistNfe.Delete: Boolean;
begin
  Result := True;
  deleteObj(Registro);
end;

destructor TControllerDistNfe.Destroy;
begin
  Lista.Free;
  Registro.Free;
  inherited;
end;

function TControllerDistNfe.Insert: Boolean;
begin
  Result := True;
  insertObj(Registro);
end;

function TControllerDistNfe.Save: Boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerDistNfe.Update: Boolean;
begin
  Result := True;
  updateObj(Registro);
end;

end.
