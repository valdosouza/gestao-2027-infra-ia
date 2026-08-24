unit trayVariants;

interface

uses     Generics.Collections;

Type
  TTraySku = class
  private
    Ftype: String;
    Fvalue: String;
    procedure setFtype(const Value: String);
    procedure setFvalue(const Value: String);

    public
      property _type : String read Ftype write setFtype;
      property value  : String read Fvalue write setFvalue;
  end;

  TTrayVariants = Class
  private
    Flength: String;
    Fstock: String;
    Fproduct_id: String;
    Fprice: String;
    Fwidth: String;
    Fstart_promotion: String;
    Fminimum_stock: String;
    Forder: String;
    Fpromotional_price: String;
    Fquantity_sold: String;
    Fend_promotion: String;
    Fweight: String;
    Fheight: String;
    Fean: String;
    Freference: String;
    Fcost_price: String;
    procedure setFcost_price(const Value: String);
    procedure setFean(const Value: String);
    procedure setFend_promotion(const Value: String);
    procedure setFheight(const Value: String);
    procedure setFlength(const Value: String);
    procedure setFminimum_stock(const Value: String);
    procedure setForder(const Value: String);
    procedure setFprice(const Value: String);
    procedure setFproduct_id(const Value: String);
    procedure setFpromotional_price(const Value: String);
    procedure setFquantity_sold(const Value: String);
    procedure setFreference(const Value: String);
    procedure setFstart_promotion(const Value: String);
    procedure setFstock(const Value: String);
    procedure setFweight(const Value: String);
    procedure setFwidth(const Value: String);


  public

    property product_id : String read Fproduct_id write setFproduct_id;
    property  ean: String read Fean write setFean;
    property  order : String read Forder write setForder;
    property  price: String read Fprice write setFprice;
    property  cost_price: String read Fcost_price write setFcost_price;
    property  stock: String read Fstock write setFstock;
    property  minimum_stock: String read Fminimum_stock write setFminimum_stock;
    property  reference: String read Freference write setFreference;
    property  weight: String read Fweight write setFweight;
    property  length: String read Flength write setFlength;
    property  width: String read Fwidth write setFwidth;
    property  height: String read Fheight write setFheight;
    property  start_promotion: String read Fstart_promotion write setFstart_promotion;
    property  end_promotion: String read Fend_promotion write setFend_promotion;
    property  promotional_price: String read Fpromotional_price write setFpromotional_price;
    property  quantity_sold: String read Fquantity_sold write setFquantity_sold;

  End;


implementation


{ TTraySku }

procedure TTraySku.setFtype(const Value: String);
begin
  Ftype := Value;
end;

procedure TTraySku.setFvalue(const Value: String);
begin
  Fvalue := Value;
end;

{ TTrayVariants }

procedure TTrayVariants.setFcost_price(const Value: String);
begin
  Fcost_price := Value;
end;

procedure TTrayVariants.setFean(const Value: String);
begin
  Fean := Value;
end;

procedure TTrayVariants.setFend_promotion(const Value: String);
begin
  Fend_promotion := Value;
end;

procedure TTrayVariants.setFheight(const Value: String);
begin
  Fheight := Value;
end;

procedure TTrayVariants.setFlength(const Value: String);
begin
  Flength := Value;
end;

procedure TTrayVariants.setFminimum_stock(const Value: String);
begin
  Fminimum_stock := Value;
end;

procedure TTrayVariants.setForder(const Value: String);
begin
  Forder := Value;
end;

procedure TTrayVariants.setFprice(const Value: String);
begin
  Fprice := Value;
end;

procedure TTrayVariants.setFproduct_id(const Value: String);
begin
  Fproduct_id := Value;
end;

procedure TTrayVariants.setFpromotional_price(const Value: String);
begin
  Fpromotional_price := Value;
end;

procedure TTrayVariants.setFquantity_sold(const Value: String);
begin
  Fquantity_sold := Value;
end;

procedure TTrayVariants.setFreference(const Value: String);
begin
  Freference := Value;
end;

procedure TTrayVariants.setFstart_promotion(const Value: String);
begin
  Fstart_promotion := Value;
end;

procedure TTrayVariants.setFstock(const Value: String);
begin
  Fstock := Value;
end;

procedure TTrayVariants.setFweight(const Value: String);
begin
  Fweight := Value;
end;

procedure TTrayVariants.setFwidth(const Value: String);
begin
  Fwidth := Value;
end;

end.
