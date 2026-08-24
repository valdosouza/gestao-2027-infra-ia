unit ControllerBoleto;

interface

uses     STDatabase, System.Classes, System.SysUtils, ControllerBase, tblBoleto, Md5, STQuery;

Type
  TControllerBoleto = Class(TControllerBase)

  private

  public
    Registro : TBoleto;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Update:Boolean;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    procedure clear;
  End;

  implementation
{ ControllerBoleto}


procedure TControllerBoleto.clear;
begin

end;

constructor TControllerBoleto.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TBoleto.Create;
end;

function TControllerBoleto.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerBoleto.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerBoleto.insert: boolean;
begin
  try
    if ( Registro.Codigo = 0 ) then
      Registro.Codigo := Generator('GN_BOLETO');
    insertObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerBoleto.save: boolean;
begin
  try
    if ( Registro.Codigo = 0 ) then
      Registro.Codigo := Generator('GN_BOLETO');
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerBoleto.Update: Boolean;
begin
  updateObj(Registro);
end;

function TControllerBoleto.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerBoleto.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;
end.
