unit trayCustomer;

interface

uses     trayCustomerProfileRelation, TrayCustomerAddress, System.Generics.Collections, System.JSON;

//Uses     GenericEntity, CAtribEntity;

Type
  TListaAddress = TObjectList<TTrayCustomerAddress>;

  TTrayCustomer = Class//(TGenericEntity)
   private
    FCnpj: string;
    FNewsletter: string;
    FCreated: string;
    FTerms: string;
    FId: string;
    FName: string;
    FRegistrationDate: string;
    FRg: string;
    FCpf: string;
    FPhone: string;
    FCellphone: string;
    FBirthDate: string;
    FGender: string;
    FEmail: string;
    FNickname: string;
    FToken: string;
    FTotalOrders: string;
    FObservation: string;
    FType: string;
    FForeign: string;
    FCompanyName: string;
    FStateInscription: string;
    FReseller: string;
    FDiscount: string;
    FBlocked: string;
    FCreditLimit: string;
    FIndicatorId: string;
    FProfileCustomerId: string;
    FLastSendingNewsletter: string;
    FLastPurchase: string;
    FLastVisit: string;
    FLastModification: string;
    FAddress: string;
    FZipCode: string;
    FNumber: string;
    FComplement: string;
    FNeighborhood: string;
    FCity: string;
    FState: string;
    FCountry: string;
    FModified: string;
    FCountOrders: string;
    FCustomerProfileRelations: TObjectList<TTrayCustomerProfileRelation>;

    FCustomerAddresses: TListaAddress;
  public
    property Cnpj: string read FCnpj write FCnpj;
    property Newsletter: string read FNewsletter write FNewsletter;
    property Created: string read FCreated write FCreated;
    property Terms: string read FTerms write FTerms;
    property Id: string read FId write FId;
    property Name: string read FName write FName;
    property RegistrationDate: string read FRegistrationDate write FRegistrationDate;
    property Rg: string read FRg write FRg;
    property Cpf: string read FCpf write FCpf;
    property Phone: string read FPhone write FPhone;
    property Cellphone: string read FCellphone write FCellphone;
    property BirthDate: string read FBirthDate write FBirthDate;
    property Gender: string read FGender write FGender;
    property Email: string read FEmail write FEmail;
    property Nickname: string read FNickname write FNickname;
    property Token: string read FToken write FToken;
    property TotalOrders: string read FTotalOrders write FTotalOrders;
    property Observation: string read FObservation write FObservation;
    property CustomerType: string read FType write FType;
    property Foreign: string read FForeign write FForeign;
    property CompanyName: string read FCompanyName write FCompanyName;
    property StateInscription: string read FStateInscription write FStateInscription;
    property Reseller: string read FReseller write FReseller;
    property Discount: string read FDiscount write FDiscount;
    property Blocked: string read FBlocked write FBlocked;
    property CreditLimit: string read FCreditLimit write FCreditLimit;
    property IndicatorId: string read FIndicatorId write FIndicatorId;
    property ProfileCustomerId: string read FProfileCustomerId write FProfileCustomerId;
    property LastSendingNewsletter: string read FLastSendingNewsletter write FLastSendingNewsletter;
    property LastPurchase: string read FLastPurchase write FLastPurchase;
    property LastVisit: string read FLastVisit write FLastVisit;
    property LastModification: string read FLastModification write FLastModification;
    property Address: string read FAddress write FAddress;
    property ZipCode: string read FZipCode write FZipCode;
    property Number: string read FNumber write FNumber;
    property Complement: string read FComplement write FComplement;
    property Neighborhood: string read FNeighborhood write FNeighborhood;
    property City: string read FCity write FCity;
    property State: string read FState write FState;
    property Country: string read FCountry write FCountry;
    property Modified: string read FModified write FModified;
    property CountOrders: string read FCountOrders write FCountOrders;
    property CustomerProfileRelations: TObjectList<TTrayCustomerProfileRelation> read FCustomerProfileRelations write FCustomerProfileRelations;
    property CustomerAddresses: TListaAddress read FCustomerAddresses write FCustomerAddresses;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayCustomer }

constructor TTrayCustomer.Create;
begin
  inherited;
  FCustomerProfileRelations := TObjectList<TTrayCustomerProfileRelation>.Create(True);
  FCustomerAddresses := TListaAddress.Create;
end;

destructor TTrayCustomer.Destroy;
begin
  FCustomerProfileRelations.Free;
  FCustomerAddresses.Free;
  inherited;
end;

procedure TTrayCustomer.FromJSON(AJson: TJSONObject);
var
  JsonValue, ItemValue: TJSONValue;
  JsonArray: TJSONArray;
  I: Integer;
  Relation: TTrayCustomerProfileRelation;
  AddressWrapper: TTrayCustomerAddress;
begin
  if AJson.TryGetValue<string>('cnpj', FCnpj) then;
  if AJson.TryGetValue<string>('newsletter', FNewsletter) then;
  if AJson.TryGetValue<string>('created', FCreated) then;
  if AJson.TryGetValue<string>('terms', FTerms) then;
  if AJson.TryGetValue<string>('id', FId) then;
  if AJson.TryGetValue<string>('name', FName) then;
  if AJson.TryGetValue<string>('registration_date', FRegistrationDate) then;
  if AJson.TryGetValue<string>('rg', FRg) then;
  if AJson.TryGetValue<string>('cpf', FCpf) then;
  if AJson.TryGetValue<string>('phone', FPhone) then;
  if AJson.TryGetValue<string>('cellphone', FCellphone) then;
  if AJson.TryGetValue<string>('birth_date', FBirthDate) then;
  if AJson.TryGetValue<string>('gender', FGender) then;
  if AJson.TryGetValue<string>('email', FEmail) then;
  if AJson.TryGetValue<string>('nickname', FNickname) then;
  if AJson.TryGetValue<string>('token', FToken) then;
  if AJson.TryGetValue<string>('total_orders', FTotalOrders) then;
  if AJson.TryGetValue<string>('observation', FObservation) then;
  if AJson.TryGetValue<string>('type', FType) then;
  if AJson.TryGetValue<string>('foreign', FForeign) then;
  if AJson.TryGetValue<string>('company_name', FCompanyName) then;
  if AJson.TryGetValue<string>('state_inscription', FStateInscription) then;
  if AJson.TryGetValue<string>('reseller', FReseller) then;
  if AJson.TryGetValue<string>('discount', FDiscount) then;
  if AJson.TryGetValue<string>('blocked', FBlocked) then;
  if AJson.TryGetValue<string>('credit_limit', FCreditLimit) then;
  if AJson.TryGetValue<string>('indicator_id', FIndicatorId) then;
  if AJson.TryGetValue<string>('profile_customer_id', FProfileCustomerId) then;
  if AJson.TryGetValue<string>('last_sending_newsletter', FLastSendingNewsletter) then;
  if AJson.TryGetValue<string>('last_purchase', FLastPurchase) then;
  if AJson.TryGetValue<string>('last_visit', FLastVisit) then;
  if AJson.TryGetValue<string>('last_modification', FLastModification) then;
  if AJson.TryGetValue<string>('address', FAddress) then;
  if AJson.TryGetValue<string>('zip_code', FZipCode) then;
  if AJson.TryGetValue<string>('number', FNumber) then;
  if AJson.TryGetValue<string>('complement', FComplement) then;
  if AJson.TryGetValue<string>('neighborhood', FNeighborhood) then;
  if AJson.TryGetValue<string>('city', FCity) then;
  if AJson.TryGetValue<string>('state', FState) then;
  if AJson.TryGetValue<string>('country', FCountry) then;
  if AJson.TryGetValue<string>('modified', FModified) then;
  if AJson.TryGetValue<string>('count_orders', FCountOrders) then;
  
  // CustomerProfileRelation array
  if AJson.TryGetValue<TJSONValue>('CustomerProfileRelation', JsonValue) and (JsonValue is TJSONArray) then
  begin
    JsonArray := TJSONArray(JsonValue);
    for I := 0 to JsonArray.Count - 1 do
    begin
      ItemValue := JsonArray.Items[I];
      if ItemValue is TJSONObject then
      begin
        Relation := TTrayCustomerProfileRelation.Create;
        Relation.FromJSON(TJSONObject(ItemValue));
        FCustomerProfileRelations.Add(Relation);
      end;
    end;
  end;
  
  // CustomerAddresses array
  if AJson.TryGetValue<TJSONValue>('CustomerAddresses', JsonValue) and (JsonValue is TJSONArray) then
  begin
    JsonArray := TJSONArray(JsonValue);
    for I := 0 to JsonArray.Count - 1 do
    begin
      ItemValue := JsonArray.Items[I];
      if ItemValue is TJSONObject then
      begin
        AddressWrapper := TtrayCustomerAddress.Create;
        AddressWrapper.FromJSON(TJSONObject(ItemValue));
        FCustomerAddresses.Add(AddressWrapper);
      end;
    end;
  end;
end;

function TTrayCustomer.ToJSON: TJSONObject;
var
  I: Integer;
  RelationsArray, AddressesArray: TJSONArray;
begin
  Result := TJSONObject.Create;
  Result.AddPair('cnpj', FCnpj);
  Result.AddPair('newsletter', FNewsletter);
  Result.AddPair('created', FCreated);
  Result.AddPair('terms', FTerms);
  Result.AddPair('id', FId);
  Result.AddPair('name', FName);
  Result.AddPair('registration_date', FRegistrationDate);
  Result.AddPair('rg', FRg);
  Result.AddPair('cpf', FCpf);
  Result.AddPair('phone', FPhone);
  Result.AddPair('cellphone', FCellphone);
  Result.AddPair('birth_date', FBirthDate);
  Result.AddPair('gender', FGender);
  Result.AddPair('email', FEmail);
  Result.AddPair('nickname', FNickname);
  Result.AddPair('token', FToken);
  Result.AddPair('total_orders', FTotalOrders);
  Result.AddPair('observation', FObservation);
  Result.AddPair('type', FType);
  Result.AddPair('foreign', FForeign);
  Result.AddPair('company_name', FCompanyName);
  Result.AddPair('state_inscription', FStateInscription);
  Result.AddPair('reseller', FReseller);
  Result.AddPair('discount', FDiscount);
  Result.AddPair('blocked', FBlocked);
  Result.AddPair('credit_limit', FCreditLimit);
  Result.AddPair('indicator_id', FIndicatorId);
  Result.AddPair('profile_customer_id', FProfileCustomerId);
  Result.AddPair('last_sending_newsletter', FLastSendingNewsletter);
  Result.AddPair('last_purchase', FLastPurchase);
  Result.AddPair('last_visit', FLastVisit);
  Result.AddPair('last_modification', FLastModification);
  Result.AddPair('address', FAddress);
  Result.AddPair('zip_code', FZipCode);
  Result.AddPair('number', FNumber);
  Result.AddPair('complement', FComplement);
  Result.AddPair('neighborhood', FNeighborhood);
  Result.AddPair('city', FCity);
  Result.AddPair('state', FState);
  Result.AddPair('country', FCountry);
  Result.AddPair('modified', FModified);
  Result.AddPair('count_orders', FCountOrders);
  
  // CustomerProfileRelation array
  RelationsArray := TJSONArray.Create;
  for I := 0 to FCustomerProfileRelations.Count - 1 do
    RelationsArray.AddElement(FCustomerProfileRelations[I].ToJSON);
  Result.AddPair('CustomerProfileRelation', RelationsArray);
  
  // CustomerAddresses array
  AddressesArray := TJSONArray.Create;
  for I := 0 to FCustomerAddresses.Count - 1 do
    AddressesArray.AddElement(FCustomerAddresses[I].ToJSON);
  Result.AddPair('CustomerAddresses', AddressesArray);
end;

end.
