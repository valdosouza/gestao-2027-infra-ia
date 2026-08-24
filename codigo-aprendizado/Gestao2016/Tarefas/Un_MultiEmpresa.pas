unit Un_MultiEmpresa;

interface

uses
      Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, DBCtrls, Buttons, DB, ActnList, ExtCtrls, System.Actions;

type
  TFr_MultiEmpresa = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DBLCB_Empresa: TDBLookupComboBox;
    Sb_Aplicar: TBitBtn;
    DS_MhaEmpresa: TDataSource;
    Ac_Comandos: TActionList;
    Ac_Fecha: TAction;
    procedure Sb_AplicarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBLCB_EmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    It_Codmha : Integer;
  end;

var
  Fr_MultiEmpresa: TFr_MultiEmpresa;

implementation

uses     UN_Principal, env, UN_Sistema, Un_DM, Un_Regra_Negocio, UN_MSG, UN_TabelasEmListas;

{$R *.dfm}

procedure TFr_MultiEmpresa.Sb_AplicarClick(Sender: TObject);
begin
  if trim(DBLCB_Empresa.Text) <> '' then
  begin
    It_Codmha := DBLCB_Empresa.KeyValue;
  end;
  Close;
end;

procedure TFr_MultiEmpresa.FormShow(Sender: TObject);
begin
  with DM_ListaConsultas do
  Begin
    Pc_ListaEstabelecimentos('EMP_FANTASIA');
    DBLCB_Empresa.KeyValue := Qr_ListaEstabelecimento.FieldByname('EMP_CODIGO').AsInteger;
  End;
end;

procedure TFr_MultiEmpresa.DBLCB_EmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  If key = #13 then
    Sb_AplicarClick(Self);
end;

procedure TFr_MultiEmpresa.FormCreate(Sender: TObject);
begin
  It_Codmha := 0;
end;

end.

