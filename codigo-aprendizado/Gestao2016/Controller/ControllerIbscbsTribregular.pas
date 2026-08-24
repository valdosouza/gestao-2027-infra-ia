unit ControllerIbscbsTribregular;

interface

uses
      STDatabase, System.Classes, System.SysUtils, ControllerBase, tblIbscbsTribregular, Md5, STQuery;

Type
  TControllerIbscbsTribregular = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbscbsTribregular;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
  end;

implementation

{ TControllerIbscbsTribregular }

constructor TControllerIbscbsTribregular.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbscbsTribregular.Create;
end;

destructor TControllerIbscbsTribregular.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerIbscbsTribregular.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsTribregular.insert: Boolean;
begin
  Result := True;
  try
    InsertObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsTribregular.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsTribregular.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

