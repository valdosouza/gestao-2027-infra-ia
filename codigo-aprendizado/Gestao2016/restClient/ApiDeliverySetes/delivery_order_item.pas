unit delivery_order_item;

interface

uses     delivery_order_item_detail, System.Generics.Collections;

  Type

    TDeliveryOrderItem = Class
    private
    FmenuId: integer;
    FmeasureId: Integer;
    Fflavors: String;
    FsubTotal: real;
    Fparts: Integer;
    Fid: integer;
    FpartsMax: Integer;
    Fqtde: Real;
    Fdescription: String;
    fitemsDetail: TArray<TDeliveryOrderItemDetail>;
    Fmeasure: String;
    Fnote: String;
    procedure setFdescription(const Value: String);
    procedure setFflavors(const Value: String);
    procedure setFid(const Value: integer);
    procedure setFitemsDetail(const Value: TArray<TDeliveryOrderItemDetail>);
    procedure setFmeasure(const Value: String);
    procedure setFmeasureId(const Value: Integer);
    procedure setFmenuId(const Value: integer);
    procedure setFparts(const Value: Integer);
    procedure setFpartsMax(const Value: Integer);
    procedure setFqtde(const Value: Real);
    procedure setFsubTotal(const Value: real);
    procedure setFnote(const Value: String);



    public
      constructor Create;
      destructor Destroy;

      property id : integer read Fid write setFid;
      property menuId : integer read FmenuId write setFmenuId;
      property description : String read Fdescription write setFdescription;
      property flavors : String read Fflavors write setFflavors;
      property measureId :Integer read FmeasureId write setFmeasureId;
      property measure : String read Fmeasure write setFmeasure;
      property qtde : Real read Fqtde write setFqtde;
      property subTotal : real read FsubTotal write setFsubTotal;
      property parts : Integer read Fparts write setFparts;
      property partsMax : Integer read FpartsMax write setFpartsMax;
      property note :String read Fnote write setFnote;
      property itemsDetail : TArray<TDeliveryOrderItemDetail> read fitemsDetail write setFitemsDetail;

    End;
implementation

{ TDeliveryOrderItem }

constructor TDeliveryOrderItem.Create;
begin

end;

destructor TDeliveryOrderItem.Destroy;
begin

end;

procedure TDeliveryOrderItem.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TDeliveryOrderItem.setFflavors(const Value: String);
begin
  Fflavors := Value;
end;

procedure TDeliveryOrderItem.setFid(const Value: integer);
begin
  Fid := Value;
end;

procedure TDeliveryOrderItem.setFitemsDetail(
  const Value: TArray<TDeliveryOrderItemDetail>);
begin
  fitemsDetail := Value;
end;

procedure TDeliveryOrderItem.setFmeasure(const Value: String);
begin
  Fmeasure := Value;
end;

procedure TDeliveryOrderItem.setFmeasureId(const Value: Integer);
begin
  FmeasureId := Value;
end;

procedure TDeliveryOrderItem.setFmenuId(const Value: integer);
begin
  FmenuId := Value;
end;

procedure TDeliveryOrderItem.setFnote(const Value: String);
begin
  Fnote := Value;
end;

procedure TDeliveryOrderItem.setFparts(const Value: Integer);
begin
  Fparts := Value;
end;

procedure TDeliveryOrderItem.setFpartsMax(const Value: Integer);
begin
  FpartsMax := Value;
end;

procedure TDeliveryOrderItem.setFqtde(const Value: Real);
begin
  Fqtde := Value;
end;

procedure TDeliveryOrderItem.setFsubTotal(const Value: real);
begin
  FsubTotal := Value;
end;

end.
