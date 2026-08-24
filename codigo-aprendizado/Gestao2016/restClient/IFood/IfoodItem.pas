unit IfoodItem;

interface

uses     IfoodSubItem, System.Generics.Collections, System.SysUtils;

Type
  TListaSubItem = TObjectList<TIFoodSubItem>;

  TIFoodItem = Class
  private
    Fname: String;
    FsubItems: TListaSubItem;
    Fprice: String;
    Faddition: String;
    FsubItemsPrice: String;
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
    procedure setFsubItems(const Value: TListaSubItem);
    procedure setFsubItemsPrice(const Value: String);
    procedure setFtotalPrice(const Value: String);



  public
    constructor Create;
    destructor Destroy;

    property name          : String read Fname write setFname;
    property quantity      : String read Fquantity write setFquantity;
    property price         : String read Fprice write setFprice;
    property subItemsPrice : String read FsubItemsPrice  write setFsubItemsPrice ;
    property totalPrice    : String read FtotalPrice write setFtotalPrice;
    property discount      : String read Fdiscount write setFdiscount;
    property addition       : String read Faddition write setFaddition;
    property externalCode : String read FexternalCode write setFexternalCode;
    property subItems: TListaSubItem read FsubItems write setFsubItems;

  End;


implementation

constructor TIFoodItem.Create;
begin
  FsubItems := TListaSubItem.Create;
end;

destructor TIFoodItem.Destroy;
begin
  FreeAndNil(FsubItems);
end;

procedure TIFoodItem.setFaddition(const Value: String);
begin
  Faddition := Value;
end;

procedure TIFoodItem.setFdiscount(const Value: String);
begin
  Fdiscount := Value;
end;

procedure TIFoodItem.setFexternalCode(const Value: String);
begin
  FexternalCode := Value;
end;

procedure TIFoodItem.setFname(const Value: String);
begin
  Fname := Value;
end;

procedure TIFoodItem.setFprice(const Value: String);
begin
  Fprice := Value;
end;

procedure TIFoodItem.setFquantity(const Value: String);
begin
  Fquantity := Value;
end;

procedure TIFoodItem.setFsubItems(const Value: TListaSubItem);
begin
  FsubItems := Value;
end;

procedure TIFoodItem.setFsubItemsPrice(const Value: String);
begin
  FsubItemsPrice := Value;
end;

procedure TIFoodItem.setFtotalPrice(const Value: String);
begin
  FtotalPrice := Value;
end;

end.
