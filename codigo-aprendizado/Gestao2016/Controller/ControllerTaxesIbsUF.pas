unit ControllerTaxesIbsUF;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, tblTaxesIbsUf, prm_taxes, Md5, Generics.Collections, STQuery;

type

  TControllerTaxesIbsUF = class(TControllerBase)
  private

  public
    Registro: TTaxesIbsUf;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
    procedure Clear;
  end;

implementation

{ TControllerTaxesIbsUF }

procedure TControllerTaxesIbsUF.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerTaxesIbsUF.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTaxesIbsUF.Create;
end;

destructor TControllerTaxesIbsUF.Destroy;
begin
  FreeAndNil( Registro);
  inherited;
end;

function TControllerTaxesIbsUF.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesIbsUF.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesIbsUF.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerTaxesIbsUF.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

