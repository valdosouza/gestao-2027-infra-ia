unit ControllerDfeProtocolo;

interface

uses
      System.Classes, System.SysUtils, System.Generics.Collections, STDatabase, STQuery, ControllerBase, tblDfeProtocolo;

type
  TListaDfeProtocolo = TObjectList<TDfeProtocolo>;

  TControllerDfeProtocolo = class(TControllerBase)
  private

  public
    Registro: TDfeProtocolo;
    Lista: TListaDfeProtocolo;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear;

    function Insert: Boolean;
    function Update: Boolean;
    function Save: Boolean;
    function Delete: Boolean;

  end;

implementation

{ TControllerDfeProtocolo }

procedure TControllerDfeProtocolo.Clear;
begin
  FreeAndNil(Registro);
  Registro := TDfeProtocolo.Create;
end;

constructor TControllerDfeProtocolo.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDfeProtocolo.Create;
  Lista    := TListaDfeProtocolo.Create;
end;

function TControllerDfeProtocolo.Delete: Boolean;
begin
  Result := True;
  deleteObj(Registro);
end;

destructor TControllerDfeProtocolo.Destroy;
begin
  Lista.Free;
  Registro.Free;
  inherited;
end;

function TControllerDfeProtocolo.Insert: Boolean;
begin
  Result := True;
  insertObj(Registro);
end;



function TControllerDfeProtocolo.Save: Boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerDfeProtocolo.Update: Boolean;
begin
  Result := True;
  updateObj(Registro);
end;

end.

