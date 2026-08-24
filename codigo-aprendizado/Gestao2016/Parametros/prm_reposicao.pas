unit prm_reposicao;

interface

uses
      prm_dsk_base, tblProdProd, System.SysUtils;

Type
  TPrmReposicao = class(TPrmDskBase)
  private
    FFieldName: TProdProd;
    procedure setFFieldName(const Value: TProdProd);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TProdProd read FFieldName write setFFieldName;
  end;

implementation

{ TPrmReposicao }

procedure TPrmReposicao.Clear;
begin
  inherited;
  clearObj(FFieldName);
end;

constructor TPrmReposicao.Create;
begin
  FFieldName := TProdProd.create;
end;

destructor TPrmReposicao.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmReposicao.setFFieldName(const Value: TProdProd);
begin
  FFieldName := Value;
end;

end.
