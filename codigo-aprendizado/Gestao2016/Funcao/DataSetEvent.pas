unit DataSetEvent;

interface

uses     Data.DB;

type
  TDatasetEvent = class(TDataSet)
  private
    FhasDisabledEvents : boolean;
    FAfterScrollTemp: TDataSetNotifyEvent;FOnNewRecordTemp:
  public
    procedure disableAllEvents;
    procedure enableAllEvents;
  end;

implementation

procedure TDatasetEvent.disableAllEvents;
begin
  FhasDisabledEvents := TRUE;
  disableControls;
  FAfterScrollTemp     := AfterScroll;
  AfterScroll     := nil;
end;

procedure TDatasetEvent.enableAllEvents;
begin
  if not FhasDisabledEvents then exit;
    AfterScroll     := FAfterScrollTemp;
    enableControls;
end;
end.
