unit EpsonPrint;

interface

uses
       System.Math, SysUtils, GeneralPrint;
type
  TEpsonPrint = class(TGeneralPrint)
    private
      Arquivo: TextFile;
    protected
     procedure print(Texto:String); Override;
    public
      constructor Create;
      destructor Destroy;
      procedure Iniciar;override;
      Procedure Reset; override;
      procedure Fechar;override;

      function VerificarStatus(Msg:AnsiString):AnsiString;Override;
      function Pc_AlinhaE(Texto : String; Tamanho : Integer;caracter:string) : String;Override;
      function Pc_AlinhaC(Texto : String; Tamanho : integer;caracter:string) : String;Override;
      function Pc_AlinhaD(Texto : String; Tamanho : Integer;caracter:string) : String;Override;
      procedure CortarPapel(Tipo:Integer);Override;
      procedure AbrirGaveta;override;
      procedure Saltar(Linhas:Integer);override;
      Procedure TextOutLC(nRow,nCol:LongInt;Text:AnsiString);Override;

  end;
implementation

procedure TEpsonPrint.AbrirGaveta;
begin
  Writeln(Arquivo , #027+ #112 + #000 + #010 + #100'');
end;

procedure TEpsonPrint.CortarPapel(Tipo:Integer);
Begin
  //Aciona a Guilhotina
  //AssignFile(Lc_Finaliza,FPorta);
  Rewrite(Arquivo);
  Writeln(Arquivo, #27+ #105);
end;

constructor TEpsonPrint.Create;
begin
  inherited;
end;

destructor TEpsonPrint.Destroy;
begin
  //
  inherited;
end;

procedure TEpsonPrint.Fechar;
begin
  CloseFile(Arquivo);
end;

procedure TEpsonPrint.Iniciar;
Var
  I : Integer;
begin
  FRow := 1;
  FCol := 1;
  AssignFile(Arquivo,FPorta);
  Rewrite(Arquivo);
end;

function TEpsonPrint.Pc_AlinhaC(Texto: String; Tamanho: integer;
  caracter: string): String;
begin

end;

function TEpsonPrint.Pc_AlinhaD(Texto: String; Tamanho: Integer;
  caracter: string): String;
begin

end;

function TEpsonPrint.Pc_AlinhaE(Texto: String; Tamanho: Integer;
  caracter: string): String;
begin

end;

procedure TEpsonPrint.print(Texto:String);
Begin
end;

procedure TEpsonPrint.Reset;
begin
  inherited;
  //Write(Arquivo,#27+'@');
end;

procedure TEpsonPrint.Saltar(Linhas:Integer);
Var
  I : Integer;
begin
  if Linhas > 0 then
  Begin
    For I := 1 to Linhas do
      Writeln(Arquivo);
  End;
end;



procedure TEpsonPrint.TextOutLC(nRow,nCol:LongInt;Text:AnsiString);
  Var xRow,xCol:LongInt;
Begin
  {Teste de próxima página}
  If nRow = FRow Then
  Begin
    For xCol:=1 To nCol-FCol Do
    Begin
      Write(Arquivo,' ');
      Inc(FCol);
    End
  End
  Else
  Begin
    FCol:=1;
    For xRow:=1 To nRow - FRow Do
    Begin
      WriteLn(Arquivo,'');
      Inc(FRow);
    End;
    For xCol:=1 To nCol Do
    Begin
      If xCol > FCol Then
      Begin
        Write(Arquivo,' ');
        Inc(FCol);
      End;
    End
  End;
  Inc(FCol,Length(Text));
  if not FQuebralinha then
    Write(Arquivo,Text)
  else
    Writeln(Arquivo,Text);
end;

function TEpsonPrint.VerificarStatus(Msg: AnsiString): AnsiString;
begin

end;

end.
