unit delivery_order;

interface

uses     delivery_order_item, delivery_customer, System.Generics.Collections, SysUtils;

  Type
    //TListaItems = TObjectList<TDeliveryOrderItem>;

    TDeliveryOrder = Class
    private
    FsubtotalValue: Real;
    Fhr_record: String;
    FtotalValue: Real;
    Fcustomer: TDeliveryCustomer;
    FdeliveryValue: Real;
    Fitems: TArray<TDeliveryOrderItem>;
    FinstitutionID: integer;
    Fdt_record: String;
    ForderID: integer;
    FpaymentType: String;

    FchangeValue: real;
    FkindAttendance: Integer;
    Fupdated_at: String;



    procedure setFcustomer(const Value: TDeliveryCustomer);
    procedure setFdeliveryValue(const Value: Real);
    procedure setFdt_record(const Value: String);
    procedure setFhr_record(const Value: String);
    procedure setFinstitutionID(const Value: integer);
    procedure setFitems(const Value: TArray<TDeliveryOrderItem>);
    procedure setForderID(const Value: integer);
    procedure setFpaymentType(const Value: String);
    procedure setFsubtotalValue(const Value: Real);
    procedure setFtotalValue(const Value: Real);

    procedure setFchangeValue(const Value: real);
    procedure setFkindAttendance(const Value: Integer);
    procedure setFupdated_at(const Value: String);


    public
      constructor Create;
      destructor Destroy;
      property orderID : integer read ForderID write setForderID;
      property institutionID: integer read FinstitutionID write setFinstitutionID ;
      property updatedAt: String read Fupdated_at write setFupdated_at;
      property dt_record: String read Fdt_record  write setFdt_record ;
      property hr_record: String read Fhr_record  write setFhr_record ;

      property subtotalValue : Real  read FsubtotalValue write setFsubtotalValue;
      property kindAttendance : Integer read FkindAttendance write setFkindAttendance;
      property deliveryValue : Real read FdeliveryValue write setFdeliveryValue ;
      property changeValue : real  read FchangeValue write setFchangeValue;
      property totalValue : Real read FtotalValue write setFtotalValue ;
      property paymentType : String read FpaymentType write setFpaymentType ;

      property items : TArray<TDeliveryOrderItem> read Fitems write setFitems;
      property customer : TDeliveryCustomer read Fcustomer write setFcustomer;
      function toJson():String;

    End;

  TListaPedido = class
  private
    Fobj_json: TArray<TDeliveryOrder>;
    procedure setFobj_json(const Value: TArray<TDeliveryOrder>);
  public
    property obj_json :TArray<TDeliveryOrder> read Fobj_json write setFobj_json;
  end;

implementation

{ TDeliveryOrder }

constructor TDeliveryOrder.Create;
begin
  inherited;

  customer := TDeliveryCustomer.create();
//  items := TListaItems.Create;
end;

destructor TDeliveryOrder.Destroy;
begin

  inherited;
end;

procedure TDeliveryOrder.setFchangeValue(const Value: real);
begin
  FchangeValue := Value;
end;

procedure TDeliveryOrder.setFcustomer(const Value: TDeliveryCustomer);
begin
  Fcustomer := Value;
end;

procedure TDeliveryOrder.setFdeliveryValue(const Value: Real);
begin
  FdeliveryValue := Value;
end;

procedure TDeliveryOrder.setFdt_record(const Value: String);
begin
  Fdt_record := Value;
end;

procedure TDeliveryOrder.setFhr_record(const Value: String);
begin
  Fhr_record := Value;
end;

procedure TDeliveryOrder.setFinstitutionID(const Value: integer);
begin
  FinstitutionID := Value;
end;

procedure TDeliveryOrder.setFitems(const Value: TArray<TDeliveryOrderItem>);
begin
  Fitems := Value;
end;

procedure TDeliveryOrder.setFkindAttendance(const Value: Integer);
begin
  FkindAttendance := Value;
end;

procedure TDeliveryOrder.setForderID(const Value: integer);
begin
  ForderID := Value;
end;

procedure TDeliveryOrder.setFpaymentType(const Value: String);
begin
  FpaymentType := Value;
end;

procedure TDeliveryOrder.setFsubtotalValue(const Value: Real);
begin
  FsubtotalValue := Value;
end;

procedure TDeliveryOrder.setFtotalValue(const Value: Real);
begin
  FtotalValue := Value;
end;


procedure TDeliveryOrder.setFupdated_at(const Value: String);
begin
  Fupdated_at := Value;
end;

function TDeliveryOrder.toJson: String;
begin

end;

{ TListaPedido }

procedure TListaPedido.setFobj_json(const Value: TArray<TDeliveryOrder>);
begin
  Fobj_json := Value;
end;

end.
