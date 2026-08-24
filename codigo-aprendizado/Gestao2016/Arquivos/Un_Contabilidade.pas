unit Un_Contabilidade;

interface

uses
      Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Empresa, Data.DB, STQuery, Vcl.Menus, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.StdCtrls, QEdit_Setes, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Un_Fm_ListaColaboradores, ControllerContador;

type
  TFr_Contabilidade = class(TFr_Empresa)
    ChBx_Contador: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Contador : TControllerContador;
  protected
    procedure InitVariable;override;
    procedure Pc_PreencheSemDados; Override;
    procedure Pc_PreencheComDados;Override;

    function Fc_VerificaRegistroDuplicado():Boolean; Override;
    procedure Pc_Gravar; Override;
    procedure Pc_GravarContador;
    procedure Pc_Deletar;Override;
  public
    { Public declarations }


  end;

var
  Fr_Contabilidade: TFr_Contabilidade;

implementation

{$R *.dfm}


{ TFr_Contabilidade }



{ TFr_Contabilidade }

function TFr_Contabilidade.Fc_VerificaRegistroDuplicado: Boolean;
Var
  Lc_Codigo : Integer;
begin
  Result := False;
  Lc_Codigo :=  Contador.VerificaSeExste(E_Codigo.Text,E_CpfCnpj.Text,True);
  if (Lc_Codigo > 0) then
  Begin
    REsult := True;
  End;

end;

procedure TFr_Contabilidade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Contador);
  inherited;
end;

procedure TFr_Contabilidade.InitVariable;
begin
  inherited;
  Contador := TControllerContador.create(Self);
end;

procedure TFr_Contabilidade.Pc_Deletar;
begin
  Contador.Registro.Codigo := Empresa.Registro.Codigo;
  Contador.Registro.Ativo := 'N';
  Contador.update;

end;

procedure TFr_Contabilidade.Pc_Gravar;
begin
  inherited;
  Pc_GravarContador;
end;

procedure TFr_Contabilidade.Pc_GravarContador;
begin
  Contador.Registro.Codigo := Empresa.Registro.Codigo;
  if ChBx_Contador.Checked then
    Contador.Registro.Ativo := 'S'
  else
    Contador.Registro.Ativo := 'N';
  Contador.salva;
end;

procedure TFr_Contabilidade.Pc_PreencheComDados;
begin
  inherited;
  Contador.Registro.Codigo := Empresa.Registro.Codigo;
  Contador.getById;
  ChBx_Contador.Checked := ( Contador.Registro.Ativo= 'S' );

end;

procedure TFr_Contabilidade.Pc_PreencheSemDados;
begin
  inherited;
  ChBx_Contador.Checked := True;

end;

end.
