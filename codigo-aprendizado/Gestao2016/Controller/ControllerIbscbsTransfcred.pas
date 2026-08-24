unit ControllerIbscbsTransfcred;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, tblIbscbsTransfcred, Md5, STQuery;

Type
  TControllerIbscbsTransfcred = class(TControllerBase)
  private
    // nenhum campo privado necessário
  public
    Registro: TIbscbsTransfcred;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function save: Boolean;
    function insert: Boolean;
    function delete: Boolean;
    function getByKey: Boolean;
  end;

implementation

{ TControllerIbscbsTransfcred }

constructor TControllerIbscbsTransfcred.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIbscbsTransfcred.Create;
end;

destructor TControllerIbscbsTransfcred.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerIbscbsTransfcred.delete: Boolean;
begin
  Result := True;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsTransfcred.insert: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsTransfcred.save: Boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerIbscbsTransfcred.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

