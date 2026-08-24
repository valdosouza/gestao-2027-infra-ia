unit TrayOrderTransaction;

interface

uses
      System.SysUtils, System.Classes, System.JSON;

type
  TTrayOrderTransaction = class
  private
    FUrlPayment: string;
    FBankSlip: string;
    FTransactionId: string;
  public
    property UrlPayment: string read FUrlPayment write FUrlPayment;
    property BankSlip: string read FBankSlip write FBankSlip;
    property TransactionId: string read FTransactionId write FTransactionId;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayOrderTransaction }

constructor TTrayOrderTransaction.Create;
begin
  inherited;
end;

destructor TTrayOrderTransaction.Destroy;
begin
  inherited;
end;

procedure TTrayOrderTransaction.FromJSON(AJson: TJSONObject);
begin
  if AJson.TryGetValue<string>('url_payment', FUrlPayment) then;
  if AJson.TryGetValue<string>('bank_slip', FBankSlip) then;
  if AJson.TryGetValue<string>('transaction_id', FTransactionId) then;
end;

function TTrayOrderTransaction.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('url_payment', FUrlPayment);
  Result.AddPair('bank_slip', FBankSlip);
  Result.AddPair('transaction_id', FTransactionId);
end;

end.
