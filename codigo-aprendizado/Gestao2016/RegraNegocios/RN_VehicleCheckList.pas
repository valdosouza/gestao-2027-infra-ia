unit RN_VehicleCheckList;

interface

uses
      Forms, Controls, SysUtils, STQuery, STStoredProc, STDatabase, classes, db, ControllerBase;

  function Fc_UpdateVehicleCheckList(TB_INSTITUTION_ID,
                                      TB_BUDGET_ID,
                                      TB_ORDER_ID,
                                      MOBILE,
                                      CHECKLIST,
                                      KM,
                                      FUEL,
                                      ABS,
                                      CIGARETTE_LIGHTER,
                                      AERIAL,
                                      CONDITIONED_AIR,
                                      HOT_AIR,
                                      HUB_CAPS,
                                      WRENCH,
                                      HYDRAULIC_STEERING,
                                      DOCTS,
                                      EXTINGUISHER,
                                      HOIST,
                                      MANUAL,
                                      FRONT_TYRE,
                                      STEPE_TYRE,
                                      BACK_TYRE,
                                      RADIO,
                                      CARPET,
                                      TRIANGLE,
                                      VALVES,
                                      OTHER,
                                      OBS,
                                      ENTRANCE_DATE,
                                      ENTRANCE_HOUR,
                                      PRISMA:String):Integer;


implementation

uses     Un_DM, UN_Sistema, UN_MSG, un_Padrao, Un_Regra_Negocio, RN_Crud;
  function Fc_UpdateVehicleCheckList(TB_INSTITUTION_ID,
                                      TB_BUDGET_ID,
                                      TB_ORDER_ID,
                                      MOBILE,
                                      CHECKLIST,
                                      KM,
                                      FUEL,
                                      ABS,
                                      CIGARETTE_LIGHTER,
                                      AERIAL,
                                      CONDITIONED_AIR,
                                      HOT_AIR,
                                      HUB_CAPS,
                                      WRENCH,
                                      HYDRAULIC_STEERING,
                                      DOCTS,
                                      EXTINGUISHER,
                                      HOIST,
                                      MANUAL,
                                      FRONT_TYRE,
                                      STEPE_TYRE,
                                      BACK_TYRE,
                                      RADIO,
                                      CARPET,
                                      TRIANGLE,
                                      VALVES,
                                      OTHER,
                                      OBS,
                                      ENTRANCE_DATE,
                                      ENTRANCE_HOUR,
                                      PRISMA:String):Integer;
Var
  Lc_Qry:TSTQuery;
  Lc_Result:TStringList;
  LcBase : TControllerBase;
begin
  Try
    Lc_Result := TStringList.Create;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      //REsultado
      Lc_Result := Fc_VerificaRegistro('TB_VEHICLE_CHECKLIST',['TB_INSTITUTION_ID','TB_BUDGET_ID','TB_ORDER_ID'],
                                                              [TB_INSTITUTION_ID,TB_BUDGET_ID,TB_ORDER_ID],
                                                              ['TB_INSTITUTION_ID','TB_BUDGET_ID','TB_ORDER_ID']);

      if (StrToIntDef( Trim( Lc_Result.Strings[0] ) ,0 )>0) then
      Begin
        SQL.Add('update "TB_VEHICLE_CHECKLIST" set '+
                '   "TB_INSTITUTION_ID" = :"TB_INSTITUTION_ID" '+
                '  ,"TB_BUDGET_ID" = :"TB_BUDGET_ID" '+
                '  ,"TB_ORDER_ID" =:"TB_ORDER_ID" '+
                '  , "MOBILE" = :"MOBILE" '+
                '  , "CHECKLIST" = :"CHECKLIST" '+
                '  , "KM" = :"KM" '+
                '  , "FUEL" = :"FUEL" '+
                '  , "ABS" = :"ABS" '+
                '  , "CIGARETTE_LIGHTER" = :"CIGARETTE_LIGHTER" '+
                '  , "AERIAL" = :"AERIAL" '+
                '  , "CONDITIONED_AIR" = :"CONDITIONED_AIR" '+
                '  , "HOT_AIR" = :"HOT_AIR" '+
                '  , "HUB_CAPS" = :"HUB_CAPS" '+
                '  , "WRENCH" = :"WRENCH" '+
                '  , "HYDRAULIC_STEERING" = :"HYDRAULIC_STEERING" '+
                '  , "DOCTS" = :"DOCTS" '+
                '  , "EXTINGUISHER" = :"EXTINGUISHER" '+
                '  , "HOIST" = :"HOIST" '+
                '  , "MANUAL" = :"MANUAL" '+
                '  , "FRONT_TYRE" = :"FRONT_TYRE" '+
                '  , "STEPE_TYRE" = :"STEPE_TYRE" '+
                '  , "BACK_TYRE" = :"BACK_TYRE" '+
                '  , "RADIO" = :"RADIO" '+
                '  , "CARPET" = :"CARPET" '+
                '  , "TRIANGLE" = :"TRIANGLE" '+
                '  , "VALVES" = :"VALVES" '+
                '  , "OTHER" = :"OTHER" '+
                '  , "OBS" = :"OBS" '+
                '  , "ENTRANCE_DATE" = :"ENTRANCE_DATE" '+
                '  , "ENTRANCE_HOUR" = :"ENTRANCE_HOUR" '+
                '  , PRISMA =:PRISMA '+
                '  where '+
                '    "TB_INSTITUTION_ID" =:"TB_INSTITUTION_ID" and '+
                '    "TB_BUDGET_ID" =:"TB_BUDGET_ID" and '+
                '    "TB_ORDER_ID" =:"TB_ORDER_ID" ');
      end
      else
      Begin
        SQL.Add('insert into "TB_VEHICLE_CHECKLIST"( '+
                '  "TB_INSTITUTION_ID" '+
                ', "TB_BUDGET_ID" '+
                ', "TB_ORDER_ID" '+
                ', "MOBILE" '+
                ', "CHECKLIST" '+
                ', "KM" '+
                ', "FUEL" '+
                ', "ABS" '+
                ', "CIGARETTE_LIGHTER" '+
                ', "AERIAL" '+
                ', "CONDITIONED_AIR" '+
                ', "HOT_AIR" '+
                ', "HUB_CAPS" '+
                ', "WRENCH" '+
                ', "HYDRAULIC_STEERING" '+
                ', "DOCTS" '+
                ', "EXTINGUISHER" '+
                ', "HOIST" '+
                ', "MANUAL" '+
                ', "FRONT_TYRE" '+
                ', "STEPE_TYRE" '+
                ', "BACK_TYRE" '+
                ', "RADIO" '+
                ', "CARPET" '+
                ', "TRIANGLE" '+
                ', "VALVES" '+
                ', "OTHER" '+
                ', "OBS" '+
                ', "ENTRANCE_DATE" '+
                ', "ENTRANCE_HOUR" '+
                ', PRISMA) '+
                'values( '+
                '  :"TB_INSTITUTION_ID" '+
                ', :"TB_BUDGET_ID" '+
                ', :"TB_ORDER_ID" '+
                ', :"MOBILE" '+
                ', :"CHECKLIST" '+
                ', :"KM" '+
                ', :"FUEL" '+
                ', :"ABS" '+
                ', :"CIGARETTE_LIGHTER" '+
                ', :"AERIAL" '+
                ', :"CONDITIONED_AIR" '+
                ', :"HOT_AIR" '+
                ', :"HUB_CAPS" '+
                ', :"WRENCH" '+
                ', :"HYDRAULIC_STEERING" '+
                ', :"DOCTS" '+
                ', :"EXTINGUISHER" '+
                ', :"HOIST" '+
                ', :"MANUAL" '+
                ', :"FRONT_TYRE" '+
                ', :"STEPE_TYRE" '+
                ', :"BACK_TYRE" '+
                ', :"RADIO" '+
                ', :"CARPET" '+
                ', :"TRIANGLE" '+
                ', :"VALVES" '+
                ', :"OTHER" '+
                ', :"OBS" '+
                ', :"ENTRANCE_DATE" '+
                ', :"ENTRANCE_HOUR" '+
                ', :PRISMA)');
      end;

      ParamByName('TB_INSTITUTION_ID').AsString :=  TB_INSTITUTION_ID;
      ParamByName('TB_BUDGET_ID').AsString := TB_BUDGET_ID ;
      ParamByName('TB_ORDER_ID').AsString := TB_ORDER_ID;
      ParamByName('MOBILE').AsString := MOBILE;
      ParamByName('CHECKLIST').AsString := CHECKLIST;
      ParamByName('KM').AsString := KM;
      ParamByName('FUEL').AsString := FUEL;
      ParamByName('ABS').AsString :=      ABS;
      ParamByName('CIGARETTE_LIGHTER').AsString := CIGARETTE_LIGHTER;
      ParamByName('AERIAL').AsString := AERIAL;
      ParamByName('CONDITIONED_AIR').AsString :=CONDITIONED_AIR;
      ParamByName('HOT_AIR').AsString := HOT_AIR;
      ParamByName('HUB_CAPS').AsString := HUB_CAPS;
      ParamByName('WRENCH').AsString := WRENCH;
      ParamByName('HYDRAULIC_STEERING').AsString := HYDRAULIC_STEERING;
      ParamByName('DOCTS').AsString := DOCTS;
      ParamByName('EXTINGUISHER').AsString := EXTINGUISHER;
      ParamByName('HOIST').AsString := HOIST;
      ParamByName('MANUAL').AsString := MANUAL;
      ParamByName('FRONT_TYRE').AsString :=FRONT_TYRE;
      ParamByName('STEPE_TYRE').AsString := STEPE_TYRE;
      ParamByName('BACK_TYRE').AsString := BACK_TYRE;
      ParamByName('RADIO').AsString := RADIO;
      ParamByName('CARPET').AsString := CARPET;
      ParamByName('TRIANGLE').AsString := TRIANGLE;
      ParamByName('VALVES').AsString := VALVES;
      ParamByName('OTHER').AsString := OTHER;
      ParamByName('OBS').AsString := OBS;
      ParamByName('ENTRANCE_DATE').AsString := ENTRANCE_DATE;
      ParamByName('ENTRANCE_HOUR').AsString := ENTRANCE_HOUR;
      ParamByName('PRISMA').AsString := PRISMA;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    FreeAndNil(LcBase);
  End;
end;

end.
