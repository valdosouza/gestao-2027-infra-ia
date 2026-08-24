unit tas_gera_nfe_schemas;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, un_geranfe3X, STDataSet, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Menus, Data.DB, STQuery, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls;

type
  TTasGeraNfeSchemas = class(TFr_GeraNfe3x)
    tbs_Schemas: TTabSheet;
    Panel10: TPanel;
    Label19: TLabel;
    MM_Schema: TMemo;
    Panel11: TPanel;
    Sb_Schema_confirma: TSpeedButton;
    Sb_Schema_Volta: TSpeedButton;
    http_down: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    procedure Sb_Schema_confirmaClick(Sender: TObject);
    procedure Sb_Schema_VoltaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function BaixarArquivo(FileName:string; link:String; DireDest: String):boolean;
    procedure BaixarArquivosSchemas;
  protected

    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
  public
    { Public declarations }
  end;

var
  TasGeraNfeSchemas: TTasGeraNfeSchemas;

implementation

{$R *.dfm}

uses     UN_Principal, env, un_sistema, un_msg;

function TTasGeraNfeSchemas.BaixarArquivo(FileName, link,
  DireDest: String): boolean;
Var
  Lc_DwnFile: TFileStream;
Begin
  try
    try
      Lc_DwnFile := TFileStream.Create(DireDest + FileName , fmCreate); // local no hd e nome do arquivo com a extens�o, onde vai salvar.
      Application.ProcessMessages;
      http_down.Get(link + FileName, Lc_DwnFile); // fazendo o download do arquivo
      Result := True;
    except
      REsult := False;
    end;
  finally
    FreeAndNil(Lc_DwnFile);
  end;
end;

procedure TTasGeraNfeSchemas.BaixarArquivosSchemas;
var
  Lc_files: TStringList;
  Lc_I: Integer;
  Lc_Arquivo: String;
  Lc_FileTxt: TextFile;
  Lc_linha: String;
  LcDirWeb :String;
begin
  // Diretorio
  LcDirWeb := 'Schemas/';
  if not DirectoryExists(GbPathexe + '\Schemas') then
    CreateDir(GbPathexe + '\Schemas');
  DeletaIECache;

  // Baixa o Arquivo com a lista dos Schemas
  MM_Schema.Lines.Add('Recebendo lista de Schemas Atualizados');
  Lc_Arquivo := 'Schemas.txt';
  BaixarArquivo(Lc_Arquivo, 'https://www.setes.com.br/Gestao2016/'+ LcDirWeb, GbPathExe + 'Schemas\');

  AssignFile(Lc_FileTxt, GbPathexe + '\Schemas\Schemas.txt');

  {$I-}         // desativa a diretiva de Input
  Reset(Lc_FileTxt); // abre o arquivo para leitura;

  Lc_files := TStringList.Create;
  While not Eof(Lc_FileTxt) do
  begin
    Readln(Lc_FileTxt, Lc_linha);
    // le do arquivo e desce uma linha. O conte�do lido � transferido para a vari�vel linha
    Lc_files.Add(Lc_linha);
  End;
  Closefile(Lc_FileTxt);
  //  {$I+}         // ativa a diretiva de Input
  MM_Schema.Lines.Clear;
  MM_Schema.Lines.Add('Baixando os Arquivos');
  MM_Schema.Update;
  For Lc_I := 0 to (Lc_files.Count - 1) do
  Begin
    try
      Lc_Arquivo := Lc_files.Strings[Lc_I];
      BaixarArquivo(Lc_Arquivo, 'https://www.setes.com.br/Gestao2016/'+ LcDirWeb, GbPathExe + 'Schemas\');
      MM_Schema.Lines.Add(Lc_Arquivo);
      // local no hd e nome do arquivo com a extens�o, onde vai salvar.
      MM_Schema.Update;
    Except
      MM_Schema.Lines.Add(Lc_Arquivo +
        'está sendo usado e não pode ser baixado...');
    end;
  end;
  MM_Schema.Lines.Add('Atualizção Realizada com sucesso.');

end;

procedure TTasGeraNfeSchemas.CriarVariaveis;
begin
  inherited;
end;

procedure TTasGeraNfeSchemas.FormataTela;
begin
  inherited;
  pg_Principal.ActivePage := tbs_Schemas;
end;

procedure TTasGeraNfeSchemas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F10:
      if Sb_Schema_confirma.Enabled then
        Sb_Schema_confirmaClick(self);
    VK_Escape:
      if Sb_Schema_Volta.Enabled then
        Sb_Schema_VoltaClick(self);
  end;
end;

procedure TTasGeraNfeSchemas.ImagemBotao;
begin
  with Fr_Principal do
  Begin
    CarregaImagemBotao(Sb_Schema_confirma,'CONFIRMAR');
    CarregaImagemBotao(Sb_Schema_Volta,'SAIR');
  End;
end;

procedure TTasGeraNfeSchemas.IniciaVariaveis;
begin
  inherited;
  pg_Principal.ActivePage := tbs_Schemas;
end;

procedure TTasGeraNfeSchemas.Sb_Schema_confirmaClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
    'Deseja baixar os arquivos de Schemas da NF-e?.' + EOLN + EOLN +
    'Confirmar a operção ?', [SIM, NAO], [bNormal, bEscape], mpConfirmacao,
    clBtnFace) = mrBotao1) then
  begin
    BaixarArquivosSchemas;
  end;

end;

procedure TTasGeraNfeSchemas.Sb_Schema_VoltaClick(Sender: TObject);
begin
  Close;
end;

end.
