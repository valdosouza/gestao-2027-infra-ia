unit prm_comissao;

interface

uses
      prm_dsk_base, tblcomissao, System.SysUtils;

Type
  TPrmComissao = class(TPrmDskBase)
  private
    FFieldName: TComissao;
    procedure setFFieldName(const Value: TComissao);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TComissao read FFieldName write setFFieldName;
  end;
implementation

{ TPrmComissao }

procedure TPrmComissao.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmComissao.Create;
begin
  FieldName := TComissao.Create
end;

destructor TPrmComissao.Destroy;
begin
  freeAndNil(FFieldName);
  inherited;
end;

procedure TPrmComissao.setFFieldName(const Value: TComissao);
begin
  FFieldName := Value;
end;

end.
