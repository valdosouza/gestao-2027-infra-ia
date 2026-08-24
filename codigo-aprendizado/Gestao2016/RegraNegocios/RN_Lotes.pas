unit RN_Lotes;

interface

uses
      STDatabase, STQuery, SysUtils, Classes;

   function Fc_ValidaExclusaoLote(fc_Codigo:Integer):Boolean;

   function Fc_AtualizaCtrlLote(Fc_CODIGO,
                                Fc_CODMHA,
                                Fc_CODEMP,
                                Fc_NUMERO,
                                Fc_CODMRC,
                                Fc_CERTIFICADO,
                                Fc_CODPRO,
                                Fc_DT_VENCIMENTO:String):Integer;

    function Fc_AtualizaMovimentoLote(Fc_CODIGO,
                                      Fc_CODCLT,
                                      Fc_DATA,
                                      Fc_TIPO,
                                      Fc_CODVCL,
                                      Fc_SENTIDO,
                                      Fc_QTDE,
                                      Fc_Observacao,
                                      Log:String;
                                      Fc_CODEXT:Integer):Integer;
    function Fc_AtualizaMovimentoLotePeloItem(Fc_CODCLT,
                                              Fc_DATA,
                                              Fc_TIPO,
                                              Fc_CODVCL,
                                              Fc_SENTIDO,
                                              Fc_QTDE:String):Integer;

  function Fc_VerificaExistenciaNumeroLote(fc_numerolote: String;Fc_Cd_Lote,Fc_Cd_Empresa,Fc_Cd_Produto:Integer): Boolean;



  Function Fc_LoteDisponivel(Fc_Cd_Produto:Integer):Integer;

implementation

uses     Un_DM, UN_Sistema, UN_MSG, un_Padrao, Un_Regra_Negocio, RN_Crud, ControllerBase, env;
function Fc_ValidaExclusaoLote(fc_Codigo:Integer):Boolean;
Var
  Lc_Qry:TSTQuery;
  LcBase : TControllerBase;
Begin
  try
    Result := True;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('SELECT IPC_CODIGO From TB_EXT_INSPECAO WHERE IPC_CODEXT=:EXT_CODIGO');
      ParamByName('EXT_CODIGO').AsInteger := Fc_Codigo;
      Active := True;
      FetchAll;
      if (recordCount >0) then
      Begin
        Result := False;
        MensagemPadrao(MENSAGEM, ATENCAO + EOLN + EOLN +
                       'Não é possível excluir este Lote.' + EOLN +
                       'Ele possue vínculos em inspeção.' + EOLN,
                       ['OK'], [bEscape], mpAlerta);
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


function Fc_AtualizaCtrlLote(Fc_CODIGO,
                              Fc_CODMHA,
                              Fc_CODEMP,
                              Fc_NUMERO,
                              Fc_CODMRC,
                              Fc_CERTIFICADO,
                              Fc_CODPRO,
                              Fc_DT_VENCIMENTO:String):Integer;
Var
  Lc_Qry:TSTQuery;
  LcBase : TControllerBase;
Begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_CTRL_LOTE',['CLT_CODIGO'],[Fc_CODIGO],['CLT_CODIGO'])).Strings[0],0) > 0 then
        Begin //Atualiza
        SQL.Add('update "TB_CTRL_LOTE"set '+
                ' "CLT_CODIGO" = :"CLT_CODIGO" '+
                ', "CLT_CODMHA" = :"CLT_CODMHA" '+
                ', "CLT_CODEMP" = :"CLT_CODEMP" '+
                ', "CLT_NUMERO" = :"CLT_NUMERO" '+
                ', "CLT_CODMRC" = :"CLT_CODMRC" '+
                ', "CLT_CERTIFICADO" = :"CLT_CERTIFICADO" '+
                ', "CLT_CODPRO" = :"CLT_CODPRO" '+
                ', "CLT_DT_VENCIMENTO" = :"CLT_DT_VENCIMENTO" '+
                'where  "CLT_CODIGO" = :"CLT_CODIGO"');
        end
      else
        Begin//Insere
        Fc_CODIGO := IntToStr(Fc_Generator('GN_CTRL_LOTE','TB_CTRL_LOTE','CLT_CODIGO'));
        SQL.Add('insert into "TB_CTRL_LOTE"( '+
                '  "CLT_CODIGO" '+
                ', "CLT_CODMHA" '+
                ', "CLT_CODEMP" '+
                ', "CLT_NUMERO" '+
                ', "CLT_CODMRC" '+
                ', "CLT_CERTIFICADO" '+
                ', "CLT_CODPRO" '+
                ', "CLT_DT_VENCIMENTO" '+
                ', "CLT_QT_ENTRADA" '+
                ', "CLT_QT_SAIDA" '+
                ', "CLT_QT_SALDO")'+
                'values( '+
                '  :"CLT_CODIGO" '+
                ', :"CLT_CODMHA" '+
                ', :"CLT_CODEMP" '+
                ', :"CLT_NUMERO" '+
                ', :"CLT_CODMRC" '+
                ', :"CLT_CERTIFICADO" '+
                ', :"CLT_CODPRO" '+
                ', :"CLT_DT_VENCIMENTO" '+
                ', :"CLT_QT_ENTRADA" '+
                ', :"CLT_QT_SAIDA" '+
                ', :"CLT_QT_SALDO")');

        ParamByName('CLT_QT_ENTRADA').AsFloat := 0;
        ParamByName('CLT_QT_SAIDA').AsFloat := 0;
        ParamByName('CLT_QT_SALDO').AsCurrency := 0;
        end;
      //Tratamento de Algumas Variaveis
      if (Trim(Fc_DT_VENCIMENTO) = '/  /') then Fc_DT_VENCIMENTO := '';

      //Passagem de Parametros

      ParamByName('CLT_CODIGO').AsString := Fc_CODIGO;
      ParamByName('CLT_CODMHA').AsString := Fc_CODMHA;
      ParamByName('CLT_CODEMP').AsString := Fc_CODEMP;
      ParamByName('CLT_NUMERO').AsString := Fc_NUMERO;
      ParamByName('CLT_CODMRC').AsString := Fc_CODMRC;
      ParamByName('CLT_CERTIFICADO').AsString := Fc_CERTIFICADO;
      ParamByName('CLT_CODPRO').AsString := Fc_CODPRO;
      ParamByName('CLT_DT_VENCIMENTO').AsString := Fc_DT_VENCIMENTO;
      Try
        ExecSQL;
        Result := StrToInt(Fc_CODIGO);
      except
        Result := 0;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

function Fc_AtualizaMovimentoLote(Fc_CODIGO,
                                  Fc_CODCLT,
                                  Fc_DATA,
                                  Fc_TIPO,
                                  Fc_CODVCL,
                                  Fc_SENTIDO,
                                  Fc_QTDE,
                                  Fc_Observacao,
                                  Log:String;
                                  Fc_CODEXT:Integer):Integer;
Var
  Lc_Qry:TSTQuery;
  LcBase : TControllerBase;
Begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_MOVIMENTO_LOTE',['MLT_CODIGO'],[Fc_CODIGO],['MLT_CODIGO'])).Strings[0],0) > 0 then
      Begin //Atualiza
        SQL.Add('update "TB_MOVIMENTO_LOTE" set '+
                ' "MLT_CODIGO" = :"MLT_CODIGO" '+
                ', "MLT_CODCLT" = :"MLT_CODCLT" '+
                ', "MLT_DATA" = :"MLT_DATA" '+
                ', "MLT_TIPO" = :"MLT_TIPO" '+
                ', "MLT_CODVCL" = :"MLT_CODVCL" '+
                ', "MLT_SENTIDO" = :"MLT_SENTIDO" '+
                ', "MLT_QTDE" = :"MLT_QTDE" '+
                ', "MLT_CODEXT" = :"MLT_CODEXT" '+
                ', "MLT_OBSERVACAO" = :"MLT_OBSERVACAO" '+
                ', "MLT_LOG" =:"MLT_LOG" '+
                'where "MLT_CODIGO" = :"MLT_CODIGO"');
      end
      else
      Begin //Insere
        Fc_CODIGO := IntToStr(Fc_Generator('GN_MOVIMENTO_LOTE','TB_MOVIMENTO_LOTE','MLT_CODIGO'));
        SQL.Add('insert into "TB_MOVIMENTO_LOTE"( '+
                '  "MLT_CODIGO" '+
                ', "MLT_CODCLT" '+
                ', "MLT_DATA" '+
                ', "MLT_TIPO" '+
                ', "MLT_CODVCL" '+
                ', "MLT_SENTIDO" '+
                ', "MLT_QTDE" '+
                ', "MLT_CODEXT" '+
                ', "MLT_OBSERVACAO" '+
                ', "MLT_LOG") '+
                'values( '+
                '  :"MLT_CODIGO" '+
                ', :"MLT_CODCLT" '+
                ', :"MLT_DATA" '+
                ', :"MLT_TIPO" '+
                ', :"MLT_CODVCL" '+
                ', :"MLT_SENTIDO" '+
                ', :"MLT_QTDE" '+
                ', :"MLT_CODEXT" '+
                ', :"MLT_OBSERVACAO" '+
                ', :"MLT_LOG");' );

      end;
      //Passagem de Parametros
      ParamByName('MLT_CODIGO').AsString := Fc_CODIGO;
      ParamByName('MLT_CODCLT').AsString := Fc_CODCLT;
      ParamByName('MLT_DATA').AsString := Fc_DATA;
      ParamByName('MLT_TIPO').AsString := Fc_TIPO;
      ParamByName('MLT_CODVCL').AsString := Fc_CODVCL;
      ParamByName('MLT_SENTIDO').AsString := Fc_SENTIDO;
      ParamByName('MLT_QTDE').AsFloat := StrToFloatDef(Fc_QTDE,0);
      ParamByName('MLT_CODEXT').AsInteger := Fc_CodExt;
      ParamByName('MLT_OBSERVACAO').AsString := Fc_Observacao;
      ParamByName('MLT_LOG').AsString := Log;
      Try
        ExecSQL;
        Result := StrToIntDef(Fc_CODIGO,0);
      except
        Result := 0;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


function Fc_AtualizaMovimentoLotePeloItem(Fc_CODCLT,
                                          Fc_DATA,
                                          Fc_TIPO,
                                          Fc_CODVCL,
                                          Fc_SENTIDO,
                                          Fc_QTDE:String):Integer;
Var
  Lc_Qry:TSTQuery;
  LcBase : TControllerBase;
  Lc_Cd_Movimento : Integer;
Begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_MOVIMENTO_LOTE',['MLT_CODVCL'],[Fc_CODVCL],['MLT_CODVCL'])).Strings[0],0) > 0 then
      Begin //Atualiza
        SQL.Add('update "TB_MOVIMENTO_LOTE" set '+
                ' "MLT_CODCLT" = :"MLT_CODCLT" '+
                ', "MLT_DATA" = :"MLT_DATA" '+
                ', "MLT_TIPO" = :"MLT_TIPO" '+
                ', "MLT_SENTIDO" = :"MLT_SENTIDO" '+
                ', "MLT_QTDE" = :"MLT_QTDE" '+
                'where "MLT_CODVCL" = :"MLT_CODVCL"');
        //Passagem de Parametros
        ParamByName('MLT_CODCLT').AsString := Fc_CODCLT;
        ParamByName('MLT_DATA').AsString := Fc_DATA;
        ParamByName('MLT_TIPO').AsString := Fc_TIPO;
        ParamByName('MLT_CODVCL').AsString := Fc_CODVCL;
        ParamByName('MLT_SENTIDO').AsString := Fc_SENTIDO;
        ParamByName('MLT_QTDE').AsFloat := StrToFloatDef(Fc_QTDE,0);
        end
      else
      Begin //Insere
        Lc_Cd_Movimento := Fc_Generator('GN_MOVIMENTO_LOTE','TB_MOVIMENTO_LOTE','MLT_CODIGO');
        SQL.Add('insert into "TB_MOVIMENTO_LOTE"( '+
                '  "MLT_CODIGO" '+
                ', "MLT_CODCLT" '+
                ', "MLT_DATA" '+
                ', "MLT_TIPO" '+
                ', "MLT_CODVCL" '+
                ', "MLT_SENTIDO" '+
                ', "MLT_QTDE" '+
                ', "MLT_CODEXT") '+
                'values( '+
                '  :"MLT_CODIGO" '+
                ', :"MLT_CODCLT" '+
                ', :"MLT_DATA" '+
                ', :"MLT_TIPO" '+
                ', :"MLT_CODVCL" '+
                ', :"MLT_SENTIDO" '+
                ', :"MLT_QTDE" '+
                ', :"MLT_CODEXT")');
        //Passagem de Parametros
        ParamByName('MLT_CODIGO').AsInteger := Lc_Cd_Movimento;
        ParamByName('MLT_CODCLT').AsString := Fc_CODCLT;
        ParamByName('MLT_DATA').AsString := Fc_DATA;
        ParamByName('MLT_TIPO').AsString := Fc_TIPO;
        ParamByName('MLT_CODVCL').AsString := Fc_CODVCL;
        ParamByName('MLT_SENTIDO').AsString := Fc_SENTIDO;
        ParamByName('MLT_QTDE').AsFloat := StrToFloatDef(Fc_QTDE,0);
      end;
      Try
        ExecSQL;
        Result := StrToIntDef(Fc_CODvcl,0);
      except
        Result := 0;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;
function Fc_VerificaExistenciaNumeroLote(fc_numerolote: String;Fc_Cd_Lote,Fc_Cd_Empresa,Fc_Cd_Produto:Integer): Boolean;
var
  Lc_Qry: TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt: string;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                  ' SELECT * FROM TB_CTRL_LOTE ',
                  'Where (CLT_NUMERO =:CLT_NUMERO) ',
                  ' and (CLT_CODEMP=:CLT_CODEMP) ',
                  ' and (CLT_CODIGO <>:CLT_CODIGO) ',
                  ' and (CLT_CODPRO =:CLT_CODPRO) '
      ));
      ParamByName('CLT_NUMERO').AsString:= fc_numerolote;
      ParamByName('CLT_CODEMP').AsInteger:= Fc_Cd_Empresa;
      ParamByName('CLT_CODIGO').AsInteger:= Fc_Cd_Lote;
      ParamByName('CLT_CODPRO').AsInteger:= Fc_Cd_Produto;
      Active :=True;
      FetchAll;
      Result:= (RecordCount > 0);
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

procedure Pc_SomaSaldoLote(Pc_Cd_Lote:Integer;Pc_QTDE:String);
var
  Lc_Qry: TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt: string;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := ' UPDATE TB_CTRL_LOTE SET '+
                   ' CLT_QT_SALDO = CLT_QT_SALDO + :CLT_QTDE '+
                   ' ,CLT_QT_ENTRADA = CLT_QT_ENTRADA + :CLT_QTDE '+

                   ' Where (CLT_CODIGO=:CLT_CODIGO) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('CLT_QTDE').AsFloat:= StrToFloatDef(Pc_QTDE,0);
      ParamByName('CLT_CODIGO').AsInteger:= Pc_Cd_Lote;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;


Function Fc_LoteDisponivel(Fc_Cd_Produto:Integer):Integer;
var
  Lc_Qry: TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt: string;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT  CLT_CODIGO '+
                   ' FROM TB_CTRL_LOTE '+
                   '    INNER JOIN TB_MOVIMENTO_LOTE '+
                   '    ON (MLT_CODCLT = CLT_CODIGO) '+
                   ' WHERE (CLT_CODPRO =:CLT_CODPRO) AND (CLT_QT_SALDO > 0) AND MLT_SENTIDO = ''E'' ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('CLT_CODPRO').AsInteger:= Fc_Cd_Produto;
      Active := True;
      Result := FieldByname('CLT_CODIGO').AsInteger;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;



end.
