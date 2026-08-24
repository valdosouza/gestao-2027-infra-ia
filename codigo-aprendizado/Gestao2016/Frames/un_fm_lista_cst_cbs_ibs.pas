unit un_fm_lista_cst_cbs_ibs;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_frame_list, STTransaction, Data.DB, STQuery, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls, Un_DM;

type
  TFmListaCstCbsIbs = class(TBaseFrameList)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Listar;
  end;

var
  FmListaCstCbsIbs: TFmListaCstCbsIbs;

implementation

{$R *.dfm}

{ TFmListaCst }

procedure TFmListaCstCbsIbs.Listar;
begin
  with Qr_Lista do
  Begin
    Active := False;
    sql.Clear;
    SQL.Add(concat(
          'SELECT distinct ec.cst, (ec.cst || '' - '' || ec.cst_description) Description ',
          'FROM tb_eclass ec ',
          'order by ec.cst '
    ));
    Active := True;
    FetchAll;
  End;
end;

end.
