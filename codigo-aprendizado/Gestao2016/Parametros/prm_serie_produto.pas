unit prm_serie_produto;

interface

uses
      prm_dsk_base, tblSerieProduto, System.SysUtils;

Type
  TPrmSerieProduto = class(TPrmDskBase)
  private
    FFieldName: TSerieProduto;
    procedure setFFieldName(const Value: TSerieProduto);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TSerieProduto read FFieldName write setFFieldName;
  end;


implementation

{ TPrmSerieProduto }

procedure TPrmSerieProduto.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmSerieProduto.Create;
begin
  FFieldName := TSerieProduto.Create;
end;

destructor TPrmSerieProduto.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmSerieProduto.setFFieldName(const Value: TSerieProduto);
begin
  FFieldName := Value;
end;

end.
