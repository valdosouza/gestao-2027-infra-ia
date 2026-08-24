unit un_fm_lista_cfop;

interface

uses
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_frame_list, sea_cfop, STTransaction, Data.DB, STQuery, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  IBX.IBDatabase, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TFm_lista_cfop = class(TBaseFrameList)
    Chbx_cfop: TCheckBox;
    procedure Chbx_cfopClick(Sender: TObject);
    procedure Sb_openClick(Sender: TObject);
  private
    FAlcada: String;
    FSentido: String;
    procedure setFAlcada(const Value: String);
    procedure setFSentido(const Value: String);
    { Private declarations }
  public
    procedure Listar;
    property Sentido : String read FSentido write setFSentido;
    property Alcada : String read FAlcada write setFAlcada;
  end;

var
  Fm_lista_cfop: TFm_lista_cfop;

implementation

{$R *.dfm}

uses     Un_DM;

procedure TFm_lista_cfop.Chbx_cfopClick(Sender: TObject);
begin
  if Chbx_cfop.Checked then
  Begin
    Sb_open.Enabled := True;
    Dblcb_Lista.Enabled := True;
    Listar;
  end
  else
  Begin
    Sb_open.Enabled := False;
    Dblcb_Lista.KeyValue := null;
    Dblcb_Lista.Enabled := False;
  end;
end;

procedure TFm_lista_cfop.Listar;
begin
  with Qr_Lista do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    sql.Clear;
    sql.Add(concat(
              'SELECT ',
              'NAT_CODIGO, ',
              'NAT_CFOP, ',
              'NAT_DESCRICAO, ',
              'NAT_CFOP || '' - '' || NAT_DESCRICAO CFOP, ',
              'NAT_RESUMIDO ',
              'FROM TB_NATUREZA ',
              'WHERE NAT_ATIVO = ''S''  ',
              '   '
    ));

    if FAlcada <> EmptyStr then
    Begin
      sql.Add(' AND NAT_ALCADA=:NAT_ALCADA ');
      ParamByName('NAT_ALCADA').AsString := FAlcada;
    End;

    if FSentido <> EmptyStr then
    Begin
      sql.Add(' AND NAT_SENTIDO =:NAT_SENTIDO ');
      ParamByName('NAT_SENTIDO').AsString := FSentido;
    End;

    sql.Add('ORDER BY NAT_CFOP ');


    Active := True;
    FetchAll;
  End;
end;

procedure TFm_lista_cfop.Sb_openClick(Sender: TObject);
Var
  Lc_Form : TSeaCFOP;
begin
  Lc_Form := TSeaCFOP.Create(Self);
  try
    if Trim(Dblcb_Lista.Text) <> '' then
      Lc_Form.CodigoRegistro := Dblcb_Lista.KeyValue;
    Lc_Form.ShowModal;
    Dblcb_Lista.KeyValue:= Lc_Form.CodigoRegistro;
  finally
    FreeAndNil(Lc_Form);
  end;


end;

procedure TFm_lista_cfop.setFAlcada(const Value: String);
begin
  FAlcada := Value;
end;

procedure TFm_lista_cfop.setFSentido(const Value: String);
begin
  FSentido := Value;
end;

end.
