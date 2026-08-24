unit base_download;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.StdCtrls, Vcl.Samples.Gauges, IdComponent, IdBaseComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Menus, Vcl.ComCtrls, IdAntiFreezeBase, Vcl.IdAntiFreeze, ACBrBase, ACBrDownload, blcksock, ACBrDownloadClass, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, un_setes_zip;

type
  TBaseDonwload = class(TFr_Base)
    Lb_Process: TLabel;
    btn_process: TButton;
    Btn_Fechar: TButton;
    GG_Progresso: TGauge;
    http_down: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    procedure btn_processClick(Sender: TObject);
    procedure Btn_FecharClick(Sender: TObject);
    procedure http_downWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure http_downWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure http_downWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  private
    ZipSetes : TSetesZip;
    FFileNameZip: STring;
    FUrl: String;

    function Baixar():boolean;Virtual;
    procedure setFFileNameZip(const Value: STring);
    procedure setFUrl(const Value: String);
  protected
    procedure IniciaVariaveis;override;
    procedure FinalizaVariaveis;override;

  public
    { Public declarations }
    property FileNameZip : STring read FFileNameZip write setFFileNameZip;
    property URL : String read FUrl write setFUrl;
  end;

var
  BaseDonwload: TBaseDonwload;

implementation

{$R *.dfm}

uses     UN_Sistema, Un_Msg, env;

procedure TBaseDonwload.Btn_FecharClick(Sender: TObject);
begin
  Close;
end;

procedure TBaseDonwload.btn_processClick(Sender: TObject);
begin
  try
    DeletaIECache;
    Baixar();
    ZipSetes.unZipArquivo(GbPathExe,FFileNameZip);
  Except

  end;
end;

procedure TBaseDonwload.FinalizaVariaveis;
begin
  FreeAndNil(ZipSetes);
  inherited;

end;

procedure TBaseDonwload.http_downWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  GG_Progresso.Progress := AWorkCount;
  Application.ProcessMessages;
end;

procedure TBaseDonwload.http_downWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  GG_Progresso.Progress := 0;
  GG_Progresso.MaxValue := AWorkCountMax;
end;

procedure TBaseDonwload.http_downWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  GG_Progresso.Progress := GG_Progresso.MaxValue;
end;

procedure TBaseDonwload.IniciaVariaveis;
begin
  inherited;
  ZipSetes := TSetesZip.create;
  ZipSetes.Progresso := GG_Progresso;
  ZipSetes.FileProcessando := Lb_Process;
end;

procedure TBaseDonwload.setFFileNameZip(const Value: STring);
begin
  FFileNameZip := Value;
end;

procedure TBaseDonwload.setFUrl(const Value: String);
begin
  FUrl := Value;
end;

function TBaseDonwload.Baixar():boolean;
Var
  Lc_DwnFile: TFileStream;
Begin
  Lb_Process.Caption := '  Baixando o progama';
  Lc_DwnFile := TFileStream.Create(GbPathExe + FFileNameZip , fmCreate); // local no hd e nome do arquivo com a extensão, onde vai salvar.
  Application.ProcessMessages;
  try
    try
      http_down.Get(FURL + FFileNameZip, Lc_DwnFile); // fazendo o download do arquivo
      Result := True;
    except
      REsult := False;
    end;
  finally
    FreeAndNil(Lc_DwnFile);
  end;
end;


end.
