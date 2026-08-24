unit TrayCustomerAddress;

interface

uses
      System.JSON;

//Uses     GenericEntity, CAtribEntity;

Type
  //nome da classe de entidade
  TTrayCustomerAddress = Class//(TGenericEntity)
  private
    FId: string;
    FCustomerId: string;
    FAddress: string;
    FNumber: string;
    FComplement: string;
    FNeighborhood: string;
    FCity: string;
    FState: string;
    FZipCode: string;
    FCountry: string;
    FType: string;
    FActive: string;
    FDescription: string;
    FRecipient: string;
    FTypeDelivery: string;
    FNotList: string;
    FCellPhone: String;

    FPhone: String;  public
    property Id: string read FId write FId;
    property CustomerId: string read FCustomerId write FCustomerId;
    property Address: string read FAddress write FAddress;
    property Number: string read FNumber write FNumber;
    property Complement: string read FComplement write FComplement;
    property Neighborhood: string read FNeighborhood write FNeighborhood;
    property City: string read FCity write FCity;
    property State: string read FState write FState;
    property ZipCode: string read FZipCode write FZipCode;
    property Country: string read FCountry write FCountry;
    property AddressType: string read FType write FType;
    property Active: string read FActive write FActive;
    property Description: string read FDescription write FDescription;
    property Recipient: string read FRecipient write FRecipient;
    property TypeDelivery: string read FTypeDelivery write FTypeDelivery;
    property NotList: string read FNotList write FNotList;
    property Phone : String read FPhone write FPhone;
    property CellPhone : String read FCellPhone write FCellPhone;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayCustomerAddress }

constructor TTrayCustomerAddress.Create;
begin
  inherited;
end;

destructor TTrayCustomerAddress.Destroy;
begin
  inherited;
end;

procedure TTrayCustomerAddress.FromJSON(AJson: TJSONObject);
begin
  if AJson.TryGetValue<string>('id', FId) then;
  if AJson.TryGetValue<string>('customer_id', FCustomerId) then;
  if AJson.TryGetValue<string>('address', FAddress) then;
  if AJson.TryGetValue<string>('number', FNumber) then;
  if AJson.TryGetValue<string>('complement', FComplement) then;
  if AJson.TryGetValue<string>('neighborhood', FNeighborhood) then;
  if AJson.TryGetValue<string>('city', FCity) then;
  if AJson.TryGetValue<string>('state', FState) then;
  if AJson.TryGetValue<string>('zip_code', FZipCode) then;
  if AJson.TryGetValue<string>('country', FCountry) then;
  if AJson.TryGetValue<string>('type', FType) then;
  if AJson.TryGetValue<string>('active', FActive) then;
  if AJson.TryGetValue<string>('description', FDescription) then;
  if AJson.TryGetValue<string>('recipient', FRecipient) then;
  if AJson.TryGetValue<string>('type_delivery', FTypeDelivery) then;
  if AJson.TryGetValue<string>('not_list', FNotList) then;
end;

function TTrayCustomerAddress.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('id', FId);
  Result.AddPair('customer_id', FCustomerId);
  Result.AddPair('address', FAddress);
  Result.AddPair('number', FNumber);
  Result.AddPair('complement', FComplement);
  Result.AddPair('neighborhood', FNeighborhood);
  Result.AddPair('city', FCity);
  Result.AddPair('state', FState);
  Result.AddPair('zip_code', FZipCode);
  Result.AddPair('country', FCountry);
  Result.AddPair('type', FType);
  Result.AddPair('active', FActive);
  Result.AddPair('description', FDescription);
  Result.AddPair('recipient', FRecipient);
  Result.AddPair('type_delivery', FTypeDelivery);
  Result.AddPair('not_list', FNotList);
end;

end.
