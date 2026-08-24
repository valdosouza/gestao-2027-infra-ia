unit IfoodMerchant;

interface

uses     IfoodCoordinates, IfoodAddress, System.SysUtils;

Type
  TIfoodMerchant = Class
  private
    Fname: String;
    Fid: String;
    Faddress: TIfoodAddress;
    procedure setfaddress(const Value: TIfoodAddress);
    procedure setFid(const Value: String);
    procedure setFname(const Value: String);


  public
    constructor Create;
    destructor Destroy;

    property id      : String read Fid write setFid;
    property name    : String read Fname write setFname;
    property address : TIfoodAddress read Faddress write setfaddress;

  End;

implementation

{ TIfoodMerchant }

constructor TIfoodMerchant.Create;
begin
  Faddress := TIfoodAddress.Create;
end;

destructor TIfoodMerchant.Destroy;
begin
  FreeAndNil(Faddress);
end;

procedure TIfoodMerchant.setfaddress(const Value: TIfoodAddress);
begin
  Faddress := Value;
end;

procedure TIfoodMerchant.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TIfoodMerchant.setFname(const Value: String);
begin
  Fname := Value;
end;

end.
