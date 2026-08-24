unit ControllerTaxesIncidency;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, tblTaxesIncidency, prm_taxes, Md5, Generics.Collections, STQuery;

type

  TControllerTaxesIncidency = class(TControllerBase)
  private

  public
    Registro: TTaxesIncidency;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
    procedure Clear;
  end;

implementation

{ TControllerTaxesIncidency }

procedure TControllerTaxesIncidency.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerTaxesIncidency.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTaxesIncidency.Create;
end;

destructor TControllerTaxesIncidency.Destroy;
begin
  FreeAndNil( Registro);
  inherited;
end;

function TControllerTaxesIncidency.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesIncidency.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesIncidency.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesIncidency.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

