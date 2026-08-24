unit Un_VehicleCheckList;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, db, pngimage, ExtCtrls, Mask, QEdit_Setes, ControllerBase, DBCtrls, Buttons, STQuery, WinINEt, ExtActns, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, ACBrBase, ACBrDownload, Vcl.ComCtrls, ACBrDownloadClass;

type
  TFr_VehicleCheckList = class(TForm)
    Panel1: TPanel;
    GroupBox1: TPanel;
    carro_10: TImage;
    carro_01: TImage;
    carro_02: TImage;
    carro_03: TImage;
    carro_04: TImage;
    carro_05: TImage;
    carro_12: TImage;
    carro_13: TImage;
    carro_14: TImage;
    carro_15: TImage;
    carro_16: TImage;
    carro_06: TImage;
    carro_07: TImage;
    carro_08: TImage;
    carro_09: TImage;
    carro_17: TImage;
    carro_18: TImage;
    carro_19: TImage;
    carro_20: TImage;
    carro_21: TImage;
    carro_11: TImage;
    carro_22: TImage;
    E_Km: TEdit_Setes;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    RG_PneuDianteiro: TRadioGroup;
    RG_PneuTraseiro: TRadioGroup;
    RG_PneuEstepe: TRadioGroup;
    RG_Combustivel: TRadioGroup;
    GroupBox3: TGroupBox;
    cbx_macaco: TCheckBox;
    cbx_manual: TCheckBox;
    cbx_Extintor: TCheckBox;
    cbx_Radio: TCheckBox;
    cbx_Abs: TCheckBox;
    cbx_DirHidraulica: TCheckBox;
    cbx_Calotas: TCheckBox;
    cbx_ArQuente: TCheckBox;
    cbx_triangulo: TCheckBox;
    cbx_ChaveRoda: TCheckBox;
    cbx_Antena: TCheckBox;
    cbx_AcendCigarro: TCheckBox;
    cbx_ArCondicionado: TCheckBox;
    cbx_outros: TCheckBox;
    cbx_Documentos: TCheckBox;
    cbx_Tapetes: TCheckBox;
    Rg_Valvulas: TRadioGroup;
    Label9: TLabel;
    E_Obs: TMemo;
    Label13: TLabel;
    E_Dt_Entrada: TMaskEdit;
    E_Hr_Entrada: TMaskEdit;
    Panel2: TPanel;
    SB_Gravar: TSpeedButton;
    SB_Cancelar: TSpeedButton;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    SpeedButton1: TSpeedButton;
    E_Nr_Prisma: TEdit_Setes;
    Label11: TLabel;
    fACBrDownload: TACBrDownload;
    procedure carro_01Click(Sender: TObject);
    procedure carro_02Click(Sender: TObject);
    procedure carro_03Click(Sender: TObject);
    procedure carro_04Click(Sender: TObject);
    procedure carro_05Click(Sender: TObject);
    procedure carro_06Click(Sender: TObject);
    procedure carro_07Click(Sender: TObject);
    procedure carro_08Click(Sender: TObject);
    procedure carro_09Click(Sender: TObject);
    procedure carro_10Click(Sender: TObject);
    procedure carro_11Click(Sender: TObject);
    procedure carro_12Click(Sender: TObject);
    procedure carro_13Click(Sender: TObject);
    procedure carro_14Click(Sender: TObject);
    procedure carro_15Click(Sender: TObject);
    procedure carro_16Click(Sender: TObject);
    procedure carro_17Click(Sender: TObject);
    procedure carro_18Click(Sender: TObject);
    procedure carro_19Click(Sender: TObject);
    procedure carro_20Click(Sender: TObject);
    procedure carro_21Click(Sender: TObject);
    procedure carro_22Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SB_GravarClick(Sender: TObject);
    procedure SB_CancelarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
    It_Inserir,It_Alterar,It_Excluir,It_Visualizar:Boolean;
    It_FUEL : String;
    It_ABS : String;
    It_CIGARETTE_LIGHTER : String;
    It_AERIAL : String;
    It_CONDITIONED_AIR : String;
    It_HOT_AIR : String;
    It_HUB_CAPS : String;
    It_WRENCH : String;
    It_HYDRAULIC_STEERING : String;
    It_DOCTS : String;
    It_EXTINGUISHER : String;
    It_HOIST : String;
    It_MANUAL : String;
    It_FRONT_TYRE : String;
    It_STEPE_TYRE : String;
    It_BACK_TYRE : String;
    It_RADIO : String;
    It_CARPET : String;
    It_TRIANGLE : String;
    It_VALVES : String;
    It_OTHER : String;
    function BaixarArquivo(FileName:string; link:String;DireDest: String):boolean;
  public
   { Public declarations }
   It_Budget_id : Integer;
   It_Order_id : Integer;
   procedure Pc_IniciaVariaveis;
   procedure Pc_ImagemBotao;
   procedure Pc_BaixarArquivosChecklist;
   procedure Pc_PermissaoBotao(Pc_Menu: string);
   procedure Pc_SetarImagem(Pc_Imagem:TImage);
   procedure Pc_LoadData;
   procedure Pc_LoadDefault;
   procedure Pc_LoadImagem(Pc_CheckList:String);
   procedure DeletaIECache;
   procedure Pc_TrataDadosParaGravacao;
   procedure Pc_Gravar;
   function Fc_GeraStringChecklist():String;
  end;

var
  Fr_VehicleCheckList: TFr_VehicleCheckList;

implementation

uses     UN_Sistema, Un_Regra_Negocio, RN_VehicleCheckList, Un_DM, UN_Principal, env;
{$R *.dfm}

procedure TFr_VehicleCheckList.Pc_IniciaVariaveis;
Begin
  //Carrega as imagens
  carro_01.Picture := nil;
  carro_02.Picture := nil;
  carro_03.Picture := nil;
  carro_04.Picture := nil;
  carro_05.Picture := nil;
  carro_06.Picture := nil;
  carro_07.Picture := nil;
  carro_08.Picture := nil;
  carro_09.Picture := nil;
  carro_10.Picture := nil;
  carro_11.Picture := nil;
  carro_12.Picture := nil;
  carro_13.Picture := nil;
  carro_14.Picture := nil;
  carro_15.Picture := nil;
  carro_16.Picture := nil;
  carro_17.Picture := nil;
  carro_18.Picture := nil;
  carro_19.Picture := nil;
  carro_20.Picture := nil;
  carro_21.Picture := nil;
  carro_22.Picture := nil;
end;

function  TFr_VehicleCheckList.Fc_GeraStringChecklist():String;
BEgin
    Result := carro_01.Hint +
              carro_02.Hint +
              carro_03.Hint +
              carro_04.Hint +
              carro_05.Hint +
              carro_06.Hint +
              carro_07.Hint +
              carro_08.Hint +
              carro_09.Hint +
              carro_10.Hint +
              carro_11.Hint +
              carro_12.Hint +
              carro_13.Hint +
              carro_14.Hint +
              carro_15.Hint +
              carro_16.Hint +
              carro_17.Hint +
              carro_18.Hint +
              carro_19.Hint +
              carro_20.Hint +
              carro_21.Hint +
              carro_22.Hint;
end;

procedure TFr_VehicleCheckList.Pc_TrataDadosParaGravacao;
Begin
  case RG_PneuDianteiro.ItemIndex of
    0:It_FRONT_TYRE := 'R';
    1:It_FRONT_TYRE := 'B';
    2:It_FRONT_TYRE := 'E';
  end;

  case RG_PneuTraseiro.ItemIndex of
    0:It_BACK_TYRE := 'R';
    1:It_BACK_TYRE := 'B';
    2:It_BACK_TYRE := 'E';
  end;

  case RG_PneuEstepe.ItemIndex of
    0:It_STEPE_TYRE := 'R';
    1:It_STEPE_TYRE := 'B';
    2:It_STEPE_TYRE := 'E';
  end;

  It_FUEL := IntToStr(RG_Combustivel.ItemIndex + 1);
  //Valvulas
  case Rg_Valvulas.ItemIndex of
    0:It_VALVES := '08';
    1:It_VALVES := '16';
    2:It_VALVES := '20';
    3:It_VALVES := '24';
  end;

  if cbx_macaco.Checked then It_HOIST := 'S' else It_HOIST := 'N';
  if cbx_manual.Checked then It_MANUAL := 'S' else It_MANUAL := 'N';
  if cbx_Extintor.Checked then It_EXTINGUISHER := 'S' else It_EXTINGUISHER := 'N';
  if cbx_Radio.Checked then It_RADIO := 'S' else It_RADIO := 'N';
  if cbx_Abs.Checked then It_ABS := 'S' else It_ABS := 'N';
  if cbx_DirHidraulica.Checked then It_HYDRAULIC_STEERING := 'S' else It_HYDRAULIC_STEERING := 'N';
  if cbx_Calotas.Checked then  It_HUB_CAPS := 'S' else It_HUB_CAPS := 'N';
  if cbx_ArQuente.Checked then It_HOT_AIR := 'S' else It_HOT_AIR := 'N';
  if cbx_triangulo.Checked then It_TRIANGLE := 'S' else It_TRIANGLE := 'N';
  if cbx_ChaveRoda.Checked then  It_WRENCH := 'S' else It_WRENCH := 'N';
  if cbx_Antena.Checked then It_AERIAL := 'S' else It_AERIAL := 'N';
  if cbx_AcendCigarro.Checked then It_CIGARETTE_LIGHTER := 'S' else It_CIGARETTE_LIGHTER := 'N';
  if cbx_ArCondicionado.Checked then  It_CONDITIONED_AIR := 'S' else It_CONDITIONED_AIR := 'N';
  if cbx_outros.Checked then It_OTHER := 'S' else It_OTHER := 'N';
  if cbx_Documentos.Checked then It_DOCTS := 'S' else It_DOCTS := 'N';
  if cbx_Tapetes.Checked then It_CARPET := 'S' else It_CARPET := 'N';
end;

procedure TFr_VehicleCheckList.Pc_Gravar;
Begin
  Pc_TrataDadosParaGravacao;
  Fc_UpdateVehicleCheckList(IntToStr(Gb_CodMha),
                            IntToStr(It_Budget_id),
                            IntToStr(It_Order_id),
                            '0',
                            Fc_GeraStringChecklist(),
                            E_Km.Text,
                            It_FUEL,
                            It_ABS,
                            It_CIGARETTE_LIGHTER,
                            It_AERIAL,
                            It_CONDITIONED_AIR,
                            It_HOT_AIR,
                            It_HUB_CAPS,
                            It_WRENCH,
                            It_HYDRAULIC_STEERING,
                            It_DOCTS,
                            It_EXTINGUISHER,
                            It_HOIST,
                            It_MANUAL,
                            It_FRONT_TYRE,
                            It_STEPE_TYRE,
                            It_BACK_TYRE,
                            It_RADIO,
                            It_CARPET,
                            It_TRIANGLE,
                            It_VALVES,
                            It_OTHER,
                            E_Obs.Text,
                            E_Dt_Entrada.Text,
                            E_Hr_Entrada.Text,
                            E_Nr_Prisma.Text);
end;

procedure TFr_VehicleCheckList.Pc_ImagemBotao;
Begin
  with fr_principal do
    Begin
    //Geral;
    SB_Gravar.Glyph.Assign(Fc_CarregaImagemBotao('GRAVAR'));
    SB_Cancelar.Glyph.Assign(Fc_CarregaImagemBotao('CANCELAR'));
    END;
end;

procedure TFr_VehicleCheckList.DeletaIECache;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
begin
  dwEntrySize := 0;
  FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize) ;
  GetMem(lpEntryInfo, dwEntrySize) ;
  if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
  hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize) ;
  if hCacheDir <> 0 then
  begin
    repeat
      DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName) ;
      FreeMem(lpEntryInfo, dwEntrySize) ;
      dwEntrySize := 0;
      FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize) ;
      GetMem(lpEntryInfo, dwEntrySize) ;
      if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
    until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize) ;
  end;
  FreeMem(lpEntryInfo, dwEntrySize) ;
  FindCloseUrlCache(hCacheDir) ;
end;

function TFr_VehicleCheckList.BaixarArquivo(FileName:string; link:String; DireDest: String):boolean;
begin
  Try
    Application.ProcessMessages;
    if FileExists(GbPathExe + Filename) then
      DeleteFile(GbPathExe + Filename);

    fACBrDownload.Protocolo := protHTTP;
    fACBrDownload.DownloadStatus := stNone;
    fACBrDownload.SizeRecvBuffer := 65536;

    fACBrDownload.Proxy.ProxyHost := '';
    fACBrDownload.Proxy.ProxyPort := '';
    fACBrDownload.Proxy.ProxyUser := '';
    fACBrDownload.Proxy.ProxyPass := '';

    fACBrDownload.FTP.FtpHost     := '';
    fACBrDownload.FTP.FtpPort     := '';
    fACBrDownload.FTP.FtpUser     := '';
    fACBrDownload.FTP.FtpPass     := '';

    fACBrDownload.DownloadDest    := DireDest;
    fACBrDownload.DownloadNomeArq := FileName;
    fACBrDownload.DownloadUrl     := concat(link, FileName);
    fACBrDownload.StartDownload;
    Result := True;
  except
    Result := False;
  End;
end;

procedure TFr_VehicleCheckList.Pc_BaixarArquivosChecklist;
var
  Lc_DwnFile: TFileStream;
  Lc_files : TStringList;
  Lc_I: Integer;
  Lc_Arquivo : String;
  Lc_FileTxt:TextFile;
  Lc_linha:String;
begin
  //Diretorio
  if not DirectoryExists(GbPathExe + '\imagem\checklist') then
    ForceDirectories(GbPathExe + '\imagem\checklist');
  DeletaIECache;
  //Verifica se tem proxy para baixar o arquivo

  Lc_Arquivo := 'listaimagem.txt';
  BaixarArquivo(Lc_Arquivo, 'https://www.setes.com.br/delphi/os/imagem/', GbPathExe + '\imagem\checklist');

  AssignFile(Lc_FileTxt,GbPathExe + '\imagem\checklist\' + Lc_Arquivo);
  Reset(Lc_FileTxt); //abre o arquivo para leitura;
  Lc_files := TStringList.Create;
  While not eof(Lc_FileTxt) do
  begin
    Readln(Lc_FileTxt,lc_linha); //le do arquivo e desce uma linha. O contedo lido  transferido para a varivel linha
    Lc_files.Add(Lc_linha);
  End;
  Closefile(Lc_FileTxt);

  For Lc_I:=0 to (Lc_files.Count -1) do
  Begin
    Lc_Arquivo := Lc_files.Strings[Lc_I];
    if not (FileExists(GbPathExe + '\imagem\checklist\' + Lc_Arquivo)) then
    Begin
      BaixarArquivo(Lc_Arquivo, 'https://www.setes.com.br/delphi/os/imagem/', GbPathExe + '\imagem\checklist');
    end;
  end;
end;

procedure TFr_VehicleCheckList.Pc_PermissaoBotao(Pc_Menu: string);
begin
  if Gb_Nivel = 1 then
  begin
    It_Alterar := True;
    It_Excluir := True;
    It_Visualizar := True;
  end
  else
  begin
    It_Alterar    := Fc_HabilitaPermissao(Pc_Menu,'ALTERAR','S');
    It_Excluir    := Fc_HabilitaPermissao(Pc_Menu,'EXCLUIR','S');
    It_Visualizar := Fc_HabilitaPermissao(Pc_Menu,'VISUALIZAR','S');
  end;
end;

procedure TFr_VehicleCheckList.Pc_SetarImagem(Pc_Imagem:TImage);
Begin
  if (Pc_Imagem.Hint = 'N') then
    Begin
  	Pc_Imagem.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\' + Pc_Imagem.Name +'r.bmp');
		Pc_Imagem.Hint := 'R';
		end
  else
	if (Pc_Imagem.Hint = 'R') then
    Begin
		Pc_Imagem.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\' + Pc_Imagem.Name +'q.bmp');
		Pc_Imagem.Hint := 'Q';
		end
	else
	if (Pc_Imagem.Hint = 'Q') then
    Begin
  	Pc_Imagem.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\' + Pc_Imagem.Name +'a.bmp');
		Pc_Imagem.Hint := 'A';
		end
  else
	if (Pc_Imagem.Hint = 'A') then
    Begin
		Pc_Imagem.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\' + Pc_Imagem.Name +'n.bmp');
		Pc_Imagem.Hint := 'N';
    end;

end;

procedure TFr_VehicleCheckList.carro_01Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_02Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_03Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_04Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_05Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_06Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_07Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_08Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_09Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_10Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_11Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_12Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_13Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_14Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_15Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_16Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_17Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_18Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_19Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_20Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_21Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.carro_22Click(Sender: TObject);
begin
  Pc_SetarImagem(TImage(Sender));
end;

procedure TFr_VehicleCheckList.Pc_LoadImagem(Pc_CheckList:String);
Begin
  //Carrega os hins
  //Carrega as imagens
  carro_01.Hint := Pc_CheckList[1];
  carro_02.Hint := Pc_CheckList[2];
  carro_03.Hint := Pc_CheckList[3];
  carro_04.Hint := Pc_CheckList[4];
  carro_05.Hint := Pc_CheckList[5];
  carro_06.Hint := Pc_CheckList[6];
  carro_07.Hint := Pc_CheckList[7];
  carro_08.Hint := Pc_CheckList[8];
  carro_09.Hint := Pc_CheckList[9];
  carro_10.Hint := Pc_CheckList[10];
  carro_11.Hint := Pc_CheckList[11];
  carro_12.Hint := Pc_CheckList[12];
  carro_13.Hint := Pc_CheckList[13];
  carro_14.Hint := Pc_CheckList[14];
  carro_15.Hint := Pc_CheckList[15];
  carro_16.Hint := Pc_CheckList[16];
  carro_17.Hint := Pc_CheckList[17];
  carro_18.Hint := Pc_CheckList[18];
  carro_19.Hint := Pc_CheckList[19];
  carro_20.Hint := Pc_CheckList[20];
  carro_21.Hint := Pc_CheckList[21];
  carro_22.Hint := Pc_CheckList[22];
  //Carrega as imagens
  carro_01.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_01' + LowerCase(Pc_CheckList[1]) + '.bmp');
  carro_01.Repaint;
  carro_02.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_02' + LowerCase(Pc_CheckList[2]) + '.bmp');
  carro_02.Repaint;
  carro_03.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_03' + LowerCase(Pc_CheckList[3]) + '.bmp');
  carro_03.Repaint;
  carro_04.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_04' + LowerCase(Pc_CheckList[4]) + '.bmp');
  carro_04.Repaint;
  carro_05.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_05' + LowerCase(Pc_CheckList[5]) + '.bmp');
  carro_05.Repaint;
  carro_06.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_06' + LowerCase(Pc_CheckList[6]) + '.bmp');
  carro_06.Repaint;
  carro_07.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_07' + LowerCase(Pc_CheckList[7]) + '.bmp');
  carro_07.Repaint;
  carro_08.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_08' + LowerCase(Pc_CheckList[8]) + '.bmp');
  carro_08.Repaint;
  carro_09.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_09' + LowerCase(Pc_CheckList[9]) + '.bmp');
  carro_09.Repaint;
  carro_10.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_10' + LowerCase(Pc_CheckList[10]) + '.bmp');
  carro_10.Repaint;
  carro_11.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_11' + LowerCase(Pc_CheckList[11]) + '.bmp');
  carro_11.Repaint;
  carro_12.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_12' + LowerCase(Pc_CheckList[12]) + '.bmp');
  carro_12.Repaint;
  carro_13.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_13' + LowerCase(Pc_CheckList[13]) + '.bmp');
  carro_13.Repaint;
  carro_14.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_14' + LowerCase(Pc_CheckList[14]) + '.bmp');
  carro_14.Repaint;
  carro_15.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_15' + LowerCase(Pc_CheckList[15]) + '.bmp');
  carro_15.Repaint;
  carro_16.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_16' + LowerCase(Pc_CheckList[16]) + '.bmp');
  carro_16.Repaint;
  carro_17.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_17' + LowerCase(Pc_CheckList[17]) + '.bmp');
  carro_17.Repaint;
  carro_18.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_18' + LowerCase(Pc_CheckList[18]) + '.bmp');
  carro_18.Repaint;
  carro_19.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_19' + LowerCase(Pc_CheckList[19]) + '.bmp');
  carro_19.Repaint;
  carro_20.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_20' + LowerCase(Pc_CheckList[20]) + '.bmp');
  carro_20.Repaint;
  carro_21.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_21' + LowerCase(Pc_CheckList[21]) + '.bmp');
  carro_21.Repaint;
  carro_22.Picture.LoadFromFile(GbPathExe + '\imagem\checklist\carro_22' + LowerCase(Pc_CheckList[22]) + '.bmp');
  carro_22.Repaint;


  
end;

procedure TFr_VehicleCheckList.Pc_LoadData;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  try
    LcBase := TControllerBase.create(Nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT * '+
              'FROM TB_VEHICLE_CHECKLIST '+
              'WHERE TB_INSTITUTION_ID=:TB_INSTITUTION_ID ');

      IF (It_budget_id > 0) then
        SQL.Add(' and TB_BUDGET_ID =:TB_BUDGET_ID ');
      if (It_order_id > 0) then
          SQL.Add(' and TB_ORDER_ID =:TB_ORDER_ID ');
      ParamByName('TB_INSTITUTION_ID').AsInteger := Gb_CodMha;
      IF (It_budget_id > 0) then
        ParamByName('TB_BUDGET_ID').AsInteger := It_Budget_id;
      if (IT_order_id > 0) then
        ParamByName('TB_ORDER_ID').AsInteger := It_Order_id;
      Active := True;
      FetchAll;
      IF (RecordCount>0) then
      Begin
        Pc_LoadImagem(FieldByName('CHECKLIST').AsString);
        cbx_macaco.Checked := (FieldByName('HOIST').AsString = 'S');
        cbx_manual.Checked := (FieldByName('MANUAL').AsString = 'S');
        cbx_Extintor.Checked := (FieldByName('EXTINGUISHER').AsString = 'S');
        cbx_Radio.Checked := (FieldByName('RADIO').AsString = 'S');
        cbx_Abs.Checked := (FieldByName('ABS').AsString = 'S');
        cbx_DirHidraulica.Checked := (FieldByName('HYDRAULIC_STEERING').AsString = 'S');
        cbx_Calotas.Checked := (FieldByName('HUB_CAPS').AsString = 'S');
        cbx_ArQuente.Checked := (FieldByName('HOT_AIR').AsString = 'S');
        cbx_triangulo.Checked := (FieldByName('TRIANGLE').AsString = 'S');
        cbx_ChaveRoda.Checked := (FieldByName('WRENCH').AsString = 'S');
        cbx_Antena.Checked := (FieldByName('AERIAL').AsString = 'S');
        cbx_AcendCigarro.Checked := (FieldByName('CIGARETTE_LIGHTER').AsString = 'S');
        cbx_ArCondicionado.Checked := (FieldByName('CONDITIONED_AIR').AsString = 'S');
        cbx_outros.Checked := (FieldByName('OTHER').AsString = 'S');
        cbx_Documentos.Checked := (FieldByName('DOCTS').AsString = 'S');
        cbx_Tapetes.Checked := (FieldByName('CARPET').AsString = 'S');
        //PNEU DIANTEIRO
        if FieldByName('FRONT_TYRE').AsString  = 'R' then
          RG_PneuDianteiro.ItemIndex := 0
        else
        if FieldByName('FRONT_TYRE').AsString  = 'B' then
          RG_PneuDianteiro.ItemIndex := 1
        else
        if FieldByName('FRONT_TYRE').AsString  = 'E' then
          RG_PneuDianteiro.ItemIndex := 2;
        //PNEU TRASEIRO
        if FieldByName('BACK_TYRE').AsString  = 'R' then
          RG_PneuTraseiro.ItemIndex := 0
        else
        if FieldByName('BACK_TYRE').AsString  = 'B' then
          RG_PneuTraseiro.ItemIndex := 1
        else
        if FieldByName('BACK_TYRE').AsString  = 'E' then
          RG_PneuTraseiro.ItemIndex := 2;
        //PNEU ESTEPE
        if FieldByName('STEPE_TYRE').AsString  = 'R' then
          RG_PneuEstepe.ItemIndex := 0
        else
        if FieldByName('STEPE_TYRE').AsString  = 'B' then
          RG_PneuEstepe.ItemIndex := 1
        else
        if FieldByName('STEPE_TYRE').AsString  = 'E' then
          RG_PneuEstepe.ItemIndex := 2;
        //Valculas
        if FieldByName('VALVES').AsString  = '08' then
          Rg_Valvulas.ItemIndex := 0
        else
        if FieldByName('VALVES').AsString  = '16' then
          Rg_Valvulas.ItemIndex := 1
        else
        if FieldByName('VALVES').AsString  = '20' then
          Rg_Valvulas.ItemIndex := 2
        else
        if FieldByName('VALVES').AsString  = '24' then
          Rg_Valvulas.ItemIndex := 3;


        RG_Combustivel.ItemIndex := StrToIntDef(FieldByName('FUEL').AsString,1) - 1;
        E_Km.Text := FieldByName('KM').AsString;
        E_Obs.Text := FieldByName('OBS').AsString;
        E_Dt_Entrada.Text := FieldByName('ENTRANCE_DATE').AsString;
        E_hR_Entrada.Text := FieldByName('ENTRANCE_HOUR').AsString;
        E_Nr_Prisma.Text := FieldByName('PRISMA').AsString;
      end
      else
        Pc_LoadDefault;
      end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  end;
end;

procedure TFr_VehicleCheckList.Pc_LoadDefault;
Begin
  Pc_LoadImagem('NNNNNNNNNNNNNNNNNNNNNN');
  cbx_macaco.Checked := False;
  cbx_manual.Checked := False;
  cbx_Extintor.Checked := False;
  cbx_Radio.Checked := False;
  cbx_Abs.Checked := False;
  cbx_DirHidraulica.Checked := False;
  cbx_Calotas.Checked := False;
  cbx_ArQuente.Checked := False;
  cbx_triangulo.Checked := False;
  cbx_ChaveRoda.Checked := False;
  cbx_Antena.Checked := False;
  cbx_AcendCigarro.Checked := False;
  cbx_ArCondicionado.Checked := False;
  cbx_outros.Checked := False;
  cbx_Documentos.Checked := False;
  cbx_Tapetes.Checked := False;
  //PNEU DIANTEIRO
  RG_PneuDianteiro.ItemIndex := 2;
  //PNEU TRASEIRO
  RG_PneuTraseiro.ItemIndex := 2;
  //PNEU ESTEPE
  RG_PneuEstepe.ItemIndex := 2;
  //Valculas
  Rg_Valvulas.ItemIndex := 0;
  RG_Combustivel.ItemIndex := 0;
  E_Km.Text := '';
  E_Obs.Text := '';
  E_Dt_Entrada.Text := '';
  E_hR_Entrada.Text := '';
end;

procedure TFr_VehicleCheckList.FormShow(Sender: TObject);
begin
  Try
    Pc_ProcesoAguarde(Self,'I');
    Self.Enabled := False;
    Pc_IniciaVariaveis;
    Pc_ImagemBotao;
    Pc_PermissaoBotao('Ordem de Servião');
    Pc_BaixarArquivosChecklist;
    Pc_LoadData;
  Finally
    Pc_ProcesoAguarde(Self,'F');
    Self.Enabled := true;
  end;    
end;

procedure TFr_VehicleCheckList.SB_GravarClick(Sender: TObject);
begin
  Pc_Gravar;
  Close;
end;

procedure TFr_VehicleCheckList.SB_CancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFr_VehicleCheckList.SpeedButton1Click(Sender: TObject);
begin
  E_Dt_Entrada.Text := DateToStr(Date);
  E_Hr_Entrada.Text := Copy(TimeToStr(Time),1,5);
end;

procedure TFr_VehicleCheckList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
    Begin
    case Key of
      VK_F5: if SB_Gravar.Enabled then  SB_GravarClick(Sender);
      VK_F8: if SB_Cancelar.Enabled then  SB_CancelarClick(Sender);
      end;
    end;
end;

end.
