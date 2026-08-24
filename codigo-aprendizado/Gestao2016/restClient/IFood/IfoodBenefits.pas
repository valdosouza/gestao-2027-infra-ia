unit IfoodBenefits;

interface

Type
  IIfoodSponsorshipValues = class
  private
    FIFOOD: String;
    FMERCHANT: String;
    procedure setFIFOOD(const Value: String);
    procedure setFMERCHANT(const Value: String);

  public
    property IFOOD      : String read FIFOOD write setFIFOOD;
    property MERCHANT   : String read FMERCHANT write setFMERCHANT;
  end;

  TIfoodBenefits = Class
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

{ IIfoodSponsorshipValues }

procedure IIfoodSponsorshipValues.setFIFOOD(const Value: String);
begin
  FIFOOD := Value;
end;

procedure IIfoodSponsorshipValues.setFMERCHANT(const Value: String);
begin
  FMERCHANT := Value;
end;

{ TIfoodBenefits }

procedure TIfoodBenefits.setFdeliveredBy(const Value: String);
begin
  FdeliveredBy := Value;
end;

procedure TIfoodBenefits.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TIfoodBenefits.setFmaxTime(const Value: String);
begin
  FmaxTime := Value;
end;

procedure TIfoodBenefits.setFminTime(const Value: String);
begin
  FminTime := Value;
end;

procedure TIfoodBenefits.setFmode(const Value: String);
begin
  Fmode := Value;
end;

procedure TIfoodBenefits.setFvalue(const Value: String);
begin
  Fvalue := Value;
end;

end.
