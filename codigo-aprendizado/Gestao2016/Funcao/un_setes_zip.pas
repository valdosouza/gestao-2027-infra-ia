unit un_setes_zip;

interface

uses     System.SysUtils, System.Classes, System.Zip, Gauges, Vcl.Forms, Vcl.StdCtrls;

type

  TSetesZip = class(TZipFile)
  private
    FZIP : TZipFile;
    FFileList : TStringList;
    FProgresso: TGauge;
    FFileProcessando: TLabel;
    function TemAtributo(Attr, Val: Integer): Boolean;
    procedure getFileList(PPath: string; Sub:Boolean);
    procedure SetFProgresso(const Value: TGauge);
    function GetFileSize(const FileName: string): Integer;
    procedure OnProgress(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
    procedure setFFileProcessando(const Value: TLabel);
  public
    constructor Create;
    destructor Destroy;
    function ZipArquivo(PPath, POrigFile, PZipFile: string): boolean;
    function ZipDirectorio(PPath,PZipDirectory,PZipFile: string): boolean;
    function UnZipArquivo(PPath,PZipFile: string): boolean;
    property Progresso : TGauge read FProgresso write SetFProgresso;
    property FileProcessando : TLabel read FFileProcessando write setFFileProcessando;
  end;

implementation


{ TSetesZip }

constructor TSetesZip.create;
begin
  inherited;
  FFileList := TStringList.Create;
  FZIP := TZipFile.Create;
  FZIP.OnProgress := onProgress;
end;

destructor TSetesZip.Destroy;
begin
  FreeAndNil(FZIP);
  FreeAndNil(FFileList);
  inherited;
end;

function TSetesZip.ZipDirectorio(PPath,PZipDirectory, PZipFile: string): boolean;
Var
  I:Integer;
begin
  REsult := True;
  FFileList.Clear;
  getFileList(concat(PPath,PZipDirectory), true);
  //FZip.ZipDirectoryContents(PZipFile,PPath,zcDeflate,nil);
  FZip.Open(concat( PPath ,PZipFile ), zmWrite);
  for I := 0 to FFileList.Count -1 do
  Begin
    FProgresso.MaxValue := GetFileSize(FFileList[I]);
    FProgresso.MinValue := 0;
    FProgresso.Progress := 0;
    FFileProcessando.Caption := FFileList[I];
    FFileProcessando.Update;

    FZip.Add(FFileList[I]);
  End;
  FFileProcessando.Caption := 'Processamento finalizado.';
  FFileProcessando.Update;

  FZip.Close;
end;

function TSetesZip.ZipArquivo(PPath, POrigFile, PZipFile: string): boolean;
Var
  Lc_file_zip : String;
begin
  Result := False;
  if FileExists( PPath + POrigFile ) then
  BEgin
    if PZipFile <> '' then
      Lc_file_zip := PZipFile
    else
      Lc_file_zip := Copy(PZipFile,1,(Length(PZipFile)-4)) + '.zip';

    FProgresso.MaxValue := GetFileSize(concat(PPath, POrigFile));
    FProgresso.MinValue := 0;
    FProgresso.Progress := 0;
    FFileProcessando.Caption := concat(PPath, POrigFile);
    FFileProcessando.Update;
    FZIP.Open(concat(PPath , Lc_file_zip), zmWrite);

    FZIP.Add(concat(PPath, POrigFile));
    FZIP.Close;
    FFileProcessando.Caption := 'Processamento finalizado.';
    FFileProcessando.Update;

    Result := True;
  End;
end;

function TSetesZip.UnZipArquivo(PPath, PZipFile: string): boolean;
begin
  Result := True;
  if fileExists(concat(PPath,PZipFile)) then
    FZip.Open(concat(PPath,PZipFile), zmRead)
  else
  Begin
    raise exception.Create('Não encontrei: ' + PZipFile);
    Result := False;
  End;
  FZip.ExtractAll(PPath);
  FFileProcessando.Caption := 'Processamento finalizado.';
  FFileProcessando.Update;
  FZip.Close;
end;

procedure TSetesZip.getFileList(PPath: string; Sub: Boolean);
var
  F: TSearchRec;
  Ret: Integer;
  TempNome: string;
begin
  Ret := FindFirst( PPath +'\*.*', faAnyFile, F);
  try
    while Ret = 0 do
    begin
      if TemAtributo(F.Attr, faDirectory) then
      begin
        if (F.Name <> '.') And (F.Name <> '..') then
          if Sub = True then
          begin
            TempNome := PPath +'\' + F.Name;
            getFileList(TempNome, True);
          end;
      end
      else
      begin
        FFileList.Add( PPath+'\'+F.Name );
      end;
      Ret := FindNext(F);
    end;
  finally
    begin
    FindClose(F);
    end;
  end;
end;


function TSetesZip.GetFileSize(const FileName: string): Integer;
var
  StreamArchive: TFileStream;
begin
  StreamArchive := TFileStream.Create(FileName, fmOpenRead);
  try
    Result := StreamArchive.Size;
  finally
    StreamArchive.Free;
  end;
end;


procedure TSetesZip.onProgress(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
begin
  FProgresso.Progress := Position;
  FProgresso.Update;
end;




procedure TSetesZip.setFFileProcessando(const Value: TLabel);
begin
  FFileProcessando := Value;
end;

procedure TSetesZip.SetFProgresso(const Value: TGauge);
begin
  FProgresso := Value;
end;

function TSetesZip.TemAtributo(Attr, Val: Integer): Boolean;
begin
  Result := Attr and Val = Val;
end;

end.
