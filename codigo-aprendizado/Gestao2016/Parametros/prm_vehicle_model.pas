unit prm_vehicle_model;

interface

uses
      prm_dsk_base, tblvehiclemodel, System.SysUtils;

Type
  TPrmVehicleModel = class(TPrmDskBase)
  private
    FFieldName: TVehicleModel;
    procedure setFFieldName(const Value: TVehicleModel);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TVehicleModel read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmVehicleModel.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmVehicleModel.Create;
begin
  inherited;
  FFieldName := TVehicleModel.Create;
end;

destructor TPrmVehicleModel.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmVehicleModel.setFFieldName(const Value: TVehicleModel);
begin
  FFieldName := Value;
end;

end.
