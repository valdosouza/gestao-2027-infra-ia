unit Un_Script_Sql;

interface

uses
       windows, SysUtils, Classes, DB, STDatabase, STQuery, IBUpdateSQL, forms, dialogs, Graphics, XMLDoc, XMLIntf, WinInet, ControllerBase;

  //-------------------------Constroi e Destroi objetos autxiliares -------------------------
  function Fc_Scp_Construtor():boolean;
  procedure Pc_Scp_Destrutor;
//-------------------------Consulta Scrip e Executa-------------------------------------------     
  procedure Pc_Consulta_Script;
  function Fc_Executa_Script(Fc_Comando:String):String;



Var
  It_Xml_Doc : TXMLDocument;
  It_Inet : dword;
  It_cd_Script : Integer;
  Lc_Sql_Array_Itens_Interface : array[0..535] of String;
   implementation

uses     UN_Sistema, Un_DM, UN_MSG;
function Fc_Scp_Construtor():boolean;
Begin
  REsult := Fc_PingConectadoSetes;
end;

procedure Pc_Scp_Destrutor;
Begin
end;

function Fc_Executa_Script(Fc_Comando:String):String;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      try
        sql.add(Fc_Comando);
        Prepare;
        ExecSQL;
        Result := 'Ok';
      except
        Result := 'Falhou';
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure Pc_Consulta_Script;
Var
  Lc_Resultado : WideString;
  Lc_NodePai: IXMLNode;
  Lc_Dados: IXMLNode;
  Lc_cd_Script : String;
  Lc_Comando : String;
  Lc_Desenvolve : String;
Begin
  {
  if (Gb_Cd_Cliente_Setes = 0) then exit;
  Lc_Desenvolve := UpperCase( Fc_Aq_Geral('L','GERAL','DESENVOLVE','N') );
  if (Lc_Desenvolve = 'N' ) then
  Begin;
    //Verifica se há conexao com a Internet
    if Fc_Scp_Construtor then
    Begin
      if fc_Ws_Prj_Construtor then
      Begin
        Lc_Resultado := Fc_Ws_prj_Ver_ScriptSQL;
        if trim(Lc_Resultado) <> '' then
        Begin
          It_Xml_Doc := TXMLDocument.Create(Application);
          It_Xml_Doc.XML.Clear;
          It_Xml_Doc.XML.Add(Lc_Resultado);
          It_Xml_Doc.Options := [];
          It_Xml_Doc.NodeIndentStr := '<tab>';
          It_Xml_Doc.Active := true;

          Lc_NodePai := It_Xml_Doc.DocumentElement.childNodes.First;
          //Se o n� for Zero não tem dados ent�o sai.

          if (Lc_NodePai.ChildNodes.Count >0 ) then
          BEgin
            Lc_Dados:= Lc_NodePai;
            // Posiciona o primeiro elemento encontrado
            Lc_Dados.ChildNodes.First;
            repeat
              // pega os dados que vc quiser dentro da tag <prod>
              Lc_cd_Script := Lc_Dados.ChildNodes[0].text;
              Lc_Comando   := Lc_Dados.ChildNodes[1].Text;
              Lc_Resultado := Fc_Executa_Script(Lc_Comando);
              Pc_Ws_Prj_Atu_Web_ConfirmaExecucaoSQL(Lc_cd_Script,Lc_Resultado);
              Lc_Dados := Lc_Dados.NextSibling;
            until Lc_Dados = nil;
          End;
        end;
        Pc_Ws_Prj_Destrutor;
      End;
      Pc_Scp_Destrutor;
    end;
  end;
  }
end;


end.




