unit BematechPrint;

interface

uses     un_mp2032, SysUtils, GeneralPrint;
type

  TBematechPrint = class(TGeneralPrint)
    private
    protected
      procedure print(Texto:String); Override;
    public

      constructor Create;
      destructor Destroy;
      procedure Iniciar;Override;
      procedure AbrirGaveta;override;
      procedure Saltar(Linhas:Integer);Override;
      procedure Reset;Override;
      procedure CortarPapel(Tipo:Integer);Override;
      procedure Fechar;Override;
      function VerificarStatus(Msg:AnsiString):AnsiString;Override;
      function Pc_AlinhaE(Texto : String; Tamanho : Integer;caracter:string) : String;Override;
      function Pc_AlinhaC(Texto : String; Tamanho : integer;caracter:string) : String;Override;
      function Pc_AlinhaD(Texto : String; Tamanho : Integer;caracter:string) : String;Override;

      Procedure TextOutLC(nRow,nCol:LongInt;Text:AnsiString);Override;

  end;

implementation


procedure TBematechPrint.AbrirGaveta;
begin
  inherited;

end;

procedure TBematechPrint.CortarPapel(Tipo: Integer);
begin
  Status := AcionaGuilhotina(Tipo);
end;

constructor TBematechPrint.Create;
begin
  FechaPorta();
  FRow := 1;
  FCol := 1;
  ModeloImpressora := 7;
  FPorta := 'USB';
  //1 - compimido  2 - Normal / 3 - Elite
  TipoLetra := 2;
  Italico     := 0;
  Expandido   := 0;
  Sublinhado  := 0;
  Enfatizado := 0;
end;

destructor TBematechPrint.Destroy;
begin
  //
  inherited;
end;

procedure TBematechPrint.Fechar;
begin
  Status := FechaPorta();
end;

procedure TBematechPrint.Iniciar;
Var
  I : Integer;
begin
  Margem := '';
  for I := 1 to TamanhoMargem do
    Margem := Margem + ' ';
  if  (Pos(UpperCase('COM'), UpperCase(Fporta)) > 0) then
    Status := IniciaPorta(Fporta);
end;


procedure TBematechPrint.print(Texto:String);
Begin
  if  (Pos(UpperCase('COM'), UpperCase(Fporta)) > 0) then
  Begin
    Status := FormataTX(Margem + Texto +#13+#10,
                       TipoLetra,
                       Italico,
                       Sublinhado,
                       Expandido,
                       Enfatizado);
  End
  else
  Begin
    Status := FormataTX(Margem + Texto,
                           TipoLetra,
                           Italico,
                           Sublinhado,
                           Expandido,
                           Enfatizado);
  End;
end;

procedure TBematechPrint.Reset;
begin
  inherited;

end;

procedure TBematechPrint.Saltar(Linhas: Integer);
Var
  lcmdtxt : AnsiString;
  I : Integer;
begin
  lcmdtxt := #13+#10;
  for I := 1 to Linhas do
    Status := ComandoTX(lcmdtxt,length (lcmdtxt));
end;



procedure TBematechPrint.TextOutLC(nRow, nCol: Integer; Text: AnsiString);
  Var xRow,xCol:LongInt;
Begin
  {Teste de próxima página}
  If nRow = FRow Then
  Begin
    For xCol:=1 To nCol - FCol Do
    Begin
      Inc(FCol);
    End
  End
  Else
  Begin
    FCol:=1;
    For xRow:=1 To nRow - FRow Do
    Begin
      Inc(FRow);
    End;
    For xCol:=1 To nCol Do
    Begin
      If xCol > FCol Then
      Begin
        Inc(FCol);
      End;
    End
  End;
  Inc(FCol,Length(Text));
  print(Text);
end;

function TBematechPrint.Pc_AlinhaE(Texto : String; Tamanho : Integer;caracter:string) : String;
begin
   Texto := Trim(Texto);
   if caracter = '' then caracter := ' ';
   while length(Texto) < Tamanho do
   begin
     Texto := concat(Texto,caracter);
   end;
   Result := Texto;
end;

// para texto centralizado

function TBematechPrint.Pc_AlinhaC(Texto : String; Tamanho : integer;caracter:string) : String;
 var
   metade: integer;
 begin
   Texto := Trim(Texto);
   metade := ((Tamanho-Length(Texto)) div 2);
   if caracter = '' then caracter := ' ';
   while Length(Texto)+metade < Tamanho do
     Texto := concat(caracter,Texto);
   result := Texto;
 end;

 // para texto a direita
function TBematechPrint.Pc_AlinhaD(Texto : String; Tamanho : Integer;caracter:string) : String;
 begin
   Texto := Trim(Texto);
   if caracter = '' then caracter := ' ';
   while length(Texto) < Tamanho do
   begin
     Texto := concat(caracter,Texto);
   end;
   Result := Texto;
 end;

function TBematechPrint.VerificarStatus(Msg:AnsiString): AnsiString;
begin
  case Status of
    -2:Result := 'Erro : ' + Msg;
     1:Result := 'Sucesso : ' + Msg;
  else
    Result := 'Erro :  - ' + Msg;

  end;
end;

end.
