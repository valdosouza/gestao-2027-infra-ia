unit delivery_order_item_detail;

interface

uses     System.Generics.Collections;

  Type
   TDeliveryOrderItemDetailRmv = Class
  private
    Fid: Integer;
    Fdescription: String;
    Fcheck: boolean;
    procedure setFcheck(const Value: boolean);
    procedure setFdescription(const Value: String);
    procedure setFid(const Value: Integer);
   public
     property id : Integer read Fid write setFid;
     property description : String read Fdescription write setFdescription;
    property check : boolean read Fcheck write setFcheck;
   End;

   TDeliveryOrderItemDetailAdd = Class
  private
    Fid: Integer;
    Fdescription: String;
    Fprice_tag: Real;
    Fcheck: boolean;
    procedure setFcheck(const Value: boolean);
    procedure setFdescription(const Value: String);
    procedure setFid(const Value: Integer);
    procedure setFprice_tag(const Value: Real);


   public
     property id : Integer read Fid write setFid;
     property description : String read Fdescription write setFdescription;
     property priceTag: Real read Fprice_tag write setFprice_tag;
    property check : boolean read Fcheck write setFcheck;
   End;


    TDeliveryOrderItemDetail = Class
    private
    Fid: Integer;
    Fnote: String;
    Fkind: String;
    Fdescription: String;
    FingredOptional: TArray<TDeliveryOrderItemDetailAdd>;
    FingredRemove: TArray<TDeliveryOrderItemDetailRmv>;
    FpriceTag: Real;
    Fcheck: boolean;
    procedure setFcheck(const Value: boolean);
    procedure setFdescription(const Value: String);
    procedure setFid(const Value: Integer);
    procedure setFingredOptional(
      const Value: TArray<TDeliveryOrderItemDetailAdd>);
    procedure setFingredRemove(
      const Value: TArray<TDeliveryOrderItemDetailRmv>);
    procedure setFkind(const Value: String);
    procedure setFnote(const Value: String);
    procedure setFpriceTag(const Value: Real);

    public
      constructor Create;
      destructor Destroy;
      property id : Integer read Fid write setFid;
      property description : String read Fdescription write setFdescription;
      property priceTag : Real read FpriceTag write setFpriceTag;
      property kind : String read Fkind write setFkind;
      property note : String read Fnote write setFnote;
      property check : boolean read Fcheck write setFcheck;
      property ingredRemove : TArray<TDeliveryOrderItemDetailRmv> read FingredRemove write setFingredRemove;
      property ingredOptional : TArray<TDeliveryOrderItemDetailAdd> read FingredOptional write setFingredOptional;

    End;



implementation


{ TDeliveryOrderItemDetail }

constructor TDeliveryOrderItemDetail.Create;
begin

end;

destructor TDeliveryOrderItemDetail.Destroy;
begin

end;

procedure TDeliveryOrderItemDetail.setFcheck(const Value: boolean);
begin
  Fcheck := Value;
end;

procedure TDeliveryOrderItemDetail.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TDeliveryOrderItemDetail.setFid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TDeliveryOrderItemDetail.setFingredOptional(
  const Value: TArray<TDeliveryOrderItemDetailAdd>);
begin
  FingredOptional := Value;
end;

procedure TDeliveryOrderItemDetail.setFingredRemove(
  const Value: TArray<TDeliveryOrderItemDetailRmv>);
begin
  FingredRemove := Value;
end;

procedure TDeliveryOrderItemDetail.setFkind(const Value: String);
begin
  Fkind := Value;
end;

procedure TDeliveryOrderItemDetail.setFnote(const Value: String);
begin
  Fnote := Value;
end;

procedure TDeliveryOrderItemDetail.setFpriceTag(const Value: Real);
begin
  FpriceTag := Value;
end;

{ TDeliveryOrderItemDetailRmv }

procedure TDeliveryOrderItemDetailRmv.setFcheck(const Value: boolean);
begin
  Fcheck := Value;
end;

procedure TDeliveryOrderItemDetailRmv.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TDeliveryOrderItemDetailRmv.setFid(const Value: Integer);
begin
  Fid := Value;
end;


{ TDeliveryOrderItemDetailAdd }

procedure TDeliveryOrderItemDetailAdd.setFcheck(const Value: boolean);
begin
  Fcheck := Value;
end;

procedure TDeliveryOrderItemDetailAdd.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TDeliveryOrderItemDetailAdd.setFid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TDeliveryOrderItemDetailAdd.setFprice_tag(const Value: Real);
begin
  Fprice_tag := Value;
end;

end.
