unit GeneralPrint;

interface

uses     un_mp2032, SysUtils, System.Math, System.Classes;
type

  TGeneralPrint = class
    private

    protected
      FRow : Integer;
      FCol : Integer;
      Margem : AnsiString;
      FQuebralinha: Boolean;
      FPorta: String;
      procedure setFPorta(const Value: String);
      procedure setFQuebralinha(const Value: Boolean);

      procedure print(Texto:String); virtual; abstract;
    protected


    public
      ModeloImpressora : Integer;
      TamanhoMargem : Integer;
      TipoLetra : Integer;
      Italico : Integer;
      Expandido : Integer;
      Sublinhado : Integer;
      Enfatizado : Integer;
      Status : Integer;
      constructor Create;
      destructor Destroy;


      procedure Iniciar;virtual; abstract;
      procedure AbrirGaveta;virtual; abstract;
      procedure Saltar(Linhas:Integer);virtual; abstract;
      Procedure Reset; virtual; abstract;
      procedure Fechar;virtual; abstract;
      procedure CortarPapel(Tipo:Integer);virtual; abstract;





      function CentralizaTexto(Fc_Texto:String; fc_Coluna:Integer;Fc_Extra:String):String;
      function Pad(AValue: String; const ALength: Integer; const ASide: TAlignment): String;
      function PadL(AValue: String; const ALength: Integer): String;
      function PadR(AValue: String; const ALength: Integer): String;



      Procedure TextOutLC(nRow,nCol:LongInt;Text:AnsiString);virtual; abstract;
      function VerificarStatus(Msg:AnsiString):AnsiString;virtual; abstract;
      function Pc_AlinhaE(Texto : String; Tamanho : Integer;caracter:string) : String;virtual; abstract;
      function Pc_AlinhaC(Texto : String; Tamanho : integer;caracter:string) : String;virtual; abstract;
      function Pc_AlinhaD(Texto : String; Tamanho : Integer;caracter:string) : String;virtual; abstract;
      property Quebralinha : Boolean read FQuebralinha write setFQuebralinha;
      property Porta: String read FPorta write setFPorta;


  end;

  TPrintGeneralFactory = class
    public
      class function criarPrint(tipo: string): TGeneralPrint;
  end;

implementation



{ TGeneralPrint }

uses     BematechPrint, EpsonPrint;

function TGeneralPrint.CentralizaTexto(Fc_Texto: String; fc_Coluna: Integer;
  Fc_Extra: String): String;
Var
  Lc_I : Integer;
  Lc_Final : Real;
  Lc_string : String;
Begin
  //Nome a ser impresso no cupom
  Lc_string := Fc_Texto;
  Lc_Final := ((fc_coluna -Length(Lc_string))/2) - 2;
  Lc_string := '';
  For Lc_I := 1 to Floor(Lc_Final) do
    Lc_string := Lc_string + Fc_Extra;
  Lc_string := Lc_string + ' ' + Fc_Texto + ' ';
  For Lc_I := 1 to (fc_coluna-Length(Lc_string)) do
      Lc_string := Lc_string + Fc_Extra;
  Result := Lc_string;
end;

constructor TGeneralPrint.Create;
begin
  inherited;
  FRow := 1;
  FCol := 1;
  FQuebralinha := True;
  setFPorta('LPT1');

end;

destructor TGeneralPrint.Destroy;
begin
  inherited;
end;

function TGeneralPrint.Pad(AValue: String; const ALength: Integer;
  const ASide: TAlignment): String;
begin
  AValue := Trim(AValue);
  if Length(AValue) > ALength then AValue := Copy(AValue,1,ALength);
  case ASide of
    taLeftJustify:
      while Length(AValue) < ALength do AValue := AValue + ' ';
    taRightJustify:
      while Length(AValue) < ALength do AValue := ' ' + AValue;
    taCenter:
      while Length(AValue) < ALength do
        if (Length(AValue) mod 2)=0 then
          AValue := AValue + ' '
        else
          AValue := ' ' + AValue;
  end;
  Result := AValue;
end;

function TGeneralPrint.PadL(AValue: String; const ALength: Integer): String;
begin
  Result := Pad(AValue, ALength, taLeftJustify);
end;

function TGeneralPrint.PadR(AValue: String; const ALength: Integer): String;
begin
  Result := Pad(AValue, ALength, taRightJustify);
end;

procedure TGeneralPrint.setFPorta(const Value: String);
begin
  IF trim(Value) <> '' then
    FPorta := Value
  else
    FPorta := 'LPT1';

end;

procedure TGeneralPrint.setFQuebralinha(const Value: Boolean);
begin
  FQuebralinha := Value;
end;

{ TPrintGeneralFactory }

class function TPrintGeneralFactory.criarPrint(tipo: string): TGeneralPrint;
begin
  if tipo = 'BEMATECH - MP4200' then
    Result := TBematechPrint.Create
  else if tipo = 'EPSON - TM-T20' then
    Result := TEpsonPrint.Create
  else
    raise Exception.Create('Tipo de impressora inválido');
end;

end.
