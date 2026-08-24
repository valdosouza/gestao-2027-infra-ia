unit ControllerFrete;

interface

uses     System.Classes, System.SysUtils, Generics.Collections, STQuery, ControllerBase, tblfrete;

Type
  TListaFrete  = TObjectList<TFrete>;
  TControllerFrete = Class(TControllerBase)
  private
  public
    Registro : TFrete;
    Lista : TListaFrete;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure getbyId;
    procedure insert;
    procedure replace;
    procedure update;
    procedure save;
    procedure delete;
    procedure clear;
    procedure Search;
  End;


implementation

{ TControllerFrete }

procedure TControllerFrete.clear;
begin
  clearObj(Registro);
end;

constructor TControllerFrete.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TFrete.Create;
  Lista := TListaFrete.Create;
end;

procedure TControllerFrete.delete;
begin
  deleteObj(Registro);
end;

destructor TControllerFrete.Destroy;
begin
  FreeAndNil( Registro );
  FreeAndNil( Lista );
  inherited;
end;

procedure TControllerFrete.getbyId;
begin
  _getByKey(Registro);
end;

procedure TControllerFrete.insert;
begin
  if registro.Codigo = 0 then
    registro.Codigo := Generator('GN_FRETE');
  insertObj(Registro);
end;

procedure TControllerFrete.replace;
begin
  replaceObj(Registro);
end;

procedure TControllerFrete.save;
begin
  if registro.Codigo = 0 then
    registro.Codigo := Generator('GN_FRETE');
  saveObj(Registro);
end;

procedure TControllerFrete.Search;
begin

end;

procedure TControllerFrete.update;
begin
  updateObj(Registro);
end;

end.
