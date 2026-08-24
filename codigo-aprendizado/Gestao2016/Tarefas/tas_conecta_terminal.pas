unit tas_conecta_terminal;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, STQuery, Datasnap.DBClient;

type
  TTasConectaTerminal = class(TForm)
    Dbg_Lista: TDBGrid;
    pnl_botao: TPanel;
    SB_Confirmar: TSpeedButton;
    SB_Sair_0: TSpeedButton;
    Ds_Lista: TDataSource;
    cds_Lista: TClientDataSet;
    cds_Listadescription: TStringField;
    cds_Listapath_server: TStringField;
    cds_Listapath_database: TStringField;
    cds_Listaid: TIntegerField;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure SB_ConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Pc_ImagemBotao;
    procedure ImportaListaTerminal;
    procedure ImportaLinha(Linha:String);
  public
    { Public declarations }
  end;

var
  TasConectaTerminal: TTasConectaTerminal;

implementation

{$R *.dfm}

uses     UN_Principal, env, UN_Sistema, Un_Regra_Negocio, Un_DM, Un_Msg;

procedure TTasConectaTerminal.FormShow(Sender: TObject);
begin
  Pc_ImagemBotao;
  ImportaListaTerminal;

end;

procedure TTasConectaTerminal.ImportaLinha(Linha:String);
Var
  Lista : TStringList;
  LC,LL : String;
  I:Integer;
  LcAux : String;
begin
  try
    Lista := TStringList.Create;
    Lista.StrictDelimiter := True;
    Lista.Delimiter := ';';
    Lista.DelimitedText := Linha;
    cds_Lista.append;
    cds_Listaid.AsInteger           := StrToIntDef(Trim(Lista[0]),0);
    cds_Listadescription.AsString   := Trim(Lista[1]);
    cds_Listapath_server.AsString   := Trim(Lista[2]);
    cds_Listapath_database.AsString := Trim(Lista[3]);
    cds_Lista.Post;
  finally
    FreeAndNil(Lista);
  end;
end;

procedure TTasConectaTerminal.ImportaListaTerminal;
var
  Lc_I : Integer;
  LcLinha : String;
  Lc_Linha : Integer;
  Lc_StrCell1: string;
  Lc_StrCell2: string;
  Lc_Texto : String;
  Lc_Print : Boolean;
  Lc_FileImport : TextFile;
begin
  Try
    AssignFile(Lc_FileImport,concat( GbPathExe,'LISTATERMINAL.TXT'));
    Reset( Lc_FileImport ); //abre o arquivo para leitura;
    if not cds_Lista.Active then cds_Lista.CreateDataSet;
    cds_Lista.EmptyDataSet;
    Reset( Lc_FileImport ); //abre o arquivo para leitura;
    Lc_I := 0;
    While not eof(Lc_FileImport) do
    begin
      Readln(Lc_FileImport,LcLinha);
      if Lc_I >0  then
        ImportaLinha(LcLinha);
      inc(Lc_I);
      Application.ProcessMessages;
    End;
  Finally
    Closefile(Lc_FileImport); //fecha o handle de arquivo
  End;
end;

procedure TTasConectaTerminal.Pc_ImagemBotao;
begin
  with fr_principal do
  Begin
    CarregaImagemBotao(SB_Confirmar,'CONFIRMAR');
    CarregaImagemBotao(SB_Sair_0,'SAIR');
  END;
end;

procedure TTasConectaTerminal.SB_ConfirmarClick(Sender: TObject);
Var
  LcDatabase : String;
  LcDatabaseOld : String;
  LcDescricao : String;
begin
  Try
    Try
      LcDatabaseOld := DM.IBD_Gestao.DatabaseName;
      LcDatabase  := concat(cds_ListaPATH_SERVER.AsString,':',Cds_ListaPATH_DATABASE.AsString);
      LcDescricao := cds_Listadescription.AsString;
      DM.IBD_Gestao.Connected := False;
      DM.IBD_Gestao.DatabaseName := LcDatabase;
      DM.IBD_Gestao.Connected := True;
      Pc_DefineEmpresaAtiva(0);
      Fr_Principal.Caption := concat(Fr_Principal.Caption,' - ',LcDescricao);
      MensagemPadrao(' S U C E S S O!!', ATENCAO + EOLN + EOLN +
                     ' Novo Terminal conectado com Sucesso.' + EOLN + EOLN,
                     ['OK'], [bEscape], mpInformacao);
    except
      DM.IBD_Gestao.Connected := False;
      DM.IBD_Gestao.DatabaseName := LcDatabaseOld;
      DM.IBD_Gestao.Connected := True;
      Pc_DefineEmpresaAtiva(0);
      MensagemPadrao(' E R R O!!!!', ATENCAO + EOLN + EOLN +
                     ' Não foi possível conectar no local escolhido.' + EOLN +
                     ' A conexão será restabelecida com o terminal anterior'+ EOLN,
                     ['OK'], [bEscape], mpInformacao);
    End;
  Finally

    Self.Close;
  End;
end;

procedure TTasConectaTerminal.SB_Sair_0Click(Sender: TObject);
begin
  Close;
end;

end.
