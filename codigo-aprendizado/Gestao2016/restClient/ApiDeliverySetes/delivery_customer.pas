unit delivery_customer;

interface
  Type
    TDeliveryCustomer = Class
    private
    Fname: String;
    Flatitude: String;
    Fstreet: String;
    Fstate: String;
    Fphone: String;
    Fid: Integer;
    Flongitude: String;
    Flocality: String;
    FzipCode: String;
    Fcomplement: String;
    Fnumber: String;
    FdocFiscal: String;
    Fneighborhood: String;
    procedure setFcomplement(const Value: String);
    procedure setFdocFiscal(const Value: String);
    procedure setFid(const Value: Integer);
    procedure setFlatitude(const Value: String);
    procedure setFlocality(const Value: String);
    procedure setFlongitude(const Value: String);
    procedure setFname(const Value: String);
    procedure setFneighborhood(const Value: String);
    procedure setFnumber(const Value: String);
    procedure setFphone(const Value: String);
    procedure setFstate(const Value: String);
    procedure setFstreet(const Value: String);
    procedure setFzipCode(const Value: String);


    public
      property id: Integer read Fid write setFid;
      property name: String read Fname write setFname;
      property phone :String read Fphone write setFphone;
      property docFiscal: String read FdocFiscal write setFdocFiscal;
      property zipCode: String read FzipCode write setFzipCode;
      property street: String read Fstreet write setFstreet;
      property number: String read Fnumber write setFnumber;
      property neighborhood: String read Fneighborhood write setFneighborhood;
      property complement: String read Fcomplement write setFcomplement;
      property locality: String read Flocality write setFlocality;
      property state:String read Fstate write setFstate;
      property longitude: String read Flongitude write setFlongitude;
      property latitude: String read Flatitude write setFlatitude;
    End;

implementation
{ TDeliveryCustomer }

{ TDeliveryCustomer }

procedure TDeliveryCustomer.setFcomplement(const Value: String);
begin
  Fcomplement := Value;
end;

procedure TDeliveryCustomer.setFdocFiscal(const Value: String);
begin
  FdocFiscal := Value;
end;

procedure TDeliveryCustomer.setFid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TDeliveryCustomer.setFlatitude(const Value: String);
begin
  Flatitude := Value;
end;

procedure TDeliveryCustomer.setFlocality(const Value: String);
begin
  Flocality := Value;
end;

procedure TDeliveryCustomer.setFlongitude(const Value: String);
begin
  Flongitude := Value;
end;

procedure TDeliveryCustomer.setFname(const Value: String);
begin
  Fname := Value;
end;

procedure TDeliveryCustomer.setFneighborhood(const Value: String);
begin
  Fneighborhood := Value;
end;

procedure TDeliveryCustomer.setFnumber(const Value: String);
begin
  Fnumber := Value;
end;

procedure TDeliveryCustomer.setFphone(const Value: String);
begin
  Fphone := Value;
end;

procedure TDeliveryCustomer.setFstate(const Value: String);
begin
  Fstate := Value;
end;

procedure TDeliveryCustomer.setFstreet(const Value: String);
begin
  Fstreet := Value;
end;

procedure TDeliveryCustomer.setFzipCode(const Value: String);
begin
  FzipCode := Value;
end;

end.
