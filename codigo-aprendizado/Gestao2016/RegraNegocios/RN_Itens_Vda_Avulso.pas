unit RN_Itens_Vda_Avulso;

interface

uses
      Forms, Controls, SysUtils, STQuery, STStoredProc, STDatabase, StdCtrls, classes, db;

  Function Fc_InsereItenVdaAvulso(Fc_Cd_Item,
                                  Fc_Unidade,
                                  Fc_Descricao:String):Integer;

implementation

uses     Un_DM, UN_Sistema, UN_MSG, un_Padrao, Un_Regra_Negocio, ControllerBase;
Function Fc_InsereItenVdaAvulso(Fc_Cd_Item,
                                Fc_Unidade,
                                Fc_Descricao:String):Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'UPDATE OR INSERT INTO TB_ITENS_AVL( ',
                'IAV_CODITF, ',
                'IAV_UNIDADE, ',
                'IAV_DESCRICAO) ',
                'values( ',
                ':IAV_CODITF, ',
                ':IAV_UNIDADE, ',
                ':IAV_DESCRICAO) ',
               ' MATCHING (IAV_CODITF)'
              ));
      //Tratamento de Algumas Variaveis

      //Passagem de Parametros
      ParamByName('IAV_CODITF').AsString := Fc_Cd_Item;
      ParamByName('IAV_UNIDADE').AsString := Fc_Unidade;
      ParamByName('IAV_DESCRICAO').AsString := Fc_Descricao;
      Try
        ExecSQL;
        Result := StrToIntDef(Fc_Cd_Item,0);
      except
        Result := 0;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

end.
