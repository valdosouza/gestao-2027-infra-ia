unit IfoodEvents;

interface


Type

  TIFoodEvents = Class
  private
    Fcode: String;
    FcorrelationId: String;
    Fid: String;
    FcreatedAt: String;
    procedure setFcode(const Value: String);
    procedure setFcorrelationId(const Value: String);
    procedure setFcreatedAt(const Value: String);
    procedure setFid(const Value: String);

  public
    property code          : String read Fcode write setFcode;
    property correlationId : String read FcorrelationId write setFcorrelationId;
    property createdAt     : String read FcreatedAt write setFcreatedAt;
    property id            : String read Fid write setFid;


  End;

implementation

{ TIFoodEvents }

procedure TIFoodEvents.setFcode(const Value: String);
begin
  Fcode := Value;
end;

procedure TIFoodEvents.setFcorrelationId(const Value: String);
begin
  FcorrelationId := Value;
end;

procedure TIFoodEvents.setFcreatedAt(const Value: String);
begin
  FcreatedAt := Value;
end;

procedure TIFoodEvents.setFid(const Value: String);
begin
  Fid := Value;
end;

end.
