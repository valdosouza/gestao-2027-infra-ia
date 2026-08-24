unit IfoodAddress;

interface

uses     IfoodCoordinates;

Type
  TIfoodAddress = Class
  private
    FformattedAddress: String;
    FstreetName: String;
    FpostalCode: String;
    Fstate: String;
    Fcountry: String;
    FstreetNumber: String;
    Fneighborhood: String;
    Fcity: String;
    procedure setFcity(const Value: String);
    procedure setFcountry(const Value: String);
    procedure setFformattedAddress(const Value: String);
    procedure setFneighborhood(const Value: String);
    procedure setFpostalCode(const Value: String);
    procedure setFstate(const Value: String);
    procedure setFstreetName(const Value: String);
    procedure setFstreetNumber(const Value: String);

  public

    property formattedAddress : String read FformattedAddress write setFformattedAddress;
    property country          : String read Fcountry write setFcountry;
    property state            : String read Fstate write setFstate;
    property city             : String read Fcity write setFcity;
    property neighborhood     : String read Fneighborhood write setFneighborhood;
    property streetName       : String read FstreetName write setFstreetName;
    property streetNumber     : String read FstreetNumber write setFstreetNumber;
    property postalCode       : String read FpostalCode write setFpostalCode;

  End;

implementation

{ TIfoodAddress }

procedure TIfoodAddress.setFcity(const Value: String);
begin
  Fcity := Value;
end;

procedure TIfoodAddress.setFcountry(const Value: String);
begin
  Fcountry := Value;
end;

procedure TIfoodAddress.setFformattedAddress(const Value: String);
begin
  FformattedAddress := Value;
end;

procedure TIfoodAddress.setFneighborhood(const Value: String);
begin
  Fneighborhood := Value;
end;

procedure TIfoodAddress.setFpostalCode(const Value: String);
begin
  FpostalCode := Value;
end;

procedure TIfoodAddress.setFstate(const Value: String);
begin
  Fstate := Value;
end;

procedure TIfoodAddress.setFstreetName(const Value: String);
begin
  FstreetName := Value;
end;

procedure TIfoodAddress.setFstreetNumber(const Value: String);
begin
  FstreetNumber := Value;
end;

end.
