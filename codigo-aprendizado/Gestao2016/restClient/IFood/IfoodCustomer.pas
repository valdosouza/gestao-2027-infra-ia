unit IfoodCustomer;

interface

Type
  TIFoodCustomer = Class
  private
    Fname: String;
    Femail: String;
    Fphone: String;
    Fid: String;
    FordersCountOnRestaurant: String;
    procedure setFemail(const Value: String);
    procedure setFid(const Value: String);
    procedure setFname(const Value: String);
    procedure setFordersCountOnRestaurant(const Value: String);
    procedure setFphone(const Value: String);

  public
    property id         : String read Fid write setFid;
    property name       : String read Fname write setFname;
    property phone      : String read Fphone write setFphone;
    property email      : String read Femail write setFemail;
    property ordersCountOnRestaurant : String read FordersCountOnRestaurant write setFordersCountOnRestaurant;

  End;

implementation

{ TIFoodCustomer }

procedure TIFoodCustomer.setFemail(const Value: String);
begin
  Femail := Value;
end;

procedure TIFoodCustomer.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TIFoodCustomer.setFname(const Value: String);
begin
  Fname := Value;
end;

procedure TIFoodCustomer.setFordersCountOnRestaurant(const Value: String);
begin
  FordersCountOnRestaurant := Value;
end;

procedure TIFoodCustomer.setFphone(const Value: String);
begin
  Fphone := Value;
end;

end.
