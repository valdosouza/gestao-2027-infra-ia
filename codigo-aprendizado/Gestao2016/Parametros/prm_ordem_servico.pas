unit prm_ordem_servico;

interface

uses
      prm_dsk_base, tblOrdemServico, System.SysUtils;

Type
  TPrmSerieProduto = class(TPrmDskBase)
  private
    FFieldName: TOrdemServico;
    procedure setFFieldName(const Value: TOrdemServico);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TOrdemServico read FFieldName write setFFieldName;
  end;

implementation

{ TPrmSerieProduto }

procedure TPrmSerieProduto.Clear;
begin
  inherited;
  ClearObj(FFieldName);
end;

constructor TPrmSerieProduto.Create;
begin
  FFieldName := TOrdemServico.Create;
end;

destructor TPrmSerieProduto.Destroy;
begin
  FreeAndNil( FFieldName );
  inherited;
end;

procedure TPrmSerieProduto.setFFieldName(const Value: TOrdemServico);
begin
  FFieldName := Value;
end;

end.
