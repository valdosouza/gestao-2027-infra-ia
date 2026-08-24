unit un_fm_lista_eventos_nfe;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_frame_list, STTransaction, Data.DB, STQuery, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFmListaEventosNfe = class(TBaseFrameList)
  private
    FAutor: String;
    procedure setFAutor(const Value: String);
    procedure Listar;
  public
    property Autor : String read FAutor write setFAutor;
  end;

var
  FmListaEventosNfe: TFmListaEventosNfe;

implementation

{$R *.dfm}

{ TBaseFrameList1 }

procedure TFmListaEventosNfe.Listar;
begin
  with Qr_Lista do
  Begin
    Active := False;
    sql.Clear;
    SQL.Add(concat(
              'SELECT * ',
              'FROM TB_NFE_EVENTO ',
              'WHERE (NVT_AUTOR=:NVT_AUTOR) or NVT_AUTOR is null  ',
              'ORDER BY NVT_DESCRICAO '
    ));
    ParamByName('NVT_AUTOR').AsString := FAutor;
    Active := True;
    FetchAll;
  End;
end;

procedure TFmListaEventosNfe.setFAutor(const Value: String);
begin
  FAutor := Value;
  Listar;
end;

end.
