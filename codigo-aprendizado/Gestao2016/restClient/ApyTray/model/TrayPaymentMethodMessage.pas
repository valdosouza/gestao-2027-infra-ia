unit TrayPaymentMethodMessage;

interface

uses
      System.SysUtils, System.Classes, System.JSON;

type
  TTrayPaymentMethodMessage = class
  private
    FText: string;
    FTextPag: string;
    FTextConfirm: string;
    FConfirmation: string;
  public
    property Text: string read FText write FText;
    property TextPag: string read FTextPag write FTextPag;
    property TextConfirm: string read FTextConfirm write FTextConfirm;
    property Confirmation: string read FConfirmation write FConfirmation;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayPaymentMethodMessage }

constructor TTrayPaymentMethodMessage.Create;
begin
  inherited;
end;

destructor TTrayPaymentMethodMessage.Destroy;
begin
  inherited;
end;

procedure TTrayPaymentMethodMessage.FromJSON(AJson: TJSONObject);
begin
  if AJson.TryGetValue<string>('text', FText) then;
  if AJson.TryGetValue<string>('text_pag', FTextPag) then;
  if AJson.TryGetValue<string>('text_confirm', FTextConfirm) then;
  if AJson.TryGetValue<string>('confirmation', FConfirmation) then;
end;

function TTrayPaymentMethodMessage.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('text', FText);
  Result.AddPair('text_pag', FTextPag);
  Result.AddPair('text_confirm', FTextConfirm);
  Result.AddPair('confirmation', FConfirmation);
end;

end.
