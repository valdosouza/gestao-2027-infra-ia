unit TrayProductsSold;

interface

uses
      System.SysUtils, System.Classes, System.Generics.Collections, System.JSON, TrayProductSoldImage, TrayCategoryNew, TrayUrl, TrayStock;

type
  TTrayProductsSold = class
  private
    FProductKitId: string;
    FProductKitIdKit: string;
    FIdCampaign: string;
    FProductId: string;
    FQuantity: string;
    FId: string;
    FOrderId: string;
    FName: string;
    FOriginalName: string;
    FVirtualProduct: string;
    FEan: string;
    FAvailabilityDays: string;
    FAvailability: string;
    FPrice: string;
    FCostPrice: string;
    FOriginalPrice: string;
    FWeight: string;
    FWeightCubic: string;
    FBrand: string;
    FModel: string;
    FReference: string;
    FLength: string;
    FWidth: string;
    FHeight: string;
    FVariantId: string;
    FAdditionalInformation: string;
    FTextVariant: string;
    FWarranty: string;
    FBoughtTogetherId: string;
    FNcm: string;
    FIncludedItems: string;
    FReleaseDate: string;
    FCommissionerValue: string;
    FComissao: string;
    FIsGiveawayByCoupon: string;
    FIsGiveaway: string;
    FProductSoldImages: TObjectList<TTrayProductSoldImage>;
    FCategories: TObjectList<TTrayCategoryNew>;
    FUrl: TTrayUrl;
    FStock: TTrayStock;
  public
    property ProductKitId: string read FProductKitId write FProductKitId;
    property ProductKitIdKit: string read FProductKitIdKit write FProductKitIdKit;
    property IdCampaign: string read FIdCampaign write FIdCampaign;
    property ProductId: string read FProductId write FProductId;
    property Quantity: string read FQuantity write FQuantity;
    property Id: string read FId write FId;
    property OrderId: string read FOrderId write FOrderId;
    property Name: string read FName write FName;
    property OriginalName: string read FOriginalName write FOriginalName;
    property VirtualProduct: string read FVirtualProduct write FVirtualProduct;
    property Ean: string read FEan write FEan;
    property AvailabilityDays: string read FAvailabilityDays write FAvailabilityDays;
    property Availability: string read FAvailability write FAvailability;
    property Price: string read FPrice write FPrice;
    property CostPrice: string read FCostPrice write FCostPrice;
    property OriginalPrice: string read FOriginalPrice write FOriginalPrice;
    property Weight: string read FWeight write FWeight;
    property WeightCubic: string read FWeightCubic write FWeightCubic;
    property Brand: string read FBrand write FBrand;
    property Model: string read FModel write FModel;
    property Reference: string read FReference write FReference;
    property Length: string read FLength write FLength;
    property Width: string read FWidth write FWidth;
    property Height: string read FHeight write FHeight;
    property VariantId: string read FVariantId write FVariantId;
    property AdditionalInformation: string read FAdditionalInformation write FAdditionalInformation;
    property TextVariant: string read FTextVariant write FTextVariant;
    property Warranty: string read FWarranty write FWarranty;
    property BoughtTogetherId: string read FBoughtTogetherId write FBoughtTogetherId;
    property Ncm: string read FNcm write FNcm;
    property IncludedItems: string read FIncludedItems write FIncludedItems;
    property ReleaseDate: string read FReleaseDate write FReleaseDate;
    property CommissionerValue: string read FCommissionerValue write FCommissionerValue;
    property Comissao: string read FComissao write FComissao;
    property IsGiveawayByCoupon: string read FIsGiveawayByCoupon write FIsGiveawayByCoupon;
    property IsGiveaway: string read FIsGiveaway write FIsGiveaway;
    property ProductSoldImages: TObjectList<TTrayProductSoldImage> read FProductSoldImages write FProductSoldImages;
    property Categories: TObjectList<TTrayCategoryNew> read FCategories write FCategories;
    property Url: TTrayUrl read FUrl write FUrl;
    property Stock: TTrayStock read FStock write FStock;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayProductsSold }

constructor TTrayProductsSold.Create;
begin
  inherited;
  FProductSoldImages := TObjectList<TTrayProductSoldImage>.Create(True);
  FCategories := TObjectList<TTrayCategoryNew>.Create(True);
  FUrl := TTrayUrl.Create;
  FStock := TTrayStock.Create;
end;

destructor TTrayProductsSold.Destroy;
begin
  FProductSoldImages.Free;
  FCategories.Free;
  FUrl.Free;
  FStock.Free;
  inherited;
end;

procedure TTrayProductsSold.FromJSON(AJson: TJSONObject);
var
  JsonValue, ItemValue: TJSONValue;
  JsonArray: TJSONArray;
  I: Integer;
  Item: TTrayProductSoldImage;
  Category: TTrayCategoryNew;
begin
  if AJson.TryGetValue<string>('product_kit_id', FProductKitId) then;
  if AJson.TryGetValue<string>('product_kit_id_kit', FProductKitIdKit) then;
  if AJson.TryGetValue<string>('id_campaign', FIdCampaign) then;
  if AJson.TryGetValue<string>('product_id', FProductId) then;
  if AJson.TryGetValue<string>('quantity', FQuantity) then;
  if AJson.TryGetValue<string>('id', FId) then;
  if AJson.TryGetValue<string>('order_id', FOrderId) then;
  if AJson.TryGetValue<string>('name', FName) then;
  if AJson.TryGetValue<string>('original_name', FOriginalName) then;
  if AJson.TryGetValue<string>('virtual_product', FVirtualProduct) then;
  if AJson.TryGetValue<string>('ean', FEan) then;
  if AJson.TryGetValue<string>('availability_days', FAvailabilityDays) then;
  if AJson.TryGetValue<string>('availability', FAvailability) then;
  if AJson.TryGetValue<string>('price', FPrice) then;
  if AJson.TryGetValue<string>('cost_price', FCostPrice) then;
  if AJson.TryGetValue<string>('original_price', FOriginalPrice) then;
  if AJson.TryGetValue<string>('weight', FWeight) then;
  if AJson.TryGetValue<string>('weight_cubic', FWeightCubic) then;
  if AJson.TryGetValue<string>('brand', FBrand) then;
  if AJson.TryGetValue<string>('model', FModel) then;
  if AJson.TryGetValue<string>('reference', FReference) then;
  if AJson.TryGetValue<string>('length', FLength) then;
  if AJson.TryGetValue<string>('width', FWidth) then;
  if AJson.TryGetValue<string>('height', FHeight) then;
  if AJson.TryGetValue<string>('variant_id', FVariantId) then;
  if AJson.TryGetValue<string>('additional_information', FAdditionalInformation) then;
  if AJson.TryGetValue<string>('text_variant', FTextVariant) then;
  if AJson.TryGetValue<string>('warranty', FWarranty) then;
  if AJson.TryGetValue<string>('bought_together_id', FBoughtTogetherId) then;
  if AJson.TryGetValue<string>('ncm', FNcm) then;
  if AJson.TryGetValue<string>('included_items', FIncludedItems) then;
  if AJson.TryGetValue<string>('release_date', FReleaseDate) then;
  if AJson.TryGetValue<string>('commissioner_value', FCommissionerValue) then;
  if AJson.TryGetValue<string>('comissao', FComissao) then;
  if AJson.TryGetValue<string>('is_giveaway_by_coupon', FIsGiveawayByCoupon) then;
  if AJson.TryGetValue<string>('is_giveaway', FIsGiveaway) then;

  // ProductSoldImage array
  if AJson.TryGetValue<TJSONValue>('ProductSoldImage', JsonValue) and (JsonValue is TJSONArray) then
  begin
    JsonArray := TJSONArray(JsonValue);
    for I := 0 to JsonArray.Count - 1 do
    begin
      ItemValue := JsonArray.Items[I];
      if ItemValue is TJSONObject then
      begin
        Item := TTrayProductSoldImage.Create;
        Item.FromJSON(TJSONObject(ItemValue));
        FProductSoldImages.Add(Item);
      end;
    end;
  end;

  // Category array
  if AJson.TryGetValue<TJSONValue>('Category', JsonValue) and (JsonValue is TJSONArray) then
  begin
    JsonArray := TJSONArray(JsonValue);
    for I := 0 to JsonArray.Count - 1 do
    begin
      ItemValue := JsonArray.Items[I];
      if ItemValue is TJSONObject then
      begin
        Category := TTrayCategoryNew.Create;
        Category.FromJSON(TJSONObject(ItemValue));
        FCategories.Add(Category);
      end;
    end;
  end;

  // Url object
  if AJson.TryGetValue<TJSONValue>('url', JsonValue) and (JsonValue is TJSONObject) then
    FUrl.FromJSON(TJSONObject(JsonValue));

  // Stock object
  if AJson.TryGetValue<TJSONValue>('Stock', JsonValue) and (JsonValue is TJSONObject) then
    FStock.FromJSON(TJSONObject(JsonValue));
end;

function TTrayProductsSold.ToJSON: TJSONObject;
var
  I: Integer;
  ImagesArray, CategoriesArray: TJSONArray;
begin
  Result := TJSONObject.Create;
  Result.AddPair('product_kit_id', FProductKitId);
  Result.AddPair('product_kit_id_kit', FProductKitIdKit);
  Result.AddPair('id_campaign', FIdCampaign);
  Result.AddPair('product_id', FProductId);
  Result.AddPair('quantity', FQuantity);
  Result.AddPair('id', FId);
  Result.AddPair('order_id', FOrderId);
  Result.AddPair('name', FName);
  Result.AddPair('original_name', FOriginalName);
  Result.AddPair('virtual_product', FVirtualProduct);
  Result.AddPair('ean', FEan);
  Result.AddPair('availability_days', FAvailabilityDays);
  Result.AddPair('availability', FAvailability);
  Result.AddPair('price', FPrice);
  Result.AddPair('cost_price', FCostPrice);
  Result.AddPair('original_price', FOriginalPrice);
  Result.AddPair('weight', FWeight);
  Result.AddPair('weight_cubic', FWeightCubic);
  Result.AddPair('brand', FBrand);
  Result.AddPair('model', FModel);
  Result.AddPair('reference', FReference);
  Result.AddPair('length', FLength);
  Result.AddPair('width', FWidth);
  Result.AddPair('height', FHeight);
  Result.AddPair('variant_id', FVariantId);
  Result.AddPair('additional_information', FAdditionalInformation);
  Result.AddPair('text_variant', FTextVariant);
  Result.AddPair('warranty', FWarranty);
  Result.AddPair('bought_together_id', FBoughtTogetherId);
  Result.AddPair('ncm', FNcm);
  Result.AddPair('included_items', FIncludedItems);
  Result.AddPair('release_date', FReleaseDate);
  Result.AddPair('commissioner_value', FCommissionerValue);
  Result.AddPair('comissao', FComissao);
  Result.AddPair('is_giveaway_by_coupon', FIsGiveawayByCoupon);
  Result.AddPair('is_giveaway', FIsGiveaway);

  // ProductSoldImage array
  ImagesArray := TJSONArray.Create;
  for I := 0 to FProductSoldImages.Count - 1 do
    ImagesArray.AddElement(FProductSoldImages[I].ToJSON);
  Result.AddPair('ProductSoldImage', ImagesArray);

  // Category array
  CategoriesArray := TJSONArray.Create;
  for I := 0 to FCategories.Count - 1 do
    CategoriesArray.AddElement(FCategories[I].ToJSON);
  Result.AddPair('Category', CategoriesArray);

  // Url object
  Result.AddPair('url', FUrl.ToJSON);

  // Stock object
  Result.AddPair('Stock', FStock.ToJSON);
end;

end.
