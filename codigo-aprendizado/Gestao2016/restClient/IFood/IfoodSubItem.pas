unit IfoodSubItem;

interface

Type
  TIFoodSubItem = Class
  private
    Fname: String;
    Fprice: String;
    Faddition: String;
    Fdiscount: String;
    Fquantity: String;
    FtotalPrice: String;
    FexternalCode: String;
    procedure setFaddition(const Value: String);
    procedure setFdiscount(const Value: String);
    procedure setFexternalCode(const Value: String);
    procedure setFname(const Value: String);
    procedure setFprice(const Value: String);
    procedure setFquantity(const Value: String);
    procedure setFtotalPrice(const Value: String);


  public
    property name         : String read Fname write setFname;
    property quantity     : String read Fquantity write setFquantity;
    property price        : String read Fprice write setFprice;
    property totalPrice   : String read FtotalPrice write setFtotalPrice;
    property discount     : String read Fdiscount write setFdiscount;
    property addition     : String read Faddition write setFaddition;
    property externalCode : String read FexternalCode write setFexternalCode;
  End;

implementation

{ TIFoodSubItem }

procedure TIFoodSubItem.setFaddition(const Value: String);
begin
  Faddition := Value;
end;

procedure TIFoodSubItem.setFdiscount(const Value: String);
begin
  Fdiscount := Value;
end;

procedure TIFoodSubItem.setFexternalCode(const Value: String);
begin
  FexternalCode := Value;
end;

procedure TIFoodSubItem.setFname(const Value: String);
begin
  Fname := Value;
end;

procedure TIFoodSubItem.setFprice(const Value: String);
begin
  Fprice := Value;
end;

procedure TIFoodSubItem.setFquantity(const Value: String);
begin
  Fquantity := Value;
end;

procedure TIFoodSubItem.setFtotalPrice(const Value: String);
begin
  FtotalPrice := Value;
end;

end.


