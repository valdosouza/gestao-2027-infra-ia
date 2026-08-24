unit un_fm_lista_tax_incidency;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_frame_list, STTransaction, Data.DB, STQuery, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFmListaTaxIncidency = class(TBaseFrameList)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Listar;
  end;

var
  FmListaTaxIncidency: TFmListaTaxIncidency;

implementation

{$R *.dfm}

{ TFmListaTaxIncidency }

procedure TFmListaTaxIncidency.Listar;
begin
  with Qr_Lista do
  Begin
    Active := False;
    sql.Clear;
    SQL.Add(concat(
            'SELECT * ',
            'FROM tb_taxes_incidency ',
            'ORDER BY KIND '
    ));
    Active := True;
    FetchAll;
  End;
end;

end.
