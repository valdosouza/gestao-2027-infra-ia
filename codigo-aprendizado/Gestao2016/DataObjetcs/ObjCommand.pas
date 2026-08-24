unit ObjCommand;

interface

uses     System.SysUtils, System.Generics.Collections, tblCommand, tblCheckOutItems;

Type
  TListaCheckOut = TObjectList<TCheckOutItems>;

  TObjCommand = Class
  private
    FItems: TListaCheckOut;
    FComanda: TCommand;
    FEstabelecimento: Integer;
    FUsuario: Integer;
    procedure setFComanda(const Value: TCommand);
    procedure setFItems(const Value: TListaCheckOut);
    procedure setFEstabelecimento(const Value: Integer);
    procedure setFusuario(const Value: Integer);

  public
      constructor Create;
      destructor Destroy;
      property Estabelecimento : Integer read FEstabelecimento write setFEstabelecimento;
      property Usuario : Integer read FUsuario write setFusuario;
      property Comanda : TCommand read FComanda write setFComanda;
      property Items : TListaCheckOut read FItems write setFItems;
  End;

implementation

{ TObjCommand }

constructor TObjCommand.Create;
begin
  Comanda := TCommand.create(self);
  Items   := TListaCheckOut.create;
end;

destructor TObjCommand.Destroy;
begin
  FreeAndNil(Comanda);
  FreeAndNil(Items);
end;


procedure TObjCommand.setFComanda(const Value: TCommand);
begin
  FComanda := Value;
end;

procedure TObjCommand.setFEstabelecimento(const Value: Integer);
begin
  FEstabelecimento := Value;
end;

procedure TObjCommand.setFItems(const Value: TListaCheckOut);
begin
  FItems := Value;
end;

procedure TObjCommand.setFusuario(const Value: Integer);
begin
  FUsuario := Value;
end;

end.
