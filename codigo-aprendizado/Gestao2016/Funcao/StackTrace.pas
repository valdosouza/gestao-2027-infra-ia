unit StackTrace;
interface

uses
      SysUtils;

function CaptureExceptionStack(const AException: Exception): string;

type
  ExceptionHelper = class helper for Exception
  public
    function Describe: string;
    class procedure RaiseNotImplementedException(const aClass: TClass; const aMethodName: string);
    class function GetStackTrace: string;
  end;

implementation

uses
      RTLConsts, SysConst, Winapi.Windows, MapStackResolver;

type
  EStackTraceException = class(Exception); // EProgrammerNotFound to make it really clear this is only to be used in very limited places ??

function RtlCaptureStackBackTrace(
  FramesToSkip, FramesToCapture: DWORD;
  BackTrace: Pointer;
  BackTraceHash: PDWORD): Word; stdcall; external kernel32 name 'RtlCaptureStackBackTrace';

function CaptureStackFramesRaw(const ASkipFrames, AMaxFrames: Integer): string;
var
  Frames: array of Pointer;
  Count: Word;
  I: Integer;
begin
  SetLength(Frames, AMaxFrames);
  Count := RtlCaptureStackBackTrace(ASkipFrames, AMaxFrames, @Frames[0], nil);
  for I := 0 to Count - 1 do
    Result := Result + Format('[%d] %p', [I, Frames[I]]) + sLineBreak;
end;

function ExtractFaultAddressFromException(const AException: Exception): Pointer;
var
  Msg, Token: string;
  PStart, I: Integer;
begin
  Result := nil;
  if AException = nil then
    Exit;

  Msg := AException.Message;
  PStart := Pos('at address ', LowerCase(Msg));
  if PStart = 0 then
    Exit;

  Token := Trim(Copy(Msg, PStart + Length('at address '), MaxInt));
  for I := 1 to Length(Token) do
    if not (Token[I] in ['0'..'9', 'A'..'F', 'a'..'f']) then
    begin
      Token := Copy(Token, 1, I - 1);
      Break;
    end;

  if Token = '' then
    Exit;

  if Token[1] <> '$' then
    Token := '$' + Token;

  try
    Result := Pointer(NativeUInt(StrToInt64(Token)));
  except
    Result := nil;
  end;
end;

function CaptureExceptionStack(const AException: Exception): string;
const
  MAX_FRAMES = 32;
var
  AddrLine: string;
  FaultAddr: Pointer;
begin
  Result := '';
  if AException = nil then
    Exit('(excecao nula)');

  if Assigned(AException.StackInfo) then
  begin
    Result := AException.StackTrace;
    if Result <> '' then
      Exit(ResolveStackFrames(AddrLine + Result));
  end;

  FaultAddr := ExtractFaultAddressFromException(AException);
  if FaultAddr <> nil then
    AddrLine := Format('Endereco da falha: %p' + sLineBreak, [FaultAddr])
  else
    AddrLine := '';

  try
    raise EStackTraceException.Create('capture') at ReturnAddress;
  except
    on E: EStackTraceException do
      Result := AddrLine + E.StackTrace;
  end;

  if Trim(StringReplace(Result, AddrLine, '', [])) = '' then
    Result := AddrLine + Exception.GetStackTrace;

  if Trim(StringReplace(Result, AddrLine, '', [])) = '' then
    Result := Result + CaptureStackFramesRaw(2, MAX_FRAMES);

  Result := ResolveStackFrames(Result);
end;

{ ExceptionHelper }

function ExceptionHelper.Describe: string;
var
  lStackTrace: string;
begin
  Result := inherited ToString();
  if Self is EInOutError then
    if Result = RTLConsts.SInvalidFileName then
      Result := SysConst.SInvalidFileName;
  if Assigned(StackInfo) then
    lStackTrace := StackTrace
  else
    lStackTrace := 'empty';
  Result := Format('Exception'#13#10'%s at $%p: %s'#13#10'with StackTrace'#13#10'%s',
    [ClassName, ExtractFaultAddressFromException(Self), Result, lStackTrace]);
end;

class function ExceptionHelper.GetStackTrace: string;
begin
  try
    Result := 'Get StackTrace via Exception.';
    raise EStackTraceException.Create(Result) at ReturnAddress;
  except
    on E: EStackTraceException do
      Result := E.StackTrace;
  end;
end;

class procedure ExceptionHelper.RaiseNotImplementedException(const aClass: TClass; const aMethodName: string);
begin
  raise ENotImplemented.CreateFmt('Method %s.%s is not implemented.', [aClass.ClassName, aMethodName]);
end;

end.
