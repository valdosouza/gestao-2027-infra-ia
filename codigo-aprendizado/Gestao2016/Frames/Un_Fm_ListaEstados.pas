unit Un_Fm_ListaEstados;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, base_frame_list, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, sea_uf, Data.DB, STQuery, Vcl.ExtCtrls, STTransaction,
  IBX.IBDatabase, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TFm_ListaEstados = class(TBaseFrameList)
    procedure Sb_openClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_Listar;
    function findBySigla(sigla: String): Integer;
  end;

implementation

{$R *.dfm}

uses     Un_DM;

function TFm_ListaEstados.findBySigla(sigla: String): Integer;
begin
  Result := 0;
  if (Qr_Lista.locate('UFE_SIGLA',Sigla,[])) then
    Result := Qr_Lista.fieldbyName('UFE_CODIGO').asInteger;
end;

procedure TFm_ListaEstados.Pc_Listar;
begin
  with Qr_Lista do
  Begin
    Active := False;
    Active := True;
    FetchAll;
  End;
end;

procedure TFm_ListaEstados.Sb_openClick(Sender: TObject);
Var
  Form : TSeaUf;
begin
  Form := TSeaUf.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;


end;

end.
