unit IfoodDeliveryAddress;

interface

uses     IfoodCoordinates, System.SysUtils;

Type
  TIfoodDeliveryAddress = Class
  private
    FformattedAddress: String;
    FstreetName: String;
    Fcoordinates: TIFoodCoordinates;
    FpostalCode: String;
    Fstate: String;
    Fcountry: String;
    FstreetNumber: String;
    Fneighborhood: String;
    Fcity: String;
    Freference: String;
    procedure setFcity(const Value: String);
    procedure setFcoordinates(const Value: TIFoodCoordinates);
    procedure setFcountry(const Value: String);
    procedure setFformattedAddress(const Value: String);
    procedure setFneighborhood(const Value: String);
    procedure setFpostalCode(const Value: String);
    procedure setFreference(const Value: String);
    procedure setFstate(const Value: String);
    procedure setFstreetName(const Value: String);
    procedure setFstreetNumber(const Value: String);

  public
    constructor Create;
    destructor Destroy;

    property formattedAddress : String read FformattedAddress write setFformattedAddress;
    property country          : String read Fcountry write setFcountry;
    property state            : String read Fstate write setFstate;
    property city             : String read Fcity write setFcity;
    property coordinates      : TIFoodCoordinates read Fcoordinates write setFcoordinates;
    property neighborhood     : String read Fneighborhood write setFneighborhood;
    property streetName       : String read FstreetName write setFstreetName;
    property streetNumber     : String read FstreetNumber write setFstreetNumber;
    property postalCode       : String read FpostalCode write setFpostalCode;
    property reference        : String read Freference write setFreference;

  End;


implementation

{ TIfoodDeliveryAddress }

constructor TIfoodDeliveryAddress.Create;
begin
  Fcoordinates := TIFoodCoordinates.Create;
end;

destructor TIfoodDeliveryAddress.Destroy;
begin
  FreeAndNil(Fcoordinates);
end;

procedure TIfoodDeliveryAddress.setFcity(const Value: String);
begin
  Fcity := Value;
end;

procedure TIfoodDeliveryAddress.setFcoordinates(
  const Value: TIFoodCoordinates);
begin
  Fcoordinates := Value;
end;

procedure TIfoodDeliveryAddress.setFcountry(const Value: String);
begin
  Fcountry := Value;
end;

procedure TIfoodDeliveryAddress.setFformattedAddress(const Value: String);
begin
  FformattedAddress := Value;
end;

procedure TIfoodDeliveryAddress.setFneighborhood(const Value: String);
begin
  Fneighborhood := Value;
end;

procedure TIfoodDeliveryAddress.setFpostalCode(const Value: String);
begin
  FpostalCode := Value;
end;

procedure TIfoodDeliveryAddress.setFreference(const Value: String);
begin
  Freference := Value;
end;

procedure TIfoodDeliveryAddress.setFstate(const Value: String);
begin
  Fstate := Value;
end;

procedure TIfoodDeliveryAddress.setFstreetName(const Value: String);
begin
  FstreetName := Value;
end;

procedure TIfoodDeliveryAddress.setFstreetNumber(const Value: String);
begin
  FstreetNumber := Value;
end;

end.
