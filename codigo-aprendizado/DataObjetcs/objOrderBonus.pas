unit objOrderBonus;

interface

uses System.SysUtils, objEntityFiscal, tblCustomer,  ObjSalesMan, tblOrder,
  tblOrderPi, tblMedParts, tblMedPartsJr, tblMedPartsRt, tblMedInsertDate,
  System.Generics.Collections, tblOrderItem, tblOrderBonus,tblOrderTotalizer,
  tblOrderBilling, objBase;

Type
  TListItems = TObjectList<TOrderItem>;
  TObjOrderBonus = Class(TObjBase)
  private
    FOrderSale: TOrderBonus;
    FTotalizer: TOrderTotalizer;
    FBilling: TOrderBilling;
    FFormaPagamento: String;
    FItems: TListItems;
    FCliente: TCustomer;
    FOrder: TOrder;
    FFiscal: TObjEntityFiscal;
    FDocFiscalVendedor: String;
    FVendedor: Integer;
    procedure setFBilling(const Value: TOrderBilling);
    procedure setFCliente(const Value: TCustomer);
    procedure setFFiscal(const Value: TObjEntityFiscal);
    procedure setFFormaPagamento(const Value: String);
    procedure setFItems(const Value: TListItems);
    procedure setFOrder(const Value: TOrder);
    procedure setFOrderSale(const Value: TOrderBonus);
    procedure setFTotalizer(const Value: TOrderTotalizer);
    procedure setFDocFiscalVendedor(const Value: String);
    procedure setFVendedor(const Value: Integer);

  public
      constructor Create;
      destructor Destroy;override;
      procedure clear;
      property Fiscal : TObjEntityFiscal read FFiscal write setFFiscal;
      property Cliente : TCustomer read FCliente write setFCliente;
      property Vendedor : Integer read FVendedor write setFVendedor;
      property DocFiscalVendedor : String read FDocFiscalVendedor write setFDocFiscalVendedor;
      property FormaPagamento     : String read FFormaPagamento write setFFormaPagamento;
      property Order : TOrder read FOrder write setFOrder;
      property OrderBonus : TOrderBonus read FOrderSale write setFOrderSale;
      property Items  : TListItems  read FItems write setFItems;
      property Totalizer : TOrderTotalizer read FTotalizer write setFTotalizer;
      property Billing  : TOrderBilling read FBilling write setFBilling;
  End;

implementation

uses GenericDao;
{ TObjOrderBonus }

procedure TObjOrderBonus.clear;
begin
  TGenericDAO._Clear(FTotalizer);
  TGenericDAO._Clear(FBilling);
  FItems.Clear;
  TGenericDAO._Clear(FCliente);
  FFiscal.clear;
  TGenericDAO._Clear(FOrderSale);
  TGenericDAO._Clear(FOrder);
end;

constructor TObjOrderBonus.Create;
begin

  FTotalizer  := TOrderTotalizer.Create;
  FBilling    := TOrderBilling.Create;
  FItems      := TListItems.Create;
  FFiscal     := TObjEntityFiscal.Create;
  FCliente    := TCustomer.Create;
  FOrderSale  := TOrderBonus.Create;
  FOrder      := TOrder.Create;
end;

destructor TObjOrderBonus.Destroy;
begin
  {$IFDEF WIN32}
    FTotalizer.DisposeOf;
    FBilling.DisposeOf;
    FItems.DisposeOf;
    Fiscal.Destroy;
    FCliente.DisposeOf;
    FOrderSale.DisposeOf;
    FOrder.DisposeOf;
  {$ENDIF }
end;


procedure TObjOrderBonus.setFBilling(const Value: TOrderBilling);
begin
  FBilling := Value;
end;

procedure TObjOrderBonus.setFCliente(const Value: TCustomer);
begin
  FCliente := Value;
end;

procedure TObjOrderBonus.setFDocFiscalVendedor(const Value: String);
begin
  FDocFiscalVendedor := Value;
end;

procedure TObjOrderBonus.setFFiscal(const Value: TObjEntityFiscal);
begin
  FFiscal := Value;
end;

procedure TObjOrderBonus.setFFormaPagamento(const Value: String);
begin
  FFormaPagamento := Value;
end;

procedure TObjOrderBonus.setFItems(const Value: TListItems);
begin
  FItems := Value;
end;

procedure TObjOrderBonus.setFOrder(const Value: TOrder);
begin
  FOrder := Value;
end;

procedure TObjOrderBonus.setFOrderSale(const Value: TOrderBonus);
begin
  FOrderSale := Value;
end;

procedure TObjOrderBonus.setFTotalizer(const Value: TOrderTotalizer);
begin
  FTotalizer := Value;
end;

procedure TObjOrderBonus.setFVendedor(const Value: Integer);
begin
  FVendedor := Value;
end;

end.


