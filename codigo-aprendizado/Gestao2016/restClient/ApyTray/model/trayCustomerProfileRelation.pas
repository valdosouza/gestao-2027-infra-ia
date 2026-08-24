unit trayCustomerProfileRelation;

interface

uses
      System.SysUtils, System.Classes, System.JSON;

type
  TTrayCustomerProfileRelation = class
  private
    FCustomerId: string;
    FCustomerProfileId: string;
  public
    property CustomerId: string read FCustomerId write FCustomerId;
    property CustomerProfileId: string read FCustomerProfileId write FCustomerProfileId;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayCustomerProfileRelation }

constructor TTrayCustomerProfileRelation.Create;
begin
  inherited;
end;

destructor TTrayCustomerProfileRelation.Destroy;
begin
  inherited;
end;

procedure TTrayCustomerProfileRelation.FromJSON(AJson: TJSONObject);
begin
  if AJson.TryGetValue<string>('customer_id', FCustomerId) then;
  if AJson.TryGetValue<string>('customer_profile_id', FCustomerProfileId) then;
end;

function TTrayCustomerProfileRelation.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('customer_id', FCustomerId);
  Result.AddPair('customer_profile_id', FCustomerProfileId);
end;

end.
