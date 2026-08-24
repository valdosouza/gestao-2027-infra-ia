unit ControllerTaxesCbs;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, tblTaxesCbs, prm_taxes, Md5, Generics.Collections, STQuery;

type

  TControllerTaxesCbs = class(TControllerBase)
  private

  public
    Registro: TTaxesCbs;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
    procedure Clear;
  end;

implementation

{ TControllerTaxesCbs }

procedure TControllerTaxesCbs.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerTaxesCbs.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTaxesCbs.Create;
end;

destructor TControllerTaxesCbs.Destroy;
begin
  FreeAndNil( Registro);
  inherited;
end;

function TControllerTaxesCbs.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesCbs.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesCbs.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesCbs.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

