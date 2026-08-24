unit ControllerTaxesIbsMUN;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, tblTaxesIbsMun, prm_taxes, Md5, Generics.Collections, STQuery;

type

  TControllerTaxesIbsMUN = class(TControllerBase)
  private

  public
    Registro: TTaxesIbsMun;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
    procedure Clear;
  end;

implementation

{ TControllerTaxesIbsMUN }

procedure TControllerTaxesIbsMUN.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerTaxesIbsMUN.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTaxesIbsMUN.Create;
end;

destructor TControllerTaxesIbsMUN.Destroy;
begin
  FreeAndNil( Registro);
  inherited;
end;

function TControllerTaxesIbsMUN.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesIbsMUN.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesIbsMUN.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesIbsMUN.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

