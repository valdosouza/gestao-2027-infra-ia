unit MapStackResolver;

interface

uses
      System.Classes;

function ResolveStackAddress(const AAddress: Pointer): string;
function ResolveStackFrames(const ARawStack: string): string;

implementation

uses
      System.SysUtils, Winapi.Windows;

{$R MapSymbols.res}

const
  MAP_SYMBOL_MAGIC = $31545347; // 'GST1'

type
  TMapSymbolRec = packed record
    RVA: Cardinal;
    Line: Cardinal;
    UnitNameOffset: Cardinal;
  end;

  TMapSymbolHeader = packed record
    Magic: Cardinal;
    Count: Cardinal;
    StringsOffset: Cardinal;
  end;

var
  GSymbols: array of TMapSymbolRec;
  GStringPool: AnsiString;
  GModuleBase: Integer;
  GLoaded: Boolean;

function ParseHexAddress(const S: string; out AValue: Cardinal): Boolean;
var
  Token: string;
begin
  Token := Trim(S);
  Result := Token <> '';
  if not Result then
    Exit;
  if (Token[1] = '$') then
    Token := Copy(Token, 2, MaxInt);
  try
    AValue := Cardinal(StrToInt64('$' + Token));
  except
    Result := False;
  end;
end;

procedure LoadMapSymbols;
var
  ResHandle: HRSRC;
  ResSize: DWORD;
  ResData: HGLOBAL;
  Data: Pointer;
  Header: ^TMapSymbolHeader;
  I: Integer;
begin
  if GLoaded then
    Exit;

  GLoaded := True;
  GModuleBase := Integer(HInstance);
  SetLength(GSymbols, 0);
  GStringPool := '';

  ResHandle := FindResource(HInstance, 'MAP_SYMBOLS', RT_RCDATA);
  if ResHandle = 0 then
    Exit;

  ResSize := SizeofResource(HInstance, ResHandle);
  if ResSize < SizeOf(TMapSymbolHeader) then
    Exit;

  ResData := LoadResource(HInstance, ResHandle);
  if ResData = 0 then
    Exit;

  Data := LockResource(ResData);
  if Data = nil then
    Exit;

  Header := Data;
  if Header.Magic <> MAP_SYMBOL_MAGIC then
    Exit;

  if Header.Count = 0 then
    Exit;

  if Integer(Header.StringsOffset) > Integer(ResSize) then
    Exit;

  SetLength(GSymbols, Header.Count);
  Move(Pointer(NativeInt(Data) + SizeOf(TMapSymbolHeader))^, GSymbols[0],
    Header.Count * SizeOf(TMapSymbolRec));

  SetLength(GStringPool, ResSize - Header.StringsOffset);
  for I := 1 to Length(GStringPool) do
    GStringPool[I] := AnsiChar(PAnsiChar(NativeInt(Data) + Header.StringsOffset)[I - 1]);
end;

function IsMainModuleAddress(const AAddress: Pointer): Boolean;
var
  MBI: TMemoryBasicInformation;
begin
  Result := False;
  if AAddress = nil then
    Exit;

  if VirtualQuery(AAddress, MBI, SizeOf(MBI)) = 0 then
    Exit;

  Result := Integer(MBI.AllocationBase) = GModuleBase;
end;

function GetUnitNameFromPool(const AOffset: Cardinal): string;
var
  P: PAnsiChar;
begin
  Result := '';
  if AOffset >= Cardinal(Length(GStringPool)) then
    Exit;

  P := PAnsiChar(@GStringPool[1]);
  Inc(P, AOffset);
  Result := string(AnsiString(P));
end;

function FindSymbolIndex(const ARVA: Cardinal): Integer;
var
  L, H, M: Integer;
begin
  Result := -1;
  if Length(GSymbols) = 0 then
    Exit;

  L := 0;
  H := High(GSymbols);
  while L <= H do
  begin
    M := (L + H) div 2;
    if GSymbols[M].RVA = ARVA then
      Exit(M)
    else if GSymbols[M].RVA < ARVA then
    begin
      Result := M;
      L := M + 1;
    end
    else
      H := M - 1;
  end;
end;

function ResolveStackAddress(const AAddress: Pointer): string;
var
  RVA: Cardinal;
  Idx: Integer;
  UnitName: string;
begin
  LoadMapSymbols;

  if not IsMainModuleAddress(AAddress) then
  begin
    Result := Format('(dll) %p', [AAddress]);
    Exit;
  end;

  RVA := Cardinal(Integer(AAddress) - GModuleBase);
  Idx := FindSymbolIndex(RVA);
  if Idx < 0 then
  begin
    Result := Format('%p (RVA %s)', [AAddress, IntToHex(RVA, 1)]);
    Exit;
  end;

  UnitName := GetUnitNameFromPool(GSymbols[Idx].UnitNameOffset);
  Result := Format('%s:%d (%p)', [UnitName, GSymbols[Idx].Line, AAddress]);
end;

function ResolveStackFrames(const ARawStack: string): string;
var
  Lines: TStringList;
  I: Integer;
  Line, Token, Prefix: string;
  P, ColonPos: Integer;
  Addr: Pointer;
  AddrValue: Cardinal;
begin
  Result := '';
  if Trim(ARawStack) = '' then
    Exit;

  Lines := TStringList.Create;
  try
    Lines.Text := ARawStack;
    for I := 0 to Lines.Count - 1 do
    begin
      Line := Trim(Lines[I]);
      if Line = '' then
        Continue;

      if CompareText(Copy(Line, 1, 18), 'Endereco da falha:') = 0 then
      begin
        Token := Trim(Copy(Line, 19, MaxInt));
        if ParseHexAddress(Token, AddrValue) then
        begin
          Addr := Pointer(AddrValue);
          Result := Result + 'Endereco da falha: ' + ResolveStackAddress(Addr) + sLineBreak;
        end
        else
          Result := Result + Line + sLineBreak;
        Continue;
      end;

      P := Pos(']', Line);
      if (P > 0) and (Line[1] = '[') then
      begin
        Token := Trim(Copy(Line, P + 1, MaxInt));
        if ParseHexAddress(Token, AddrValue) then
        begin
          Addr := Pointer(AddrValue);
          Prefix := Trim(Copy(Line, 1, P));
          Result := Result + Prefix + '] ' + ResolveStackAddress(Addr) + sLineBreak;
          Continue;
        end;
      end;

      ColonPos := Pos(':', Line);
      if (CompareText(Copy(Line, 1, 8), 'Endereco') = 0) and (ColonPos > 0) then
      begin
        Token := Trim(Copy(Line, ColonPos + 1, MaxInt));
        if ParseHexAddress(Token, AddrValue) then
        begin
          Addr := Pointer(AddrValue);
          Result := Result + Trim(Copy(Line, 1, ColonPos)) + ' ' +
            ResolveStackAddress(Addr) + sLineBreak;
          Continue;
        end;
      end;

      Result := Result + Line + sLineBreak;
    end;
  finally
    Lines.Free;
  end;
end;

initialization
  LoadMapSymbols;

end.
