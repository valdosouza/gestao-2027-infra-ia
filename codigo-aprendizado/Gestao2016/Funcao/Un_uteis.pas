unit Un_uteis;

interface

Uses     DB, dialogs, sysutils, variants, StdCtrls, windows, classes, dateutils, controls, TypInfo, Graphics, DBCtrls, STQuery, STDatabase, STTransaction;

type
  tSql = Class ( tStringList ) ;

  {tQueryUtil}
  tQueryUtil = class
  private
         FdbConn: TSTDatabase;
         FdbTransaction: TSTTransaction;
         FDbConCreateHere: Boolean;
         function BuscaUmDadoSql(pr_sql: string; pr_defaultvalue: variant): variant;
         Function CreateDataBase(pr_caminho:string): TSTDatabase;
         Procedure SetdbConn(const Value: TSTDatabase);
  public
        function Listacampos(pr_nometabela: string): TSTQUERY;
        Property dbConn: TSTDatabase read FdbConn Write SetdbConn;
        function BuscaUmDadoSqlAsDateTime(pr_sql: string): tdatetime;
        function BuscaUmDadoSqlAsFloat(pr_sql: string): Extended;
        function BuscaUmDadoSqlAsInteger(pr_sql: string): integer;
        function BuscaUmDadoSqlAsString(pr_sql: string): string;
        function QueryCreate(pr_sql: string): TSTQUERY;

        function tabelaexiste(pr_nometabela:string):boolean;


        function ListaNomesTabelas: TSTQUERY;
        procedure begintransaction;
        procedure commit;
        procedure rollback;
        procedure commitretain;
        function getnextsequence( pr_nmsequence: string ):integer;
        constructor Create( pr_caminho:string );
        destructor destroy;
  end;


Procedure GeraException( msgerro:string ); // Apresenta msgerro e gera um exceção
Function DateToSql( dt: tDatetime ):string; // retorna data no formato sql
Function TimeToSql( dt: tDateTime ): String;
Function DateTimeToSql( dt: tDatetime ):string;
Function FloatToSql( flt: Extended ):string;
function currencytosql(flt:extended):string;

function posn( strbuscar, txt : String; nOcorr : Integer ) : Integer;
function JanelaExiste(Classe, Janela: string): Boolean;
function DelphiAberto: Boolean;
function MinTime( dt: tDateTime ): tDateTime;
function MaxTime( dt: tDateTime ): tDateTime;
function uTrim( pr_txt:string): string;
function AddCommaText( pr_text,pr_delimiter,pr_txtadd:string):string;
function ElapsedTime ( pr_dtini, pr_dtfim: tDateTime ):int64;
function ReplaceTextAll ( pr_text,pr_txtbusca,pr_txtsubstituto: string): string;
function ReplaceCommaTextAll ( pr_text,pr_TxtBuscaCommaText,pr_txtsubstituto: string): string;
Function SecsToHMS(pr_Secs: LongInt): string;
Function iif( pr_condicao:boolean; result_true, result_false:variant ): variant;
Procedure EnblControl( pr_control: tWinControl );
Procedure DsblControl( pr_control: tWinControl );
Function BarraInvert(pr_value:string):string;
Function datetimetonamefile(dt:tDateTime):string;
Function StringDateSqlToDateTime( dt:string ): tDateTime;
Function FilterTo( Tipo,dado,campo:string ):string;
Function IsDate(wData:String; MostraErr:boolean):Boolean;
Function HasTextaValidDate( DtStr: string ) : boolean;
function ExtrairNumeros(msg: string): string; // extrai digitos decimais de uma string
Function LastDay( dtRef: tDate ) : Integer ;

implementation

uses     un_Funcoes, UN_MSG;
Function IsDate(wData:String; MostraErr:boolean):Boolean;
Begin
     Result := HasTextaValidDate( wData );
     if (not Result) and Mostraerr then
        GeraException( 'Data inv�lida!' );
end;

Function HasTextaValidDate( DtStr: string ) : boolean;
var
  dd: Integer;
  mm: Integer;
  yy: Integer;
  ultdia: Integer;
  DateStr: String;
begin
     result := false ;
     DateStr := ExtrairNumeros( DtStr ) ;
     if length(DateStr)=8 then
     begin
          dd := strtointdef( copy ( datestr , 1 , 2 ) , 0 );
          mm := strtointdef( copy ( datestr , 3 , 2 ) , 0 );
          yy := strtointdef( copy ( datestr , 5 , 4 ) , 0 );
          if (dd>0) and (mm>0) and (yy>1900) then
          begin
               if (mm<13) then // mes v�lido
               begin
                    ultdia := LastDay ( encodedate ( yy,mm,1 ) );
                    if dd <= ultdia then
                       result := true;
               end;
          end;
     end;
end;

Function LastDay( dtRef: tDate ) : Integer ;
var
  ano: word;
  mes: word;
  dia: word;
begin
     decodedate( dtref, ano, mes, dia);
     mes := mes + 1;
     if mes = 13 then
     begin
          mes := 1;
          ano := ano + 1;
     end;
     dia := 1;
     DecodeDate ( EncodeDate ( ano, mes, dia )-1 , ano, mes, dia);
     result := dia ;
end;

function ExtrairNumeros(msg: string): string; // extrai digitos decimais de uma string
var x,y:integer;
    num:string;
begin
     num:='';
     x := length(msg);
     for y:=1 to x do
     begin
          if pos(msg[y],'1234567890')<>0 then
             num := num + msg[y];
     end;
     result := num;
end;

Function FilterTo( Tipo,dado,campo:string ):string;
var dd,nn,op: string;
begin
     result := '';
     dd := trim( dado );
     if dd <> '' then
     begin
          if tipo = 'I' then
          begin
               op := '=';
               nn := ExtrairNumeros(dd);
          end
          Else
          if tipo = 'S' then
          begin
               op := ' LIKE ';
               nn := quotedstr(dd+'%');
          end;
          if nn<>'' then
          begin
               Result := campo+op+nn;
          end;
     end;
end;

Function StringDateSqlToDateTime( dt:string ): tDateTime;
{ recebe str com data formato yyyy-mm-dd hh:mm (sql firebird) - retorna data }
var y,m,d,ah,am,ams: word;
begin
     y := strtointdef( copy( dt , 1,4),0 );
     m := strtointdef( copy( dt , 6,2),0 );
     d := strtointdef( copy( dt , 9,2),0 );
     ah:= strtointdef( copy( dt ,12,2),0 );
     am:= strtointdef( copy( dt ,15,2),0 );
     ams := 0;
     result := encodedatetime(y,m,d,ah,am,ams,ams);
end;

Function datetimetonamefile(dt:tDateTime):string;
{ DRY }
var y,m,d,ah,am,ase,ams: word;
begin
     decodedatetime( dt, y,m,d,ah,am,ase,ams);
     result := strzero(y,4,0)+strzero(m,2,0)+strzero(d,2,0)+strzero(ah,2,0)+strzero(am,2,0)+strzero(ase,2,0) ;
end;

Function BarraInvert(pr_value:string):string;
{ DRY }
begin
     if (pr_value[length(pr_value)]<>'\') then
        result := pr_value + '\'
     else
        result := pr_value;
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

Function iif( pr_condicao:boolean; result_true, result_false:variant ): variant;
{ clipper like }
begin
     if pr_condicao then
        result := result_true
     else
        result := result_false;
end;

Function SecsToHMS(pr_Secs: LongInt): string;
{ ret string 'x horas, y minutos, n segundos' }
var lc_Hrs, lc_Min, lc_sec: Word;
begin
     Lc_Hrs := pr_Secs div 3600;
     Lc_Sec := pr_Secs mod 3600;
     Lc_Min := Lc_Sec div 60;
     Lc_Sec := Lc_Sec mod 60;
     Result := '';
     if Lc_Hrs<>0 then
        Result:=AddCommaText(result,',',inttostr( lc_Hrs )+' Hora'+iif(lc_Hrs>1,'s','')) ;
     if Lc_Min<>0 then
        Result:=AddCommaText(result,',',inttostr( lc_Min )+' Minuto'+iif(lc_Min>1,'s','')) ;
     if Lc_Sec<>0 then
        Result:=AddCommaText(result,',',inttostr( lc_Sec )+' Segundo'+iif(lc_Sec>1,'s','')) ;
end;

function ReplaceTextAll( pr_text,pr_txtbusca,pr_txtsubstituto: string): string;
{ DRY }
begin
     result := stringreplace(pr_text,pr_txtbusca,pr_txtsubstituto,[rfReplaceAll]);
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

function ElapsedTime ( pr_dtini, pr_dtfim: tDateTime ):int64;
{ retorna tempo decorrido em segundos }
var lc_TimeStamp : TTimeStamp;
begin
     lc_TimeStamp := DateTimeToTimeStamp(pr_dtini - pr_dtfim);
     Dec(lc_TimeStamp.Date, TTimeStamp(DateTimeToTimeStamp(0)).Date);
     Result := (lc_TimeStamp.Date*24*60*60)+(lc_TimeStamp.Time div 1000);
end;

function AddCommaText( pr_text,pr_delimiter,pr_txtadd:string):string;
{ DRY }
begin
     result := pr_text;
     if result<>'' then
        result := result+pr_delimiter;
     result := result + pr_txtadd;
end;

function uTrim( pr_txt:string): string;
{ DRY }
begin
     uTrim := uppercase(trim(pr_txt));
end;

function JanelaExiste(Classe, Janela: string): Boolean;
var aClasse, aJanela: array[0..79] of char;
begin
     if Classe = '' then
        aClasse[0] := #0
     else
         StrPCopy(aClasse, Classe);
     if Janela = '' then
        aJanela[0] := #0
     else
         StrPCopy(aJanela, Janela);
     Result := FindWindow(aClasse, aJAnela) <> 0;
end;

function DelphiAberto: Boolean;
{  Evitar execução dos timers em tempo de projeto facilitando a depurção}
begin
     Result := JanelaExiste('TPropertyInspector', 'Object Inspector');
end;

function posn( strbuscar, txt : String; nOcorr : Integer ) : Integer;
{retorna posição da nOcorr de strbuscar em txt}
var contar, iOcorr, iResult, tambuscar: integer;
    strparte : string;
Begin
     tambuscar:=length(strbuscar);
     iOcorr := 0;
     iResult := 0;
     for contar := 1 to length(txt) do
     begin
          strparte:= Copy( txt, contar, length(strbuscar) );
          if strbuscar = strparte then
          begin
               Inc(iOcorr);
               if iOcorr = nOcorr then
               begin
                    iResult := contar;
                    break;
               end;
          end;
     end;
     Result := iResult;
end;

procedure GeraException(msgerro: string);
{ exceção }
begin
  if trim(msgerro)<>'' then
  begin
    try
      MensagemPadrao( 'Erro',msgerro,['OK'],[bEscape],mpAlerta);
      abort;
    except
      raise;
    end;
  end;
end;

function DateToSql(dt: tDatetime): string;
{ retorna string data formato sql }
var y,m,d: word;
begin
     //result := quotedstr( formatdatetime('mm/dd/yyyy',dt) );
     decodedate( dt, y,m,d);
     result := quotedstr( strzero(y,4,0)+'-'+strzero(m,2,0)+'-'+strzero(d,2,0) );
end;

function MinTime(dt: tDatetime): tDateTime;
var y,m,d,ho: word;
begin
     decodedate( dt, y,m,d);
     ho := 0;
     result := encodedatetime(y,m,d,ho,ho,ho,ho);
end;

function MaxTime(dt: tDatetime): tDateTime;
var y,m,d,ho,mi: word;
begin
     decodedate( dt, y,m,d);
     ho := 23;
     mi := 59;
     result := encodedatetime(y,m,d,ho,mi,mi,mi);
end;

function TimeToSql(dt: tDatetime): string;
{ retorna string com time no formato sql }
var y,m,d,ah,am,ase,ams: word;
begin
     decodedatetime( dt, y,m,d,ah,am,ase,ams);
     result := quotedstr( strzero(ah,2,0)+':'+strzero(am,2,0)+':'+strzero(ase,2,0) );
end;

function DateTimeToSql(dt: tDatetime): string;
{ retorna string com time no formato sql }
var y,m,d,ah,am,ase,ams: word;
begin
     decodedatetime( dt, y,m,d,ah,am,ase,ams);
     result := quotedstr( strzero(y,4,0)+'-'+strzero(m,2,0)+'-'+strzero(d,2,0)+' '+strzero(ah,2,0)+':'+strzero(am,2,0)+':'+strzero(ase,2,0) );
end;


function floattosql(flt:extended):string;
begin
     result := quotedstr( ReplaceTextAll(floattostr(flt),',','.' ) );
end;

function currencytosql(flt:extended):string;
begin
     result := quotedstr( ReplaceTextAll(currtostr(flt),',','.') );
end;

{ tQueryUtil }

function tQueryUtil.BuscaUmDadoSql(pr_sql: string; pr_defaultvalue: variant): variant;
{executa query e retorna o variant obtido}
var lc_qry: TSTQUERY;
begin
     try
       lc_qry:=QueryCreate(pr_sql);
       if lc_qry.Fields[0].Value<>null then
          result:=lc_qry.Fields[0].Value
       else
          result:=pr_defaultvalue;
     finally
            lc_qry.Close;
            FreeAndNil(lc_qry);
     end;
end;

function tQueryUtil.BuscaUmDadoSqlAsDateTime(pr_sql: string): tdatetime;
{executa query e retorna data se obtida }
begin
  Result:=BuscaUmDadoSql(pr_sql,0);
end;

function tQueryUtil.BuscaUmDadoSqlAsFloat(pr_sql: string): Extended;
{executa query e retorna valor se obtido }
begin
  Result:=BuscaUmdadoSql(pr_sql,0.00);
end;

function tQueryUtil.BuscaUmDadoSqlAsInteger(pr_sql: string): integer;
{executa query e retorna inteiro se obtido }
begin
  Result:=BuscaUmdadoSql(pr_sql,0);
end;

function tQueryUtil.BuscaUmDadoSqlAsString(pr_sql: string): string;
{executa query e retorna string se obtida }
begin
  Result:=BuscaUmdadoSql(pr_sql,'');
end;


Function tQueryUtil.Listacampos(pr_nometabela:string):TSTQUERY;
begin
     Result := QueryCreate( 'SELECT A.RDB$FIELD_NAME FROM RDB$RELATION_FIELDS A '+
                            'WHERE (A.RDB$RELATION_NAME = '+quotedstr(pr_nometabela)+')' );
end;

procedure tQueryUtil.begintransaction;
{begin tran}
begin
    commit;
    dbConn.DefaultTransaction.StartTransaction;
end;

procedure tQueryUtil.commit;
{ commit }
begin
    if dbconn.DefaultTransaction.InTransaction then
      dbconn.DefaultTransaction.Commit;
end;

procedure tQueryUtil.commitretain;
{ commit retain}
begin
    commit;
    dbConn.DefaultTransaction.StartTransaction;
end;

procedure tQueryUtil.rollback;
{ rollback }
begin
     if dbconn.DefaultTransaction.InTransaction then
        dbConn.DefaultTransaction.Rollback;
end;

constructor tQueryUtil.create(pr_caminho: string);
{ objeto queryutil }
begin
  FDbConCreateHere:=False;
  if pr_caminho<>'' then
  begin
    FDbConCreateHere:=True;
    DbConn:=CreateDataBase(pr_caminho);
  end;
end;

destructor tQueryUtil.destroy;
begin
  if dbconn.Connected then
  begin
      commit;
  end;
  if fdbConCreateHere then
  begin
    if assigned(dbConn) then
    begin
      if assigned(FdbTransaction) then
        freeandnil(FdbTransaction);
      freeandnil(fdbconn);
    end;
  end;
end;

function tQueryUtil.ListaNomesTabelas: TSTQUERY;
{ retornA dataset com lista de nomes de tabelas do usuário }
begin
  ListaNomesTabelas := QueryCreate('SELECT RDB$RELATION_NAME FROM RDB$RELATIONS '+
                                   'WHERE RDB$RELATION_TYPE=0 '+
                                   'AND RDB$VIEW_BLR IS NULL '+
                                   'AND rdb$system_flag=0');
end;

function tQueryUtil.QueryCreate(pr_sql: string): TSTQUERY;
{ executa query e retorna dataset aberta }
begin
     try
        result:=TSTQUERY.Create(Nil);
        result.database:=dbConn;
        result.transaction:=FdbTransaction;
        result.SQL.text:=pr_sql;
        result.open;
        result.First;
     Except
           raise;
     end;
End;

function tQueryUtil.CreateDataBase(pr_caminho: string): TSTDatabase;
{ conect database }
begin
  FdbTransaction := TSTTransaction.Create(nil);
  result := TSTDatabase.Create(nil);
  FdbTransaction.DefaultDatabase := result;
  result.Params.Values['DriverID'] := 'FB';
  result.Params.Values['Database'] := pr_caminho;
  result.Params.Values['User_Name'] := 'SYSDBA';
  result.Params.Values['Password'] := 'masterkey';
  result.Params.Values['CharacterSet'] := 'WIN1252';
  result.LoginPrompt := False;
  result.Connected := True;
end;

procedure tQueryUtil.SetdbConn(const Value: TSTDatabase);
begin
     if FdbConn<>Value then
        FDbConn := Value;
     IF FdbTransaction<>Value.DefaultTransaction then
        FdbTransaction:=Value.DefaultTransaction;
end;


function tQueryUtil.tabelaexiste(pr_nometabela: string): boolean;
begin
     result := BuscaUmDadoSqlAsInteger('SELECT COUNT(*) FROM RDB$RELATIONS WHERE RDB$RELATION_NAME='+quotedstr(pr_nometabela))>0;
end;

function tQueryUtil.getnextsequence(pr_nmsequence: string): integer;
begin
     result := BuscaUmDadoSqlAsInteger( 'SELECT GEN_ID( '+pr_nmsequence+', 1 ) FROM RDB$DATABASE');
end;


end.

