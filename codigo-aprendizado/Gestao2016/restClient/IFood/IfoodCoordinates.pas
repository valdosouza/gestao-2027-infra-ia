unit IfoodCoordinates;

interface

Type
  TIFoodCoordinates = Class
  private
    Flatitude: String;
    Flongitude: String;
    procedure setFlatitude(const Value: String);
    procedure setFlongitude(const Value: String);

  public
    property latitude   : String read Flatitude write setFlatitude;
    property longitude  : String read Flongitude write setFlongitude;

  End;


implementation

{ TIFoodCoordinates }

procedure TIFoodCoordinates.setFlatitude(const Value: String);
begin
  Flatitude := Value;
end;

procedure TIFoodCoordinates.setFlongitude(const Value: String);
begin
  Flongitude := Value;
end;

end.
