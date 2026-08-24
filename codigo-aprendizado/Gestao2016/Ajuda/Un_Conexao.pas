unit Un_Conexao;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, STDatabase, IniFiles, StrUtils;

type
  TFr_ConectaBanco = class(TForm)
    Panel1: TPanel;
    Btn_Fechar: TButton;
    Btn_Ap_5: TButton;
    Pn_Config: TPanel;
    Label1: TLabel;
    Sb_Executa_Config: TSpeedButton;
    Label2: TLabel;
    E_IP_Config: TEdit;
    Opd_Abrir: TOpenDialog;
    IBD_Gestao: TSTDatabase;
    E_Caminho_Config: TEdit;
    procedure Btn_FecharClick(Sender: TObject);
    procedure Btn_Ap_5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sb_Executa_ConfigClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GravaDataBasePath(Pc_Caminho:String);
  public
    { Public declarations }

  end;

var
  Fr_ConectaBanco: TFr_ConectaBanco;

implementation

uses     UN_Sistema, env, UN_MSG;
{$R *.dfm}

procedure TFr_ConectaBanco.Btn_FecharClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TFr_ConectaBanco.Btn_Ap_5Click(Sender: TObject);
begin
  try
    IBD_Gestao.Connected := False;
    if Length(Trim(E_IP_Config.Text)) > 0 then
      IBD_Gestao.DatabaseName := E_IP_Config.Text + ':' + E_Caminho_Config.Text
    else
      IBD_Gestao.DatabaseName := E_Caminho_Config.Text;
    if not IBD_Gestao.Connected then
      IBD_Gestao.Connected := true;
    ShowMessage('Banco de dados Conectado com Sucesso !!');
    GravaDataBasePath(GbPathExe + 'Config.INI');
  except
    on E : Exception do
      MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                    'Não foi possível Conectar o Banco de Dados.' + EOLN +
                    'Erro: ' + E.Message + EOLN +
                    'Entre em contato com o suporte técnico.' + EOLN,
                    ['OK'], [bEscape], mpErro);
  end;
end;

procedure TFr_ConectaBanco.GravaDataBasePath(Pc_Caminho:String);
var
  Lc_Arq_Ini: TIniFile;
  Lc_Host: String;
  Lc_Path: String;
begin
  TRy
    if Length(Trim(E_IP_Config.Text)) > 0 then
      Lc_Host := E_IP_Config.Text+':'
    else
      Lc_Host := '';
    Lc_Path := E_Caminho_Config.Text;
    Lc_Arq_Ini := TIniFile.Create(Pc_Caminho);

    Gb_PathBd := LeftStr(GbPathExe, (Length(GbPathExe) - 4));
    Gb_PathBd := Lc_Host + Lc_Path;

    if Lc_Arq_Ini.SectionExists('PATH') then
      Lc_Arq_Ini.WriteString('Path', 'Database', Gb_PathBd);

  Finally
    FreeAndNil(Lc_Arq_Ini);
  End;
end;

procedure TFr_ConectaBanco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  HALT;
end;

procedure TFr_ConectaBanco.Sb_Executa_ConfigClick(Sender: TObject);
begin
  If Opd_Abrir.Execute then
  begin
    Opd_Abrir.Title := 'Selecione o Banco de Dados';
    Opd_Abrir.DefaultExt := '*.GDB';
    Opd_Abrir.Filter := 'Arquivos GDB (*.GDB)|*.FDB|Arquivos FDB (*.FDB)|*.CD|Arquivos CD (*.CD)|Todos os Arquivos (*.*)|*.*';
    Opd_Abrir.InitialDir := GbPathExe;
    E_Caminho_Config.Text := (Opd_Abrir.FileName);
  end;
end;

procedure TFr_ConectaBanco.FormCreate(Sender: TObject);
begin
  GbPathExe := ExtractFilePath(Application.ExeName);
end;

end.
