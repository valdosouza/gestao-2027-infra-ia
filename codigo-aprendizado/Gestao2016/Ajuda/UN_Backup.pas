unit UN_Backup;

interface

uses
      STQuery, Data.DB, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes, Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages, Winapi.Windows, Vcl.Dialogs, Registry, un_setes_zip, Vcl.Samples.Gauges;


type
  tProcCallBack = procedure( pr_msg: string ) of object;

type
  TFr_Backup = class(TForm)
    SaveDialogo: TSaveDialog;
    OpenDialogo: TOpenDialog;
    Pg_Backup: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    ImgBkp: TImage;
    Label1: TLabel;
    RE_Status: TRichEdit;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    SB_Voltar: TSpeedButton;
    SB_Aplicar: TSpeedButton;
    Label8: TLabel;
    pnl_botoes: TPanel;
    Sb_Sair: TSpeedButton;
    SB_Restaurar: TSpeedButton;
    Sb_Copiar: TSpeedButton;
    Sb_Configurar: TSpeedButton;
    ChBx_Bkp: TCheckBox;
    ChBx_Reparar: TCheckBox;
    Panel3: TPanel;
    Label9: TLabel;
    E_Path_BD_Origem: TEdit;
    SpeedButton1: TSpeedButton;
    Panel4: TPanel;
    E_Armazena_destino: TEdit;
    Sb_Logotipo: TSpeedButton;
    Panel5: TPanel;
    Lb_Processamento: TLabel;
    Gg_Progresso: TGauge;
    procedure FormCreate(Sender: TObject);
    procedure Sb_CopiarClick(Sender: TObject);
    procedure Sb_SairClick(Sender: TObject);
    procedure SB_RestaurarClick(Sender: TObject);
    procedure Sb_ConfigurarClick(Sender: TObject);
    procedure SB_VoltarClick(Sender: TObject);
    procedure SB_AplicarClick(Sender: TObject);
    procedure Sb_LogotipoClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    It_FileName_Bkp : String;
    It_FileName_Zip : String;
    ZipSetes : TSetesZip;
  public
    { Public declarations }
    It_Autoexec:Boolean;
    AutoBAckup : Boolean;
    function validaBAckup:Boolean;
    procedure Pc_Reparar;
    function  Pc_Backup:Boolean;
    procedure Pc_Restaurar;
    function Pc_Compactar(Pc_Path, Pc_Aq_Orig,Pc_Aq_Zip : String):Boolean;
    procedure Pc_Descompactar;
    procedure Save;
    procedure ShowData;
    procedure Pc_SelecionaArquivo;
    Procedure xWinExec( cmd,prm:string );
    procedure CaptureConsoleOutput(const ACommand, AParameters: String; CallBack: tProcCallBack);
    procedure AddStatusLine(S: string; Cor: TColor);
    procedure MmCallBack(msg: string);

  end;

var
  Fr_Backup: TFr_Backup;

const
     ctt_usr = 'SYSDBA';
     ctt_pass = 'masterkey';

implementation

Uses     Un_Principal, env, UN_MSG, Un_DM, UN_Sistema;

{$R *.DFM}

function ReplaceTextAll( pr_text,pr_txtbusca,pr_txtsubstituto: string): string;
{ DRY }
begin
     result := stringreplace(pr_text,pr_txtbusca,pr_txtsubstituto,[rfReplaceAll]);
end;

function strzero(Num : Real ; Zeros: integer): string;
var tam,z : integer;
    res,zer : string;
    lc_negativo : boolean;
begin
   //verifica se o numero é negativo
   Lc_Negativo := False;
   if Num < 0 then
   begin
      Lc_Negativo := True;
      Num := Num * -1;
   end;
   Str(Num:Zeros, res);
   res := Trim(res);
   tam := Length(res);
   zer := '';
   for z := 1 to (Zeros-tam) do
   begin
      //se for numero negativo coloca sinha negativo
      If (Lc_Negativo) and (z = (Zeros-tam)) then
         zer := '-' + zer
      else
         zer := zer + '0';
   end;
   Result := zer+res;
end;
{Fim de StrZero}

Function BarraInvert(pr_value:string):string;
{ DRY }
begin
  if (pr_value[length(pr_value)]<>'\') then
    result := pr_value + '\'
  else
    result := pr_value;
end;

procedure GeraException(msgerro: string);
{ exceção }
begin
  if trim(msgerro)<>'' then
  begin
    try
      ShowMessage( 'Erro: ' + msgerro);
      abort;
    except
      raise;
    end;
  end;
end;

function ReplaceCommaTextAll ( pr_text,pr_TxtBuscaCommaText,pr_txtsubstituto: string): string;
{ DRY }
var lc_lst: tStringList;
    lc_x: integer;
    lc_rs: string;
begin
     lc_lst:=tStringList.Create;
     lc_rs:=pr_text;
     try
        lc_lst.Delimiter:=',';
        lc_lst.DelimitedText:=pr_TxtBuscaCommaText;
        for lc_x := 0 to lc_lst.count-1 do
            lc_rs := ReplaceTextAll( lc_rs, lc_lst[lc_x],pr_txtsubstituto );
     finally
            lc_lst.clear;
            freeandnil(lc_lst);
     end;
     result := lc_rs;
end;


procedure TFr_Backup.Pc_SelecionaArquivo;
var
  Lc_Date : String;
begin
  Lc_Date := DateTimeToStr(Now);
  Lc_Date := StringReplace(Lc_Date, '/', '-', [rfReplaceAll, rfIgnoreCase]);
  Lc_Date := StringReplace(Lc_Date, ' ', '_', [rfReplaceAll, rfIgnoreCase]);
  Lc_Date := StringReplace(Lc_Date, ':', '-', [rfReplaceAll, rfIgnoreCase]);
  It_FileName_Bkp := 'bKP' + Lc_Date +'.FBK';
  It_FileName_Zip := 'bKP' + Lc_Date +'.zip';
end;

function  TFr_Backup.Pc_Compactar(Pc_Path, Pc_Aq_Orig,Pc_Aq_Zip : String):Boolean;
begin
  Result := False;
  //Apaga Arquivo Compactado anteriormente
  if FileExists(Pc_Path + Pc_Aq_Zip) then
  begin
    DeleteFile(pchar(Pc_Path + Pc_Aq_Zip));
  end;

  //Adiciona e compacta o arquivo

  if FileExists( Pc_Path + Pc_Aq_Orig ) then
  BEgin
    ZipSetes.ZipArquivo( Pc_Path,Pc_Aq_Orig,Pc_Aq_Zip);

    //Apaga o Backup normal
    if FileExists(Pc_Path + Pc_Aq_Orig) then
    begin
      DeleteFile(Pchar(Pc_Path + Pc_Aq_Orig));
    end;
    Result := True;
  End
  else
  Begin
    AddStatusLine('Arquivo para compactação não encontrado.',clBlack);
    AddStatusLine('',clRed);
  end;
end;

procedure TFr_Backup.Pc_Descompactar;
var
  Lc_Path : String;
begin
  if OpenDialogo.Execute then
  Begin
    Lc_Path := ExtractFilePath(OpenDialogo.FileName);
    It_FileName_Zip := ExtractFileName(OpenDialogo.FileName);
    It_FileName_Bkp := copy(It_FileName_Zip,1,Length(It_FileName_Zip) - 3) + 'FBK';

    AddStatusLine('Extraindo Arquivo',clBlack);
    ZipSetes.UnZipArquivo(Lc_PAth,It_FileName_Zip);

    AddStatusLine( ' Arquivo Extraido',clBlack );

  End;
end;

procedure TFr_Backup.MmCallBack(msg: string);
begin
  AddStatusLine( ReplaceCommaTextAll(msg,ctt_usr+','+ctt_pass,'***'),clBlack );
end;

Procedure TFr_Backup.xWinExec( cmd,prm:string );
var cmdline: string;
begin
  cmdline := ''+cmd+' '+prm;
  // showmessage( cmdline );
  mmcallback( cmdline );
  AddStatusLine( '',clBlack );
  CaptureConsoleOutput( 'cmd /A /C',cmdline , mmcallback );
end;

function GetRegistryValue(const AKey, AValue: String): String;
var
  Reg: TRegistry;
  oGuid: TGUID;
  sGuid: String;
begin
  Result := '';
  // Attempt to retrieve the real key
  Reg := TRegistry.Create(KEY_READ OR KEY_WOW64_64KEY);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKeyReadOnly('SOFTWARE\Firebird Project\Firebird Server\Instances') and Reg.ValueExists('DefaultInstance') then
      Result := Reg.ReadString('DefaultInstance');
    Reg.CloseKey;
  finally
    FreeAndNil(Reg);
  end;
  // If retrieval fails, look for the surrogate
  if Result = '' then begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('SOFTWARE\Firebird Project\Firebird Server\Instances', True) then begin
        if Reg.ValueExists('DefaultInstance') then
          Result := Reg.ReadString('DefaultInstance')
        else begin
          // If the surrogate doesn't exist, create it
          if CreateGUID(oGUID) = 0 then begin
            sGuid := Lowercase(GUIDToString(oGUID));
            Reg.WriteString('DefaultInstance', Copy(sGuid, 2, Length(sGUID) - 2));
            Result := Reg.ReadString('DefaultInstance');
          end;
        end;
      end;
      Reg.CloseKey;
    finally
      FreeAndNil(Reg);
    end;
  end;
  if Result = '' then
    raise Exception.Create('Unable to access registry value in GetComputerGUID');
end;

procedure TFr_Backup.CaptureConsoleOutput(const ACommand, AParameters: String; CallBack: tProcCallBack);
const
     CReadBuffer = 2400;
var
   saSecurity: TSecurityAttributes;
   hRead : THandle;
   hWrite : THandle;
   suiStartup: TStartupInfo;
   piProcess : TProcessInformation;
   pBuffer : array [0 .. CReadBuffer] of AnsiChar;
   dBuffer : array [0 .. CReadBuffer] of AnsiChar;
   dRead : DWORD;
   dRunning : DWORD;
   dAvailable: DWORD;
begin
     saSecurity.nLength := SizeOf(TSecurityAttributes);
     saSecurity.bInheritHandle := true;
     saSecurity.lpSecurityDescriptor := nil;
     if CreatePipe(hRead, hWrite, @saSecurity, 0) then
     try
        FillChar(suiStartup, SizeOf(TStartupInfo), #0);
        suiStartup.cb := SizeOf(TStartupInfo);
        suiStartup.hStdInput := hRead;
        suiStartup.hStdOutput := hWrite;
        suiStartup.hStdError := hWrite;
        suiStartup.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
        suiStartup.wShowWindow := SW_HIDE;
        if CreateProcess(nil, PChar(ACommand + ' ' + AParameters), @saSecurity, @saSecurity, true, NORMAL_PRIORITY_CLASS,nil, nil, suiStartup, piProcess) then
        try
           repeat
                 dRunning := WaitForSingleObject(piProcess.hProcess, 100);
                 PeekNamedPipe(hRead, nil, 0, nil, @dAvailable, nil);
                 if (dAvailable > 0) then
                 repeat
                       dRead := 0;
                       ReadFile(hRead, pBuffer[0], CReadBuffer, dRead, nil);
                       pBuffer[dRead] := #0;
                       OemToCharA(pBuffer, dBuffer);
                       CallBack(String(dBuffer));
                 until (dRead < CReadBuffer);
                 Application.ProcessMessages;
           until (dRunning <> WAIT_TIMEOUT);
        Finally
               CloseHandle(piProcess.hProcess);
               CloseHandle(piProcess.hThread);
        end;
     Finally
            CloseHandle(hRead);
            CloseHandle(hWrite);
     end;
end;

procedure TFr_Backup.Pc_Reparar;
var
  Lc_DB,  lc_path_firebird: string;
  ///
  Procedure gFix;
  begin
    xWinExec ( BarraInvert(lc_path_firebird)+'bin\gfix.exe',' -v -f "'+lc_DB+'" -user '+ctt_usr+' -pass '+ctt_pass );
    xWinExec ( BarraInvert(lc_path_firebird)+'bin\gfix.exe',' -m -i "'+lc_DB+'" -user '+ctt_usr+' -pass '+ctt_pass );
  end;
begin
  Try
    AddStatusLine('Desconectando o Banco de dados',clGreen);
    if DM.IBD_Gestao.Connected then DM.IBD_Gestao.Connected:= False;

    AddStatusLine('Verifica se o PC é o Servidor',clGreen);
    //1-caminho fb
    lc_path_firebird:=ExtractShortPathName(GetRegistryValue( 'SOFTWARE\Firebird Project\Firebird Server\Instances',  'DefaultInstance')) ;
    if lc_path_firebird='' then
      GeraException ('Não é o servidor. Nada a reparar!');

    //2-DB
    AddStatusLine('Desconecta o banco de dados',clGreen);
    lc_DB := Fc_Aq_Geral('L','BACKUP','DATABASE','');
    xWinExec ( BarraInvert(lc_path_firebird)+'bin\instsvc.exe',' start' );
    xWinExec ( BarraInvert(lc_path_firebird)+'bin\gfix.exe',' -online "'+lc_DB+'" -user '+ctt_usr+' -pass '+ctt_pass );
    xWinExec ( BarraInvert(lc_path_firebird)+'bin\gfix.exe',' -shut single -force 15 "'+lc_DB+'" -user '+ctt_usr+' -pass '+ctt_pass );

    // 3 - gFix
    AddStatusLine('Efetua possíveis correções',clGreen);
    gFix;
  finally
    AddStatusLine('================= Reparação Finalizado ===============',clGreen);
    if not DM.IBD_Gestao.Connected then DM.IBD_Gestao.Connected:=True;
    Application.ProcessMessages;
    Cursor:=crDefault;
  end;
end;


function TFr_Backup.Pc_Backup:Boolean;
var
  Lc_DB,  lc_path_firebird,  lc_bak: string;
  procedure gBak;
  begin
    xWinExec ( BarraInvert(lc_path_firebird)+'bin\gbak.exe',' -g -b -z -l -v "'+lc_DB+'" "'+lc_bak+'" -user '+ctt_usr+' -pass '+ctt_pass );
   end;
begin
  Try
    Try
      REsult := True;
      AddStatusLine('Desconectando o Banco de dados',clGreen);
      if DM.IBD_Gestao.Connected then DM.IBD_Gestao.Connected:= False;

      AddStatusLine('Verifica se o PC é o Servidor',clGreen);
      //1-caminho fb
      lc_path_firebird:=ExtractShortPathName(GetRegistryValue( 'SOFTWARE\Firebird Project\Firebird Server\Instances',  'DefaultInstance')) ;
      if lc_path_firebird='' then
        GeraException ('Não é o servidor. Não é possível efetuar backup!')
      else
      lc_path_firebird := stringreplace(lc_path_firebird, 'Program Files', '"Program Files"',[rfReplaceAll, rfIgnoreCase]);

      // 2 - gbak
      AddStatusLine('Efetuando o backup',clGreen);
      lc_DB := Fc_Aq_Geral('L','BACKUP','DATABASE','');
      lc_bak := Fc_Aq_Geral('L','BACKUP','ARMAZENA','') + It_FileName_Bkp;
      gBak;
    except
      REsult := FAlse
    end;
  finally
    if REsult then
      AddStatusLine('=========== Backup Finalizado com SUCESSO =========',clGreen)
    else
      AddStatusLine('======== Backup Finalizado com PROBLEMAS ==========',clRed);
    if not DM.IBD_Gestao.Connected then DM.IBD_Gestao.Connected:=True;
    Application.ProcessMessages;
    Cursor:=crDefault;
  end;
end;


procedure TFr_Backup.Pc_Restaurar;
var
  Lc_DB, lc_path_firebird,  lc_bak: string;
  procedure gBak;
  begin
    xWinExec ( BarraInvert(lc_path_firebird)+'bin\gbak.exe',' -g -c -z -v -REP "'+lc_bak+'" "'+lc_DB+'" -user '+ctt_usr+' -pass '+ctt_pass );
//    xWinExec ( BarraInvert(lc_path_firebird)+'bin\gbak.exe',' -r -p 4096 -o "'+lc_bak+'" "'+lc_DB+'" -user '+ctt_usr+' -pass '+ctt_pass );

  end;
Begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     '      Confirma a Restauração dos Arquivos '+EOLN+
                     'sob pena de todos os dados atuais serem perdidos?'+EOLN+EOLN+
                     'Confirmar a restauração ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    if DM.IBD_Gestao.Connected then DM.IBD_Gestao.Connected:=False;
    lc_bak := It_FileName_Bkp;
    Lc_DB := DM.IBD_Gestao.DatabaseName;
    AddStatusLine('Verifica se o PC é o Servidor',clGreen);
    //1-caminho fb
    lc_path_firebird:=ExtractShortPathName(GetRegistryValue( 'SOFTWARE\Firebird Project\Firebird Server\Instances',  'DefaultInstance')) ;
    if lc_path_firebird='' then
      GeraException ('Não é o servidor. Não é possível reparar o banco de dados!');

    //2-Pára o servidor para derrubar os terminais
    AddStatusLine('Parando o Serviço do Firebird...',clGreen);
    xWinExec ( BarraInvert(lc_path_firebird)+'bin\instsvc.exe',' stop' );
    AddStatusLine('Serviço Firebird parado',clGreen);
    //3-Reinicia o Servidor
    AddStatusLine('Reiniciando o Serviço do Firebird...',clGreen);
    xWinExec ( BarraInvert(lc_path_firebird)+'bin\instsvc.exe',' start' );
    AddStatusLine('Serviço Firebird Rodando...',clGreen);
    //4-gbak
    AddStatusLine('Efetuando a restauração',clGreen);
    if DM.IBD_Gestao.Connected then DM.IBD_Gestao.Connected := False;
    gBak;
    AddStatusLine('Restauração Efetuda com Sucesso',clGreen);
    Application.ProcessMessages;
    AddStatusLine('Reconectando o banco de dados',clGreen);
    Application.ProcessMessages;
    if not DM.IBD_Gestao.Connected then DM.IBD_Gestao.Connected:=True;
  end;
end;

procedure TFr_Backup.FormActivate(Sender: TObject);
begin
  if AutoBAckup then
  BEgin
    Sb_CopiarClick(Self);
  End;
end;

procedure TFr_Backup.FormCreate(Sender: TObject);
Var
 LC_I : Integer;
begin
  AutoBAckup := False;
  Height:= 426 - 15;
  For LC_I:=1 to Pg_Backup.PageCount do Pg_Backup.Pages[LC_I-1].TabVisible:=False;
  RE_Status.Clear;
  Pg_Backup.ActivePageIndex:=0;
  ZipSetes := TSetesZip.create;
  ZipSetes.Progresso := GG_progresso;
  ZipSetes.FileProcessando := Lb_Processamento;
end;

procedure TFr_Backup.AddStatusLine(S: string; Cor: TColor);
begin
  RE_Status.SelAttributes.Color := Cor;
  RE_Status.Lines.Add(S);
  RE_Status.SetFocus;
  RE_Status.SelStart := RE_Status.GetTextLen;
  RE_Status.Perform(EM_SCROLLCARET, 0, 0);
  Application.ProcessMessages;
end;

procedure TFr_Backup.Sb_CopiarClick(Sender: TObject);
Var
  LcResult : Boolean;
begin
  if validaBAckup then
  Begin
    TRY
      Fr_Principal.Tm_Agenda.Enabled := False;
      AddStatusLine('Definindo nome dos arquivos',clGreen);
      Pc_SelecionaArquivo;
      if ChBx_Reparar.Checked then
        Pc_Reparar;
      LcResult := Pc_Backup;
      if LcResult then
        LcResult := Pc_Compactar(Fc_Aq_Geral('L','BACKUP','ARMAZENA',''), It_FileName_Bkp, It_FileName_Zip);
      if LcResult then
      Begin
        MensagemPadrao('Informação',ATENCAO+EOLN+EOLN+
                       'Cópia realizada com sucesso!!!'+EOLN,
                       ['Fechar'],[bNormal],mpInformacao);
        Fr_Principal.Tm_Agenda.Enabled := True;
      End;
    except
      AddStatusLine('Arquivo contem erros. Refaça a Cópia.',clRed);
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Houve erro no Gerar a Cópia de Segurança.'+EOLN+
                     'Entre em Contato com o Suporte Técnico.'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Fr_Principal.Tm_Agenda.Enabled := True;
    end;
  End;
  if AutoBAckup then
  Begin

    Self.Close;
  End;
end;

procedure TFr_Backup.Sb_SairClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_Backup.SB_RestaurarClick(Sender: TObject);
begin
  TRY
    Fr_Principal.Tm_Agenda.Enabled := False;
    Pc_SelecionaArquivo;
    Pc_Descompactar;
    Pc_Restaurar;
    MensagemPadrao('Informação',ATENCAO+EOLN+EOLN+
                   'Restauração realizada com sucesso!!!'+EOLN,
                   ['Fechar'],[bNormal],mpInformacao);
    Fr_Principal.Tm_Agenda.Enabled := True;
  except
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Houve erro ao tentar restauraar o Backup.'+EOLN+
                   'Entre em Contato com o Suporte Técnico.'+EOLN,
                   ['OK'],[bEscape],mpErro);
    Fr_Principal.Tm_Agenda.Enabled := True;
  end;
end;

procedure TFr_Backup.Sb_ConfigurarClick(Sender: TObject);
begin
  Pg_Backup.ActivePageIndex := 1;
end;

procedure TFr_Backup.SB_VoltarClick(Sender: TObject);
begin
  Pg_Backup.ActivePageIndex := 0;
end;

procedure TFr_Backup.ShowData;
begin
  // Abre arquivo de configuracao
  ChBx_Bkp.Checked := ( Fc_Aq_Geral('L','BACKUP','BACKUP','S') = 'S' );

  E_Armazena_destino.Text := Fc_Aq_Geral('L','BACKUP','ARMAZENA','');

  E_Path_BD_Origem.Text := Fc_Aq_Geral('L','BACKUP','DATABASE','');

end;

procedure TFr_Backup.Save;
begin
  // Abre arquivo de configuracao
  if  ChBx_Bkp.Checked then
    Fc_Aq_Geral('G','BACKUP','BACKUP','S')
  else
    Fc_Aq_Geral('G','BACKUP','BACKUP','N');

  Fc_Aq_Geral('G','BACKUP','ARMAZENA',E_Armazena_destino.Text);

  Fc_Aq_Geral('G','BACKUP','DATABASE',E_Path_BD_Origem.Text);
end;

procedure TFr_Backup.SB_AplicarClick(Sender: TObject);
begin
  Save;
end;

procedure TFr_Backup.Sb_LogotipoClick(Sender: TObject);
begin
  if OpenDialogo.Execute then
    E_Armazena_destino.Text := OpenDialogo.FileName
end;

procedure TFr_Backup.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialogo.Execute then
    E_Path_BD_Origem.Text := OpenDialogo.FileName
end;

function TFr_Backup.validaBAckup: Boolean;
begin
  Result := True;
  if not FileExists( E_Path_BD_Origem.Text) then
  Begin
    MensagemPadrao(ATENCAO,
                   'Por favor informe o local onde está o banco de dados.'+EOLN,
                   ['OK'],[bNormal],mpInformacao);
    REsult := False;
    Exit;
  End;
  if E_Armazena_destino.Text = '' then
  Begin
    MensagemPadrao(ATENCAO,
                   'Por favor informe onde será gravado o backup.'+EOLN,
                   ['Fechar'],[bNormal],mpInformacao);
    REsult := False;
    Exit;
  End;

end;

procedure TFr_Backup.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
   VK_F2 : Sb_CopiarClick(Sender);
   VK_F3  : SB_RestaurarClick(Sender);
   VK_F4  : Sb_ConfigurarClick(Sender);
   VK_Escape : Sb_SairClick(Sender);
   end;
end;



procedure TFr_Backup.FormShow(Sender: TObject);
begin
  ShowData;



end;

end.
