unit CnXlsWriter;

interface

uses
      Classes, Variants, Sysutils, ComObj{$IFDEF COMPILER6_UP}, Variants{$ENDIF}, Data.DB, DBCtrls, Forms, Controls, STQuery, ExtCtrls, StdCtrls, Mask, Windows, Messages, Graphics, Dialogs, ComCtrls, Buttons, StrUtils;

type
  TCnXlsWriter = class(TObject)
  private
    FStream: TFileStream;
  protected
    procedure XlsBeginStream( const BuildNumber: Word);

  public
    constructor Create(fileName:String);
    destructor  Destroy; override;
    procedure XlsEndStream;

    procedure XlsWriteCellRk(const ACol: Byte; const ARow: Word;
      const AValue: Integer);
    procedure XlsWriteCellNumber(const ACol: Byte; const ARow: Word;
      const AValue: Double);
    procedure XlsWriteCellLabel(const ACol: Byte; const ARow: Word;
      const AValue: AnsiString);
    procedure XlsWriteCellBlank(const ACol: Byte; const ARow: Word);





  end;

implementation

var
  CXlsBof: array[0..5] of Word = ($809, 8, 00, $10, 0, 0);
  CXlsEof: array[0..1] of Word = ($0A, 00);
  CXlsLabel: array[0..5] of Word = ($204, 0, 0, 0, 0, 0);
  CXlsNumber: array[0..4] of Word = ($203, 14, 0, 0, 0);
  CXlsRk: array[0..4] of Word = ($27E, 10, 0, 0, 0);
  CXlsBlank: array[0..4] of Word = ($201, 6, 0, 0, $17);

procedure TCnXlsWriter.XlsBeginStream(const BuildNumber: Word);
begin
  CXlsBof[4] := BuildNumber;
  Self.FStream.WriteBuffer(CXlsBof, SizeOf(CXlsBof));
end;

procedure TCnXlsWriter.XlsEndStream;
begin
  Fstream.WriteBuffer(CXlsEof, SizeOf(CXlsEof));
end;

procedure TCnXlsWriter.XlsWriteCellRk(const ACol: Byte; const ARow: Word;
  const AValue: Integer);
var
  V: Integer;
begin
  CXlsRk[2] := ARow;
  CXlsRk[3] := ACol;
  Self.FStream.WriteBuffer(CXlsRk, SizeOf(CXlsRk));
  V := (AValue shl 2) or 2;
  Self.FStream.WriteBuffer(V, 4);
end;

procedure TCnXlsWriter.XlsWriteCellNumber(const ACol: Byte; const ARow: Word;
  const AValue: Double);
begin
  CXlsNumber[2] := ARow;
  CXlsNumber[3] := ACol;
  Self.FStream.WriteBuffer(CXlsNumber, SizeOf(CXlsNumber));
  Self.FStream.WriteBuffer(AValue, 8);
end;

procedure TCnXlsWriter.XlsWriteCellLabel(const ACol: Byte; const ARow: Word;
  const AValue: AnsiString);
var
  L: Word;
begin
  L := Length(AValue);
  CXlsLabel[1] := 8 + L;
  CXlsLabel[2] := ARow;
  CXlsLabel[3] := ACol;
  CXlsLabel[5] := L;
  Self.FStream.WriteBuffer(CXlsLabel, SizeOf(CXlsLabel));
  Self.FStream.WriteBuffer(Pointer(AValue)^, L);
end;


procedure TCnXlsWriter.XlsWriteCellBlank(const ACol: Byte;
const ARow: Word);
begin
  CXlsBlank[2] := ARow;
  CXlsBlank[3] := ACol;
  Self.FStream.WriteBuffer(CXlsBlank, SizeOf(CXlsBlank));
end;

constructor TCnXlsWriter.Create(fileName:String);
begin
  inherited Create;
  FStream := TFileStream.Create(fileName, fmCreate);
  FStream.Size := 0;
  XlsBeginStream(0);
end;

destructor TCnXlsWriter.Destroy;
begin
  FreeAndNil(FStream);
  inherited Destroy;
end;



end.
