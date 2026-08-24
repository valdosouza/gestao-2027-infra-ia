unit Un_Funcoes;
{$R-,Q-}   //Switches para desabilitar a chegagem de overflow e de range
           //Para a função de criptografia. Não apagar!
//{$D-} // desabilitar debug
interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls, Registry, QRExport, Excel2000, Un_Liberacao, REST.Json, Json, ControllerDskSyncTable, Vcl.ComCtrls, IdHTTP, Winapi.ShellAPI, System.Math, AnsiStrings, ControllerBase, System.TypInfo, Vcl.DBCtrls, ACBrBase, ACBrValidador;




const
   EOLN=chr(13)+chr(10);   //Usado para fazer fim de linha nos quadros de mensagens
   C1=52845;  //Utilizado para criptogravar os dados
   C2=22719;  //Utilizado para criptogravar os dados



{Protítipo das funções da unidade}
function StrTran(Entra: string ; Search: string ; Replace : string): string;
function StrZero(Num : Real ; Zeros,Deci: integer): string;
function Alltrim(Text : string) : string;

function Fc_DesNum (lcN_Numero : Real; Lc_Feminino : Boolean = False) : string;
function Fc_ValExt(lcN_Valor : Currency; Const Lc_Singular, Lc_Plural : String) : string;
function Fc_DesMes(lcN_nummes : integer; Lc_Upper : Boolean) : string;

function Fc_ValData (lcS_Data : string) : Boolean;
function Fc_ConvPrimeiraLetra (lcS_String : string) : string;
function Fc_Day (Data : TDateTime) : Integer;
function Fc_Month (Data : TDateTime) : Integer;
function Fc_Year (Data : TDateTime) : Integer;
Function FormataInteiro(Lc_Inteiro : Integer) : string;

function Encrypt_New(const Lc_Valor : string; Lc_Chave: Word) : String;
function Decrypt_New(const Lc_Valor : string; Lc_Chave: Word) : String;
function Pad(AValue: String; const ALength: Integer; const ASide: TAlignment): String;
function PadL(AValue: String; const ALength: Integer): String;
function PadR(AValue: String; const ALength: Integer): String;

function Fc_RemoveEspacos(Lc_Texto : string) : string;
function Fc_RemoveAspasSimples(Lc_Texto : string) : string;
function Fc_RemoveCaracterInformado(Str: String; Caracteres: Array of String): String;
function RemoveCaracterInformado(Str: String; Caracteres: Array of String): String;
procedure Fc_Porcentagem(Lc_TitForm, Lc_TitGeral, Lc_TitAtual : string; Lc_Total, Lc_Atual : integer; Lc_Operacao : Char);
function UltDiaDoMes(Data: TDateTime): Word;
//function Password(const Lc_Nivel, Lc_Msg, Lc_Ocorrencia: string;const Lc_TipoAto : String = ' ';
//                  Lc_TipoOcorre : String = ' ';Lc_Codigo : String = '0000000') : boolean;

function AjustaStr ( str: String; tam: Integer ): String;
function Fc_TestaDrive(Lc_Drive : String; var Lc_Livre : Integer) : Boolean;
Function Fc_BuscaTamArquivo(Lc_Arquivo : String) : Integer;
function Fc_CalcIdade(Lc_Nas : TDateTime; Lc_Data : TDateTime) : Double;
Procedure Pc_DestroiPreview;
function Upper(InString: string): string;
function getPathExe:String;


//novas Funções  - 20/07/2011

function Fc_GetIPFromNet():String;
function Fc_NomeComputador: string;
function Fc_SubstituirCaracteres(S: String; C1: String; C2: String): String;
function Fc_DeleteFolder(FolderName: String; LeaveFolder: Boolean): Boolean;
function Fc_ArredondarParaBaixo(Fc_Valor:Real;Fc_Casas:Integer;Fc_Forcar:Boolean):Real;
function Fc_ArredondarParaCima(Value: Extended; Decimals: Integer): Extended;
Function Fc_RetornaSequenciaLista(Fc_Lista:TStringList):Integer;
Function Fc_RetornaListaSequenciaFaltante(Fc_Lista:TStringList):TStringList;
function fc_justr(s : string; tamanho : integer) : string;
function fc_justl(s : string; tamanho : integer) : string;
function ObterVersaoWindows: String;
function Fc_QuotedStr(const S: string): string;
procedure Pc_PreenceCelulaExcel(Pc_Formata:Boolean;
                                Pc_Sheet:Variant;
                                Pc_Linha,
                                Pc_ColIni,
                                Pc_ColFim,
                                Pc_ColWith:Integer;
                                Pc_Aling:Integer;
                                Pc_Formato:String;
                                Pc_Valor:Variant);

  function Fc_BuscaCodigoEstado(Fc_Sigla:String): Integer;
  function Fc_BuscaCodigoCidade(fc_IBGE:Integer; Fc_Descricao,Fc_UF:String): Integer;


  function ValidaDiretorio(Dir: string): Boolean;
  function getCamposJsonString(json,value:String): String;
  procedure updateTableSync(Tabela, pSentido: String; tempo: TDateTime);
  function RetiraEnter(aText : string): string;

  Procedure EnblControl( pr_control: tWinControl );
  Procedure DsblControl( pr_control: tWinControl );

  Function unMaskField(Text:String):String;
  function  ValidDocFiscal(doc:String):String;
  function CalculoCnpj(xCGC: string): Boolean;
  function CalculoCpf(xCPF: string): Boolean;


{Classe padrao de espera para porcentagem feita}
type TPorcentagem = class(TComponent)
    Form        : TForm;
    L_Titulo    : TLabel;
    PB_Progresso: TProgressBar;
    L_Fazendo   : TLabel;

    procedure SetCaption(Value : string);
    procedure SetTitulo(Value : string);
    procedure SetTotPorcento(Value : Integer);
    procedure SetNomeFazendo(Value : String);
    procedure SetValue(Value : Integer);
    procedure SetColor(Value : TColor);
    procedure SetMostraFazendo(Value : Boolean);
    function GetValue: Integer;
public
   Constructor Create(AOwner : TComponent); override;
   destructor Destroy; override;
   Procedure Show;
   property Caption : string write SetCaption;
   property Titulo : string write SetTitulo;
   property TotPorcento : integer write SetTotPorcento;
   property NomeFazendo : string write SetNomeFazendo;
   property Value : Integer read GetValue write SetValue;
   property Color : TColor write SetColor;
   property NomeFazendoEnabled : Boolean Write SetMostraFazendo default True;

end;




var

   Fr_Espera : TPorcentagem;
  {----------------- Variaveis globais do sistema ----------------------}
   // OBSERVAÇÃO: Se quiser inicializar com valor DEFAULT coloque na
   // un_senha na última função (Begin...End)

   // Tabela_Funcionario : TwwDBISAMTable;
   //--------------------------
   //Codigo, nome, cargo e nivel do funcionario
   //que acessou o programa
   //--------------------------
   Pbl_Codigo_Funcionario : string[4];
   Pbl_Nome_Funcionario   : string;
   Pbl_CPF_Funcionario    : string[11];
   Pbl_Cargo_Funcionario  : string;
   Pbl_Nivel_Funcionario  : string[1];

   //--------------------------
   //Codigo, nome, cargo e nivel do funcionario
   //que liberou, ou seja passou a sua senha para liberacao
   //inicialmente é o mesmo do funcionario que acessou o programa
   //porem em algum momento que o programa solicite a senha
   //esta será guardada nestas variaveis, até que novamente seja
   //solicitada
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
   Pbl_LigaCorretor     : String[1];   //se liga o Corretor Ortográfico S OU N
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
   Pbl_NAcessosMesPRT : String[4];   //numero de acesso no mes, nao ultrapassar a 200 (controle senha mensal)
implementation

uses     Un_Msg, Un_dm, UN_Sistema, UN_Principal, env, Un_Regra_Negocio;
 
function Fc_RemoveEspacos(Lc_Texto : string) : string;
var
   Lc_Idx : Integer;
begin
   Result := '';
   For Lc_Idx := 1 to Length(Lc_Texto) do
      if Lc_Texto[Lc_Idx] <> ' ' then
         Result := Result + lc_Texto[Lc_Idx];
end;

function Fc_RemoveAspasSimples(Lc_Texto : string) : string;
var
   Lc_Idx : Integer;
begin
   Result := '';
   For Lc_Idx := 1 to Length(Lc_Texto) do
      if Lc_Texto[Lc_Idx] <> Chr(39) then
         Result := Result + lc_Texto[Lc_Idx];
end;

{-------------------------------------------
 Função : Fc_DesNum
 Descrição : Descreve um número decimal. O número não pode ter mais
             de nove casa decimais.
 Recebe  : O Número a ser descrito.
           Lc_Feminino =  se deve fazer os numeros no femenino
 Retorna : A descrição do número.
 -------------------------------------------}
function Fc_DesNum (lcN_Numero : Real; Lc_Feminino : Boolean = False) : string;
var
   lcA_Numeros : array[1..900] of string;  {Tabela com as descrições dos Números}
   lcS_num9   : string;                    {Numero Convertido para string}

   lcA_num3,                               {Números que seráo trabalhados}
   lcA_num1 : array[1..3] of string;

   lcA_des3,                               {Tabelas de descrições}
   lcA_des1 : array[1..3] of string;

   lcN_idx,                                {Indices de arrays}
   lcN_idx1,
   lcN_idx2,
   lcN_Code : integer;                     {Código de retorno da função VAL}
begin
   //testa se dever colocar no feminino
   //os numeros ou no masculino
   if Lc_Feminino then
   begin
     lcA_Numeros[001] := 'uma';               {Criação da tabela com as}
     lcA_Numeros[002] := 'duas';             {descrições}
   end
   else
   begin
     lcA_Numeros[001] := 'um';               {Criação da tabela com as}
     lcA_Numeros[002] := 'dois';             {descrições}
   end;
   lcA_Numeros[003] := 'trás';
   lcA_Numeros[004] := 'quatro';
   lcA_Numeros[005] := 'cinco';
   lcA_Numeros[006] := 'seis';
   lcA_Numeros[007] := 'sete';
   lcA_Numeros[008] := 'oito';
   lcA_Numeros[009] := 'nove';
   lcA_Numeros[010] := 'dez';
   lcA_Numeros[011] := 'onze';
   lcA_Numeros[012] := 'doze';
   lcA_Numeros[013] := 'treze';
   lcA_Numeros[014] := 'quatorze';
   lcA_Numeros[015] := 'quinze';
   lcA_Numeros[016] := 'dezesseis';
   lcA_Numeros[017] := 'dezessete';
   lcA_Numeros[018] := 'dezoito';
   lcA_Numeros[019] := 'dezenove';
   lcA_Numeros[020] := 'vinte';
   lcA_Numeros[030] := 'trinta';
   lcA_Numeros[040] := 'quarenta';
   lcA_Numeros[050] := 'cinquenta';
   lcA_Numeros[060] := 'sessenta';
   lcA_Numeros[070] := 'setenta';
   lcA_Numeros[080] := 'oitenta';
   lcA_Numeros[090] := 'noventa';
   lcA_Numeros[100] := 'cento';
   lcA_Numeros[200] := 'duzentos';
   lcA_Numeros[300] := 'trezentos';
   lcA_Numeros[400] := 'quatrocentos';
   lcA_Numeros[500] := 'quinhentos';
   lcA_Numeros[600] := 'seiscentos';
   lcA_Numeros[700] := 'setecentos';
   lcA_Numeros[800] := 'oitocentos';
   lcA_Numeros[900] := 'novecentos';

   lcA_des3[1] := ' ';
   lcA_des3[2] := ' ';
   lcA_des3[3] := ' ';
   lcS_num9 := strzero(lcN_Numero,9,0);

   lcA_num3[1] := copy(lcS_num9,1,3);           {Copia as centenas para}
   lcA_num3[2] := copy(lcS_num9,4,3);           {as respectivas variáveis}
   lcA_num3[3] := copy(lcS_num9,7,3);

   for lcN_idx := 1 to 3 do
   begin
      for lcN_idx1 := 1 to 3 do
      begin
         lcA_des1[lcN_idx1] := ' ';
         lcA_num1[lcN_idx1] := copy (lcA_num3[lcN_idx],lcN_idx1,1);
      end;

      repeat
         if ((lcA_num1[1] = '1') and (lcA_num1[2] = '0') and (lcA_num1[3] = '0')) then
         begin
            lcA_des3[lcN_idx] := 'cem';
            break;
         end
         else
         begin
            if lcA_num1[1] <> '0' then
            begin
               val (lcA_num1[1] + '0' + '0',lcN_idx2,lcN_Code);
               lcA_des1[1] := lcA_Numeros[lcN_idx2];
            end;
         end;

         if (lcA_num1[2] = '1') then
         begin
            val (lcA_num1[2] + lcA_num1[3],lcN_idx2,lcN_Code);
            lcA_des1[2] := lcA_Numeros[lcN_idx2];
         end
         else
         begin
            if (lcA_num1[2] <> '0') then
            begin
               val (lcA_num1[2] + '0',lcN_idx2,lcN_Code);
               lcA_des1[2] := lcA_Numeros[lcN_idx2];
            end;

            if (lcA_num1[3] <> '0') then
            begin
               val(lcA_num1[3],lcN_idx2,lcN_Code);
               lcA_des1[3] := lcA_Numeros[lcN_idx2];
            end;
         end;

         if lcA_des1[1] <> ' ' then
         begin
            lcA_des3[lcN_idx] := lcA_des1[1];
         end;

         for lcN_idx1 := 2 to 3 do
         begin
            if lcA_des1[lcN_idx1] <> ' ' then
            begin
               if lcA_des3[lcN_idx] <> ' ' then
                  lcA_des3[lcN_idx] := lcA_des3[lcN_idx]+' e '+lcA_des1[lcN_idx1]
               else
                  lcA_des3[lcN_idx] := lcA_des1[lcN_idx1];
            end;
         end;
         break;
      until True;
   end;

   Result := ' ';
   if lcA_des3[1] <> ' ' then
   begin
      if lcA_des3[1] = 'um' then
      begin
         Result := lcA_des3[1] + ' milhões';
      end
      else
      begin
         Result := lcA_des3[1] + ' milhôes';
      end;
   end;

   if lcA_des3[2] <> ' ' then
   begin
      if Result <> ' ' then
      begin
          Result := Result + ', ' + lcA_des3[2] + ' mil';
      end
      else
      begin
          Result := lcA_des3[2] + ' mil';
      end;
   end;

   if lcA_des3[3] <> ' ' then
   begin
      if Result <> ' ' then
      begin
         Result := Result + ' e '+lcA_des3[3];
      end
      else
      begin
         Result := lcA_des3[3];
      end;
   end;

   if lcN_Numero = 0 then
   begin
      Result := 'zero'
   end;
end;
{Fim de Fc_DesNum}

{----------------------------------------
 Funcao..: Descreve um valor por extenso.
 Recebe..: Valor a ser descrito, no formato de moeda (currency)
 Retorna.: A descrição do valor.
 ----------------------------------------}
function Fc_ValExt(lcN_Valor : Currency; Const Lc_Singular, Lc_Plural : String) : string;
var lcS_exten : string;
    lcN_cent : Currency;
begin
    lcS_exten := '____________';
    if lcN_Valor <> 0.00 then
    begin
       lcS_exten:= Format ('%m',[lcN_Valor]); {Formata para moeda de acordo}
                                              {com as configurações no painel de}
                                              {controle - Config. Regional}
       lcS_exten:=lcS_exten + ' ('+fc_desnum(int(lcN_Valor))+' ';
       if int(lcN_Valor) <> 1.00 then
       begin
           lcS_exten:=lcS_exten + Lc_Plural;
       end
       else
       begin
          lcS_exten:=lcS_exten + Lc_Singular;
       end;

       lcN_cent:=Frac(lcN_Valor)*100;
       if lcN_Cent <> 0 then
       begin
          lcS_exten:=lcS_exten + ' e '+fc_desnum(int(lcN_cent));
          lcS_exten:=lcS_exten + ' centavo';
          if int(lcN_cent) > 1.00 then
          begin
              lcS_exten:=lcS_exten + 's';
          end
       end;
       lcS_exten:=lcS_exten + ')';
    end;
    Fc_ValExt := lcS_exten;
end;
{Fim de Fc_ValExt}

{---------------------------------------------
 Função : Retorna a descrição do mês.
 Recebe : O valor numérico do mês que se deseja
          a descrição
          Lc_upper se quiser que a primeira letra volte maiuscula
 Retorna : A descrição do mês em forma de string
 ---------------------------------------------}
function Fc_DesMes(lcN_nummes : integer; Lc_Upper : Boolean) : string;
var
    lcA_Mes : array [1..12] of string;
begin
   lcA_Mes[01] := 'janeiro';
   lcA_Mes[02] := 'fevereiro';
   lcA_Mes[03] := 'março';
   lcA_Mes[04] := 'abril';
   lcA_Mes[05] := 'maio';
   lcA_Mes[06] := 'junho';
   lcA_Mes[07] := 'julho';
   lcA_Mes[08] := 'agosto';
   lcA_Mes[09] := 'setembro';
   lcA_Mes[10] := 'outubro';
   lcA_Mes[11] := 'novembro';
   lcA_Mes[12] := 'dezembro';
   if (lcN_nummes = 0) or (lcN_nummes > 12) then
   begin
      Fc_DesMes := '______________';
   end
   else
   begin
      //que que volte com a primeira letra maiuscula
      if Lc_Upper then
         Fc_DesMes := Copy(UpperCase(lcA_Mes[lcN_nummes]),1,1)+Copy(lcA_Mes[lcN_nummes],2,Length(lcA_Mes[lcN_nummes])-1)
      else
         Fc_DesMes := lcA_Mes[lcN_nummes];
   end;

end;
{Fim de Fc_DesMes}


{------------------------------------------
 Funcao : Verifica se uma data é valida, é
   responsável também por acrescentar o número
   do século quando este é omitido e colocar zeros
   na frente de números que não possuam
 Recebe :  LcS_Data = Data a ser verificada
                      no formato 99/99/9999.
           LcB_Valido = Variavel Booleana que ira retornar
                        se a data é valida ou não.
 Retorna : A data convertida.
 ------------------------------------------}
function Fc_ValData (lcS_Data : string) : Boolean;
var lcN_Dia,
    lcN_Mes,
    lcN_Ano : integer;
    LcB_Valida : Boolean;
begin
     LcN_Dia:= 0;
     LcN_Mes:= 0;
     LcN_Ano:= 0;

     lcS_Data := StrTran (lcS_Data,'/','');
     LcB_Valida := True;
     if (length(Trim(lcS_Data)) > 0) then
     begin
         if Trim(copy (lcS_Data,1,2)) <> '' then
         begin
             lcN_Dia := StrToInt(Trim(copy (lcS_Data,1,2)))
         end
         else
         begin
             lcN_Dia := 0;
         end;

         if Trim(copy (lcS_Data,3,2)) <> '' then
         begin
             lcN_Mes := StrToInt(Trim(copy (lcS_Data,3,2)));
         end
         else
         begin
             lcN_Mes := 0;
         end;

         if Trim(copy (lcS_Data,5,4)) <> '' then
         begin
             try
                 lcN_Ano := StrToInt(Trim(copy (lcS_Data,5,4)));
             except
                on EConvertError do
                begin
                  lcN_Dia := 0;
                  lcN_Ano := 0;
               end;
             end;
         end
         else
         begin
             lcN_Dia := 0;
             lcN_Ano := 0;
         end;

         if (lcN_Ano < 100) then
         begin
            if (lcN_Ano >= 80) then
              lcN_Ano := LcN_Ano + 1900
            else
              lcN_Ano := LcN_Ano + 2000;
         end;

         if (LcN_Mes = 0) or (LcN_Mes > 12) or (lcN_Dia = 0) or (LcN_Dia > 31) then
         begin
             LcB_Valida := False;
         end
         else
         begin
             if (lcN_Dia = 29) and (lcN_Mes = 2) and ((lcN_Ano mod 4) <> 0) then
             begin
                 LcB_Valida := False;
             end;
             if (lcN_Dia = 30) and (lcN_Mes = 2) then
             begin
                 LcB_Valida := False;
             end;
             if (lcN_Dia = 31) and
                ((LcN_Mes = 2) or (LcN_Mes = 4) or (LcN_Mes = 6) or
                 (LcN_Mes = 9) or (LcN_Mes = 11)) then
             begin
                 LcB_Valida := False;
             end;
         end;
     end;

     { Valor de retorno da função}
  Result := lcB_Valida
end;
{------ Fim de Fc_ValData -------}



{----------------------------------------------------
  Função : Converte as primeiras letras de uma strings em letra maiuscula
  Recebe : A string a ser convertida
  Retorna : A string com as primeiras letras em maiusculo e as outras em minusculo
-----------------------------------------------------}
function Fc_ConvPrimeiraLetra (lcS_String : string) : string;
var
   Lc_Char : String;
   Lc_Idx  : Integer;
begin
   Lc_Char := '';
   Result  := '';
   LcS_String := AnsiLowerCase(lcS_String);
   for Lc_Idx:= 1 to length(lcS_String) do
   begin
      if Lc_Char = '' then
         Lc_Char := AnsiUpperCase(copy(lcS_String,Lc_Idx,1))
      else
         Lc_Char := copy(lcS_String,Lc_Idx,1);
      Result := Result+Lc_Char;
      if copy(lcS_String,Lc_Idx,1) = ' ' then
         Lc_Char := '';
   end;
end;


{---------------------------------------------------}
{                                                   }
{Definição da classe padrão para mostrar porcentagem}
{                                                   }
{---------------------------------------------------}
{Metodo de criacao da classe}
Constructor TPorcentagem.Create(AOwner : TComponent);
begin
   inherited Create(AOwner);
   Form := TForm.CreateNew(Application);
   with Form do begin
      Position:=PoScreenCenter;
      BorderIcons:=[];
      BorderStyle:=bsDialog;
      Scaled:=False;
      Height:=100;
      Width:=528;
   end;

   L_Titulo := TLabel.Create(Form);
   with L_Titulo do begin
      Parent:=Form;
      Align := alClient;
      Alignment := taCenter;
      Color := clNavy;
      {Ajusta as propriedades da fonte}
      Font.Name := 'Arial';
      Font.Size := 14;
      Font.Style := [fsBold];
      Font.Color := clYellow;
      Caption    := ' ' //'Abrindo banco de dados, aguarde...';
   end;

   PB_Progresso := TProgressBar.Create(Form);
   with PB_Progresso do begin
      Parent:=Form;
      Left:=20;
      Top:=30;
      Width:=480;
   end;

   L_Fazendo := TLabel.Create(Form);
   with L_Fazendo do begin
      Parent:=Form;
      Color := clNavy;
      AutoSize := False;
      {Ajusta as propriedades da fonte}
      Font.Name  := 'Arial';
      Font.Size  := 10;
      Font.Style := [fsBold];
      Font.Color := clAqua;
      Caption    := ' ';
      Left:=20;
      Top:=55;
      Width := 480;
   end;
end;

{Destrutor da classe}
Destructor TPorcentagem.Destroy;
begin
   FreeAndNil(Form);
   inherited Destroy;
end;

{Altera o titulo da porcentagem}
procedure TPorcentagem.SetCaption(Value : string);
begin
   Form.Caption := Value;
   Application.ProcessMessages;
end;

{Metodo Show do formulário - Mostra e remonta o formulário}
procedure TPorcentagem.Show;
begin
   Form.Show;
   Form.Refresh;
end;

{Altera o titulo da porcentagem}
procedure TPorcentagem.SetTitulo(Value : string);
begin
   L_Titulo.Caption := Value;
   L_Titulo.Refresh;
end;

{Ajusta Numero Total de Arquivos}
procedure TPorcentagem.SetTotPorcento(Value : integer);
begin
   PB_Progresso.Max:=Value;
end;

// Ajusta Nome do Arquivos
procedure TPorcentagem.SetNomeFazendo(Value : String);
begin
   PB_Progresso.Position:= PB_Progresso.Position+1;
   L_Fazendo.Caption:=Value;
   L_Fazendo.Refresh;
end;

// Acerta o valor atual da porcentagem
procedure TPorcentagem.SetValue(Value : Integer);
begin
   PB_Progresso.Position:=Value;
   L_Fazendo.Refresh;
end;

// Pega o valor atual da porcentagem
function TPorcentagem.GetValue : Integer;
begin
   Result := PB_progresso.Position;
end;

// Ajusta a cor do formulário
procedure TPorcentagem.SetColor(Value : TColor);
begin
   L_Titulo.Color := Value;
   L_Fazendo.Color := Value;
end;

// Ajusta se está é para mostrar o label fazendo ou True
procedure TPorcentagem.SetMostraFazendo(Value : Boolean);
begin
   if Value = False then
   begin
      //Apaga o label e redimensiona o formulário
      L_Titulo.Caption  := '';
      L_Fazendo.Visible := False;
      PB_Progresso.Top := PB_Progresso.Top - 22;
      Form.Height := Form.Height - L_Fazendo.Height - 25;
   end
   else
   begin
      //Apaga o label e redimensiona o formulário
      L_Fazendo.Visible := True;
      PB_Progresso.Top := PB_Progresso.Top + 22;
      Form.Height := Form.Height + L_Fazendo.Height + 25;
   end;
end;

{---------------------------------------------------------------
 Procecure que monta e mostra tela de porcentagem
 Recebe  Lc_TitForm  - é o titulo que aparecera no topo do formulario
                        Ex: Configuração so Sistema
         Lc_TitGeral - é o titulo da funcao que esta fazendo
                        Ex: Abrindo arquivos, aguarde...
         Lc_TitAtual - é o titulo do que esta fazendo no momento
                       se nao passar será menor (somente grade de progressao)
                       se vier com (P) calcula e mostra porcento %
                       Ex: Abrindo arquivo de Feriados.
         Lc_Total    - qual o valor total da procentagem
         Lc_Atual    - é o valor atual da porcentagem
         Lc_Operacao - I - cria a grade de porcentagem (quando entra)
                           antes de comecar a porcentagem deve mandar este paramentro
                       M - mostra porcentagem
                       F - fim de mostra porcentagem
                           quando terminar a porcentagem deve mandar este parametro
 Obs: Os parametro Lc_TitForm,Lc_TitGeral basta passar na primeira vez quando cria o formulario.
      Se nao passar o Lc_TitAtual o formulario de porcentagem sera menor
      Se pasara no Lc_TitAtual a letra P, sera mostrado a porcentagem em numero
 ------------------ 	----------------------------------------------}
procedure Fc_Porcentagem(Lc_TitForm, Lc_TitGeral, Lc_TitAtual : string; Lc_Total, Lc_Atual : integer; Lc_Operacao : Char);
begin
   //so para nao dar erro quando entrar
   If Lc_Total = 0 then
      Lc_Total:=1;
   If Lc_Atual = 0 then
      Lc_Atual:=1;

   case Lc_Operacao of
      //operacao incial monta o formulario
      'I' :
          begin
             //Muda o cursor para a ampulheta
             //Screen.Cursor := crHourGlass;
             //Cria o formulário de espera de abertura do banco de dados
             Fr_Espera := TPorcentagem.Create(Application);
             Fr_Espera.Titulo := Lc_TitGeral;
             Fr_Espera.TotPorcento := Lc_Total;
             Fr_Espera.Caption := Lc_TitForm;
             //desliga a opcao de nome fazendo se nao passar o parametro
             if Lc_TitAtual = '' then
                Fr_Espera.NomeFazendoEnabled := False;
             //Mostra o formulário
             Fr_Espera.Show;
          end;
      //mostra fazendo porcentagem
      'M' :
          begin
            //nao mostra a opcao de nome fazendo se nao passar o parametro
            if Lc_TitAtual <> '' then
            begin
               // se passou o parametro (P) mostra porcentagem (valor numerico de porcento feito)
               if Lc_TitAtual = 'P' then
               begin
                  Fr_Espera.NomeFazendo:='Fazendo:  '+IntToStr(Lc_Atual)+'/'+IntToStr(Lc_Total)+'     '+IntToStr(Lc_Atual * 100 div Lc_Total)+'%';
               end
               else
               begin
                  Fr_Espera.NomeFazendo:=Lc_TitAtual;
               end;
            end;
            Fr_Espera.Value := Lc_Atual;
          end;
      //desmonta formulario e libera area
      'F' :
          begin
             //Muda o cursor novamente para seta
             //Screen.Cursor := crDefault;
             Fr_Espera.Destroy;
          end;
   end;
end;

{----------------------------}
{                            }
{ Fim da clase Porcentagem   }
{                            }
{----------------------------}

{--------
 Funcao : Retorna o dia de uma determinada data
 --------}
function Fc_Day (Data : TDateTime) : Integer;
begin
   Result := StrToIntDef(Copy(DateToStr(Data),1,2),1);
end;

{--------
 Funcao : Retorna o mes de uma determinada data
 --------}
function Fc_Month (Data : TDateTime) : Integer;
begin
   Result := StrToIntDef(Copy(DateToStr(Data),4,2),1);
end;

{--------
 Funcao : Retorna o ano de uma determinada data
 --------}
function Fc_Year (Data : TDateTime) : Integer;
begin
   Result := StrToIntDef(Copy(DateToStr(Data),7,4),1);
end;


{--------------------------------------------------------
 função para Cliptografar (Nova)
 --------------------------------------------------------}
function Encrypt_New(const Lc_Valor : String; Lc_Chave : Word) : String;
var
   mensx : string;
   l     : integer;
   i     : integer;
   j     : integer;
const
   ch = 'RarbOcodNenfAgahLiljDkolmSnsoCpcqHrhsMwmxIyizTtzhk';
begin
   j:= 0;
   mensx := '';
   for i := 1 to length(Lc_Valor) do
      begin
        j := j+1;
        //verifica se passou do tamanho da chave, volta ao inicio
        If (j > length(ch)) then
           j:=1;
    //    l:= Asc(SubStr(Lc_Valor, i, 1)) + Asc(SubStr(ch, j, 1));
        if (j = 50) then
             j:= 1;
        if (l > 255) then
             l:= l - 256;
        mensx := mensx + Chr(l)
     end;
  Encrypt_New := mensx;
end;

{--------------------------------------------------------
 função para Descriptografar Nova
 --------------------------------------------------------}
function Decrypt_New(const Lc_Valor : String; Lc_Chave : Word) : String;
var
   mensx : string;
   l     : integer;
   i     : integer;
   j     : integer;
const
   ch = 'RarbOcodNenfAgahLiljDkolmSnsoCpcqHrhsMwmxIyizTtzhk';
begin
   j:= 0;
   mensx := '';
   for i := 1 to length(Lc_Valor) do
      begin
        j := j+1;
//        l := asc(copy(Lc_Valor, i, 1)) - asc(copy(ch, j, 1));
        if (j = 50) then
            j:= 1;
        if (l < 0) then
            l := l + 256;
        mensx := mensx + chr(l);
     end;
   Decrypt_New := mensx;
end;

{---------------------------------------------------------------------------
 Metodo : Captura uma senha e verifica se a senha tem permissão
          suficiente para realizar a ação, gera ocorrência
 OBS    : se for a primeira vez carrega conteúdos para variáveis
          verifica também se veio através de parametros
 Recebe : Lc_Nivel : Nivel para acesso é operação
          Lc_Msg   : Título da janela que permite a entrada da senha
          Lc_Ocorrencia: Se for para gerar ocorrência -> Ocorrência
          Lc_TipoAto : Quando gerar ocorrência também grava o tipo de ato
          Lc_TipoOcorre: Grava o tipo de ocorrência ex: E-Exclusão, A-Alteração,
                         I-Impressão, C-Config;
          Lc_Códgo : Grava o codigo referente a ocorrência ex: 0000567 (Protocolo Tbl)
 ----------------------------------------------------------------------------}
{function Password(const Lc_Nivel,
                        Lc_Msg,
                        Lc_Ocorrencia: string;
                  const Lc_TipoAto : String = ' ';
                        Lc_TipoOcorre : String = ' ';
                        Lc_Codigo : String = '0000000') : boolean;
var
   Lc_Open    : boolean;
   Lc_Existe  : boolean;
   Lc_NivelOK : boolean;
   Lc_SenhaArquivo : String;
   Lc_Posicao : ShortInt;
   Lc_AutoInc : string[7];
begin
   Lc_Existe  := False;
   Lc_NivelOK := False;
   Lc_Open    := False;
   // verifica se entrou com parametros entao libera entrada
   // se entrou com parametro OK libera acesso
   if (ParamCount > 2) and (ParamStr(3) = 'OK') Then
   begin
      Result := True;
      exit;
   end;
   // Define a posicao que vai avaliar o nível do Usuário de acordo com o sistema
   Lc_Posicao := 9;

   // Abre table de funcionarios para abrir files - aqui té ok!
   if not DM.Tb_Usuario.Active then
      DM.Tb_Usuario.Open
   else
      Lc_Open:=True;  // marca que já estava aberto

   // Captura a senha de acesso
 //  Fr_Senha.Modo := 'E';
   Fr_Senha.Caption := Lc_Msg; // Muda o título do funcionário
   Fr_Senha.ShowModal;

   // Vindo ok a senha
   if Fr_Senha.ModalResult = mrOk then
   begin
//      DM.Tb_Usuario.IndexFieldNames := 'CODIGO';
      DM.Tb_Usuario.First;  // vai p/ o 1º elemento
      // Captura nome e cargo do oficial (1º Registro do cadastro de funcionários)
      //Pesquisa sequencialmente no registro até achar código do funcionário q bata com a senha
      while (not DM.Tb_Usuario.EOF) and (not Lc_Existe) do
      begin
        // verifica se a senha existe
        Lc_SenhaArquivo := Trim(Copy(Decrypt_New(DM.Tb_Usuario.FieldByName('SENHA').AsString,1998),1,8));
        if (Trim(Fr_Senha.Senha) = Lc_SenhaArquivo) or (Trim(FR_Senha.Senha) = 'ALASLM') then
        begin
          Lc_Existe := True;
          // verifica se é a1º vez q está entrando então carrega
          // variáveis (se codigo_funcionario = 0000
          if Pbl_Codigo_Funcionario = '0000' then //se for 1º vez q está entrando
          begin
            Pbl_Codigo_Funcionario := DM.Tb_Usuario.FieldByName('CODIGO').AsString;
            Pbl_Nome_Funcionario   := DM.Tb_Usuario.FieldByName('NOME').AsString;
            Pbl_CPF_Funcionario    := DM.Tb_Usuario.FieldByName('CPF').AsString;
            Pbl_Cargo_Funcionario  := DM.Tb_Usuario.FieldByName('CARGO').AsString;


            if (Trim(FR_Senha.Senha) = 'ALASLM') then
               Pbl_Nivel_Funcionario := '1'
            else
                Pbl_Nivel_Funcionario := Copy(Decrypt_New(DM.Tb_Usuario.FieldByName('SENHA').AsString,1998),Lc_Posicao,1);



            //assume que é o mesmo funcionario que entrou
            Pbl_Codigo_Senha := Pbl_Codigo_Funcionario;
            Pbl_Nome_Senha   := Pbl_Nome_Funcionario;
            Pbl_Nivel_Senha  := Pbl_Nivel_Funcionario;

            Lc_NivelOK := True;
            Pbl_Acesso := DM.Tb_Usuario.FieldByName('ACESSOS').AsString;

            if (Trim(FR_Senha.Senha) = 'ALASLM') then
               Pbl_Acesso:='********************';
          end
          else
            begin
               // testa se nivel é permitido para esta operação
               If StrToIntDef(Copy(Decrypt_New(DM.Tb_Usuario.FieldByName('SENHA').AsString,1998),Lc_Posicao,1),5) <= StrToIntDef(Lc_Nivel,1) then
                  Lc_NivelOK := True
               else
                  Lc_NivelOK := (Date = DM.Tb_Usuario.FieldByName('Hora').AsDateTime) and
                                (TimetoStr(Now) <= TimetoStr(DM.Tb_Usuario.FieldByName('Hora').AsDateTime));

               If Lc_NivelOk Then
               Begin
              // Variável Pública Auxiliar para Verificação de Codigo,Nome,Nivel entrado
              // apàsa primeira entrada do sistema.... Capturar quem está acessando a password
              Pbl_Codigo_Senha := DM.Tb_Usuario.FieldByName('CODIGO').AsString;
              Pbl_Nome_Senha   := DM.Tb_Usuario.FieldByName('NOME').AsString;
              If (Trim(FR_Senha.Senha) = 'ALASLM') then
                 Pbl_Nivel_Senha  := '1'
              else
                 Pbl_Nivel_Senha := Copy(Decrypt_New(DM.Tb_Usuario.FieldByName('SENHA').AsString,1998),Lc_Posicao,1);
            end;
          end;
        end;
        DM.Tb_Usuario.Next;
      end;

      if not Lc_Existe then
      begin
         MensagemPadrao('SISPROT - Captura de senha',
                        'Senha não está cadastrada. Verifique...'+EOLN,
                        ['Continuar'],[bEscape],mpErro);
         Lc_NivelOK := False;
      end else
      begin
         if not Lc_NivelOK then
         begin
            MensagemPadrao('SISPROT - Captura de senha',
                          'Usuário não pode realizar a operação escolhida.'+EOLN,
                          ['Continuar'],[bEscape],mpErro);
            Lc_NivelOK := False;
         end;
      end;
   end;

   Result := Lc_NivelOK;

   // Fecha a tabela de funcionarios
   if not Lc_Open then
      DM.Tb_Usuario.Close;

   if (Fr_Senha.ModalResult = mrCancel) and
      (Lc_Msg = 'Acesso Inicial') then
      Application.Terminate;
end;    }

{---------------------------------------------------------------------------
 Metodo : Gerar Ocorrencia sem pedir senha de liberacao
 Recebe : Lc_Ocorrencia: Se for para gerar ocorrência -> Ocorrência
          Lc_TipoAto : Quando gerar ocorrência também grava o tipo de ato
          Lc_TipoOcorre: Grava o tipo de ocorrência ex: E-Exclusão, A-Alteração,
                         I-Impressão, C-Config;
          Lc_Códgo: Grava o codigo referente a ocorrência ex: 0000567 (Protocolo Tbl)
 ----------------------------------------------------------------------------}
{function Fc_Ocorrencia(const Lc_Ocorrencia : String;
                       const Lc_TipoAto    : String = ' ';
                             Lc_TipoOcorre : String = ' ';
                             Lc_Codigo     : String = '0000000') : Boolean;
var
  Lc_ArquivoJaAberto:Boolean;
  Lc_ArquivoJaAbertoUsuario:Boolean;
Begin
  Result := False;
  Lc_ArquivoJaAbertoUsuario := DM.Tb_Usuario.Active;
  Lc_ArquivoJaAberto := DM_Tab.T_Ocorrencia.Active;
  // se gerar Ocorrência
  if not Empty(Lc_Ocorrencia) then
  begin
    Try
     If not Lc_ArquivoJaAbertoUsuario then
        Fc_Rede(DM.Tb_Usuario,'Open','Usuários','Arquivo em uso...',5,0,0);
     If not Lc_ArquivoJaAberto then
        Fc_Rede(DM_Tab.T_Ocorre,'Open','Ocorrências','Arquivo em uso...',5,0,0);

     DM_Tab.T_Ocorre.Append;
     DM_Tab.T_Ocorrencia['DT_OCORRE']    := Date;
     DM_Tab.T_Ocorrencia['HORA']         := Now;
     DM_Tab.T_Ocorrencia['ESC_SOLICITOU']:= Pbl_Codigo_Funcionario;
     DM_Tab.T_Ocorrencia['ESC_LIBEROU']  := Pbl_Codigo_Senha;
     DM_Tab.T_Ocorrencia['TIPO_ATO']     := Lc_TipoAto;
     DM_Tab.T_Ocorrencia['TIPO_OCORRE']  := Lc_TipoOcorre;
     DM_Tab.T_Ocorrencia['CODIGO']       := Lc_Codigo;
     DM_Tab.T_Ocorrencia['OCORRENCIA']   := Lc_Ocorrencia;
     DM_Tab.T_Ocorrencia.Post;
     Result := True;
    Finally
     If not Lc_ArquivoJaAberto Then
        DM_Tab.T_Ocorrencia.Close;
     If not Lc_ArquivoJaAbertoUsuario then
        DM.Tb_Usuario.Close;
    end;
  end;

End;  }



{----------------
 Evento : Formata um número inteiro
          colocando pontos ex: entra 123445678
          e sai 123.445.678
 ----------------}
function FormataInteiro(Lc_Inteiro : Integer) : string;
begin
   // Inicializa o resultado
   Result := '';

   while Lc_Inteiro > 1000 do
   begin
      Result := '.' + StrZero(Lc_Inteiro mod 1000, 3, 0) + Result;
      Lc_Inteiro := Lc_Inteiro div 1000;
   end;

   Result := IntToStr(Lc_Inteiro) + Result;
end;

{--------------
 Verifica se o drive disquet esta ok
 recebe: Lc_Drive - pode vir numerico como alfanumerico
                    ou seja A = 1
                            B = 2, tanto faz vir com A ou 1, mas como string
                    pode vir tambem com A:\
         Lc_Livre - variavel que dever retornar o tamanho livre do disquete
---------------}
function Fc_TestaDrive(Lc_Drive : String; var Lc_Livre : Integer) : Boolean;
var
   Lc_NumDrive : Integer;
   Lc_LetraDrive : String;
begin
   //padrao acessa unidade a
   Lc_NumDrive:=1;
   Lc_LetraDrive := 'A:';

   //verifica qual o drive a ser testado
   if (Lc_Drive = 'A:\') or
      (Lc_Drive = 'A:')  or
      (Lc_Drive = 'A')   or
      (Lc_Drive = '1')   then
   begin
      Lc_NumDrive := 1;
      Lc_LetraDrive := 'A:';
   end
   else
      if (Lc_Drive = 'B:\') or
         (Lc_Drive = 'B:')  or
         (Lc_Drive = 'B')   or
         (Lc_Drive = '2')   then
      begin
         Lc_NumDrive := 2;
         Lc_LetraDrive := 'B:';
      end
      else
         if (Lc_Drive = 'C:\') or
            (Lc_Drive = 'C:')  or
            (Lc_Drive = 'C')   or
            (Lc_Drive = '3')   then
         begin
            Lc_NumDrive := 3;
            Lc_LetraDrive := 'C:';
         end
         else
            if (Lc_Drive = 'D:\') or
               (Lc_Drive = 'D:')  or
               (Lc_Drive = 'D')   or
               (Lc_Drive = '4')   then
            begin
               Lc_NumDrive := 4;
               Lc_LetraDrive := 'D:';
            end;

   // marca como retorno com problemas
   Lc_Livre:= 0;
   // verifica
   while True do
   begin
      Lc_Livre:=DiskFree(Lc_NumDrive);
      // verifica se deu problema no acesso ao disquete
      if  Lc_Livre = -1 then
      begin
         if (MensagemPadrao('Testa Disquete',ATENCAO+eoln+eoln+
                  'O  drive/disquete da unidade '+Lc_LetraDrive+eoln+eoln+
                  'Não foi possível acessar, Verifique!!'+eoln,
                  ['Acessar Novamente','Cancelar Operação'],
                  [bNormal,bEscape],mpConfirmacao) = mrBotao2) then
         begin
            Result:=False;
            exit;
         end;
      end
      else
      begin
         Result:=True;
         exit;
      end;
   end;
end;





{--------------
 Busca o tamanho do arquivo em bytes
 recebe: Lc_Arquivo - Nome do arquivo caminho e extensao ex: \ansata\rtd\dat\teste.txt
 obs: se nao conseguir o tamanho volta -1
-----------------------------------------------}
function Fc_BuscaTamArquivo(Lc_Arquivo : String) : Integer;
var
  Lc_NomeArquivo : File of Byte;
begin
   Result:=-1;

   If FileExists(Lc_Arquivo)  then
   begin
      AssignFile(Lc_NomeArquivo,Lc_Arquivo);
      // garante q o arquivo está fechado, então tenta fecha-lo,
      // e se não estiver aberto dá erro então deixa dentro do Try-Except
      try
         Reset(Lc_NomeArquivo);
         Result:=FileSize(Lc_NomeArquivo);
         CloseFile(Lc_NomeArquivo);
      except
         Try
            CloseFile(Lc_NomeArquivo);
            Reset(Lc_NomeArquivo);
            Result:=FileSize(Lc_NomeArquivo);
            CloseFile(Lc_NomeArquivo);
         except
            Result:=-1;
        end;
      end;
   end;
end;

{--------------
 Funcao : Calcula a idade.
 Parametros -> Lc_nas  = Data de nascimento
               Lc_data = Data para a qual se deseja saber a idade, se estiver
                         em branco, a data do dia é assumida
 Retorna -> um numero inteiro com a idade
--------------------------------}
function Fc_CalcIdade(Lc_Nas : TDateTime; Lc_Data : TDateTime) : Double;
var
   Lc_Niver : TDateTime;
   Lc_dias,Lc_bissexto : Double;
begin
   //se a data de nascimento esta em branco volta 0
   if Lc_Nas = 0 then
   begin
      Result:=0;
      exit;
   end;
   //se a data de nascimento esta em branco volta 0
   if Lc_Data = 0 then
   begin
      Lc_Data:=Date;
   end;
   //verifica se o aniversario do cara é no dia 29 de fevereiro
   //e se no ano que sendo calculado é bissexto ou nao, isto para nao dar pau
   if (Fc_Day(Lc_Nas) = 29) and
      (Fc_Month(Lc_Nas) = 02) and
      (Fc_Year(Lc_Data) mod 4 <> 0) then
      Lc_Niver := StrToDate('28/02/'+StrZero(Fc_Year(Lc_Data),4,0))
   else
      Lc_Niver := StrToDate(StrZero(Fc_Day(Lc_Nas),2,0)+'/'+StrZero(Fc_Month(Lc_Nas),2,0)+'/'+StrZero(Fc_Year(Lc_Data),4,0));
   //calcula a idade
   Lc_Dias:= Lc_Niver - Lc_Nas;
   Lc_Bissexto:=Int(Lc_Dias / 365);
   Lc_Bissexto:=Lc_Bissexto*365;
   Lc_Bissexto:=Lc_Dias-Lc_Bissexto;
   Result := Int(((Lc_Data-Lc_Bissexto)-Lc_Nas) / 365);
end;


{-------------------------------------------------------------------
 Função : StrZero
 Descrição : Acresenta zeros na frente de um numero
 -------------------------------------------------------------------}
function StrZero(Num : Real ; Zeros,Deci: integer): string;
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
   Str(Num:Zeros:Deci, res);
   res := Alltrim(res);
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
   If Deci <> 0 then
      Result := StrTran(Result,'.',',');
end;
{Fim de StrZero}


{-----------------------------
 Função : StrTran
 Descrição : Procura pelas ocorrencias de um caracter numa
             string e troca por outro valor.
 OBS : Esta função ainda não é totalmente com o Clipper.
       é necessário acrescentar dois parametros para a
       compatibilidade total.
------------------------------}
function StrTran(Entra: string ; Search: string ; Replace : string): string;
var
   tamanho,
   Count : Integer;
   StrTemp,
   Sai : string;
begin
  If Pos(Search,Entra) = 0 Then
  Begin
    Result := Entra;
    Exit;
  End;
  tamanho := length(Search);
  Sai := '';
  for count := 1 to length(Entra) do
  begin
      StrTemp := StrTemp + Entra[count];

      if length (StrTemp) = tamanho then
      begin
          if AnsiCompareText (StrTemp,Search) = 0 then
          begin
              if Replace <> '' then
              begin
                  Sai := Sai + Replace;
              end;
              StrTemp := '';
         end
         else
         begin
            Sai := Sai + StrTemp[1];
            Strtemp := copy (StrTemp,2,tamanho - 1);
         end;
      end;
  end;
  Sai := Sai + StrTemp;

  Result := Sai;
end;
{fim de StrTran}

{-------------------------------------------------------------------
 Função: Alltrim
 Descrição : Remove todos os espaços que antecedem e procedem uma
             string
 ------------------------------------------------------------------}
function Alltrim(Text : string) : string;
begin
   Alltrim := Trim(Text);
end;
{Fim de Alltrim}

function Pad(AValue: String; const ALength: Integer; const ASide: TAlignment): String;
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


function PadL(AValue: String; const ALength: Integer): String;
begin

  Result := Pad(AValue, ALength, taLeftJustify);

end;

function PadR(AValue: String; const ALength: Integer): String;

begin

  Result := Pad(AValue, ALength, taRightJustify);

end;


function UltDiaDoMes(Data: TDateTime): Word;
// Retorna o Ultimo dia do mes de uma determinada
// data
var
d,m,a: Word;
dt: TDateTime;
begin
DecodeDate(Data, a,m,d);
Inc(m);
if m = 13 then
   begin
   m := 1;
   end;
dt := EncodeDate(a,m,1);
dt := dt - 1;
DecodeDate(dt, a,m,d);
Result := d;
end;

Procedure Pc_DestroiPreview;
var 
  Lc_Idx:Integer; 
begin 
  for Lc_Idx := (Screen.FormCount - 1) downto 0 do 
     With Screen.Forms[Lc_Idx] do 
        if ClassName = 'TQRStandardPreview' then
           Destroy; 
end;

function Upper(InString: string): string;
Var
  Lc_texto:String;
  Lc_I : integer;
begin
  Result := '';
  Lc_texto := UpperCase(InString);
  For Lc_I := 1 to Length(Lc_texto) do
  Begin
    Result := Result + upperAcento(Lc_texto[Lc_I]);
  end;

end;

function getPathExe:String;
Begin
  Result := ExtractFilePath(Application.ExeName) ;
End;

function Fc_RemoveCaracterInformado(Str: String; Caracteres: Array of String): String;
var
  I: Integer;
begin
  Result := Str;
  for I := 0 to High(Caracteres) do
  begin
    Result := StringReplace(Result,Caracteres[I],'',[rfReplaceAll,rfIgnoreCase]);
//    while Pos(Caracteres[I], Result) > 0 do
//      Delete(Result, Pos(Caracteres[I], Result), 1);
  end;
end;

function RemoveCaracterInformado(Str: String; Caracteres: Array of String): String;
var
  I: Integer;
begin
  Result := Str;
  for I := 0 to High(Caracteres) do
  begin
    Result := StringReplace(Result,Caracteres[I],'',[rfReplaceAll,rfIgnoreCase]);
//    while Pos(Caracteres[I], Result) > 0 do
//      Delete(Result, Pos(Caracteres[I], Result), 1);
  end;
end;

function AjustaStr ( str: String; tam: Integer ): String;
begin
while Length ( str ) < tam do 
str := str + ' '; 
if Length ( str ) > tam then 
str := Copy ( str, 1, tam ); 
Result := str; 
end;






function Fc_NomeComputador: string;
var
  c: array[0..127] of Char;
  sz: dword;
begin
  sz := SizeOf(c);
  GetComputerName(c, sz);
  Result := c;
end;

function Fc_GetIPFromNet():String;
var
  Lc_hr,Lc_txt:string ;
  Lc_Cont: integer;
  Lc_Posicao : Integer;
  Lc_HTTP: TIdHTTP;
begin
  Try
    Lc_HTTP := TIdHTTP.Create(nil);
    Try
      Lc_txt := Lc_HTTP.Get('http://checkip.dyndns.org/');
    except
      Lc_txt :='Address: 192.168.0.1';
    end;

    Lc_Posicao := pos('Address:',Lc_txt);
    Lc_hr := copy(Lc_txt,Lc_Posicao,22);
    Result:='';
    for Lc_Cont:=1 to length(Lc_hr) do
      begin
      if ( copy(Lc_hr,Lc_Cont,1) = '0' ) or
         ( copy(Lc_hr,Lc_Cont,1) = '1' ) or
         ( copy(Lc_hr,Lc_Cont,1) = '2' ) or
         ( copy(Lc_hr,Lc_Cont,1) = '3' ) or
         ( copy(Lc_hr,Lc_Cont,1) = '4' ) or
         ( copy(Lc_hr,Lc_Cont,1) = '5' ) or
         ( copy(Lc_hr,Lc_Cont,1) = '6' ) or
         ( copy(Lc_hr,Lc_Cont,1) = '7' ) or
         ( copy(Lc_hr,Lc_Cont,1) = '8' ) or
         ( copy(Lc_hr,Lc_Cont,1) = '9' ) or
         ( copy(Lc_hr,Lc_Cont,1) = '.' ) then
         Result := Result + copy(Lc_hr,Lc_Cont,1);
    end;
  Finally
    FreeAndNil(Lc_HTTP);
  End;

end;

function Fc_SubstituirCaracteres(S: String; C1: String; C2: String): String;
 var
  IndexadorS: Integer;
  TrechosDaString: String[1];
  StringAuxiliar: String;
begin
 //Inicializa as variáveis
 IndexadorS := 0;
 StringAuxiliar := '';
 //Somente executa a função se o comprimento for 0 ou 1
 if (Length(C1) = 0) or (Length(C1) = 1) then
  begin
   Case Length(C1) of
    0:
     begin
      if C1 = '' then
       S := C2;
     end;
    1:
     begin
      //Procura o caractere "C1" na String "S" e substitui por "C2"
      for IndexadorS := 1 to Length(S) do
       begin
        TrechosDaString := Copy(S, IndexadorS, 1);
         if TrechosDaString = C1 then
          TrechosDaString := C2;
        StringAuxiliar := StringAuxiliar + TrechosDaString;
       end;
      S := StringAuxiliar;
     end;
   end;
  end;
 Result := S;
end;

function Fc_DeleteFolder(FolderName: String; LeaveFolder: Boolean): Boolean;
var
  r: TshFileOpStruct;
begin
  Result := False;
  if not DirectoryExists(FolderName) then Exit;
  if LeaveFolder then
    FolderName := FolderName + ' *.* '
  else
  if FolderName[Length(FolderName)] = ' \ ' then
    Delete(FolderName,Length(FolderName), 1);
  FillChar(r, SizeOf(r), 0);
  r.wFunc := FO_DELETE;
  r.pFrom := PChar(FolderName);
  r.fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION;
  Result := ((ShFileOperation(r) = 0) and (not r.fAnyOperationsAborted));
end;

function Fc_ArredondarParaBaixo(Fc_Valor:Real;Fc_Casas:Integer;Fc_Forcar:Boolean):Real;
Var
  Lc_strAux : String;
Begin
  if Fc_Forcar then
    Fc_Valor := Fc_Valor - (5 / (power(10,Fc_Casas+1)));
  Lc_strAux := FloatToStrf(Fc_Valor,ffFixed,10,Fc_Casas);
  //Retorna a string com duas casas para o valor Real
  Result := StrToFloatDef(Lc_strAux,0);
end;

function Fc_ArredondarParaCima(Value: Extended; Decimals: Integer): Extended;
var
  Factor, Fraction: Extended;
begin
  Factor := IntPower(10, Decimals);
  Value := StrToFloat(FloatToStr(Value * Factor));
  Result := Int(Value);
  Fraction := Frac(Value);
  if Fraction >= 0.5 then
    Result := Result + 1
  else
    if Fraction <= -0.5 then
      Result := Result - 1;
  Result := Result / Factor;
end;

Function Fc_RetornaSequenciaLista(Fc_Lista:TStringList):Integer;
var
  Lc_I : integer;
  Lc_Nr_Atual   : Integer;
  Lc_Nr_Proximo  : Integer;
  Lc_Nr_Sequencia : Integer;

begin
  Lc_I := 0;
  Fc_Lista.Sort;
  if Fc_Lista.Count = 1 then
    Begin
    Lc_Nr_Atual   := StrToIntDef(Fc_Lista.Strings[Lc_I],0);
    if (Lc_Nr_Atual =1) then
      Lc_Nr_Sequencia := 2
    else
      Lc_Nr_Sequencia := succ(Lc_Nr_Atual);
    Result := Lc_Nr_Sequencia
    end
  else
    Begin
    repeat
      Lc_Nr_Atual   := StrToIntDef(Fc_Lista.Strings[Lc_I],0);
      Lc_Nr_Proximo := StrToIntDef(Fc_Lista.Strings[Lc_I + 1],0);
      if (Lc_Nr_Proximo =0) then exit;
      Lc_Nr_Sequencia := succ(Lc_Nr_Atual);
      if (Lc_Nr_Proximo > Lc_Nr_Sequencia) then
        Begin
        Result := Lc_Nr_Sequencia;
        break;
        end;
      inc(Lc_I);
    until (Lc_I >= (Fc_Lista.Count-1));
    if (Lc_Nr_Sequencia = Lc_Nr_Proximo) then
      Result := Lc_Nr_Proximo + 1;
    end;
end;

Function Fc_RetornaListaSequenciaFaltante(Fc_Lista:TStringList):TStringList;
var
  Lc_I : integer;
  Lc_Nr_Atual   : Integer;
  Lc_Nr_Proximo  : Integer;
  Lc_Nr_Sequencia : Integer;

Label
   Lb_volta;
begin
  Result.Clear;
  Lc_I := 0;
  Fc_Lista.Sort;
  repeat
    Lc_Nr_Atual   := StrToIntDef(Fc_Lista.Strings[Lc_I],0);
    Lc_Nr_Proximo := StrToIntDef(Fc_Lista.Strings[Lc_I + 1],0);
    if (Lc_Nr_Proximo =0) then exit;
    Lc_Nr_Sequencia := succ(Lc_Nr_Atual);
Lb_volta:
    if (Lc_Nr_Proximo > Lc_Nr_Sequencia) then
      Begin
      Result.Add(IntToStr(Lc_Nr_Sequencia));
      Lc_Nr_Sequencia := succ(Lc_Nr_Sequencia);
      goto lb_volta;
      end;
    inc(Lc_I);
  until (Lc_I > (Fc_Lista.Count-1))
end;


function fc_justr(s : string; tamanho : integer) : string;
var i : integer;
begin
   i := tamanho-length(s);
   if i>0 then
     s := DupeString(' ', i)+s;
   Fc_justr := s;
end;

function fc_justl(s : string; tamanho : integer) : string;
var i : integer;
begin
   i := tamanho-length(s);
   if i>0 then
     s := s+DupeString(' ', i);
   Fc_justl := s;
end;

function ObterVersaoWindows: String;
var
  vNome,
  vVersao,
  vCurrentBuild: String;
  Reg: TRegistry;
begin
  Reg         := TRegistry.Create; //Criando um Registro na Meméria
  Reg.Access  := KEY_READ; //Colocando nosso Registro em modo Leitura
  Reg.RootKey := HKEY_LOCAL_MACHINE; //Definindo a Raiz

  //Abrindo a chave desejada
  Reg.OpenKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\', true);

  //Obtendo os Parâmetros desejados
  vNome         := Reg.ReadString('ProductName');
  vVersao       := Reg.ReadString('CurrentVersion');
  vCurrentBuild := Reg.ReadString('CurrentBuild');

  //Montando uma String com a Versão e alguns detalhes
  Result := vNome + ' - ' + vVersao + ' - ' + vCurrentBuild;
end;



function Fc_QuotedStr(const S: string): string;
var
  I: Integer;
begin
  Result := S;
  for I := Result.Length - 1 downto 0 do
    if Result.Chars[I] = '''' then Result := Result.Insert(I, '''');
  Result := '''' + Result + '''';
end;


procedure Pc_PreenceCelulaExcel(Pc_Formata:Boolean;
                               Pc_Sheet:Variant;
                               Pc_Linha,
                               Pc_ColIni,
                               Pc_ColFim,
                               Pc_ColWith:Integer;
                               Pc_Aling:Integer;
                               Pc_Formato:String;
                               Pc_Valor:Variant);
Var
  Lc_StrCell1: string;
  Lc_StrCell2: string;
Begin
  Lc_StrCell1 := fc_PegaLetraColuna(Pc_ColIni) + IntToStr(Pc_Linha);
  Lc_StrCell2 := fc_PegaLetraColuna(Pc_ColFim) + IntToStr(Pc_Linha);
  Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Select;
  Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
  if not Pc_Formata then
  Begin
    Pc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.ColumnWidth := Pc_ColWith;
    Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.WrapText := True;
    Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlTop);
    case Pc_Aling of
      1:Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlLeft);
      2:Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      3:Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlRight);
      end;
    Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Orientation := 0;
    Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlThin), Integer(xlAutomatic), Integer(xlAutomatic));
    if Trim(Pc_Formato) <> '' then
      Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].NumberFormat := Pc_Formato;
  end;
  Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
  if Trim(Pc_Valor) <> '' then
  Begin
    if (Pc_Formato = 'dd/mm/yyyy') then
    Begin
      Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value2 := FormatDateTime('dd/MMM/yyyy',StrToDate(Pc_Valor));
    end
    else
    Begin
      if StrToFloatDef(Pc_Valor,0)>0 then
        Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value2 := Pc_Valor
      else
        Pc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := Pc_Valor;
    end;
  end;
end;

function Fc_BuscaCodigoEstado(Fc_Sigla:String): Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select UFE_CODIGO FROM TB_UF WHERE upper( UFE_SIGLA )=:UFE_SIGLA');
      ParamByName('UFE_SIGLA').AsString := UPPERcASE( Fc_Sigla );
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('UFE_CODIGO').AsInteger
      else
        Result := 41;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function Fc_BuscaCodigoCidade(fc_IBGE:Integer; Fc_Descricao,Fc_UF:String): Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if (fc_IBGE > 0) then
        Begin
        SQL.Add('select CDD_CODIGO FROM TB_CIDADE WHERE CDD_IBGE=:CDD_IBGE');
        ParamByName('CDD_IBGE').AsInteger := fc_IBGE;
        end
      else
        Begin
        SQL.Add('select CDD_CODIGO '+
                'FROM TB_CIDADE '+
                'WHERE UPPER( CDD_DESCRICAO) =:CDD_DESCRICAO AND UPPER(CDD_UF) =:CDD_UF');
        ParamByName('CDD_DESCRICAO').AsString := UpperCase( Fc_Descricao );
        ParamByName('CDD_UF').AsString := UpperCase( Fc_UF );
        end;
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('CDD_CODIGO').AsInteger
      else
        Result := 4004;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;



function ValidaDiretorio(Dir: string): Boolean;
var
SR: TSearchRec;
I: Integer;
begin
  Result := False;
  FindFirst(IncludeTrailingPathDelimiter(Dir) + '*', faAnyFile, SR);
  for I := 1 to 2 do
    if (SR.Name = '.') or (SR.Name = '..') then
      Result := FindNext(SR) <> 0;
  FindClose(SR);

end;

function getCamposJsonString(json,value:String): String;
var
   LJSONObject: TJSONObject;
   function TrataObjeto(jObj:TJSONObject):string;
   var i:integer;
       jPar: TJSONPair;
   begin
        result := '';
        for i := 0 to jObj.Size - 1 do
        begin
             jPar := jObj.Get(i);
             if jPar.JsonValue Is TJSONObject then
                result := TrataObjeto((jPar.JsonValue As TJSONObject)) else
             if sametext(trim(jPar.JsonString.Value),value) then
             begin
                  Result := jPar.JsonValue.Value;
                  break;
             end;
             if result <> '' then
                break;
        end;
   end;
begin
   try
      LJSONObject := nil;
      LJSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(json),0) as TJSONObject;
      result := TrataObjeto(LJSONObject);
   finally
      FreeAndNil(LJSONObject);
   end;


End;

procedure updateTableSync(Tabela, pSentido: String; tempo: TDateTime);
Var
  LcStrDataTime : String;
  LcSyncClient  : TcontrollerDskSyncTable;
begin
  LcSyncClient := TcontrollerDskSyncTable.Create(Nil);
  try
    with LcSyncClient.Registro do
    Begin
      Codigo := Tabela;
      Sentido := pSentido;
      LcStrDataTime := DateTimeToStr(Tempo);
      //13/12/2017 01:37:38
      Data := StrToDate(Copy(LcStrDataTime,1,10));
      Hora := StrToTime(Copy(LcStrDataTime,12,8 )) + StrToTime('00:00:01');
      OPerador := 0;
      Tipo := '1';
    End;
    LcSyncClient.save;
  finally
    freeAndNil(LcSyncClient);
  end;
end;

function RetiraEnter(aText : string): string;
begin
  Result := aText;
  exit;
  { Retirando as quebras de linha em campos blob }
  Result := StringReplace(aText, #$D#$A, '', [rfReplaceAll]);

  { Retirando as quebras de linha em campos blob }
  Result := StringReplace(Result, #13#10, '', [rfReplaceAll]);
end;

Procedure EnblControl( pr_control: tWinControl );
var lc_PropInfo: PPropInfo;
begin
     pr_control.Enabled:=true;
     pr_control.TabStop:=true;
     if pr_control.InheritsFrom(TDBLookupControl)
        or pr_control.InheritsFrom(TCustomEdit) then
     begin
          lc_PropInfo:=GetPropInfo(pr_control, 'color');
          if lc_PropInfo <> nil then
             SetPropValue(pr_control,'color', clWindow);
          lc_PropInfo:=GetPropInfo(pr_control, 'ReadOnly');
          if lc_PropInfo <> nil then
             SetPropValue(pr_control,'ReadOnly', False);
     end;
end;

Procedure DsblControl( pr_control: tWinControl );
var lc_PropInfo: PPropInfo;
begin
     pr_control.Enabled:=False;
     pr_control.TabStop:=False;
     if pr_control.InheritsFrom(TDBLookupControl)
        or pr_control.InheritsFrom(TCustomEdit) then
     begin
          lc_PropInfo:=GetPropInfo(pr_control, 'color');
          if lc_PropInfo <> nil then
             SetPropValue(pr_control,'color', $00E8E8E8);
          lc_PropInfo:=GetPropInfo(pr_control, 'ReadOnly');
          if lc_PropInfo <> nil then
             SetPropValue(pr_control,'ReadOnly', True);
     End;
end;

Function unMaskField(Text:String):String;
Begin
  Result := Text;
  Result := stringReplace(Result, '-', '', []);
  Result := stringReplace(Result, '-', '', []);
  Result := stringReplace(Result, '(', '', []);
  Result := stringReplace(Result, ')', '', []);
  Result := stringReplace(Result, '.', '', []);
  Result := stringReplace(Result, '.', '', []);
  Result := stringReplace(Result, '/', '', []);
  Result := stringReplace(Result, '-', '', []);
  Result := stringReplace(Result, ' ', '', []);
End;

function  ValidDocFiscal(doc:String):String;
Var
  Lc_Doc : String;
  Lc_Validador: TACBrValidador;
Begin
  Result := 'OK';
  if (Fc_Tb_Geral('L','GRL_G_VALIDA_CPF_CNPJ','') = 'N') then
  Begin
    //DEvolve ok por que foi desabilitado a verificação
    Exit;
  end;

  Try
    Lc_Validador := TACBrValidador.create(Nil);

    Lc_Doc := TRIM(unMaskField(Doc));
    Lc_Validador.Documento   := Lc_Doc ;
    if ( Length(Lc_Doc) = 11 ) then
    begin
      Lc_Validador.TipoDocto :=  docCPF;
      if not Lc_Validador.Validar then
      begin
        Result := 'Número de C.P.F. Inválido.';
        exit;
      end;
    end
    else
    begin
      Lc_Validador.TipoDocto := docCNPJ;
      if not Lc_Validador.Validar then
      begin
        Result := 'Número de C.N.P.J. Inválido.';
        exit;
      end;
    end;

  Finally
    FreeAndNil(Lc_Validador);
  End;

End;

function CalculoCnpj(xCGC: string): Boolean;
var
   d1, d4, xx, nCount, fator, resto, digito1, digito2: Integer;
   Check: string;
begin
  xCGC := StringReplace(xCGC, ' ', EmptyStr, [rfReplaceAll]);

  if Trim(xCGC) = '' then
  Begin
    Result := False;
    Exit;
  End;

  if (Length(Trim(xCGC)) < 14 ) then
  Begin
    Result := False;
    Exit;
  End;

 if (xCGC = '11111111111111') or (xCGC = '22222222222222') or (xCGC = '33333333333333') or (xCGC = '44444444444444') or
    (xCGC = '55555555555555') or (xCGC = '66666666666666') or (xCGC = '77777777777777') or (xCGC = '88888888888888') or
    (xCGC = '99999999999999') OR  (TRIM(xCGC) = '') or (xCGC = '00000000000000')then
     begin
     Result := False;
     Exit;
     end;
   d1 := 0;
   d4 := 0;
   xx := 1;
   for nCount := 1 to Length(xCGC) - 2 do
   begin
      if Pos(Copy(xCGC, nCount, 1), '/-.') = 0 then
      begin
         if xx < 5 then
         begin
            fator := 6 - xx;
         end
         else
         begin
            fator := 14 - xx;
         end;
         d1 := d1 + StrToInt(Copy(xCGC, nCount, 1)) * fator;
         if xx < 6 then
         begin
            fator := 7 - xx;
         end
         else
         begin
            fator := 15 - xx;
         end;
         d4 := d4 + StrToInt(Copy(xCGC, nCount, 1)) * fator;
         xx := xx + 1;
      end;
   end;
   resto := (d1 mod 11);
   if resto < 2 then
   begin
      digito1 := 0;
   end
   else
   begin
      digito1 := 11 - resto;
   end;
   d4 := d4 + 2 * digito1;
   resto := (d4 mod 11);
   if resto < 2 then
   begin
      digito2 := 0;
   end
   else
   begin
      digito2 := 11 - resto;
   end;

   Check := IntToStr(Digito1) + IntToStr(Digito2);
   if Check <> copy(xCGC, succ(length(xCGC) - 2), 2) then
   begin
      Result := False;
   end
   else
   begin
      Result := True;
   end;
end;

function CalculoCpf(xCPF: string): Boolean;
var
   d1, d4, xx, nCount, resto, digito1, digito2: Integer;
   Check: string;
begin
  xCPF := StringReplace(xCPF, ' ', EmptyStr, [rfReplaceAll]);

  if Trim(xCPF) = '' then
  Begin
    Result := False;
    Exit;
  End;

  if (Length(Trim(xCPF)) < 11 ) then
  Begin
    Result := False;
    Exit;
  End;

  if (xCPF = '11111111111') or (xCPF = '22222222222') or (xCPF = '33333333333') or (xCPF = '44444444444') or
    (xCPF = '55555555555') or (xCPF = '66666666666') or (xCPF = '77777777777') or (xCPF = '88888888888') or
    (xCPF = '99999999999') OR  (TRIM(xCPF) = '')or (xCPF = '00000000000000') then
     begin
     Result := False;
     Exit;
     end;

   if (xCPF = '00000000000') then
     begin
     Result := False;
     Exit;
     end;


   d1 := 0; d4 := 0; xx := 1;
   for nCount := 1 to Length(xCPF) - 2 do
   begin
      if Pos(Copy(xCPF, nCount, 1), '/-.') = 0 then
      begin
         d1 := d1 + (11 - xx) * StrToInt(Copy(xCPF, nCount, 1));
         d4 := d4 + (12 - xx) * StrToInt(Copy(xCPF, nCount, 1));
         xx := xx + 1;
      end;
   end;
   resto := (d1 mod 11);
   if resto < 2 then
   begin
      digito1 := 0;
   end
   else
   begin
      digito1 := 11 - resto;
   end;
   d4 := d4 + 2 * digito1;
   resto := (d4 mod 11);
   if resto < 2 then
   begin
      digito2 := 0;
   end
   else
   begin
      digito2 := 11 - resto;
   end;
   Check := IntToStr(Digito1) + IntToStr(Digito2);
   if Check <> copy(xCPF, succ(length(xCPF) - 2), 2) then
   begin
      Result := False;
   end
   else
   begin
      Result := True;
   end;
end;

end.
