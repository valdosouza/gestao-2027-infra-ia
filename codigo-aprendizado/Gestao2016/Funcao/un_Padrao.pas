{----------------------------------------------------------------------------
 Observação : Unit padrão dos sistemas desenvolvidas pela
                      Setes Gestão Computacional
-----------------------------------------------------------------------------}

unit un_Padrao;
{$R-,Q-}  //Switches para desabilitar a chegagem de overflow e de range
          //Para a função de criptografia. Não apagar!

interface

uses
        Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, un_Conversao, UnFunctions;


const
   EOLN=chr(13)+chr(10);    //Usado para fazer fim de linha nos quadros de mensagens
   C1=52845;                //Utilizado para criptogravar os dados
   C2=22719;                //Utilizado para criptogravar os dados



{C}

function Fc_CriaZero(Fc_Dado: String; Fc_Tamanho : Integer): string;
function Fc_CriaEspaco(Fc_Dado: String; Fc_Tamanho : Integer):String;

{E}

function ExecutarAjusteTagNro(Corrigir: boolean; Nro: string): string;

{I}

function IIf(const condicao: Boolean; const Verdadeiro, Falso: Variant): Variant;



{N}
function Fc_NumeroCasaDecima(Fc_numero:String):Integer;

{R}

function RetornarConteudoEntre(const Frase, Inicio, Fim: string): string;


function RetornarPosEx(const SubStr, S: AnsiString; Offset: Cardinal = 1): Integer;
function RetornarVersaoLayout(const schema: TpcnSchema; const Layout: TpcnTipoLayout): string;
function ReverterFiltroTextoXML(aTexto: AnsiString): AnsiString;
function RetornarAAMM(const data: TDateTime): string;


{S}

function SomenteNumeros(const s: string): string;

function SubStrEmSubStr(const SubStr1: string; SubStr2: string): boolean;


function ValidarNumeros(const s: string): boolean;

{U}
function Fc_Ult_Dia_Mes(Pc_Data: TDate): String;



var
  //Fr_Espera   : TPorcentagem;

  //----------------- Variaveis globais do sistema ----------------------
  // OBSERVAçõO: Se quiser inicializar com valor DEFAULT coloque na
  // un_senha na última função (Begin...End)

  // Tabela_Funcionario : TwwDBISAMTable;

  //--------------------------
  //Codigo, nome, cargo e nivel do funcionario que acessou o programa
  //--------------------------
  Pbl_Codigo_Funcionario : string[4];
  Pbl_Nome_Funcionario   : string;
  Pbl_CPF_Funcionario    : string[11];
  Pbl_Cargo_Funcionario  : string;
  Pbl_Nivel_Funcionario  : string[1];

  //--------------------------
  //Codigo, nome, cargo e nivel do funcionario
  //que liberou, ou seja passou a sua senha para liberacao
  //inicialmente � o mesmo do funcionario que acessou o programa
  //porem em algum momento que o programa solicite a senha
  //esta será guardada nestas variaveis, at� que novamente seja solicitada
  //--------------------------
  Pbl_Codigo_Senha     : string[4];
  Pbl_Nome_Senha       : string;
  Pbl_Nivel_Senha      : string[1];
  Pbl_Acesso           : string;
  Pbl_DataSistema      : TDateTime;
  // variavel que guarda a caminho da base de dados
  Pbl_PathBase         : String;
  Pbl_Sistema          : String[3]; // contém o sistema q está executando, exempo RTD/TBL/CRT
  Pbl_Terminais        : Integer;

  Pbl_LimitedeRegistro : Integer;
  Pbl_TipodeProtecao   : String[20];
  Pbl_NumeroSerie      : String[6];   //numero se serie com strzeros
  Pbl_LigaSenha        : string[1];   //se liga a senha mensal S ou N
  Pbl_LigaCorretor     : String[1];   //se liga o Corretor Ortogr�fico S OU N
  Pbl_RazaoSocial      : String[80];
  Pbl_NomeFantasia     : String[80];
  Pbl_Endereco         : String[80];
  Pbl_Complemento      : String[50];  //sala, bairro, caixa postal
  Pbl_Municipio        : String[50];  //municipio em letra minuscula
  Pbl_Comarca          : String[50];  //comarca em letra minuscula
  Pbl_Distrito         : String[50];  //distrito em letra minuscula
  Pbl_UF               : String[2];
  Pbl_CEP              : String[10];  //formato 80.530-010
  Pbl_Fone             : String[15];  //formato (0041)253-5545
  Pbl_Fax              : String[15];  //formato (0041)252-2940
  Pbl_UltimaUtilizacao : String[10];  //data do ultimo acesso ao programa (controle senha mensal)
  Pbl_NumeroAcessosMes : String[4];   //numero de acesso no mes, nao ultrapassar a 200 (controle senha mensal)
  Pbl_NumeroTentativas : String[1];   //numero de tentativas de senhas mensal errada
  Pbl_NAcessosMesPRT   : String[4];   //numero de acesso no mes, nao ultrapassar a 200 (controle senha mensal)


implementation

uses     Un_Msg, UN_Sistema, Un_Funcoes, env; // Mudar depois para default

{-------------------------------------------------------------------
 Função         : RetornarConteudoEntre
 Descrição      : Retornar� conteudo entre parametro informado
 -------------------------------------------------------------------}
function RetornarConteudoEntre(const Frase, Inicio, Fim: string): string;
var
  i: integer;
  s: string;
begin
  result := '';
  i := pos(Inicio, Frase);
  if i = 0 then
    exit;
  s := Copy(Frase, i + length(Inicio), maxInt);
  result := Copy(s, 1, pos(Fim, s) - 1);
end;

{-------------------------------------------------------------------
 Função         : SubStrEmSubStr
 -------------------------------------------------------------------}
function SubStrEmSubStr(const SubStr1: string; SubStr2: string): boolean;
var
  s: string;
  i: integer;
begin
  i := 0;
  while (i = 0) and (length(SubStr2) > 0) do
  begin
    SubStr2 := copy(SubStr2, 2, maxInt);
    s := copy(SubStr2, 1, pos('|', SubStr2) - 1);
    SubStr2 := copy(SubStr2, pos('|', SubStr2), maxInt);
    if s <> '' then
      i := i + pos('|' + s, '|' + SubStr1);
  end;
  result := i > 0;
end;

{-------------------------------------------------------------------
 Função         : SomenteNumeros
 Descrição      : Retornar� apenas os números <0..9>
 -------------------------------------------------------------------}
function SomenteNumeros(const s: string): string;
var
  i: integer;
begin
  result := '';
  for i := 1 to length(s) do
    if pos(s[i], '0123456789') > 0 then
      result := result + s[i];
end;


{-------------------------------------------------------------------
 Função         : ValidarNumeros
 -------------------------------------------------------------------}
function ValidarNumeros(const s: string): boolean;
var
  i: integer;
begin
  result := true;
  for i := 1 to length(s) do
    if pos(s[i], '0123456789') = 0 then
      result := false;
end;



{-------------------------------------------------------------------
 Função         : RetornarVersaoLayout
 -------------------------------------------------------------------}
function RetornarVersaoLayout(const schema: TpcnSchema; const Layout: TpcnTipoLayout): string;
begin
  Result := '0.00';
  if schema = TsPL005c then
  begin
    if Layout = tlAtuCadEmiDFe then
      Result := '1.01';
    if Layout = tlCadEmiDFe then
      Result := '1.01';
    if Layout = tlCancNFe then
      Result := '1.07';
    if Layout = tlConsCad then
      Result := '1.01';
    if Layout = tlConsReciNFe then
      Result := '1.10';
    if Layout = tlConsSitNFe then
      Result := '1.07';
    if Layout = tlConsStatServ then
      Result := '1.07';
    if Layout = tlInutNFe then
      Result := '1.07';
    if Layout = tlNFe then
      Result := '1.10';
    if Layout = tlProcNFe then
      Result := '1.10';
    if Layout = tlProcInutNFe then
      Result := '1.07';
    if Layout = tlRetAtuCadEmiDFe then
      Result := '1.01';
    if Layout = tlRetCancNFe then
      Result := '1.07';
    if Layout = tlRetConsCad then
      Result := '1.01';
    if Layout = tlRetConsReciNFe then
      Result := '1.10';
    if Layout = tlRetConsStatServ then
      Result := '1.07';
    if Layout = tlRetConsSitNFe then
      Result := '1.07';
    if Layout = tlRetEnvNFe then
      Result := '1.10';
    if Layout = tlRetInutNFe then
      Result := '1.07';
    if Layout = tlEnvNFe then
      Result := '1.10';
    if Layout = tlProcCancNFe then
      Result := '1.07';
  end;
end;




{-------------------------------------------------------------------
 Função         : ReverterFiltroTextoXML
 -------------------------------------------------------------------}
function ReverterFiltroTextoXML(aTexto: AnsiString): AnsiString;
begin
  aTexto := StringReplace(aTexto, '&amp;', '&', [rfReplaceAll]);
  aTexto := StringReplace(aTexto, '&lt;', '<', [rfReplaceAll]);
  aTexto := StringReplace(aTexto, '&gt;', '>', [rfReplaceAll]);
  aTexto := StringReplace(aTexto, '&quot;', '"', [rfReplaceAll]);
  aTexto := StringReplace(aTexto, '&#39;', #39, [rfReplaceAll]);
  result := Trim(aTexto);
end;





{-------------------------------------------------------------------
 Função         : ExecutarAjusteTagNro
 -------------------------------------------------------------------}
function ExecutarAjusteTagNro(Corrigir: boolean; Nro: string): string;
begin
  Nro := trim(Nro);
  result := Nro;
  if not corrigir then
    exit;
  if (ValidarNumeros(Nro)) and (length(Nro) = 1) then
    Result := '00' + Nro;
  if (ValidarNumeros(Nro)) and (length(Nro) = 2) then
    Result := '0' + Nro;
end;

{-------------------------------------------------------------------
 Função         : ValidarUF
 -------------------------------------------------------------------}



{-------------------------------------------------------------------
 Função         : IIf
 -------------------------------------------------------------------}
function IIf(const condicao: Boolean; const Verdadeiro, Falso: Variant): Variant;
begin
  if condicao then
    Result := Verdadeiro
  else
    Result := Falso;
end;

function Fc_Ult_Dia_Mes(Pc_Data: TDAte): String;
Var
  Lc_Mes : Integer;
Begin
  Lc_Mes := Fc_Month(Pc_Data);

  if (Lc_Mes=1) or (Lc_Mes=3) or (Lc_Mes=5)  or (Lc_Mes=7) or (Lc_Mes=8) or (Lc_Mes=10) or (Lc_Mes=12) then
    begin
    Result := '31';
    end
  else
    begin
    if (Lc_Mes=2) then
      begin
      Result := '28';
      end
    else
      begin
      Result := '30';
      end;
    end;

end;


{-------------------------------------------------------------------
 Função         : RetornarPosEx
 -------------------------------------------------------------------}
function RetornarPosEx(const SubStr, S: AnsiString; Offset: Cardinal = 1): Integer;
var
  I, X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;


{-------------------------------------------------------------------
 Função         : RetornarAAMM
 -------------------------------------------------------------------}
function RetornarAAMM(const data: TDateTime): string;
var
  ls_Data : string;
begin
  ls_Data := DateToStr(data);
  Result := Copy(ls_Data,9,2) + Copy(ls_Data,4,2);
end;

{-------------------------------------------------------------------
Funcao       : Fc_CriaZero
Exemplo      : Fc_CriaZero('1250','5',True) - Retornar� '01250'
-------------------------------------------------------------------}
function Fc_CriaZero(Fc_Dado: String; Fc_Tamanho : Integer): string;
var
  Lc_Resultado  : string;
  Lc_Zero       : string;
  Lc_I          : Integer;
begin
  Lc_Resultado := copy(Fc_Dado,1,Fc_Tamanho);
  if (Length(Fc_Dado) < Fc_Tamanho) then
  begin
    for Lc_I := 1 to (Fc_Tamanho - Length(Fc_Dado)) do
      begin
      Lc_Zero := '0' + Lc_Zero
      end;
  end;
  Result := Lc_Zero + Lc_Resultado;
end;

function Fc_CriaEspaco(Fc_Dado: String; Fc_Tamanho : Integer):String;
Var
  Lc_Resultado : String;
  Lc_I : Integer;
BEgin
  Lc_Resultado := copy(Fc_Dado,1,Fc_Tamanho);
  if (Length(Fc_Dado) < Fc_Tamanho) then
    Begin
    For Lc_I := 1 to (Fc_Tamanho - Length(Fc_Dado)) do
      Lc_Resultado := Lc_Resultado + ' ';
    end;
  Result := Lc_Resultado;
end;

{-------------------------------------------------------------------
Funcao       : Fc_NumeroCasaDecima
Exemplo      : Fc_NumeroCasaDecima('1250,1234) - Retornar� '4'
-------------------------------------------------------------------}
function Fc_NumeroCasaDecima(Fc_numero:String):Integer;
Var
  Lc_I : Integer;
  Lc_Contar : Boolean;
  Lc_numero : String;
  Lc_Casa : String;
Begin
  Lc_Contar := False;
  For Lc_I := 1 to Length(Fc_numero) do
  Begin
    if (Fc_numero[Lc_I] =',') or (Fc_numero[Lc_I] ='.') then Lc_Contar := True;
    if Lc_Contar and ((Fc_numero[Lc_I] <>',') and (Fc_numero[Lc_I] <>'.')) then Lc_numero := Lc_numero + Fc_numero[Lc_I];
  end;
  Lc_Contar := False;
  For Lc_I := Length(Lc_numero) downto 1 do
    Begin
    if (lc_numero[Lc_I] = '0')and not Lc_Contar then
      Begin
      Lc_Contar := false;
      end
    else
      Begin
      Lc_Contar := true;
      Lc_Casa := lc_numero[Lc_I] + Lc_Casa;
      end;
    end;
  Result := Length(Lc_Casa);
end;




end.

