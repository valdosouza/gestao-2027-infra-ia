unit un_fm_lista_class_trib_cbs_ibs;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_frame_list, STTransaction, Data.DB, STQuery, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFmListaClassTribIbsCbs = class(TBaseFrameList)
  private
    FCST: String;
    procedure setFCST(const Value: String);
    procedure Listar;
  public
    property CST : String read FCST write setFCST;
  end;

var
  FmListaClassTribIbsCbs: TFmListaClassTribIbsCbs;

implementation

{$R *.dfm}

{ TFmListaClassTrib }

procedure TFmListaClassTribIbsCbs.Listar;
begin
  with Qr_Lista do
  Begin
    Active := False;
    sql.Clear;
    SQL.Add(concat(
              'SELECT distinct ec.classe, (ec.classe || '' - '' || ec.class_name) DESCRIPTION ',
              'FROM tb_eclass ec ',
              'WHERE ec.cst =:cst ',
              'order by ec.classe '
    ));
    ParamByName('CST').AsString := FCST;
    Active := True;
    FetchAll;
  End;
end;

procedure TFmListaClassTribIbsCbs.setFCST(const Value: String);
begin
  Qr_Lista.Active := False;
  FCST := Value;
  if ( Value <> '') then
    Listar;
end;

end.
