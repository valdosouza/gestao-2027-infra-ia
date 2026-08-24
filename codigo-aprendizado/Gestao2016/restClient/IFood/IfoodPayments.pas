unit IfoodPayments;

interface

Type
  TIFoodPayments = Class
  private
    Fname: String;
    Fcode: String;
    Fprepaid: String;
    Fissuer: String;
    Fvalue: String;
    procedure setFcode(const Value: String);
    procedure setFissuer(const Value: String);
    procedure setFname(const Value: String);
    procedure setFprepaid(const Value: String);
    procedure setFvalue(const Value: String);


  public
    property name    :String read Fname write setFname;
    property code    :String read Fcode write setFcode;
    property value   :String read Fvalue write setFvalue;
    property prepaid :String read Fprepaid write setFprepaid;
    property issuer  :String read Fissuer write setFissuer;
  End;

implementation

{ TIFoodPayments }

procedure TIFoodPayments.setFcode(const Value: String);
begin
  Fcode := Value;
end;

procedure TIFoodPayments.setFissuer(const Value: String);
begin
  Fissuer := Value;
end;

procedure TIFoodPayments.setFname(const Value: String);
begin
  Fname := Value;
end;

procedure TIFoodPayments.setFprepaid(const Value: String);
begin
  Fprepaid := Value;
end;

procedure TIFoodPayments.setFvalue(const Value: String);
begin
  Fvalue := Value;
end;

end.

