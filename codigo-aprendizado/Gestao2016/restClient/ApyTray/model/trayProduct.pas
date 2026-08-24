unit trayProduct;

interface

Uses     GenericEntity, CAtribEntity, Generics.Collections, System.Classes;

Type
  //nome da classe de entidade

  TTrayProduct = Class
  private
    Fean: String;
    Freference: String;
    Fname: String;
    Fdescription_small: String;
    Fdescription: String;
    Fpayment_option: String;
    Flength: String;
    Fstock: String;
    Fprice: String;
    Fmodel: String;
    Fstart_promotion: String;
    Frelated_categories: String;
    Fpromotional_price: String;
    Favailable: String;
    Fshortcut: String;
    Fvirtual_product: String;
    Fweight: String;
    Fend_promotion: String;
    Fbrand: String;
    Fcategory_id: String;
    Fheight: String;
    Fcost_price: String;
    Frelease_date: String;
    Fwidth: String;
    Fid: String;
    Fhot: String;
    Fpicture_source_2: String;
    Fpicture_source_3: String;
    Fpicture_source_1: String;
    Fpicture_source_6: String;
    Fpicture_source_4: String;
    Fpicture_source_5: String;

    procedure setF(const Value: String);

    procedure setFbrand(const Value: String);
    procedure setFcategory_id(const Value: String);
    procedure setFcost_price(const Value: String);
    procedure setFdescription(const Value: String);
    procedure setFdescription_small(const Value: String);
    procedure setFean(const Value: String);
    procedure setFend_promotion(const Value: String);
    procedure setFheight(const Value: String);
    procedure setFlength(const Value: String);
    procedure setFmodel(const Value: String);
    procedure setFname(const Value: String);
    procedure setFpayment_option(const Value: String);
    procedure setFpromotional_price(const Value: String);
    procedure setFreference(const Value: String);
    procedure setFrelated_categories(const Value: String);
    procedure setFrelease_date(const Value: String);
    procedure setFshortcut(const Value: String);
    procedure setFstart_promotion(const Value: String);
    procedure setFstock(const Value: String);
    procedure setFavailable(const Value: String);
    procedure setFvirtual_product(const Value: String);
    procedure setFweight(const Value: String);
    procedure setFwidth(const Value: String);
    procedure setFid(const Value: String);
    procedure setFhot(const Value: String);
    procedure setFpicture_source_1(const Value: String);
    procedure setFpicture_source_2(const Value: String);
    procedure setFpicture_source_3(const Value: String);
    procedure setFpicture_source_4(const Value: String);
    procedure setFpicture_source_5(const Value: String);
    procedure setFpicture_source_6(const Value: String);

  public
    property id : String read Fid write setFid;

    property ean : String read Fean write setFean;

    property name : String read Fname write setFname;

    property description : String read Fdescription write setFdescription;

    property description_small : String read Fdescription_small write setFdescription_small;

    property price : String read Fprice write setF;

    property cost_price : String read Fcost_price write setFcost_price;

    property promotional_price : String read Fpromotional_price write setFpromotional_price;

    property start_promotion : String read Fstart_promotion write setFstart_promotion;

    property end_promotion : String read Fend_promotion write setFend_promotion;

    property brand : String read Fbrand write setFbrand;

    property model : String read Fmodel write setFmodel;

    property weight : String read Fweight write setFweight;

    property length : String read Flength write setFlength;

    property width : String read Fwidth write setFwidth;

    property height : String read Fheight write setFheight;

    property stock : String read Fstock write setFstock;

    property category_id : String read Fcategory_id write setFcategory_id;

    property available : String read Favailable write setFavailable;

    property reference : String read Freference write setFreference;

    property payment_option : String read Fpayment_option write setFpayment_option;

    property related_categories : String read Frelated_categories write setFrelated_categories;

    property release_date : String read Frelease_date write setFrelease_date;

    property shortcut : String read Fshortcut write setFshortcut;

    property virtual_product : String read Fvirtual_product write setFvirtual_product;

    property hot : String read Fhot write setFhot;

    property picture_source_1 : String read Fpicture_source_1 write setFpicture_source_1;
    property picture_source_2 : String read Fpicture_source_2 write setFpicture_source_2;
    property picture_source_3 : String read Fpicture_source_3 write setFpicture_source_3;
    property picture_source_4 : String read Fpicture_source_4 write setFpicture_source_4;
    property picture_source_5 : String read Fpicture_source_5 write setFpicture_source_5;
    property picture_source_6 : String read Fpicture_source_6 write setFpicture_source_6;

  End;

implementation

{ TTrayProduct }

procedure TTrayProduct.setF(const Value: String);
begin
  Fprice := Value;
end;


procedure TTrayProduct.setFbrand(const Value: String);
begin
  Fbrand := Value;
end;

procedure TTrayProduct.setFcategory_id(const Value: String);
begin
  Fcategory_id := Value;
end;

procedure TTrayProduct.setFcost_price(const Value: String);
begin
  Fcost_price := Value;
end;

procedure TTrayProduct.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TTrayProduct.setFdescription_small(const Value: String);
begin
  Fdescription_small := Value;
end;

procedure TTrayProduct.setFean(const Value: String);
begin
  Fean := Value;
end;

procedure TTrayProduct.setFend_promotion(const Value: String);
begin
  Fend_promotion := Value;
end;

procedure TTrayProduct.setFheight(const Value: String);
begin
  Fheight := Value;
end;

procedure TTrayProduct.setFhot(const Value: String);
begin
  Fhot := Value;
end;

procedure TTrayProduct.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TTrayProduct.setFlength(const Value: String);
begin
  Flength := Value;
end;

procedure TTrayProduct.setFmodel(const Value: String);
begin
  Fmodel := Value;
end;

procedure TTrayProduct.setFname(const Value: String);
begin
  Fname := Value;
end;

procedure TTrayProduct.setFpayment_option(const Value: String);
begin
  Fpayment_option := Value;
end;

procedure TTrayProduct.setFpicture_source_1(const Value: String);
begin
  Fpicture_source_1 := Value;
end;

procedure TTrayProduct.setFpicture_source_2(const Value: String);
begin
  Fpicture_source_2 := Value;
end;

procedure TTrayProduct.setFpicture_source_3(const Value: String);
begin
  Fpicture_source_3 := Value;
end;

procedure TTrayProduct.setFpicture_source_4(const Value: String);
begin
  Fpicture_source_4 := Value;
end;

procedure TTrayProduct.setFpicture_source_5(const Value: String);
begin
  Fpicture_source_5 := Value;
end;

procedure TTrayProduct.setFpicture_source_6(const Value: String);
begin
  Fpicture_source_6 := Value;
end;

procedure TTrayProduct.setFpromotional_price(const Value: String);
begin
  Fpromotional_price := Value;
end;

procedure TTrayProduct.setFreference(const Value: String);
begin
  Freference := Value;
end;

procedure TTrayProduct.setFrelated_categories(const Value: String);
begin
  Frelated_categories := Value;
end;

procedure TTrayProduct.setFrelease_date(const Value: String);
begin
  Frelease_date := Value;
end;

procedure TTrayProduct.setFshortcut(const Value: String);
begin
  Fshortcut := Value;
end;

procedure TTrayProduct.setFstart_promotion(const Value: String);
begin
  Fstart_promotion := Value;
end;

procedure TTrayProduct.setFstock(const Value: String);
begin
  Fstock := Value;
end;

procedure TTrayProduct.setFavailable(const Value: String);
begin
  Favailable := Value;
end;

procedure TTrayProduct.setFvirtual_product(const Value: String);
begin
  Fvirtual_product := Value;
end;

procedure TTrayProduct.setFweight(const Value: String);
begin
  Fweight := Value;
end;

procedure TTrayProduct.setFwidth(const Value: String);
begin
  Fwidth := Value;
end;


end.
