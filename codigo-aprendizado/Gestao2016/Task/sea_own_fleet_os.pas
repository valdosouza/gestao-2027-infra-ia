unit sea_own_fleet_os;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, STQuery;

type
  TSeaOwnFleetOs = class(TBaseSearch)
    Label2: TLabel;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    E_Placa: TEdit;
    cds_searchTB_INSTITUTION_ID: TIntegerField;
    cds_searchID: TIntegerField;
    cds_searchTB_VEHICLE_ID: TWideStringField;
    cds_searchDT_RECORD: TDateField;
    cds_searchKM: TWideStringField;
    cds_searchOBS: TBlobField;
    cds_searchMRC_DESCRICAO: TWideStringField;
    cds_searchMOD_DESCRICAO: TWideStringField;
  private
  protected
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;

    procedure setPerfil;Override;
    procedure SelectSql;Override;
    procedure InnerJoinSql;Override;
    procedure WhereSql;Override;
    procedure OrderBySql;Override;
    procedure SetParameters(Param: TSTQuery);Override;
    procedure GetView;Override;
    procedure SetRegister;Override;
  public
    { Public declarations }
  end;

var
  SeaOwnFleetOs: TSeaOwnFleetOs;

implementation

{$R *.dfm}

uses     tas_own_fleet_os;
procedure TSeaOwnFleetOs.CriarVariaveis;
begin
  inherited;

end;

procedure TSeaOwnFleetOs.GetView;
Var
  LcForm : TTasOwnFleetOs;
begin
  try
    LcForm := TTasOwnFleetOs.Create(nil);
    LcForm.CodigoRegistro := cds_searchID.AsInteger;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TSeaOwnFleetOs.IniciaVariaveis;
begin
  inherited;
  E_Data_Ini.DateTime := Date;
  E_Data_Fim.DateTime := Date;
end;

procedure TSeaOwnFleetOs.InnerJoinSql;
begin
  inherited;
  InnerJoinTxt := concat(
      '  INNER JOIN tb_veiculo VEI ',
      '  ON (VEI.vei_placa = OS.tb_vehicle_id) ',
      '  INNER join tb_marca_veiculo MA ',
      '  ON (MA.mrc_codigo = VEI.vei_codmrc) ',
      '  INNER join TB_MODELO MD ',
      '  ON (MD.MOD_CODIGO = VEI.VEI_CODMOD) '
    )
end;

procedure TSeaOwnFleetOs.OrderBySql;
begin
  inherited;
  OrderByTxt := ' Order By DT_RECORD ';
end;

procedure TSeaOwnFleetOs.SelectSql;
begin
  inherited;
  SelectTxt := concat(
                'SELECT OS.*, MA.mrc_descricao, MD.MOD_DESCRICAO ',
                'FROM TB_OWN_FLEET_OS OS '
            );
end;

procedure TSeaOwnFleetOs.SetParameters(Param: TSTQuery);
begin
  with Param do
  Begin
    if ChBx_Periodo.Checked then
    BEgin
      ParamByName('DATAINI').AsDateTime := E_Data_Ini.DateTime;
      ParamByName('DATAFIM').AsDateTime := E_Data_Fim.DateTime;
    End;

    //incrementa SQL
    if E_Placa.Text <> '' then
      ParamByName('tb_vehicle_id').AsString := E_Placa.Text;

  End;

end;

procedure TSeaOwnFleetOs.setPerfil;
begin
  inherited;

end;

procedure TSeaOwnFleetOs.SetRegister;
Var
  LcForm : TTasOwnFleetOs;
begin
  try
    LcForm := TTasOwnFleetOs.Create(nil);
    LcForm.CodigoRegistro := 0;
    LcForm.ShowModal;
  finally
    FreeAndNil(LcForm);
  end;
end;

procedure TSeaOwnFleetOs.WhereSql;
begin
  inherited;
  WhereTxt := concat(
             'WHERE (ID IS NOT NULL)   '
              );

  if ChBx_Periodo.Checked then
    WhereTxt := concat(
                  WhereTxt,
                  ' and ( DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) '
                );

  if E_Placa.Text <> '' then
    WhereTxt := concat(
                  WhereTxt,
                  ' and (tb_vehicle_id =:tb_vehicle_id) '
                );

end;

end.
