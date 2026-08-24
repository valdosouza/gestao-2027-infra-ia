unit IfoodDeliveryMethod;

interface

Type

  TIFoodDeliveryMethod = Class
  private
    Fmode: String;
    Fid: String;
    FmaxTime: String;
    FdeliveredBy: String;
    Fvalue: String;
    FminTime: String;
    procedure setFdeliveredBy(const Value: String);
    procedure setFid(const Value: String);
    procedure setFmaxTime(const Value: String);
    procedure setFminTime(const Value: String);
    procedure setFmode(const Value: String);
    procedure setFvalue(const Value: String);

  public
    property id          : String read Fid write setFid;
    property value       : String read Fvalue write setFvalue;
    property minTime     : String read FminTime write setFminTime;
    property maxTime     : String read FmaxTime write setFmaxTime;
    property mode        : String read Fmode write setFmode;
    property deliveredBy : String read FdeliveredBy write setFdeliveredBy;

  End;


implementation

{ TIFoodDeliveryMethod }

procedure TIFoodDeliveryMethod.setFdeliveredBy(const Value: String);
begin
  FdeliveredBy := Value;
end;

procedure TIFoodDeliveryMethod.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TIFoodDeliveryMethod.setFmaxTime(const Value: String);
begin
  FmaxTime := Value;
end;

procedure TIFoodDeliveryMethod.setFminTime(const Value: String);
begin
  FminTime := Value;
end;

procedure TIFoodDeliveryMethod.setFmode(const Value: String);
begin
  Fmode := Value;
end;

procedure TIFoodDeliveryMethod.setFvalue(const Value: String);
begin
  Fvalue := Value;
end;

end.
