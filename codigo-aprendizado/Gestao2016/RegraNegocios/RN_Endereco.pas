unit RN_Endereco;

interface

uses
      Forms, Controls, SysUtils, STQuery, STStoredProc, STDatabase, StdCtrls, classes, db, ControllerEndereco, tblEndereco;

  function Fc_GravaEndereco(Fc_CODIGO: integer;
                             Fc_CODEMP: integer;
                             Fc_CNPJ: string;
                             Fc_TIPO: string;
                             Fc_ENDER: string;
                             Fc_COMPLEM: string;
                             Fc_BAIRRO: string;
                             Fc_CEP: string;
                             Fc_CONTATO: string;
                             Fc_FONE: string;
                             Fc_FAX: string;
                             Fc_CELULAR: string;
                             Fc_COMERCIAL: String;
                             Fc_PORTARIA: String;
                             Fc_REGIAO: string;
                             Fc_NUMERO: string;
                             Fc_PAIS: string;
                             Fc_CODCDD: integer;
                             Fc_CODUFE: integer;
                             Fc_PRINCIPAL: string;
                             fc_whatsup:Boolean):Integer;

  procedure Pc_InativaEndereco(Pc_Codigo: Integer);

implementation

uses     Un_DM, UN_Sistema, UN_MSG, un_Padrao, ControllerBase, Un_Regra_Negocio, Un_Funcoes, env;
function Fc_GravaEndereco(Fc_CODIGO: integer;
                           Fc_CODEMP: integer;
                           Fc_CNPJ: string;
                           Fc_TIPO: string;
                           Fc_ENDER: string;
                           Fc_COMPLEM: string;
                           Fc_BAIRRO: string;
                           Fc_CEP: string;
                           Fc_CONTATO: string;
                           Fc_FONE: string;
                           Fc_FAX: string;
                           Fc_CELULAR: string;
                           Fc_COMERCIAL: String;
                           Fc_PORTARIA: String;
                           Fc_REGIAO: string;
                           Fc_NUMERO: string;
                           Fc_PAIS: string;
                           Fc_CODCDD: integer;
                           Fc_CODUFE: integer;
                           Fc_PRINCIPAL: string;
                           fc_whatsup:Boolean):Integer;
var
   Endereco : TControllerEndereco;
   Lc_RegEnder : TEndereco;
begin
  Endereco := TControllerEndereco.create(Application);
  Lc_RegEnder := Nil;
  Try

    Endereco.Registro.CodigoEmpresa := Fc_CODEMP;
    Lc_RegEnder := Endereco.getPrincipal;
    //Codigo do Estabelecimento - Aqui e uma tentativa de corrir um erro que acontece e ainda nao consegui pegar em tempo de execucao
    if (Lc_RegEnder.Codigo > 0) and (Lc_RegEnder.CodigoEmpresa = Gb_CodMha) then
    Begin
      Endereco.ClonarObj(Endereco.Registro,Lc_RegEnder);
      Endereco.Registro.CodigoPais := StrToInt( Fc_PAIS );
      Endereco.Registro.CodigoCidade := Fc_CODCDD;
      Endereco.Registro.CodigoEstado := Fc_CODUFE;
      Endereco.Update;
    End;

    if ( Lc_RegEnder.Codigo > 0 ) AND (Lc_RegEnder.Codigo <> Fc_CODIGO)  AND (Fc_PRINCIPAL ='S') then
    Begin
      Fc_PRINCIPAL := 'N';
    end
    else
    Begin
      if (Fc_CODIGO = 0) then
      Begin
        Fc_PRINCIPAL := 'S';
      end;
    end;
    //Gera o Sql

    with Endereco do
    Begin
      //Procura endereço
      Registro.Codigo := Fc_CODIGO;
      Registro.CodigoEmpresa := Fc_CODEMP;
      Registro.Cnpj := Fc_CNPJ;
      Registro.Tipo := Fc_TIPO;
      Registro.Logradouro := Fc_ENDER;
      Registro.NumeroPredial := Fc_NUMERO;
      Registro.Complemento := Copy(Fc_COMPLEM,1,25);
      Registro.EnderecoPrincipal := Fc_PRINCIPAL;
      Registro.cep := Fc_CEP;
      Registro.Bairro := Fc_BAIRRO;
      Registro.Contato := Fc_CONTATO;
      Registro.Regiao := Fc_REGIAO;
      Registro.Fone := Fc_RemoveCaracterInformado(Fc_FONE, ['(',')','-','-',' ']);
      Registro.Celular := Fc_RemoveCaracterInformado(Fc_CELULAR,  ['(',')','-','-',' ']);
      Registro.Fax := Fc_RemoveCaracterInformado(Fc_FAX,  ['(',')','-','-',' ']);
      Registro.FoneComercial := Fc_RemoveCaracterInformado(Fc_COMERCIAL,  ['(',')','-','-',' ']);
      Registro.FonePortaria := Fc_RemoveCaracterInformado(Fc_PORTARIA, ['(',')','-','-',' ']);
      Registro.CodigoPais := StrToInt( Fc_PAIS );
      Registro.CodigoCidade := Fc_CODCDD;
      Registro.CodigoEstado := Fc_CODUFE;
      if fc_whatsup then
      Registro.PossuiWhatsapp := 'S'
      else
      Registro.PossuiWhatsapp := 'N';
      Endereco.salva;
      Result := Endereco.Registro.Codigo;
    end;
  Finally
    FreeAndNil(Endereco);
  End;
end;

procedure Pc_InativaEndereco(Pc_Codigo: Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : sTRING;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'UPDATE TB_ENDERECO SET   ' +
                   'END_PRINCIPAL = ''I'' '+
                   'WHERE  END_CODIGO =:END_CODIGO  ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('END_CODIGO').AsInteger := Pc_Codigo;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


end.
