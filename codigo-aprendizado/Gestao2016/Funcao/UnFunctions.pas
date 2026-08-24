unit UnFunctions;

interface

uses
       Windows, SysUtils, Classes, DB, STDatabase, STQuery, forms, dialogs, Graphics, pngimage, Vcl.ExtCtrls, Vcl.Imaging.jpeg, System.ZLib;
   //Un_JPEGImageExt;

    procedure ApagaArquivosTemp;
    function CriaArquivoBmp:String;
    function CriaArquivoJPG:String;
    function  Fc_CapturaTela: TBitmap;
    function CompressString(const InputString: string): string;
  implementation

uses     env;

procedure ApagaArquivosTemp;
Var
  caminho : string;
  SR: TSearchRec;
  I: integer;
begin
  caminho := GbPathexe + 'temp\*.*';
  I := FindFirst(caminho, faAnyFile, SR);
  while I = 0 do
  begin
    if (SR.Attr and faDirectory) <> faDirectory then
    begin
      caminho:= GbPathexe + 'temp\'  + SR.Name;
      DeleteFile(PwideChar(caminho));
    end;
    I := FindNext(SR);
  end;
end;


function CriaArquivoBmp:String;
Var
  lc_Imagem :TImage;
  LcArquivo : String;
Begin
  lc_Imagem := TImage.Create(nil);
  try
    LcArquivo := IntToStr(Round(random(99999)));
    lc_Imagem.Picture.Bitmap.Handle := TBitmap(Fc_CapturaTela).Handle;
    IF not (DirectoryExists(GbPathexe+'temp\')) then ForceDirectories(GbPathexe+'temp\');
    Result := concat(GbPathexe , 'temp\' , LcArquivo  ,'.bmp');
    lc_Imagem.Picture.SaveToFile(Result);
  finally
    FreeAndNil(lc_Imagem);
  end;
end;

function CriaArquivoJPG:String;
var
  MyJPEG : TJPEGImage;
  LcArquivo : String;
begin
  MyJPEG := TJPEGImage.Create;
  try
    LcArquivo := IntToStr(Round(random(99999)));
    MyJPEG.Assign(Fc_CapturaTela);
    IF not (DirectoryExists(GbPathexe+'temp\')) then ForceDirectories(GbPathexe+'temp\');
    Result := concat(GbPathexe , 'temp\' , LcArquivo  ,'.jpg');
    MyJPEG.SaveToFile(Result);
  finally
    FreeAndNil(MyJPEG);
  end;
end;

function  Fc_CapturaTela: TBitmap;
var
  ScreenDC: HDC;
begin
  Result := TBitmap.Create;
  Result.Width := Screen.Width;
  Result.Height := Screen.Height;
  BitBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height, ScreenDC, 0, 0, SRCCOPY); // Copia a tela para o bitmap
  ReleaseDC(0, ScreenDC); // Libera o contexto do dispositivo
end;

function CompressString(const InputString: string): string;
var
  InputBytes, CompressedBytes: TBytes;
  Compressor: TZCompressionStream;
  OutputStream: TStringStream;
begin
  InputBytes := TEncoding.UTF8.GetBytes(InputString);
  OutputStream := TStringStream.Create('');
  try
    Compressor := TZCompressionStream.Create(TCompressionLevel.clDefault, OutputStream);
    try
      Compressor.Write(InputBytes[0], Length(InputBytes));
      Compressor.Free;
      CompressedBytes := OutputStream.Bytes;
      Result := TEncoding.UTF8.GetString(CompressedBytes);
    except
      Compressor.Free;
      raise;
    end;
  finally
    OutputStream.Free;
  end;
end;

end.
