unit prm_serie_veiculo;

interface

uses
      prm_dsk_base, tblSerieVeiculo, System.SysUtils;

Type
  TPrmSerieVeiculo = class(TPrmDskBase)
  private
    FFieldName: TSerieVeiculo;
    procedure setFFieldName(const Value: TSerieVeiculo);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TSerieVeiculo read FFieldName write setFFieldName;
  end;


implementation

{ TPrmSerieVeiculo }

procedure TPrmSerieVeiculo.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmSerieVeiculo.Create;
begin
  FFieldName := TSerieVeiculo.Create;
end;

destructor TPrmSerieVeiculo.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmSerieVeiculo.setFFieldName(const Value: TSerieVeiculo);
begin
  FFieldName := Value;
end;

end.
