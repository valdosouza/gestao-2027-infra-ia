unit ControllerEClass;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, tblEClass, Md5, Generics.Collections, STQuery;

type
  TControllerEClass = class(TControllerBase)
  private
  public
    Registro: TEClass;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear;
    function Save: Boolean;
    function Insert: Boolean;
    function Update: Boolean;
    function Delete: Boolean;
    function getByKey: Boolean;
  end;

implementation

{ TControllerEClass }

procedure TControllerEClass.Clear;
begin
  ClearObj(Registro);
end;

constructor TControllerEClass.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TEClass.Create;
end;

function TControllerEClass.Delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

destructor TControllerEClass.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerEClass.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

function TControllerEClass.Insert: Boolean;
begin
  Result := True;
  try
    insertObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerEClass.Save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerEClass.Update: Boolean;
begin
  Result := True;
  try
    updateObj(Registro);
  except
    Result := False;
  end;
end;

end.
