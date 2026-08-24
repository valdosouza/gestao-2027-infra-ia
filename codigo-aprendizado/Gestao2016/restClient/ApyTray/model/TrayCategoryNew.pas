unit TrayCategoryNew;

interface

uses
      System.SysUtils, System.Classes, System.JSON;

type
  TTrayCategoryNew = class
  private
    FId: string;
    FName: string;
    FMainCategory: string;
  public
    property Id: string read FId write FId;
    property Name: string read FName write FName;
    property MainCategory: string read FMainCategory write FMainCategory;

    constructor Create;
    destructor Destroy; override;

    procedure FromJSON(AJson: TJSONObject);
    function ToJSON: TJSONObject;
  end;

implementation

{ TTrayCategoryNew }

constructor TTrayCategoryNew.Create;
begin
  inherited;
end;

destructor TTrayCategoryNew.Destroy;
begin
  inherited;
end;

procedure TTrayCategoryNew.FromJSON(AJson: TJSONObject);
begin
  if AJson.TryGetValue<string>('id', FId) then;
  if AJson.TryGetValue<string>('name', FName) then;
  if AJson.TryGetValue<string>('main_category', FMainCategory) then;
end;

function TTrayCategoryNew.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('id', FId);
  Result.AddPair('name', FName);
  Result.AddPair('main_category', FMainCategory);
end;

end.
